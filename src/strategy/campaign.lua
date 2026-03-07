-- 战役管理器 (Campaign)
-- 管理大战略模式的游戏流程

local CountyData = require("src.data.county_data")
local Faction = require("src.strategy.faction")
local AllGenerals = require("src.data.all_generals")

local Campaign = Class:extend()

function Campaign:init(game)
    self.game = game
    
    -- 战役状态
    self.round = 1          -- 当前轮回
    self.turn = 1           -- 当前回合
    self.factions = {}      -- 所有势力
    self.playerFaction = nil -- 玩家势力
    
    -- 战斗队列
    self.pendingBattles = {} -- 待进行的战斗
    self.currentBattle = nil -- 当前进行的战斗
    
    -- 游戏状态
    self.state = "setup"    -- setup, strategy, battle, result, unified
    self.paused = false
    
    -- 历史记录
    self.history = {
        rounds = {},         -- 每轮回的记录
        conquests = {}       -- 征服记录
    }
end

-- 初始化新战役
function Campaign:startNewCampaign(playerData)
    self.state = "setup"
    
    -- 创建势力
    self:createFactions()
    
    -- 设置玩家势力
    self:setupPlayerFaction(playerData)
    
    -- 分配初始郡县
    self:distributeCounties()
    
    self.state = "strategy"
    print("战役开始！当前轮回: " .. self.round)
end

-- 创建势力
function Campaign:createFactions()
    self.factions = {}
    
    -- 创建玩家势力（稍后设置）
    -- 创建AI势力
    local aiColors = {
        {0.9, 0.2, 0.2},  -- 红
        {0.2, 0.9, 0.2},  -- 绿
        {0.2, 0.2, 0.9},  -- 蓝
        {0.9, 0.9, 0.2},  -- 黄
        {0.9, 0.2, 0.9},  -- 紫
        {0.2, 0.9, 0.9},  -- 青
        {0.9, 0.5, 0.2},  -- 橙
        {0.5, 0.2, 0.9},  -- 靛
    }
    
    local aiNames = {"曹魏", "蜀汉", "孙吴", "袁绍", "刘表", "马腾", "刘璋", "张鲁"}
    
    for i = 1, 8 do
        local faction = Faction({
            id = "ai_" .. i,
            name = aiNames[i] or "势力" .. i,
            color = aiColors[i] or {0.5, 0.5, 0.5},
            isPlayer = false,
            level = self.round -- 随轮回增加等级
        })
        
        table.insert(self.factions, faction)
    end
end

-- 设置玩家势力
function Campaign:setupPlayerFaction(playerData)
    local playerFaction = Faction({
        id = "player",
        name = playerData.name or "玩家势力",
        color = {1, 0.8, 0.2},  -- 金黄色
        isPlayer = true,
        level = self.round
    })
    
    -- 添加初始将领
    for _, general in ipairs(playerData.generals or {}) do
        playerFaction:addGeneral(general)
    end
    
    table.insert(self.factions, 1, playerFaction)
    self.playerFaction = playerFaction
end

-- 分配初始郡县
function Campaign:distributeCounties()
    local counties = CountyData:getAllCounties()
    local factionIndex = 1
    
    -- 随机打乱
    for i = #counties, 2, -1 do
        local j = math.random(i)
        counties[i], counties[j] = counties[j], counties[i]
    end
    
    -- 分配（每个势力2个初始郡县）
    for i, county in ipairs(counties) do
        local faction = self.factions[factionIndex]
        if faction then
            faction:addCounty(county.id)
            
            -- 该郡县特产将领加入势力
            local specialties = CountyData:getSpecialtyGenerals(county.id)
            for _, spec in ipairs(specialties) do
                if math.random() < 0.5 then  -- 50%概率获得
                    local general = AllGenerals:getBySurname(spec.surname)[1]
                    if general then
                        faction:addGeneral(general)
                    end
                end
            end
            
            factionIndex = factionIndex + 1
            if factionIndex > #self.factions then
                factionIndex = 1
            end
        end
    end
end

-- 开始战略回合
function Campaign:startStrategyTurn()
    self.state = "strategy"
    self.pendingBattles = {}
    
    -- 重置所有势力的行动状态
    for _, faction in ipairs(self.factions) do
        if not faction.defeated then
            faction:resetTurn()
        end
    end
    
    print("第 " .. self.turn .. " 回合开始")
end

-- 玩家选择进攻目标
function Campaign:playerSelectTarget(targetCountyId)
    if self.state ~= "strategy" then
        return false, "不在战略阶段"
    end
    
    if self.playerFaction.hasActed then
        return false, "本回合已行动"
    end
    
    -- 检查是否相邻
    local canAttack = false
    for _, countyId in ipairs(self.playerFaction.counties) do
        if CountyData:isAdjacent(countyId, targetCountyId) then
            canAttack = true
            break
        end
    end
    
    if not canAttack then
        return false, "目标不相邻"
    end
    
    -- 查找目标郡县所属势力
    local targetFaction = nil
    for _, faction in ipairs(self.factions) do
        if faction:controlsCounty(targetCountyId) then
            targetFaction = faction
            break
        end
    end
    
    if not targetFaction then
        return false, "目标无归属"
    end
    
    if targetFaction == self.playerFaction then
        return false, "不能攻击自己的郡县"
    end
    
    -- 创建战斗
    table.insert(self.pendingBattles, {
        attacker = self.playerFaction,
        defender = targetFaction,
        county = targetCountyId
    })
    
    self.playerFaction.hasActed = true
    return true
