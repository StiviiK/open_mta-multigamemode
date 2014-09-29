POParser = {}
-- Class by Jusonex (https://github.com/OpenMTADayZ/open_dayz_playground/blob/master/open_dayz/shared/classes/POParser.lua)

setmetatable(POParser,
    {
        __call = function (self, poPath) self.m_Strings = {}
            local file = File.Open(poPath, true)
            local lines = split(assert(file:getContent(), "Reading the translation file failed"), "\n")
            local lastKey
            for _, line in ipairs(lines) do
                local pos = line:find(' ')
                if pos then
                    local instruction = line:sub(1, pos-1)
                    local argument = line:sub(pos+1)
                    if instruction == "msgid" then
                        -- Remove ""
                        argument = argument:sub(2, #argument-2)
                        self.m_Strings[argument] = false
                        lastKey = argument
                    elseif instruction == "msgstr" then
                        -- Remove ""
                        argument = argument:sub(2, #argument-2)
                        self.m_Strings[lastKey] = argument
                    end
                end
            end
        end
    }
)