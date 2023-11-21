

# pgn_with_instance = [
#     "127488",
#     # - engine_boost_pressure
#     # -"engine_tilt_trim": 64,
#  engine_speed
# ]

engine_status_items = {
    127489: [
        "engine_oil_press",
        "engine_oil_temp",
        "engine_coolant_temp",
        "alternator_voltage",
        "engine_hours",
        "engine_coolant_press",
        "engine_fuel_press",
    ],
    127493: ["oil_pressure", "oil_temperature"],
}


battery_status_items = {
    127506: [
        "DC_type",
        "state_of_charge",
        "state_of_health",
        "ripple_voltage",
        "capacity",
    ],
    127508: ["battery_voltage", "battery_temperature"],
}


# internal
vessel_status_items = {
    130311: ["temperature", "temperature_source", "humidity"],
    130312: ["temperature", "temperature_source", "humidity"],
    130314: ["pressure", "pressure_source"],
}


# external
environmental_status_items = {
    128267: ["water_depth_below_surface"],
    130311: ["temperature", "temperature_source", "humidity"],
    130312: ["temperature", "temperature_source", "humidity"],
    130314: ["pressure", "pressure_source"],
    130306: ["wind_speed", "wind_angle"],
}


tank_status_items = {127505: ["fluid_type", "level", "capacity"]}

vessel_temp_mappings = [
    "Inside air temperature",
    "Engine room temperature",
    "Main cabin temperature",
    "Live well temperature",
    "Bait well temperature",
    "Regrigeration temperature",
    "Heating system temperature",
    "Freezer temperature",
    "Exhaust gas temperature",
]

env_temp_mappings = [
    "Sea temperature",
    "Outside air temperature",
    "Dew point temperature",
    "Apparent wind chill temperature",
    "Theoretical wind chill temperature",
    "Heat index temperature",
]

env_pressure_mappings = ["Atmospheric pressure", "Unknown"]
