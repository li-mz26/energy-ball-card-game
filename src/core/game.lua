-- 游戏主类 (增强版)
-- 支持两种模式：快速对战 和 战役模式

local Constants = require("src.utils.constants")
local Player = require("src.entities.player")
local BattleSystem = require("src.systems.battle")
local UI = require("src.ui.main_ui")
local StrategyUI = require("src.ui.strategy_ui")
local AllGenerals = require("src.data.all_generals")
local Campaign = require("src.strategy.campaign")

local Game = Class:extend()

function Game:init()
    -- 游戏模式: "menu", "quick" (快速对战), "campaign" (战役模式)
    self.mode = "menu"
    
    -- 快速对战相关
    self.quickBattle = {
        state = "menu",
        players = {},
        battleSystem = nil,
        currentRound = 1,
        attackerIndex = 1,
    }
    
    -- 战役模式相关
    self.campaign = nil
    
    -- UI
    self.ui = nil
    self.strategyUI = StrategyUI(self)
    
    -- 创建主菜单
    self:createMainMenu()
end

-- 创建主菜单
function Game:createMainMenu()
    self.menuButtons = {
        {
            text = "快速对战",
            y = 350,
            action = function() self:startQuickBattle() end
        },
        {
            text = "天下统一战 (战役)",
            y = 430,
            action = function() self:startCampaign() end
        },
        {
            text = "退出",
            y = 510,
            action = function() love.event.quit() end
        }
    }
end

-- ==================== 快速对战模式 ====================

function Game:startQuickBattle()
    self.mode = "quick"
    self.quickBattle.state = "deployment"
    self.quickBattle.currentRound = 1
    self.quickBattle.attackerIndex = 1
    
    -- 创建玩家
    self:createQuickBattlePlayers()
    
    -- 创建UI
    self.ui = UI(self)
    
    print("开始快速对战模式")
end

function Game:createQuickBattlePlayers()
    -- 获取随机将领
    local allGenerals = AllGenerals:getAllGenerals()
    
    -- 洗牌
    for i = #allGenerals, 2, -1 do
        local j = math.random(i)
        allGenerals[i], allGenerals[j] = allGenerals[j], allGenerals[i]
    end
    
    -- 分配22名给玩家
    local player1Generals = {}
    local player2Generals = {}
    
    for i = 1, 11 do
        table.insert(player1Generals, allGenerals[i])
    end
    for i = 12, 22 do
        table.insert(player2Generals, allGenerals[i])
    end
    
    self.quickBattle.players = {
        Player({id = "p1", name = "玩家", generals = player1Generals}),
        Player({id = "p2", name = "电脑", generals = player2Generals, isAI = true}),
    }
end

-- ==================== 战役模式 ====================

function Game:startCampaign()
    self.mode = "campaign"
    
    -- 创建战役管理器
    self.campaign = Campaign(self)
    
    -- 获取初始将领（5名）
    local startGenerals = AllGenerals:getRandomGenerals(5)
    
    -- 启动战役
    self.campaign:startNewCampaign({
        name = "玩家势力",
        generals = startGenerals
    })
    
    -- 设置战略UI
    self.strategyUI:setCampaign(self.campaign)
    
    print("开始战役模式")
end

-- 战役中的战斗开始
function Game:startCampaignBattle(battleInfo)
    -- 创建临时玩家对象用于战术对战
    local attackerPlayer = Player({
        id = "attacker",
        name = battleInfo.attacker.name,
        generals = battleInfo.attacker:selectBattleGenerals()
    })
    
    local defenderPlayer = Player({
        id = "defender", 
        name = battleInfo.defender.name,
        generals = battleInfo.defender:selectBattleGenerals()
    })
    
    -- 创建战术对战
    self.quickBattle.players = {attackerPlayer, defenderPlayer}
    self.quickBattle.state = "deployment"
    self.quickBattle.currentRound = 1
    self.quickBattle.attackerIndex = 1
    self.quickBattle.battleSystem = nil
    self.quickBattle.campaignBattle = battleInfo  -- 记录战役战斗信息
    
    -- 创建UI
    self.ui = UI(self)
    
    -- 切换到战术界面
    self.mode = "campaign_battle"
    
    print("战役战斗: " .. battleInfo.attacker.name .. " vs " .. battleInfo.defender.name)
end

-- 战役战斗结束
function Game:endCampaignBattle(winnerIndex)
    local battleInfo = self.quickBattle.campaignBattle
    if not battleInfo then return end
    
    local winner = (winnerIndex == 1) and battleInfo.attacker or battleInfo.defender
    local loser = (winnerIndex == 1) and battleInfo.defender or battleInfo.attacker
    
    -- 通知战役管理器处理结果
    self.campaign:resolveBattle(winner, loser, battleInfo.county)
    
    -- 返回战略界面
    self.mode = "campaign"
    self.quickBattle.campaignBattle = nil
    self.ui = nil
end

-- ==================== 更新与绘制 ====================

function Game:update(dt)
    if self.mode == "quick" or self.mode == "campaign_battle" then
        if self.quickBattle.battleSystem then
            self.quickBattle.battleSystem:update(dt)
        end
    end
end

function Game:draw()
    if self.mode == "menu" then
        self:drawMainMenu()
    elseif self.mode == "quick" or self.mode == "campaign_battle" then
        self:drawQuickBattle()
    elseif self.mode == "campaign" then
        self:drawCampaign()
    end
end

