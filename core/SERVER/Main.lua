Main = {}

function Main.onStartup ()
	core = Core:constructor()
end
Main.onStartup()

function Main.onStop ()
	core:destructor()
end
addEventHandler("onResourceStop", resourceRoot, Main.onStop, true, "low-9999")

--Database:connect(Settings.DATABASE_Host, Settings.DATABASE_Name, Settings.DATABASE_Pass, Settings.DATABASE_DBName, Settings.DATABASE_Settings)