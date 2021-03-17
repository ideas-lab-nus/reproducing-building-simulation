`%>%` <- magrittr::`%>%`

# function to calculate root mean square error
rmse <- function(sim, obs) {
    sqrt(sum((sim - obs)^2, na.rm = TRUE) / (length(sim) - 1))
}

# function to calculate coefficient of variation of the root mean square error
cvrmse <- function(sim, obs) {
    rmse(sim, obs) / mean(obs, na.rm = TRUE)
}

# function to calculate normalized mean bias error
nmbe <- function(sim, obs){
    sum(sim - obs, na.rm = TRUE) / ((length(sim) - 1) * mean(obs, na.rm = TRUE))
}

# function to convert Joules to kWh
j_to_kwh <- function(x, digits = 2) {
    x %>%
        units::set_units("J") %>%
        units::set_units("kWh") %>%
        units::drop_units() %>%
        round(digits)
}

# define a function to update material properties
update_material <- function(idf, conductivity, density, specific_heat) {
    # modify material properties of the exterior walls
    idf$set(SGP_Concrete_200mm = list(
        conductivity = conductivity,
        density = density,
        specific_heat = specific_heat
    ))
}

# function to update infiltration rate
update_infiltration <- function(idf, infil) {
    idf$set(ZoneInfiltration_DesignFlowRate := list(air_changes_per_hour = infil))
}

# function to update people density
update_people <- function(idf, people) {
    idf$set(People := list(zone_floor_area_per_person = people))
}

# function to update lighting power density
update_lights <- function(idf, lpd) {
    # get names of office zones
    re <- "(Core|Zone)_(Bot|Mid|Top)"
    zones <- idf$object_name("Zone")$Zone
    zones <- stringr::str_subset(zones, re)

    idf$set(c(sprintf("%s_Lights", zones)) := list(watts_per_zone_floor_area = lpd))
}

# function to update electric equipment power density
update_equip <- function(idf, epd) {
    idf$set(ElectricEquipment := list(watts_per_zone_floor_area = epd))
}

# function to update cooling setpoint
update_setpoint <- function(idf, core, perimeter) {
    idf$set(
        Sch_Zone_Cooling_Setpoint_Wo_Solar = list(field_4 = as.character(perimeter)),
        Sch_Zone_Cooling_Setpoint_Solar = list(field_4 = as.character(core))
    )
}

# function to read the synthetic data
read_measured <- function() {
    readr::read_csv(here::here("data/synthetic_meter.csv"), col_types = readr::cols())
}

# function to extract building electricity from simulation
extract_electricity <- function(idf) {
    if (is_idf(idf)) {
        # get the simulation job from IDF
        job <- idf$last_job()

        # stop if no simulation has been run
        if (is.null(job)) stop("No simulation job found for input IDF.")

    } else if (is.character(idf)) {
        # get the simulation SQLite from idf name
        path_sql <- file.path(here("data/sim", idf, sprintf("%.sql", idf)))
        job <- eplusr::eplus_sql(path_sql)
    }

    # extract the annual electricity
    job$report_data(
        name = "Electricity:Building",
        environment_name = "Singapore 2018",
        year = 2018) %>%
        # convert to kWh
        dplyr::mutate(value = j_to_kwh(value)) %>%
        dplyr::select(case, datetime, `electricity [kWh]` = value)
}

# function to plot a line graph of one week in specified month
weekly_compare <- function(meter, month = 7, week = 1) {
    if (!is.data.frame(meter)) meter <- extract_electricity(meter)

    meter %>%
        dplyr::bind_rows(read_measured()) %>%
        dplyr::mutate(month = lubridate::month(datetime), day = lubridate::mday(datetime)) %>%
        dplyr::filter(month == !!month, ceiling(day / 7) == !!week) %>%
        ggplot2::ggplot(ggplot2::aes(datetime, `electricity [kWh]`, color = case)) +
        ggplot2::geom_line() +
        ggplot2::scale_x_datetime(NULL, date_labels = "%b %d %a") +
        ggplot2::theme_bw()
}

# function to get the nmbe and cvrmse
cal_stats <- function(meter) {
    if (!is.data.frame(meter)) meter <- extract_electricity(meter)

    synthetic <- read_measured()

    res <- c(
        nmbe = nmbe(meter$`electricity [kWh]`, synthetic$`electricity [kWh]`),
        cvrmse = cvrmse(meter$`electricity [kWh]`, synthetic$`electricity [kWh]`)
    )

    formattable::percent(res)
}
