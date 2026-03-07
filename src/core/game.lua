-- 游戏主类 (Game)

local Constants = require("src.utils.constants")
local Player = require("src.entities.player")
local BattleSystem = require("src.systems.battle")
local UI = require("src.ui.main_ui")

local Game = Class:extend()

function Game:init()
    self.state = "menu" -- menu, deployment, battle, result
    self.currentRound = 1
    self.maxRounds = Constants.GAME.MAX_ROUNDS
    self.attackerIndex = 1 -- 1或2
    
    -- 创建测试数据
    self:createTestData()
    
    -- UI
    self.ui = UI(self)
    
    -- 战斗系统
    self.battleSystem = nil
end

-- 创建测试数据
function Game:createTestData()
    -- 玩家1的将领
    local generals1 = {
        require("src.entities.general")({
            name = "赵云", title = "常山", 
            dynasty = "蜀", surname = "赵", origin = "常山",
            rarity = Constants.RARITY.PURPLE,
            bravery = 95, command = 80, reception = 70, insight = 8,
            maxHealth = 120
        }),
        require("src.entities.general")({
            name = "关羽", title = "武圣", 
            dynasty = "蜀", surname = "关", origin = "河东",
            rarity = Constants.RARITY.ORANGE,
            bravery = 98, command = 85, reception = 75, insight = 7,
            maxHealth = 140
        }),
        require("src.entities.general")({
            name = "张飞", title = "万人敌", 
            dynasty = "蜀", surname = "张", origin = "涿郡",
            rarity = Constants.RARITY.PURPLE,
            bravery = 96, command = 60, reception = 65, insight = 6,
            maxHealth = 130
        }),
        require("src.entities.general")({
            name = "诸葛亮", title = "卧龙", 
            dynasty = "蜀", surname = "诸葛", origin = "琅琊",
            rarity = Constants.RARITY.ORANGE,
            bravery = 40, command = 95, reception = 90, insight = 10,
            maxHealth = 100
        }),
        require("src.entities.general")({
            name = "黄忠", title = "老当益壮", 
            dynasty = "蜀", surname = "黄", origin = "南阳",
            rarity = Constants.RARITY.BLUE,
            bravery = 90, command = 70, reception = 60, insight = 6,
            maxHealth = 110
        }),
        require("src.entities.general")({
            name = "马超", title = "锦马超", 
            dynasty = "蜀", surname = "马", origin = "扶风",
            rarity = Constants.RARITY.PURPLE,
            bravery = 94, command = 75, reception = 65, insight = 7,
            maxHealth = 115
        }),
        require("src.entities.general")({
            name = "魏延", title = "反骨", 
            dynasty = "蜀", surname = "魏", origin = "义阳",
            rarity = Constants.RARITY.BLUE,
            bravery = 88, command = 78, reception = 60, insight = 7,
            maxHealth = 110
        }),
        require("src.entities.general")({
            name = "姜维", title = "幼麟", 
            dynasty = "蜀", surname = "姜", origin = "天水",
            rarity = Constants.RARITY.PURPLE,
            bravery = 85, command = 88, reception = 75, insight = 8,
            maxHealth = 115
        }),
        require("src.entities.general")({
            name = "庞统", title = "凤雏", 
            dynasty = "蜀", surname = "庞", origin = "襄阳",
            rarity = Constants.RARITY.PURPLE,
            bravery = 35, command = 90, reception = 85, insight = 9,
            maxHealth = 95
        }),
        require("src.entities.general")({
            name = "法正", title = "奇谋", 
            dynasty = "蜀", surname = "法", origin = "扶风",
            rarity = Constants.RARITY.BLUE,
            bravery = 50, command = 85, reception = 80, insight = 8,
            maxHealth = 100
        }),
        require("src.entities.general")({
            name = "马岱", title = "平北", 
            dynasty = "蜀", surname = "马", origin = "扶风",
            rarity = Constants.RARITY.GREEN,
            bravery = 78, command = 65, reception = 60, insight = 5,
            maxHealth = 100
        }),
    }
    
    -- 玩家2的将领 (魏国)
    local generals2 = {
        require("src.entities.general")({
            name = "张辽", title = "止啼", 
            dynasty = "魏", surname = "张", origin = "雁门",
            rarity = Constants.RARITY.ORANGE,
            bravery = 93, command = 88, reception = 75, insight = 8,
            maxHealth = 135
        }),
        require("src.entities.general")({
            name = "许褚", title = "虎痴", 
            dynasty = "魏", surname = "许", origin = "谯郡",
            rarity = Constants.RARITY.PURPLE,
            bravery = 96, command = 55, reception = 60, insight = 5,
            maxHealth = 140
        }),
        require("src.entities.general")({
            name = "典韦", title = "恶来", 
            dynasty = "魏", surname = "典", origin = "陈留",
            rarity = Constants.RARITY.PURPLE,
            bravery = 97, command = 50, reception = 55, insight = 5,
            maxHealth = 130
        }),
        require("src.entities.general")({
            name = "司马懿", title = "冢虎", 
            dynasty = "魏", surname = "司马", origin = "河内",
            rarity = Constants.RARITY.ORANGE,
            bravery = 60, command = 98, reception = 90, insight = 10,
            maxHealth = 110
        }),
        require("src.entities.general")({
            name = "郭嘉", title = "鬼才", 
            dynasty = "魏", surname = "郭", origin = "颍川",
            rarity = Constants.RARITY.PURPLE,
            bravery = 30, command = 92, reception = 85, insight = 10,
            maxHealth = 90
        }),
        require("src.entities.general")({
            name = "荀彧", title = "王佐", 
            dynasty = "魏", surname = "荀", origin = "颍川",
            rarity = Constants.RARITY.PURPLE,
            bravery = 35, command = 90, reception = 95, insight = 9,
            maxHealth = 95
        }),
        require("src.entities.general")({
            name = "夏侯惇", title = "盲侯", 
            dynasty = "魏", surname = "夏侯", origin = "沛国",
            rarity = Constants.RARITY.BLUE,
            bravery = 89, command = 75, reception = 70, insight = 6,
            maxHealth = 120
        }),
        require("src.entities.general")({
            name = "徐晃", title = "亚夫", 
            dynasty = "魏", surname = "徐", origin = "河东",
            rarity = Constants.RARITY.BLUE,
            bravery = 87, command = 82, reception = 75, insight = 7,
            maxHealth = 115
        }),
        require("src.entities.general")({
            name = "张郃", title = "巧变", 
            dynasty = "魏", surname = "张", origin = "河间",
            rarity = Constants.RARITY.BLUE,
            bravery = 85, command = 80, reception = 72, insight = 7,
            maxHealth = 110
        }),
        require("src.entities.general")({
            name = "邓艾", title = "口吃", 
            dynasty = "魏", surname = "邓", origin = "义阳",
            rarity = Constants.RARITY.PURPLE,
            bravery = 82, command = 90, reception = 80, insight = 8,
            maxHealth = 110
        }),
        require("src.entities.general")({
            name = "钟会", title = "士季", 
            dynasty = "魏", surname = "钟", origin = "颍川",
            rarity = Constants.RARITY.BLUE,
            bravery = 70, command = 88, reception = 78, insight = 8,
            maxHealth = 105
        }),
    }
    
    self.players = {
        Player({id = "p1", name = "刘备", generals = generals1}),
        Player({id = "p2", name = "曹操", generals = generals2, isAI = true}),
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
