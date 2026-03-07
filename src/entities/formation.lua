-- 军阵类 (Formation)

local Constants = require("src.utils.constants")

local Formation = Class:extend()

function Formation:init(index, owner)
    self.index = index
    self.name = Constants.GAME.FORMATION_NAMES[index]
    self.owner = owner
    self.maxSlots = Constants.GAME.FORMATION_SLOTS[index]
    self.slots = {}
    
    -- 初始化空槽位
    for i = 1, self.maxSlots do
        self.slots[i] = {
            index = i,
            general = nil,
        }
    end
end

-- 放置将领
function Formation:placeGeneral(general, slotIndex)
    if slotIndex < 1 or slotIndex > self.maxSlots then
        return false
    end
    
    local slot = self.slots[slotIndex]
    if slot.general ~= nil then
        return false -- 槽位已被占用
    end
    
    slot.general = general
    general.slot = {formation = self, slotIndex = slotIndex}
    return true
end

-- 移除将领
function Formation:removeGeneral(slotIndex)
    local slot = self.slots[slotIndex]
    if not slot or not slot.general then
        return nil
    end
    
    local general = slot.general
    general.slot = nil
    slot.general = nil
    return general
end

-- 获取槽位中的将领
function Formation:getGeneral(slotIndex)
    local slot = self.slots[slotIndex]
    return slot and slot.general or nil
end

-- 检查是否已满
function Formation:isFull()
    for _, slot in ipairs(self.slots) do
        if slot.general == nil then
            return false
        end
    end
    return true
end

-- 获取当前将领数量
function Formation:getGeneralCount()
    local count = 0
    for _, slot in ipairs(self.slots) do
        if slot.general then
            count = count + 1
        end
    end
    return count
end

-- 获取所有存活将领
function Formation:getAliveGenerals()
    local generals = {}
    for _, slot in ipairs(self.slots) do
        if slot.general and slot.general:isAlive() then
            table.insert(generals, slot.general)
        end
    end
    return generals
end

-- 获取第一个可用槽位
function Formation:getFirstEmptySlot()
    for i, slot in ipairs(self.slots) do
        if slot.general == nil then
            return i
        end
    end
    return nil
end

-- 清空所有将领
function Formation:clear()
    local removed = {}
    for i, slot in ipairs(self.slots) do
        if slot.general then
            table.insert(removed, slot.general)
            slot.general.slot = nil
            slot.general = nil
        end
    end
    return removed
end

return Formation
