# function to update insulation material properties
update_insulation <- function(idf, conductivity, density, specific_heat) {
    # modify insulation material properties of the exterior walls
    idf$set(`Steel Frame NonRes Wall Insulation` = list(
        conductivity = round(conductivity, 5),
        density = round(density, 2),
        specific_heat = round(specific_heat, 2)
    ))
}

# function to update window properties
update_window <- function(idf, u_value, SHGC) {
    # modify window material properties of the exterior windows
    idf$set(`NonRes Fixed Assembly Window` = list(
        u_factor = round(u_value, 4),
        solar_heat_gain_coefficient = round(SHGC, 3)
    ))
}

# function to update infiltration rate
update_infiltration <- function(idf, flow_per_area) {
    idf$set(ZoneInfiltration_DesignFlowRate := list(flow_per_exterior_surface_area = round(flow_per_area, 3)))
}

# function to update people density
update_people <- function(idf, people) {
    idf$set(People := list(zone_floor_area_per_person = round(people, 3)))
}

# function to update lighting power density
update_lights <- function(idf, lpd) {
    idf$set(Lights := list(watts_per_zone_floor_area = round(lpd, 3)))
}

# function to update electric equipment power density
update_equip <- function(idf, epd) {
    idf$set(ElectricEquipment := list(watts_per_zone_floor_area = round(epd, 3)))
}

# function to update cooling and heating setpoint
update_setpoint <- function(idf, cooling, heating) {
    clg <- as.character(round(cooling, 3))
    htg <- as.character(round(heating, 3))

    idf$set(
        CLGSETP_SCH = list(field_6 = clg, field_13 = clg),
        HTGSETP_SCH = list(field_6 = htg, field_16 = htg, field_21 = htg)
    )
}

