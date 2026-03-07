-- 玩家类 (Player)

local Constants = require("src.utils.constants")
local Formation = require("src.entities.formation")

local Player = Class:extend()

function Player:init(data)
    self.id = data.id or "player_" .. math.random(1000)
    self.name = data.name or "玩家"
    self.isAI = data.isAI or false
    
    -- 主营生命值
    self.mainCampHealth = Constants.GAME.MAIN_CAMP_HEALTH
    self.maxMainCampHealth = Constants.GAME.MAIN_CAMP_HEALTH
    
    -- 军阵
    self.formations = {}
    for i = 1, Constants.GAME.FORMATION_COUNT do
        self.formations[i] = Formation(i, self)
    end
    
    -- 将领收藏 (MVP简化，直接用所有可用将领)
    self.generals = data.generals or {}
    
    -- 手牌 (待部署的将领)
    self.hand = {}
    for _, general in ipairs(self.generals) do
        table.insert(self.hand, general)
    end
end

-- 部署将领到指定军阵和槽位
function Player:deployGeneral(general, formationIndex, slotIndex)
    local formation = self.formations[formationIndex]
    if not formation then
        return false
    end
    
    -- 从手牌中移除
    for i, g in ipairs(self.hand) do
        if g == general then
            table.remove(self.hand, i)
            break
        end
    end
    
    -- 放置到军阵
    return formation:placeGeneral(general, slotIndex)
end

-- 从手牌移除将领
function Player:removeFromHand(general)
    for i, g in ipairs(self.hand) do
        if g == general then
            table.remove(self.hand, i)
            return true
        end
    end
    return false
end

-- 对主营造成伤害
function Player:takeDamage(amount)
    self.mainCampHealth = math.max(0, self.mainCampHealth - amount)
end

-- 主营是否被攻破
function Player:isDefeated()
    return self.mainCampHealth <= 0
end

-- 获取主营生命值百分比
function Player:getHealthPercent()
    return self.mainCampHealth / self.maxMainCampHealth
end

-- 获取所有军阵
function Player:getAllFormations()
    return self.formations
end

-- 获取指定军阵
function Player:getFormation(index)
    return self.formations[index]
end

-- 获取所有存活将领
function Player:getAllAliveGenerals()
    local all = {}
    for _, formation in ipairs(self.formations) do
        for _, general in ipairs(formation:getAliveGenerals()) do
            table.insert(all, general)
        end
    end
    return all
end

-- 清空所有军阵 (回合结束/重新布阵)
function Player:clearFormations()
    for _, formation in ipairs(self.formations) do
        local removed = formation:clear()
        -- 将领回到手牌
        for _, general in ipairs(removed) do
            table.insert(self.hand, general)
        end
    end
end

return Player
