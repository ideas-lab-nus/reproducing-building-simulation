`%>%` <- magrittr::`%>%`

# function to convert Joules to kWh
j_to_kwh <- function(x, digits = 2) {
    x %>%
        units::set_units("J") %>%
        units::set_units("kWh") %>%
        units::drop_units() %>%
        round(digits)
}