end

-- AI行动
function Campaign:aiActions()
    for _, faction in ipairs(self.factions) do
        if not faction.isPlayer and not faction.defeated and not faction.hasActed then
            self:aiDecision(faction)
        end
    end
end

-- AI决策
function Campaign:aiDecision(faction)
    local targets = faction:getAttackableTargets()
    
    if #targets > 0 then
        -- 随机选择一个目标
        local target = targets[math.random(#targets)]
        
        -- 查找目标所属势力
        for _, otherFaction in ipairs(self.factions) do
            if otherFaction:controlsCounty(target.id) then
                table.insert(self.pendingBattles, {
                    attacker = faction,
                    defender = otherFaction,
                    county = target.id
                })
                break
            end
        end
    end
    
    faction.hasActed = true
end

-- 执行所有待进行的战斗
function Campaign:executeBattles()
    if #self.pendingBattles == 0 then
        self:endTurn()
        return
    end
    
    self.state = "battle"
    self.currentBattle = table.remove(self.pendingBattles, 1)
    
    -- 通知游戏进入战斗
    if self.game then
        self.game:startCampaignBattle(self.currentBattle)
    end
end

-- 战斗结果处理
function Campaign:resolveBattle(winner, loser, countyId)
    -- 转移郡县
    loser:removeCounty(countyId)
    winner:addCounty(countyId)
    
    -- 记录征服
    table.insert(self.history.conquests, {
        turn = self.turn,
        winner = winner.name,
        loser = loser.name,
        county = countyId
    })
    
    -- 检查失败者是否灭亡
    if loser:checkDefeated() then
        print(loser.name .. " 被灭亡！")
        -- 胜者吸收败者将领
        winner:absorb(loser)
    end
    
    -- 继续下一场战斗
    if #self.pendingBattles > 0 then
        self.currentBattle = table.remove(self.pendingBattles, 1)
        if self.game then
            self.game:startCampaignBattle(self.currentBattle)
        end
    else
        self:endTurn()
    end
end

-- 结束回合
function Campaign:endTurn()
    self.turn = self.turn + 1
    
    -- 检查统一
    if self:checkUnification() then
        self:handleUnification()
    else
        self:startStrategyTurn()
    end
end

-- 检查是否统一
function Campaign:checkUnification()
    local aliveFactions = 0
    for _, faction in ipairs(self.factions) do
        if not faction.defeated then
            aliveFactions = aliveFactions + 1
        end
    end
    return aliveFactions <= 1
end

-- 处理统一
function Campaign:handleUnification()
    self.state = "unified"
    
    -- 查找统一者
    local unifier = nil
    for _, faction in ipairs(self.factions) do
        if not faction.defeated then
            unifier = faction
            break
        end
    end
    
    if unifier then
        print(unifier.name .. " 统一了天下！")
        
        -- 如果是玩家，进入下一轮回
        if unifier.isPlayer then
            self:startNewRound()
        else
            -- 玩家失败
            self:gameOver(false)
        end
    end
end

-- 开始新轮回
function Campaign:startNewRound()
    self.round = self.round + 1
    self.turn = 1
    
    -- 记录历史
    table.insert(self.history.rounds, {
        round = self.round - 1,
        unifier = self.playerFaction.name,
        generalCount = #self.playerFaction.generals
    })
    
    print("第 " .. self.round .. " 轮回开始！")
    
    -- 保留玩家将领，重置地图
    local playerGenerals = {}
    for _, g in ipairs(self.playerFaction.generals) do
        table.insert(playerGenerals, g)
    end
    
    -- 重新初始化
    self:startNewCampaign({
        name = self.playerFaction.name,
        generals = playerGenerals
    })
end

-- 游戏结束
function Campaign:gameOver(victory)
    self.state = "gameover"
    print("游戏结束！")
    
    if victory then
        print("恭喜你完成了 " .. self.round .. " 轮回！")
    else
        print("你在第 " .. self.round .. " 轮回中失败了")
    end
end

-- 获取存活的势力
function Campaign:getAliveFactions()
    local alive = {}
    for _, faction in ipairs(self.factions) do
        if not faction.defeated then
            table.insert(alive, faction)
        end
    end
    return alive
end

-- 获取势力控制的郡县颜色（用于地图显示）
function Campaign:getCountyColor(countyId)
    for _, faction in ipairs(self.factions) do
        if faction:controlsCounty(countyId) then
            return faction.color
        end
    end
    return {0.3, 0.3, 0.3}  -- 灰色表示无归属
end

-- 获取郡县所属势力
function Campaign:getCountyOwner(countyId)
    for _, faction in ipairs(self.factions) do
        if faction:controlsCounty(countyId) then
            return faction
        end
    end
    return nil
end

return Campaign
