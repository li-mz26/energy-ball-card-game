-- 游戏主类 (Game)

local Constants = require("src.utils.constants")
local Player = require("src.entities.player")
local BattleSystem = require("src.systems.battle")
local UI = require("src.ui.main_ui")
local AllGenerals = require("src.data.all_generals")

local Game = Class:extend()

function Game:init()
    self.state = "menu" -- menu, deployment, battle, result
    self.currentRound = 1
    self.maxRounds = Constants.GAME.MAX_ROUNDS
    self.attackerIndex = 1 -- 1或2
    
    -- 创建玩家数据
    self:createPlayers()
    
    -- UI
    self.ui = UI(self)
    
    -- 战斗系统
    self.battleSystem = nil
end

-- 创建玩家和将领
function Game:createPlayers()
    -- 获取随机将领
    local allGenerals = AllGenerals:getAllGenerals()
    
    -- 洗牌
    for i = #allGenerals, 2, -1 do
        local j = math.random(i)
        allGenerals[i], allGenerals[j] = allGenerals[j], allGenerals[i]
    end
    
    -- 分配22名给玩家（各11名）
    local player1Generals = {}
    local player2Generals = {}
    
    for i = 1, 11 do
        table.insert(player1Generals, allGenerals[i])
    end
    for i = 12, 22 do
        table.insert(player2Generals, allGenerals[i])
    end
    
    -- 创建玩家
    self.players = {
        Player({id = "p1", name = "玩家", generals = player1Generals}),
        Player({id = "p2", name = "电脑", generals = player2Generals, isAI = true}),
    }
end

function Game:update(dt)
    if self.battleSystem then
        self.battleSystem:update(dt)
    end
end

function Game:draw()
    -- 清空背景
    local bg = Constants.COLORS.BACKGROUND
    love.graphics.setColor(bg[1], bg[2], bg[3])
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    
    -- 绘制UI
    self.ui:draw()
end

function Game:mousepressed(x, y, button)
    self.ui:mousepressed(x, y, button)
end

function Game:mousereleased(x, y, button)
    self.ui:mousereleased(x, y, button)
end

function Game:keypressed(key)
    self.ui:keypressed(key)
end

-- 开始战斗
function Game:startBattle()
    self.state = "battle"
    local attacker = self.players[self.attackerIndex]
    local defender = self.players[self.attackerIndex == 1 and 2 or 1]
    
    self.battleSystem = BattleSystem(self, attacker, defender)
    self.battleSystem:start()
end

-- 结束战斗回合
function Game:endBattleRound()
    -- 切换攻守
    self.attackerIndex = self.attackerIndex == 1 and 2 or 1
    
    -- 检查回合
    if self.attackerIndex == 1 then
        self.currentRound = self.currentRound + 1
    end
    
    -- 检查游戏结束
    if self.currentRound > self.maxRounds then
        self.state = "result"
        return
    end
    
    -- 重新布阵
    self.state = "deployment"
    self.battleSystem = nil
end

return Game
