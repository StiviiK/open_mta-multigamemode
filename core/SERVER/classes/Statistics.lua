if Database:isConnected() then
	Statistics = {};
	Statistics.classes = {}
	table.insert(core.startedClasses, {Statistics, "Statistics"})
	
	function Statistics:constructor ()
		outputDebug("[Statistics] Statistics has been successfull activated!")
			
		-- Load the Statistics Files
		for _, v in ipairs(classes.statistics) do
			if v[3] then
				outputDebug(("[Statistics] [STARTING] %s"):format(v[1]))
				require(v[2])
			end
		end
	end
	
	function Statistics:isClasspresent (class)
		for i, v in ipairs(self.classes) do
			if v[2] == class then
				return true;
			end
		end
		
		return false;
	end
	
	
	Statistics:constructor()
else
	outputDebug("[Statistics] There was not database connection established! Statistics won't work!", 1)
end