-- This is the Database manager class for a MultiGamemode
Database = {};
table.insert(core.startedClasses, {Database, "Databasemanager"})

function Database:connect (host, user, pass, database, settings)
	--assert(type(host) == "string" and type(user) == "string" and type(pass) == "string" and type(database) == "string" and type(settings) == "string", "Bad Argument @ Database.connect [Invalid Arguments given!]")
	Check("Database.connect", "string", host, "Host", "string", user, "Username", "string", pass, "Password", "string", database, "Database-Name", "string", settings, "Settings")
	self.Connection = dbConnect("mysql", ("dbname=%s;host=%s"):format(database, host), user, pass, settings)
	
	if (self.Connection) then
		outputDebug("Database Connection failed! Stopping resource...")
		stopResource(getThisResource())
	end
end

function Database:destructor ()
	if (self:isConnected()) then
		destroyElement(self.Connection)
	end
end

function Database:isConnected ()
	return self.Connection ~= false and self.Connection ~= nil;
end

function Database:query (...)
	local query = self.Connection:query(...)
	local arg1, arg2, arg3 = query:poll(-1)
	
	if (not arg1) then
		outputDebug(("[Database] Query failed! Errormessage: %s [%d]"):format(arg3, arg2))
		return false;
	end
	
	return arg1, arg2, arg3;
end

function Database:execute (...)
	return self.Connection:exec(...);
end

function Database:disconnect ()
	if self.Connection ~= nil then
		return destroyElement(self.Connection);
	end
	
	return false;
end