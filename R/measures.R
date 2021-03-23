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

