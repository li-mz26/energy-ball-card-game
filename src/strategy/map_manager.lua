-- 地图管理器 (MapManager)

local CountyData = require("src.data.county_data")
local County = require("src.strategy.county")
local Faction = require("src.strategy.faction")

local MapManager = Class:extend()

function MapManager:init()
    self.counties = {}      -- 所有郡县
    self.factions = {}      -- 所有势力
    self.playerFaction = nil
    
    -- 初始化郡县
    self:initCounties()
end

-- 初始化郡县
function MapManager:initCounties()
    for _, data in ipairs(CountyData.COUNTIES) do
        local county = County(data)
        self.counties[county.id] = county
    end
end

-- 根据ID获取郡县
function MapManager:getCounty(id)
    return self.counties[id]
end

-- 获取所有郡县
function MapManager:getAllCounties()
    local list = {}
    for _, county in pairs(self.counties) do
        table.insert(list, county)
    end
    return list
end

-- 创建势力
function MapManager:createFaction(data)
    local faction = Faction(data)
    table.insert(self.factions, faction)
    
    if faction.isPlayer then
        self.playerFaction = faction
    end
    
    return faction
end

-- 随机分配郡县给势力
function MapManager:distributeCounties(factionCount)
    local allCounties = self:getAllCounties()
    
    -- 清空现有所有权
    for _, county in pairs(self.counties) do
        county.owner = nil
        county.faction = nil
    end
    
    -- 随机打乱郡县
    for i = #allCounties, 2, -1 do
        local j = math.random(i)
        allCounties[i], allCounties[j] = allCounties[j], allCounties[i]
    end
    
    -- 分配给各势力
    local countiesPerFaction = math.floor(#allCounties / factionCount)
    local index = 1
    
    for i, faction in ipairs(self.factions) do
        local count = countiesPerFaction
        if i == 1 then
            -- 给玩家稍微少一点，增加挑战性
            count = countiesPerFaction - 1
        elseif i == factionCount then
            -- 最后一个势力拿剩余
            count = #allCounties - index + 1
        end
        
        for j = 1, count do
            if index <= #allCounties then
                faction:addCounty(allCounties[index])
                index = index + 1
            end
        end
    end
end

-- 获取势力数量
function MapManager:getFactionCount()
    return #self.factions
end

-- 获取存活势力
function MapManager:getAliveFactions()
    local alive = {}
    for _, faction in ipairs(self.factions) do
        if not faction:isDefeated() then
            table.insert(alive, faction)
        end
    end
    return alive
end

-- 检查是否统一
function MapManager:checkUnification()
    local alive = self:getAliveFactions()
    return #alive == 1, alive[1]
end

-- 获取某郡县的占领者
function MapManager:getOwnerOf(countyId)
    local county = self.counties[countyId]
    return county and county.faction
end

-- 转移郡县所有权
function MapManager:transferCounty(countyId, fromFaction, toFaction)
    local county = self.counties[countyId]
    if not county then return false end
    
    if fromFaction then
        fromFaction:removeCounty(county)
    end
    
    toFaction:addCounty(county)
    return true
end

-- AI势力选择进攻目标
function MapManager:aiSelectTarget(aiFaction)
    local targets = aiFaction:getAttackableTargets()
    
    if #targets == 0 then
        return nil
    end
    
    -- 简单AI：优先选择弱的邻居
    -- 可以扩展为更复杂的策略
    return targets[math.random(#targets)]
end

-- 获取势力颜色列表
function MapManager:getFactionColors()
    return {
        {0.9, 0.2, 0.2},  -- 红
        {0.2, 0.6, 0.9},  -- 蓝
        {0.2, 0.8, 0.2},  -- 绿
        {0.9, 0.8, 0.2},  -- 黄
        {0.8, 0.2, 0.9},  -- 紫
        {0.9, 0.5, 0.2},  -- 橙
        {0.2, 0.9, 0.9},  -- 青
        {0.9, 0.9, 0.9},  -- 白
    }
end

-- 重置地图
function MapManager:reset()
    self.factions = {}
    self.playerFaction = nil
    
    for _, county in pairs(self.counties) do
        county.owner = nil
        county.faction = nil
    end
end

-- 获取地图统计
function MapManager:getStats()
    local stats = {
        totalCounties = 0,
        occupiedCounties = 0,
        factionCounties = {}
    }
    
    for _, county in pairs(self.counties) do
        stats.totalCounties = stats.totalCounties + 1
        if county:isOccupied() then
            stats.occupiedCounties = stats.occupiedCounties + 1
        end
    end
    
    for _, faction in ipairs(self.factions) do
        stats.factionCounties[faction.name] = faction:getCountyCount()
    end
    
    return stats
end

return MapManager
