# function to read the synthetic data
read_measured <- function() {
    readr::read_csv(here::here("data/synthetic_meter.csv"), col_types = readr::cols())
}

# function to extract building electricity from simulation
extract_electricity <- function(idf) {
    if (eplusr::is_idf(idf)) {
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
        environment_name = c("annual", "Philadelphia 2014"),
        year = 2014) %>%
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
        ggplot2::scale_y_continuous("Electricity [kWh]", limits = c(0, 700)) +
        ggplot2::theme_bw()
}

# function to get the NMBE and CVRMSE from simulation results
cal_stats <- function(meter) {
    if (!is.data.frame(meter)) meter <- extract_electricity(meter)

    synthetic <- read_measured()

    res <- c(
        nmbe = nmbe(meter$`electricity [kWh]`, synthetic$`electricity [kWh]`),
        cvrmse = cvrmse(meter$`electricity [kWh]`, synthetic$`electricity [kWh]`)
    )

    formattable::percent(res)
}
