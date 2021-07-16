`%>%` <- magrittr::`%>%`

# function to convert Joules to kWh
j_to_kwh <- function(x, digits = 2) {
    x %>%
        units::set_units("J") %>%
        units::set_units("kWh") %>%
        units::drop_units() %>%
        round(digits)
}

# use English locale
use_english_locale <- function() {
    if (.Platform$OS.type == "windows") {
        Sys.setlocale(locale = "English")
    } else {
        Sys.setlocale(locale = "en_us.utf-8")
    }
}
