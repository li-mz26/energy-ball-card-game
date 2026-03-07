-- 势力类 (Faction)
-- 代表地图上的一个势力/阵营

local CountyData = require("src.data.county_data")

local Faction = Class:extend()

function Faction:init(data)
    self.id = data.id or "faction_" .. math.random(10000)
    self.name = data.name or "无名势力"
    self.color = data.color or {1, 1, 1}
    
    -- 控制的郡县
    self.counties = data.counties or {}
    
    -- 将领池
    self.generals = data.generals or {}
    self.maxGenerals = data.maxGenerals or 30
    
    -- 势力等级（轮回次数）
    self.level = data.level or 1
    
    -- 是否玩家控制
    self.isPlayer = data.isPlayer or false
    
    -- 势力君主（用于显示）
    self.leader = data.leader or nil
    
    -- 本回合是否已行动
    self.hasActed = false
    
    -- 势力状态
    self.defeated = false
end

-- 添加郡县
function Faction:addCounty(countyId)
    -- 检查是否已拥有
    for _, id in ipairs(self.counties) do
        if id == countyId then
            return false
        end
    end
    
    table.insert(self.counties, countyId)
    return true
end

-- 移除郡县
function Faction:removeCounty(countyId)
    for i, id in ipairs(self.counties) do
        if id == countyId then
            table.remove(self.counties, i)
            return true
        end
    end
    return false
end

-- 检查是否控制某个郡县
function Faction:controlsCounty(countyId)
    for _, id in ipairs(self.counties) do
        if id == countyId then
            return true
        end
    end
    return false
end

-- 获取可进攻的目标（相邻但不属于己方）
function Faction:getAttackableTargets()
    local targets = {}
    
    for _, countyId in ipairs(self.counties) do
        local neighbors = CountyData:getNeighbors(countyId)
        for _, neighbor in ipairs(neighbors) do
            -- 检查是否已拥有
            if not self:controlsCounty(neighbor.id) then
                -- 检查是否已在目标列表
                local exists = false
                for _, target in ipairs(targets) do
                    if target.id == neighbor.id then
                        exists = true
                        break
                    end
                end
                if not exists then
                    table.insert(targets, neighbor)
                end
            end
        end
    end
    
    return targets
end

-- 添加将领
function Faction:addGeneral(general)
    if #self.generals >= self.maxGenerals then
        return false, "将领池已满"
    end
    
    table.insert(self.generals, general)
    return true
end

-- 移除将领
function Faction:removeGeneral(generalId)
    for i, general in ipairs(self.generals) do
        if general.id == generalId then
            table.remove(self.generals, i)
            return general
        end
    end
    return nil
end

-- 获取存活将领数量
function Faction:getGeneralCount()
    return #self.generals
end

-- 选择11名上阵将领（用于战斗）
function Faction:selectBattleGenerals()
    local selected = {}
    local count = math.min(11, #self.generals)
    
    -- 优先选择等级高的将领
    local sorted = {}
    for _, g in ipairs(self.generals) do
        table.insert(sorted, g)
    end
    
    table.sort(sorted, function(a, b)
        return (a.level * 100 + a.rarity.level) > (b.level * 100 + b.rarity.level)
    end)
    
    for i = 1, count do
        table.insert(selected, sorted[i])
    end
    
    return selected
end

-- 获取势力中心位置（用于地图显示）
function Faction:getCenterPosition()
    if #self.counties == 0 then
        return 0, 0
    end
    
    local totalX, totalY = 0, 0
    for _, countyId in ipairs(self.counties) do
        local county = CountyData:getCounty(countyId)
        if county then
            totalX = totalX + county.x
            totalY = totalY + county.y
        end
    end
    
    return totalX / #self.counties, totalY / #self.counties
end

-- 检查是否被灭亡
function Faction:checkDefeated()
    if #self.counties == 0 then
        self.defeated = true
        return true
    end
    return false
end

-- 合并另一势力的所有郡县和将领
function Faction:absorb(otherFaction)
    -- 吞并郡县
    for _, countyId in ipairs(otherFaction.counties) do
        self:addCounty(countyId)
    end
    
    -- 收编将领（上限限制）
    for _, general in ipairs(otherFaction.generals) do
        self:addGeneral(general)
    end
    
    -- 标记对方为灭亡
    otherFaction.defeated = true
    otherFaction.counties = {}
    otherFaction.generals = {}
end

-- 重置回合状态
function Faction:resetTurn()
    self.hasActed = false
end

-- 增加势力等级（轮回继承）
function Faction:levelUp()
    self.level = self.level + 1
end

return Faction
