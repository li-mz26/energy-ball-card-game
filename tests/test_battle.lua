-- 战斗系统(BattleSystem)测试

local TestFramework = require("tests.test_framework")
local Player = require("src.entities.player")
local General = require("src.entities.general")
local BattleSystem = require("src.systems.battle")

-- 加载类系统
local Class = require("src.utils.class")
_G.Class = Class

-- 模拟Game对象
local MockGame = {}
function MockGame:new()
    return {state = "battle", currentRound = 1}
end

TestFramework:test("战斗系统 - 创建", function()
    local game = MockGame:new()
    local attacker = Player({generals = {}})
    local defender = Player({generals = {}})
    
    local bs = BattleSystem(game, attacker, defender)
    
    assertEquals(attacker, bs.attacker, "攻击者错误")
    assertEquals(defender, bs.defender, "防守者错误")
    assertEquals("idle", bs.state, "初始状态错误")
end)

TestFramework:test("战斗系统 - 创建军资", function()
    local game = MockGame:new()
    local attacker = Player({generals = {}})
    local defender = Player({generals = {}})
    
    -- 给攻击者先锋部署将领
    local general = General({name = "先锋将"})
    table.insert(attacker.generals, general)
    attacker.hand = {general}
    attacker:deployGeneral(general, 1, 1)
    
    local bs = BattleSystem(game, attacker, defender)
    bs:start()
    
    assertEquals("dispatching", bs.state, "应进入dispatching状态")
    -- 注意：由于processNextSupply立即执行，supplies会被清空
end)

TestFramework:test("战斗系统 - 先锋阵亡无法进攻", function()
    local game = MockGame:new()
    local attacker = Player({generals = {}})
    local defender = Player({generals = {}})
    
    -- 给攻击者先锋部署将领但击杀
    local general = General({name = "阵亡先锋", maxHealth = 10})
    table.insert(attacker.generals, general)
    attacker.hand = {general}
    attacker:deployGeneral(general, 1, 1)
    general:takeDamage(20)
    
    local bs = BattleSystem(game, attacker, defender)
    bs:start()
    
    assertEquals("finished", bs.state, "先锋阵亡时应直接结束")
end)

TestFramework:test("战斗系统 - 造成伤害", function()
    local game = MockGame:new()
    local attacker = Player({generals = {}})
    local defender = Player({generals = {}})
    
    local bs = BattleSystem(game, attacker, defender)
    bs.damageDealt = 30
    bs:finishBattle()
    
    assertEquals(70, defender.mainCampHealth, "应造成30点伤害")
end)

TestFramework:test("战斗系统 - 无伤害", function()
    local game = MockGame:new()
    local attacker = Player({generals = {}})
    local defender = Player({generals = {}})
    
    local bs = BattleSystem(game, attacker, defender)
    bs.damageDealt = 0
    bs:finishBattle()
    
    assertEquals(100, defender.mainCampHealth, "无伤害时生命值不变")
end)

TestFramework:test("战斗系统 - 攻破主营", function()
    local game = MockGame:new()
    local attacker = Player({generals = {}})
    local defender = Player({generals = {}})
    
    local bs = BattleSystem(game, attacker, defender)
    bs.damageDealt = 150 -- 超额伤害
    bs:finishBattle()
    
    assertEquals(0, defender.mainCampHealth, "生命值应为0")
    assertTrue(defender:isDefeated(), "应被判定为攻破")
end)

-- 运行测试
return TestFramework:run()
