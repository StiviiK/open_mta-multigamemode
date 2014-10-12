DEBUG = true
VERSION = "0.2dev 0"

classes = {
	server = {
		{"Databasemanager",   "core/SERVER/classes/Database.lua",           true}, -- ID: 1
		{"Playerclass",       "core/SERVER/classes/Player.lua",             true}, -- ID: 2
		{"Playermanager",     "core/SERVER/classes/Playermanager.lua",      true}, -- ID: 3
		{"Gamemodemanager",   "core/SERVER/classes/Gamemode.lua",           true}, -- ID: 4
		{"Elementmanager",    "core/SERVER/classes/Elementmanager.lua",     true}, -- ID: 5
		{"Permissionmanager", "core/SERVER/classes/Permissionmanager.lua",  true}, -- ID: 6
		{"Mapmanager",        "core/SERVER/classes/Mapmanager.lua",         true}, -- ID: 7
		{"Downloadmanager",   "core/SERVER/classes/Downloadmanager.lua",    true},  -- ID: 8
		{"Statistics",        "core/SERVER/classes/Statistics.lua",         true}  -- ID: 9
	},
	statistics = {
		{"Playerdata",   "core/SERVER/statistics/playerdata.lua", true}
	}
}