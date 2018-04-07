
local cfg = {}

cfg.inventory_weight_per_strength = 10 -- weight for an user inventory per strength level (no unit, but thinking in "kg" is a good norm)

-- default chest weight for vehicle trunks
cfg.default_vehicle_chest_weight = 50

-- define vehicle chest weight by model in lower case
cfg.vehicle_chest_weights = {
  ["benson"] = 120,
  ["trailersmall"] = 100,
  ["trailers"] = 500,
  ["tanker"] = 5000
}

-- list of static chest types (map of name => {.title,.blipid,.blipcolor,.weight, .permissions (optional)})
cfg.static_chest_types = {
  ["police_seized"] = { -- example of a static chest
    title = "Saisies police",
    blipid = 374,
    blipcolor = 38,
    weight = 500,
    permissions = {"police.chest_seized"}
  }
}

-- list of static menu points
cfg.static_chests = {
  {"police_seized", 452.37237548828,-979.22149658203,30.689582824707}
}

return cfg
