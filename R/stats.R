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
