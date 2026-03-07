-- 玩家(Player)测试

local TestFramework = require("tests.test_framework")
local Player = require("src.entities.player")
local General = require("src.entities.general")

-- 加载类系统
local Class = require("src.utils.class")
_G.Class = Class

TestFramework:test("玩家创建", function()
    local player = Player({
        id = "p1",
        name = "刘备",
        generals = {}
    })
    
    assertEquals("p1", player.id, "ID错误")
    assertEquals("刘备", player.name, "名称错误")
    assertEquals(100, player.mainCampHealth, "主营生命值错误")
    assertEquals(4, #player.formations, "应有4个军阵")
end)

TestFramework:test("玩家 - 4个军阵类型", function()
    local player = Player({generals = {}})
    
    assertEquals("先锋", player.formations[1].name, "第1军阵应为先锋")
    assertEquals("中军", player.formations[2].name, "第2军阵应为中军")
    assertEquals("后军", player.formations[3].name, "第3军阵应为后军")
    assertEquals("大营", player.formations[4].name, "第4军阵应为大营")
end)

TestFramework:test("部署将领", function()
    local general = General({name = "赵云"})
    local player = Player({
        generals = {general}
    })
    
    -- 将领初始应在手牌
    assertEquals(1, #player.hand, "手牌应有1张")
    
    -- 部署
    local result = player:deployGeneral(general, 1, 1) -- 部署到先锋
    
    assertTrue(result, "部署应成功")
    assertEquals(general, player.formations[1]:getGeneral(1), "将领应在先锋")
    assertEquals(0, #player.hand, "手牌应为空")
end)

TestFramework:test("部署将领 - 从军牌移除", function()
    local g1 = General({name = "赵云"})
    local g2 = General({name = "关羽"})
    local player = Player({generals = {g1, g2}})
    
    player:deployGeneral(g1, 2, 1) -- 部署到中军
    
    -- 检查手牌中是否还有g1
    local hasG1 = false
    for _, g in ipairs(player.hand) do
        if g == g1 then hasG1 = true end
    end
    assertFalse(hasG1, "手牌中不应有已部署的将领")
    
    -- 检查手牌中还有g2
    local hasG2 = false
    for _, g in ipairs(player.hand) do
        if g == g2 then hasG2 = true end
    end
    assertTrue(hasG2, "手牌中应有未部署的将领")
end)

TestFramework:test("主营受伤", function()
    local player = Player({generals = {}})
    
    player:takeDamage(30)
    assertEquals(70, player.mainCampHealth, "受伤后生命值错误")
    
    player:takeDamage(100) -- 超额伤害
    assertEquals(0, player.mainCampHealth, "生命值不应为负")
end)

TestFramework:test("主营是否被攻破", function()
    local player = Player({generals = {}})
    
    assertFalse(player:isDefeated(), "满血时不应被攻破")
    
    player:takeDamage(100)
    assertTrue(player:isDefeated(), "生命值为0时应被攻破")
end)

TestFramework:test("获取生命值百分比", function()
    local player = Player({generals = {}})
    
    assertEquals(1.0, player:getHealthPercent(), "满血时应为100%")
    
    player:takeDamage(50)
    assertEquals(0.5, player:getHealthPercent(), "50血时应为50%")
end)

TestFramework:test("获取所有存活将领", function()
    local g1 = General({name = "赵云"})
    local g2 = General({name = "关羽"})
    local g3 = General({name = "阵亡将"})
    g3:takeDamage(100)
    
    local player = Player({generals = {g1, g2, g3}})
    player:deployGeneral(g1, 1, 1)
    player:deployGeneral(g2, 2, 1)
    player:deployGeneral(g3, 2, 2)
    
    local alive = player:getAllAliveGenerals()
    
    assertEquals(2, #alive, "应有2名存活将领")
end)

TestFramework:test("清空军阵 - 将领回手牌", function()
    local g1 = General({name = "赵云"})
    local player = Player({generals = {g1}})
    
    player:deployGeneral(g1, 1, 1)
    assertEquals(0, #player.hand, "部署后手牌为空")
    
    player:clearFormations()
    
    assertEquals(1, #player.hand, "清除后手牌应有1张")
    assertEquals(nil, player.formations[1]:getGeneral(1), "军阵应为空")
end)

TestFramework:test("手牌数量", function()
    local generals = {}
    for i = 1, 11 do
        table.insert(generals, General({name = "将" .. i}))
    end
    
    local player = Player({generals = generals})
    
    assertEquals(11, #player.hand, "初始手牌应为11张")
    
    player:deployGeneral(generals[1], 1, 1)
    assertEquals(10, #player.hand, "部署1张后应为10张")
end)

-- 运行测试
return TestFramework:run()
