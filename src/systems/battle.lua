-- 战斗系统 (BattleSystem)

local Supply = require("src.entities.supply")

local BattleSystem = Class:extend()

function BattleSystem:init(game, attacker, defender)
    self.game = game
    self.attacker = attacker
    self.defender = defender
    
    self.state = "idle" -- idle, dispatching, resolving, finished
    self.currentFormationIndex = 1
    self.supplies = {}
    self.damageDealt = 0
    self.message = ""
    self.messageTimer = 0
    
    -- 动画控制
    self.animationQueue = {}
    self.currentAnimation = nil
    self.animationTimer = 0
end

function BattleSystem:start()
    self.state = "dispatching"
    self:message("战斗开始！" .. self.attacker.name .. "发动进攻")
    
    -- 从先锋开始创建军资
    self:createSupplies()
end

-- 创建军资
function BattleSystem:createSupplies()
    local vanguard = self.attacker:getFormation(1)
    if not vanguard then return end
    
    local general = vanguard:getGeneral(1)
    if not general or not general:isAlive() then
        self:message("先锋阵亡，无法发动进攻")
        self.state = "finished"
        return
    end
    
    -- 创建5份军资 (MVP简化)
    local nextFormation = self.attacker:getFormation(2)
    if nextFormation then
        local targetSlot = nextFormation.slots[1] -- 简化：总是传给第一个
        
        for i = 1, 5 do
            local supply = Supply(general, targetSlot)
            table.insert(self.supplies, supply)
        end
        
        self:message(general:getDisplayName() .. "发动了5份军资")
    end
    
    -- 开始处理军资
    self:processNextSupply()
end

-- 处理下一份军资
function BattleSystem:processNextSupply()
    if #self.supplies == 0 then
        self:finishBattle()
        return
    end
    
    local supply = table.remove(self.supplies, 1)
    
    -- 执行输送判定
    local success = supply:attemptDispatch()
    
    if success then
        self:message(string.format("%s 成功送达", supply.dispatcher.name))
        -- 送达大营则造成伤害
        if supply.targetSlot and supply.targetSlot.formation and supply.targetSlot.formation.index == 4 then
            self.damageDealt = self.damageDealt + 10
        end
    else
        if supply.state == "lost" then
            self:message(string.format("%s 在输送途中损耗", supply.dispatcher.name))
        else
            self:message(string.format("%s 输送失败", supply.dispatcher.name))
        end
    end
    
    -- 延迟处理下一份
    self.animationTimer = 1.0  -- 1秒延迟
end

function BattleSystem:update(dt)
    -- 更新动画计时器
    if self.animationTimer > 0 then
        self.animationTimer = self.animationTimer - dt
        if self.animationTimer <= 0 then
            self.animationTimer = 0
            if self.state == "dispatching" then
                self:processNextSupply()
            end
        end
    end
    
    -- 更新消息计时器
    if self.messageTimer > 0 then
        self.messageTimer = self.messageTimer - dt
    end
end

function BattleSystem:message(text)
    self.message = text
    self.messageTimer = 3.0  -- 显示3秒
    print(text)  -- 控制台也输出
end

function BattleSystem:finishBattle()
    self.state = "finished"
    
    -- 造成伤害
    if self.damageDealt > 0 then
        self.defender:takeDamage(self.damageDealt)
        self:message(string.format("造成 %d 点伤害！敌方主营剩余 %d 生命", 
            self.damageDealt, self.defender.mainCampHealth))
    else
        self:message("未能造成伤害")
    end
    
    -- 延迟结束
    self.animationTimer = 2.0
end

return BattleSystem
