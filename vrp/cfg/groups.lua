
local cfg = {}

-- define each group with a set of permissions
-- _config property:
--- gtype (optional): used to have only one group with the same gtype per player (example: a job gtype to only have one job)
--- onspawn (optional): function(player) (called when the player spawn with the group)
--- onjoin (optional): function(player) (called when the player join the group)
--- onleave (optional): function(player) (called when the player leave the group)
--- (you have direct access to vRP and vRPclient, the tunnel to client, in the config callbacks)

local police = {}
function police.init(player)
  local weapons = {}
  weapons["WEAPON_STUNGUN"] = {ammo=1000}
  weapons["WEAPON_COMBATPISTOL"] = {ammo=100}
  weapons["WEAPON_NIGHTSTICK"] = {ammo=0}
  weapons["WEAPON_FLASHLIGHT"] = {ammo=0}
  
  vRPclient._giveWeapons(player,weapons,true)
  vRPclient._setCop(player,true)
end

function police.onjoin(player)
  police.init(player)
  vRPclient._notify(player,"Vous avez rejoint la police.")
end

function police.onleave(player)
  vRPclient.giveWeapons(player,{},true)
  vRPclient._notify(player,"Vous avez quitté la police.")
  vRPclient._setCop(player,false)
end

function police.onspawn(player)
  police.init(player)
  vRPclient._notify(player,"Vous êtes policier.")
end

local taxi = {}
function taxi.onjoin(player)
  vRPclient._notify(player,"Vous êtes chauffeur de taxi.")
end

function taxi.onspawn(player)
  vRPclient._notify(player,"Vous êtes chauffeur de taxi.")
end

function taxi.onleave(player)
  vRPclient._notify(player,"Vous avez quitté les chauffeurs de taxi.")
end

local repair = {}
function repair.onjoin(player)
  vRPclient._notify(player,"Vous êtes réparateur.")
end

function repair.onspawn(player)
  vRPclient._notify(player,"Vous êtes réparateur.")
end

function repair.onleave(player)
  vRPclient._notify(player,"Vous avez quitté les réparateurs.")
end

local emergency = {}
function emergency.onjoin(player)
  vRPclient._notify(player,"Vous êtes urgentiste.")
end

function emergency.onspawn(player)
  vRPclient._notify(player,"Vous êtes urgentiste.")
end

function emergency.onleave(player)
  vRPclient._notify(player,"Vous avez quitté les urgentistes.")
end

local function user_spawn(player)
  if user_id ~= nil and vRP.getSpawns(user_id) == 1 then
    -- motd 
    -- vRPclient._notify(player,"")
  end
end

cfg.groups = {
  ["superadmin"] = {
    _config = {onspawn = function(player) vRPclient._notify(player,"Vous êtes superadmin.") end},
    "player.group.add",
    "player.group.remove",
    "player.givemoney",
    "player.giveitem"
  },
  ["admin"] = {
    "player.list",
    "player.whitelist",
    "player.unwhitelist",
    "player.kick",
    "player.ban",
    "player.unban",
    "player.noclip",
    "player.custom_emote",
    "player.custom_sound",
    "player.display_custom",
    "player.coords",
    "player.tptome",
    "player.tpto",
    "admin.tickets",
    "admin.announce"
  },
  ["god"] = {
    "admin.god" -- reset survivals/health periodically
  },
  -- the group user is auto added to all logged players
  ["user"] = {
    _config = { onspawn = user_spawn },
    "player.phone",
    "player.calladmin",
    "police.askid",
    "police.store_weapons",
    "police.seizable" -- can be seized
  },
  ["police"] = {
    _config = { gtype = "job", onleave = police.onleave, onjoin = police.onjoin, onspawn = police.onspawn },
    "police.menu",
    "police.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.vehicle",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.chest_seized",
    "-police.store_weapons",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["emergency"] = {
    _config = { gtype = "job", onspawn = emergency.onspawn, onjoin = emergency.onjoin, onleave = emergency.onleave },
    "emergency.revive",
    "emergency.shop",
    "emergency.service",
    "emergency.vehicle",
    "emergency.cloakroom"
  },
  ["taxi"] = {
    _config = { gtype = "job", onspawn = taxi.onspawn, onjoin = taxi.onjoin, onleave = taxi.onleave },
    "taxi.service",
    "taxi.vehicle"
  },
  ["repair"] = {
    _config = { gtype = "job", onspawn = repair.onspawn, onjoin = repair.onjoin, onleave = repair.onleave },
    "vehicle.repair",
    "vehicle.replace",
    "repair.service",
    "mission.repair.satellite_dishes", -- basic mission
    "mission.repair.wind_turbines" -- basic mission
  },
  ["citizen"] = {
    _config = { gtype = "job" }
  }
}

-- groups are added dynamically using the API or the menu, but you can add group when an user join here
cfg.users = {
  [1] = { -- give superadmin and admin group to the first created user on the database
    "superadmin",
    "admin"
  }
}

-- group selectors
-- _config
--- x,y,z, blipid, blipcolor permissions (optional)

cfg.selectors = {
  ["Métiers"] = {
    _config = {x = -268.363739013672, y = -957.255126953125, z = 31.22313880920410, blipid = 351, blipcolor = 47},
    "taxi",
    "réparateur",
    "citoyen"
  },
  ["Pointage police"] = {
    _config = {x = 437.924987792969,y = -987.974182128906, z = 30.6896076202393 , blipid = 351, blipcolor= 38 },
    "police",
    "citoyen"
  },
  ["Pointage urgences"] = {
    _config = {x=-498.959716796875,y=-335.715148925781,z=34.5017547607422, blipid = 351, blipcolor= 1 },
    "urgences",
    "citoyen"
  }
}

return cfg

