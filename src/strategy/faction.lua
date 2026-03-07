-- 势力类 (Faction)

local General = require("src.entities.general")

local Faction = Class:extend()

function Faction:init(data)
    self.id = data.id or "faction_" .. math.random(10000)
    self.name = data.name or "无名势力"
    self.isPlayer = data.isPlayer or false
    self.isAI = not self.isPlayer
    
    -- 势力颜色 (用于地图显示)
    self.color = data.color or {1, 1, 1}
    
    -- 控制的郡县
    self.counties = {}
    
    -- 将领池 (最多11人上场，但池子可以更大)
    self.generals = data.generals or {}
    self.generalPool = {}  -- 未上场的将领
    
    -- 君主/主将
    self.leader = data.leader or nil
    
    -- 传承等级 (轮回次数)
    self.legacyLevel = data.legacyLevel or 0
    
    -- 本轮战绩
    self.wins = 0
    self.losses = 0
    
    -- 初始化将领池
    self:organizeGenerals()
end

-- 整理将领 (前11人上场)
function Faction:organizeGenerals()
    self.generals = {}
    for i = 1, math.min(11, #self.generalPool) do
        table.insert(self.generals, self.generalPool[i])
    end
end

-- 添加郡县
function Faction:addCounty(county)
    table.insert(self.counties, county)
    county:setOwner(self)
end

-- 移除郡县
function Faction:removeCounty(county)
    for i, c in ipairs(self.counties) do
        if c == county then
            table.remove(self.counties, i)
            county:setOwner(nil)
            return true
        end
    end
    return false
end

-- 获取郡县数量
function Faction:getCountyCount()
    return #self.counties
end

-- 检查是否控制指定郡县
function Faction:ownsCounty(countyId)
    for _, county in ipairs(self.counties) do
        if county.id == countyId then
            return true
        end
    end
    return false
end

-- 获取可进攻的目标
function Faction:getAttackableTargets()
    local targets = {}
    local checked = {}
    
    for _, county in ipairs(self.counties) do
        for _, neighborId in ipairs(county.neighbors) do
            if not checked[neighborId] then
                checked[neighborId] = true
                -- 检查是否已被自己控制
                local isOwned = false
                for _, myCounty in ipairs(self.counties) do
                    if myCounty.id == neighborId then
                        isOwned = true
                        break
                    end
                end
                
                if not isOwned then
                    table.insert(targets, neighborId)
                end
            end
        end
    end
    
    return targets
end

-- 添加将领
function Faction:addGeneral(generalData)
    local general = General(generalData)
    table.insert(self.generalPool, general)
    
    -- 如果上场将领不足11人，自动补充
    if #self.generals < 11 then
        table.insert(self.generals, general)
    end
    
    return general
end

-- 招募将领 (从郡县特产)
function Faction:recruitFromCounty(county, availableGenerals)
    -- 筛选符合郡县特产的将领
    local candidates = {}
    for _, genData in ipairs(availableGenerals) do
        -- 简单匹配：同区域或同朝代
        if genData.origin == county.name or genData.dynasty == "汉" then
            table.insert(candidates, genData)
        end
    end
    
    if #candidates == 0 then
        -- 随机选择一个
        candidates = availableGenerals
    end
    
    local selected = candidates[math.random(#candidates)]
    return self:addGeneral(selected)
end

-- 是否被灭亡
function Faction:isDefeated()
    return #self.counties == 0
end

-- 获取势力强度评分
function Faction:getPowerScore()
    local score = 0
    -- 郡县数
    score = score + #self.counties * 10
    
    -- 将领平均属性
    for _, gen in ipairs(self.generals) do
        score = score + (gen.bravery + gen.command + gen.reception) / 10
    end
    
    return math.floor(score)
end

-- 记录胜利
function Faction:addWin()
    self.wins = self.wins + 1
end

-- 记录失败
function Faction:addLoss()
    self.losses = self.losses + 1
end

-- 重置回合统计
function Faction:resetStats()
    self.wins = 0
    self.losses = 0
end

-- 提升传承等级
function Faction:levelUpLegacy()
    self.legacyLevel = self.legacyLevel + 1
end

return Faction
