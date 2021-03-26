# function to update insulation material properties
update_insulation <- function(idf, conductivity, density, specific_heat) {
    # modify insulation material properties of the exterior walls
    idf$set(`Steel Frame NonRes Wall Insulation` = list(
        conductivity = conductivity,
        density = density,
        specific_heat = specific_heat
    ))
}

# function to update window properties
update_window <- function(idf, u_value, SHGC) {
    # modify window material properties of the exterior windows
    idf$set(`NonRes Fixed Assembly Window` = list(
        u_factor = u_value,
        solar_heat_gain_coefficient = SHGC
    ))
}

# function to update infiltration rate
update_infiltration <- function(idf, flow_per_area) {
    idf$set(ZoneInfiltration_DesignFlowRate := list(flow_per_exterior_surface_area = flow_per_area))
}

# function to update people density
update_people <- function(idf, people) {
    idf$set(People := list(zone_floor_area_per_person = people))
}

# function to update lighting power density
update_lights <- function(idf, lpd) {
    idf$set(Lights := list(watts_per_zone_floor_area = lpd))
}

# function to update electric equipment power density
update_equip <- function(idf, epd) {
    idf$set(ElectricEquipment := list(watts_per_zone_floor_area = epd))
}

# function to update cooling and heating setpoint
update_setpoint <- function(idf, cooling, heating) {
    idf$set(
        CLGSETP_SCH = list(field_6 = as.character(cooling)),
        HTGSETP_SCH = list(field_6 = as.character(heating))
    )
}

