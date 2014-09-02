Settings                        = {}
Settings.DATABASE_Host	 	= "127.0.0.1"
Settings.DATABASE_Name	 	= "root"
Settings.DATABASE_Pass 	 	= ""
Settings.DATABASE_DBName 	= "multi-sa"
Settings.DATABASE_Settings 	= "share=1"

-- Custom Events
addEvent("onPlayerGamemodeJoin", true)
addEvent("onPlayerGamemodeLeft", true)
addEvent("onGamemodeMinimumPlayerReached", true)

-- Experimental
RPC:addListeningEvent("onPlayerGamemodeJoin")
RPC:addListeningEvent("onPlayerGamemodeLeft")
RPC:addListeningEvent("onGamemodeMinimumPlayerReached")