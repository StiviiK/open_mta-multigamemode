devSettings	= {}

-- Startup Classes (do not edit, unless you know what are you doing!)
-- Here you can define which classes should be started
devSettings.startup = {
	{"Databasemanager",   "core/SERVER/classes/Database.lua",           false},
	{"Playerclass",       "core/SERVER/classes/Player.lua",             true},
	{"Playermanager",     "core/SERVER/classes/Playermanager.lua",      true},
	{"Gamemodemanager",   "core/SERVER/classes/Gamemode.lua",           true},
	{"Elementmanager",    "core/SERVER/classes/Elementmanager.lua",     true},
	{"Permissionmanager", "core/SERVER/classes/Permissionmanager.lua",  true},
	{"Mapmanager",        "core/SERVER/classes/Mapmanager.lua",         true},
    {"Downloadmanager",   "core/SERVER/classes/Downloadmanager.lua",    true}
}