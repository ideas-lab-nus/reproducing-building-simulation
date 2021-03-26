# define a fitness function which takes all calibration parameters as input and
# return the CV(RMSE) and NMBE as output
calib_fitness <- function(
    conductivity, density, specific_heat, # exterior wall insulation properties
    u_value, SHGC,                        # exterior window properties
    infiltration,                         # infiltration
    people,                               # people density
    lpd,                                  # lighting power density
    epd,                                  # equipment power density
    cooling, heating,                     # cooling and heating setpoint
    gen,                                  # generation index used to save model and results
    ind                                   # individual index used to save model and results
) {
    # disable verbose information
    eplusr::eplusr_option(verbose_info = FALSE)

    # read the initial model
    idf <- eplusr::read_idf(here::here("data/idf/Init.idf"))

    # update calibration parameter based on input
    update_insulation(idf, conductivity = conductivity, density = density, specific_heat = specific_heat)
    update_window(idf, u_value = u_value, SHGC = SHGC)
    update_infiltration(idf, flow_per_area = infiltration)
    update_people(idf, people = people)
    update_lights(idf, lpd = lpd)
    update_equip(idf, epd = epd)
    update_setpoint(idf, cooling = cooling, heating = heating)

    # save model into corresponding generation folder in 'data/idf'
    ## contruct generation folder
    dir_gen <- sprintf("Gen%i", gen)
    ## contruct individual model path
    idf_ind <- sprintf("%s_Ind%i.idf", dir_gen, ind)
    ## save
    idf$save(here::here("data/idf", dir_gen, idf_ind), overwrite = TRUE)

    # run simulation
    path_epw_amy <- here("data-raw/epw/AMY/PA_PHILADELPHIA_720304_14-13.epw")
    ## contruct individual simulation output path
    dir_out <- here::here("data/sim", dir_gen, sprintf("%s_Ind%i", dir_gen, ind))
    ## run simulation with AMY
    idf$run(path_epw_amy, dir_out, echo = FALSE)

    # calculate statistical indicators
    stats <- cal_stats(idf)

    # generate a plot with inputs and outputs
    p <- weekly_compare(idf, month = 7, week = 1) +
        ggplot2::labs(
            title = sprintf("Gen: %i, Ind: %i; NMBE: %s; CV(RMSE): %s",
                gen, ind, stats["nmbe"], stats["cvrmse"]
            ),
            subtitle = paste0(
                "Insulation Conductivity: "  , round(conductivity  , 2) , " W/m-K\n"     ,
                "Insulation Density: "       , round(density       , 2) , " kg/m3\n"     ,
                "Insulation Specific Heat: " , round(specific_heat , 2) , " J/kg-K\n"    ,
                "Window U-Value: "           , round(u_value       , 3) , " W/m2-K\n"    ,
                "Window SHGC: "              , round(SHGC          , 2) , "\n"           ,
                "Infiltration Rate: "        , round(infiltration  , 6) , " m3/s-m2\n"   ,
                "People Density: "           , round(people        , 2) , " m2/person\n" ,
                "LPD: "                      , round(lpd           , 2) , " W/m2\n"      ,
                "EPD: "                      , round(epd           , 2) , " W/m2\n"      ,
                "Cooling Setpoint: "         , round(cooling       , 1) , " C\n"         ,
                "Heating Setpoint: "         , round(heating       , 1) , " C\n"
            )
        )
    ## contruct individual plot path
    png_ind <- sprintf("%s_Ind%i.png", dir_gen, ind)
    ## create the folder to store plot of each generation
    if (!dir.exists(here::here("figures", dir_gen))) {
        dir.create(here::here("figures", dir_gen))
    }
    ## save the plot
    ggplot2::ggsave(here::here("figures", dir_gen, png_ind),
        p, height = 6, width = 10, dpi = 300)

    abs(stats)
}

# define a function to evaluate the fitness in parallel
evaluate_fitness <- function(control, inds, gen, workers = 1) {
    # add generation and individual index
    inds <- purrr::map2(inds, seq_along(inds), ~c(.x, gen, .y))

    # use future framework to run in parallel
    if (workers == 1L) {
        future::plan(future::sequential)
    } else {
        future::plan(future::multisession, workers = workers)
        on.exit(future::plan(future::sequential), add = TRUE)
    }

    fun <- control$task$fitness.fun
    fit <- future.apply::future_mapply(
        function(ind) do.call(fun, as.list(ind)),
        inds, SIMPLIFY = FALSE, future.seed = 1L
    )

    ecr:::makeFitnessMatrix(do.call(cbind, fit), control)
}

# create a terminator to stop simulation when CV(RMSE) and NMBE meet the
# creteria in ASHRAE Guideline 14
stopOnMeetCreteria <- function(cvrmse = 0.3, nmbe = 0.1) {
    condition.fun <- function(log) {
        # fitness of current individual
        fit <- log$env$pop[[log$env$n.gens]]$fitness
        fit <- fit[, ncol(fit)]
        # check if creteria are met
        fit["nmbe"] <= nmbe && fit["cvrmse"] <= cvrmse
    }

    ecr::makeTerminator(
        condition.fun,
        name = "MeetCalibrationCreteria",
        message = sprintf("Calibration creteria (CVRMSE=%s, NMBE=%s) has been met", cvrmse, nmbe)
    )
}
