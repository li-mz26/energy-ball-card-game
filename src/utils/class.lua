-- 类系统 (简化版MiddleClass)
local Class = {}

function Class:new(super)
    local class = setmetatable({}, {__index = super or self})
    class.__index = class
    return class
end

function Class:extend()
    return self:new(self)
end

function Class:__call(...)
    local obj = setmetatable({}, self)
    if obj.init then obj:init(...) end
    return obj
end

return Class
