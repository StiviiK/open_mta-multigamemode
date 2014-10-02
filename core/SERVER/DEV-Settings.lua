devSettings	= {}

-- Startup Classes (do not edit, unless you know what are you doing!)
-- Here you can define which classes should be started
devSettings.startup = {
	{"Databasemanager",   "core/SERVER/classes/Database.lua",           false}, -- ID: 1
	{"Playerclass",       "core/SERVER/classes/Player.lua",             true}, -- ID: 2
	{"Playermanager",     "core/SERVER/classes/Playermanager.lua",      true}, -- ID: 3
	{"Gamemodemanager",   "core/SERVER/classes/Gamemode.lua",           true}, -- ID: 4
	{"Elementmanager",    "core/SERVER/classes/Elementmanager.lua",     true}, -- ID: 5
	{"Permissionmanager", "core/SERVER/classes/Permissionmanager.lua",  true}, -- ID: 6
	{"Mapmanager",        "core/SERVER/classes/Mapmanager.lua",         true}, -- ID: 7
    {"Downloadmanager",   "core/SERVER/classes/Downloadmanager.lua",    true} -- ID: 8
}