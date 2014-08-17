if (fileExists("/permissions.xml")) then
	Permissions = {}

	function Permissions:ff ()
	end
else
	local xml = xmlCreateFile("/permissions.xml", "Permissions")
	xmlSaveFile(xml)
	xmlUnloadFile(xml)
	
	restartResource(getThisResource())
end