function Game:drawMainMenu()
    -- 背景
    love.graphics.setColor(0.1, 0.1, 0.12)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    
    -- 标题
    love.graphics.setColor(0.9, 0.7, 0.3)
    love.graphics.setFont(love.graphics.newFont(48))
    love.graphics.printf("数风流", 0, 150, love.graphics.getWidth(), "center")
    
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.setColor(0.7, 0.7, 0.7)
    love.graphics.printf("Shu Fengliu - 天下统一战", 0, 220, love.graphics.getWidth(), "center")
    
    -- 按钮
    local screenW = love.graphics.getWidth()
    for _, btn in ipairs(self.menuButtons) do
        local btnW, btnH = 300, 60
        local btnX = (screenW - btnW) / 2
        
        -- 按钮背景
        love.graphics.setColor(0.25, 0.3, 0.4)
        love.graphics.rectangle("fill", btnX, btn.y, btnW, btnH)
        
        -- 边框
        love.graphics.setColor(0.5, 0.6, 0.8)
        love.graphics.rectangle("line", btnX, btn.y, btnW, btnH)
        
        -- 文字
        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(love.graphics.newFont(24))
        love.graphics.printf(btn.text, btnX, btn.y + 15, btnW, "center")
    end
end

function Game:drawQuickBattle()
    if not self.ui then return end
    
    -- 背景
    local bg = Constants.COLORS.BACKGROUND
    love.graphics.setColor(bg[1], bg[2], bg[3])
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    
    -- 如果是战役中的战斗，显示额外信息
    if self.mode == "campaign_battle" and self.quickBattle.campaignBattle then
        local info = self.quickBattle.campaignBattle
        love.graphics.setColor(1, 1, 0.5)
        love.graphics.setFont(love.graphics.newFont(16))
        love.graphics.printf(
            string.format("战役战斗: %s 进攻 %s 的 %s", 
                info.attacker.name, info.defender.name, 
                CountyData:getCounty(info.county).name),
            0, 10, love.graphics.getWidth(), "center"
        )
    end
    
    -- 绘制UI
    self.ui:draw()
end

function Game:drawCampaign()
    if not self.strategyUI then return end
    self.strategyUI:draw()
end

-- ==================== 输入处理 ====================

function Game:mousepressed(x, y, button)
    if self.mode == "menu" then
        self:handleMenuClick(x, y)
    elseif self.mode == "quick" or self.mode == "campaign_battle" then
        if self.ui then
            self.ui:mousepressed(x, y, button)
        end
    elseif self.mode == "campaign" then
        if self.strategyUI then
            self.strategyUI:mousepressed(x, y, button)
        end
    end
end

function Game:mousereleased(x, y, button)
    if self.ui then
        self.ui:mousereleased(x, y, button)
    end
end

function Game:keypressed(key)
    if key == "escape" then
        if self.mode ~= "menu" then
            self.mode = "menu"
            self.campaign = nil
            self.ui = nil
        else
            love.event.quit()
        end
    elseif self.mode == "quick" or self.mode == "campaign_battle" then
        if self.ui then
            self.ui:keypressed(key)
        end
    elseif self.mode == "campaign" then
        if self.strategyUI then
            self.strategyUI:keypressed(key)
        end
    end
end

function Game:handleMenuClick(x, y)
    local screenW = love.graphics.getWidth()
    local btnW, btnH = 300, 60
    local btnX = (screenW - btnW) / 2
    
    for _, btn in ipairs(self.menuButtons) do
        if x >= btnX and x <= btnX + btnW and
           y >= btn.y and y <= btn.y + btnH then
            btn.action()
            return
        end
    end
end

-- ==================== 快速对战接口 ====================

-- 供UI调用的接口
function Game:getPlayers()
    return self.quickBattle.players
end

function Game:getState()
    return self.quickBattle.state
end

function Game:setState(state)
    self.quickBattle.state = state
end

function Game:getCurrentRound()
    return self.quickBattle.currentRound
end

function Game:getMaxRounds()
    return Constants.GAME.MAX_ROUNDS
end

function Game:getAttackerIndex()
    return self.quickBattle.attackerIndex
end

function Game:startBattle()
    self.quickBattle.state = "battle"
    local attacker = self.quickBattle.players[self.quickBattle.attackerIndex]
    local defender = self.quickBattle.players[self.quickBattle.attackerIndex == 1 and 2 or 1]
    
    self.quickBattle.battleSystem = BattleSystem(self, attacker, defender)
    self.quickBattle.battleSystem:start()
end

function Game:endBattleRound()
    -- 切换攻守
    self.quickBattle.attackerIndex = self.quickBattle.attackerIndex == 1 and 2 or 1
    
    -- 检查回合
    if self.quickBattle.attackerIndex == 1 then
        self.quickBattle.currentRound = self.quickBattle.currentRound + 1
    end
    
    -- 检查游戏结束
    if self.quickBattle.currentRound > Constants.GAME.MAX_ROUNDS then
        -- 判定胜负
        local p1 = self.quickBattle.players[1]
        local p2 = self.quickBattle.players[2]
        
        if self.mode == "campaign_battle" then
            -- 战役模式：根据主营生命值判定
            local winner = (p1.mainCampHealth > p2.mainCampHealth) and 1 or 2
            self:endCampaignBattle(winner)
        else
            -- 快速对战：显示结果
            self.quickBattle.state = "result"
        end
        return
    end
    
    -- 重新布阵
    self.quickBattle.state = "deployment"
    self.quickBattle.battleSystem = nil
end

return Game
