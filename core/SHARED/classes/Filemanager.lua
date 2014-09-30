File = {}

-- Save the default functions
File.backup = {
    fileOpen = fileOpen,
    fileCreate = fileCreate,
    fileClose = fileClose
}

-- Functions
function File:create (path)
    local f = File.backup.fileCreate(path)

    if f then
        fileClose(f)
        return File:open(path);
    end

    return false;
end
function File:open (f, ...)
    if fileExists(f) then
        local obj = setmetatable({
            handle = File.backup.fileOpen(f, ...)
        }, {
            __index = self
        })

        if obj.handle then
           return obj;
        end
    end

    return false;
end

function File:close ()
    File.backup.fileClose(self.handle)
    self.handle = nil
end

function File:read (c)
    if not c then c = self:getSize() end

    if c > 0 then
        return fileRead(self.handle, c)
    end

    return "";
end

function File:write (data)
    fileWrite(self.handle, data or "")
end

function File:getSize ()
    return self.handle ~= nil and fileGetSize(self.handle) or false;
end

function File:md5 ()
    return md5(self:read());
end

function File:base64 ()
    return base64Encode(self:read());
end

_G["fileOpen"] = function (...) return File:open(...) end
_G["fileCreate"] = function (...) return File:create(...) end
_G["fileClose"] = function (f, ...) return f:close(...) end