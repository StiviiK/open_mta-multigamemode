if DEBUG then
	Debugging = {}
	table.insert(core.startedClasses, {Debugging, "Debuggingclass"})
	
	function Debugging:constructor ()
	end
	
	function Debugging:destructor ()
	end
	
	function Debugging:outputDebug ()
	end
end