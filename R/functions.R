rmse <- function(sim, obs) {
    sqrt(sum((sim - obs)^2, na.rm = TRUE) / (length(sim) - 1))
}

cvrmse <- function(sim, obs) {
    rmse(sim, obs) / mean(obs, na.rm = TRUE)
}

nmbe <- function(sim, obs){
  sum(sim - obs, na.rm = TRUE) / ((length(sim) - 1) * mean(obs, na.rm = TRUE))
}

j_to_kwh <- function(x, digits = 2) {
    x %>%
        units::set_units("J") %>%
        units::set_units("kWh") %>%
        units::drop_units() %>%
        round(digits)
}
