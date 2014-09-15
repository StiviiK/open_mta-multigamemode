Settings                        = {}

-- Database
Settings.DATABASE_Host		= "127.0.0.1"
Settings.DATABASE_Name		= "root"
Settings.DATABASE_Pass		= ""
Settings.DATABASE_DBName	= "multi-sa"
Settings.DATABASE_Settings	= "share=1"

-- Custom Events
addEvent("onPlayerGamemodeJoin", true)
addEvent("onPlayerGamemodeLeft", true)
addEvent("onGamemodeMinimumPlayerReached", true)

-- Experimental
RPC:addListeningEvent("onPlayerGamemodeJoin")
RPC:addListeningEvent("onPlayerGamemodeLeft")
RPC:addListeningEvent("onGamemodeMinimumPlayerReached")

-- Functions
function require (file)
	if type(file) == "string" then
		if fileExists(file) then
			local fileName = file
			local file = fileOpen(fileName, true)
			
			if fileGetSize(file) > 0 then
				local f, errmsg = loadstring(fileRead(file, fileGetSize(file)), fileName)
					if (f) then			
						local status, errmsg = pcall(f)
						
						if (not status) then
							error(errmsg, 0)
						end
						
						return true;
					else
						error(errmsg, 0)
					end
				else
					fileClose(file)
					error("Error @ 'require' [Got empty file!]", 2)
				end
		else
			error("Error @ 'require' [File not found!]", 2)
		end
	else
		error("Bad Argument @ 'require' [Expected file at Argument 1, got "..type(file).."]", 2)
	end
end