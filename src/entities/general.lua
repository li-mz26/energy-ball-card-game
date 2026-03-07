-- 将领类 (General)

local Constants = require("src.utils.constants")

local General = Class:extend()

function General:init(data)
    self.id = data.id or tostring(math.random(1000000))
    self.name = data.name or "无名"
    self.title = data.title or ""
    
    -- 羁绊属性
    self.dynasty = data.dynasty or "未知"
    self.surname = data.surname or ""
    self.origin = data.origin or "未知"
    
    -- 品阶和等级
    self.rarity = data.rarity or Constants.RARITY.WHITE
    self.level = data.level or 1
    
    -- 基础属性
    self.maxHealth = data.maxHealth or 100
    self.currentHealth = self.maxHealth
    self.bravery = data.bravery or 50      -- 武勇
    self.command = data.command or 50      -- 调度
    self.reception = data.reception or 50  -- 接应
    self.insight = data.insight or 5       -- 洞察
    
    -- 特技
    self.skill = data.skill or nil
    
    -- 状态
    self.slot = nil
    self.hasTransferred = false
end

-- 受到伤害
function General:takeDamage(amount)
    self.currentHealth = math.max(0, self.currentHealth - amount)
end

-- 是否存活
function General:isAlive()
    return self.currentHealth > 0
end

-- 计算与另一将领的羁绊加成
function General:calculateBondBonus(other)
    local bonus = 0
    local bonds = {}
    
    -- 同朝
    if self.dynasty == other.dynasty then
        bonus = bonus + Constants.BOND.DYNASTY_BONUS
        table.insert(bonds, "同朝")
    end
    
    -- 同姓
    if self.surname == other.surname and self.surname ~= "" then
        bonus = bonus + Constants.BOND.SURNAME_BONUS
        table.insert(bonds, "同姓")
    end
    
    -- 同籍
    if self.origin == other.origin then
        bonus = bonus + Constants.BOND.ORIGIN_BONUS
        table.insert(bonds, "同籍")
    end
    
    -- 同朝同姓额外加成
    if self.dynasty == other.dynasty and self.surname == other.surname then
        bonus = bonus + Constants.BOND.COMBO_BONUS
    end
    
    return bonus, bonds
end

-- 获取输送成功率 (对特定目标)
function General:getDispatchSuccessRate(target)
    local baseRate = Constants.GAME.BASE_DISPATCH_SUCCESS_RATE
    
    -- 属性加成 (调度影响发送，接应影响接收)
    local statBonus = (self.command + target.reception) / 500  -- 最多+20%
    
    -- 羁绊加成
    local bondBonus = self:calculateBondBonus(target)
    
    -- 计算最终成功率
    local successRate = baseRate + statBonus + bondBonus
    
    -- 限制最大成功率
    successRate = math.min(successRate, Constants.BOND.MAX_SUCCESS_RATE)
    
    return successRate
end

-- 获取截击成功率
function General:getInterceptRate(distance)
    local baseRate = 0.35
    local braveryBonus = self.bravery / 200  -- 武勇影响，最多+50%
    local distancePenalty = distance * 0.1    -- 距离惩罚
    
    local rate = baseRate + braveryBonus - distancePenalty
    return math.max(0.05, math.min(0.90, rate))
end

-- 重置回合状态
function General:resetRound()
    self.hasTransferred = false
end

-- 获取显示名称
function General:getDisplayName()
    if self.title ~= "" then
        return self.title .. "·" .. self.name
    end
    return self.name
end

-- 获取品阶颜色
function General:getRarityColor()
    return self.rarity.color or {1, 1, 1}
end

return General
