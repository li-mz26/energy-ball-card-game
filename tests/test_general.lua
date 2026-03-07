-- 将领(General)测试

local TestFramework = require("tests.test_framework")
local Constants = require("src.utils.constants")
local General = require("src.entities.general")

-- 加载类系统
local Class = require("src.utils.class")
_G.Class = Class

TestFramework:test("将领创建 - 基本属性", function()
    local general = General({
        name = "测试将",
        dynasty = "蜀",
        surname = "张",
        origin = "涿郡",
        bravery = 80,
        command = 70,
    })
    
    assertEquals("测试将", general.name, "名称不匹配")
    assertEquals("蜀", general.dynasty, "朝代不匹配")
    assertEquals("张", general.surname, "姓氏不匹配")
    assertEquals("涿郡", general.origin, "祖籍不匹配")
    assertEquals(80, general.bravery, "武勇不匹配")
    assertEquals(70, general.command, "调度不匹配")
end)

TestFramework:test("将领创建 - 默认属性", function()
    local general = General({name = "无名"})
    
    assertEquals("未知", general.dynasty, "默认朝代应为未知")
    assertEquals("", general.surname, "默认姓氏应为空")
    assertEquals(50, general.bravery, "默认武勇应为50")
    assertEquals(50, general.command, "默认调度应为50")
    assertEquals(100, general.maxHealth, "默认生命值应为100")
end)

TestFramework:test("将领 - 受伤与存活", function()
    local general = General({maxHealth = 100})
    
    assertTrue(general:isAlive(), "满血时应存活")
    
    general:takeDamage(30)
    assertEquals(70, general.currentHealth, "受伤后生命值错误")
    assertTrue(general:isAlive(), "还有血量时应存活")
    
    general:takeDamage(100)
    assertEquals(0, general.currentHealth, "生命值不应为负")
    assertFalse(general:isAlive(), "生命值为0时应死亡")
end)

TestFramework:test("羁绊 - 同朝加成", function()
    local g1 = General({dynasty = "蜀", surname = "刘", origin = "涿郡"})
    local g2 = General({dynasty = "蜀", surname = "关", origin = "河东"})
    
    local bonus, bonds = g1:calculateBondBonus(g2)
    
    assertEquals(0.15, bonus, "同朝加成应为15%")
    assertEquals(1, #bonds, "应有1个羁绊")
    assertEquals("同朝", bonds[1], "羁绊类型应为同朝")
end)

TestFramework:test("羁绊 - 同姓加成", function()
    local g1 = General({dynasty = "蜀", surname = "张", origin = "涿郡"})
    local g2 = General({dynasty = "魏", surname = "张", origin = "河间"})
    
    local bonus, bonds = g1:calculateBondBonus(g2)
    
    assertEquals(0.10, bonus, "同姓加成应为10%")
    assertEquals(1, #bonds, "应有1个羁绊")
end)

TestFramework:test("羁绊 - 同籍加成", function()
    local g1 = General({dynasty = "魏", surname = "夏侯", origin = "沛国"})
    local g2 = General({dynasty = "魏", surname = "曹", origin = "沛国"})
    
    local bonus, bonds = g1:calculateBondBonus(g2)
    
    assertEquals(0.10, bonus, "同籍加成应为10%")
end)

TestFramework:test("羁绊 - 同朝同姓叠加", function()
    local g1 = General({dynasty = "蜀", surname = "张", origin = "涿郡"})
    local g2 = General({dynasty = "蜀", surname = "张", origin = "常山"})
    
    local bonus, bonds = g1:calculateBondBonus(g2)
    
    -- 同朝15% + 同姓10% + 叠加5% = 30%
    local expected = 0.15 + 0.10 + 0.05
    assertEquals(expected, bonus, "同朝同姓叠加加成错误")
end)

TestFramework:test("羁绊 - 三项全中", function()
    local g1 = General({dynasty = "蜀", surname = "张", origin = "涿郡"})
    local g2 = General({dynasty = "蜀", surname = "张", origin = "涿郡"})
    
    local bonus, bonds = g1:calculateBondBonus(g2)
    
    -- 同朝15% + 同姓10% + 同籍10% + 叠加5% = 40%
    local expected = 0.15 + 0.10 + 0.10 + 0.05
    assertEquals(expected, bonus, "三项羁绊加成错误")
    assertEquals(3, #bonds, "应有3个羁绊")
end)

TestFramework:test("羁绊 - 无关联", function()
    local g1 = General({dynasty = "蜀", surname = "赵", origin = "常山"})
    local g2 = General({dynasty = "魏", surname = "司马", origin = "河内"})
    
    local bonus, bonds = g1:calculateBondBonus(g2)
    
    assertEquals(0, bonus, "无关联时加成应为0")
    assertEquals(0, #bonds, "无关联时应无羁绊")
end)

TestFramework:test("输送成功率 - 基础计算", function()
    local dispatcher = General({command = 50})
    local receiver = General({reception = 50})
    
    local rate = dispatcher:getDispatchSuccessRate(receiver)
    
    -- 基础70% + (50+50)/500 = 20% = 90%
    assertGreaterThan(0.89, rate, "基础成功率应约90%")
end)

TestFramework:test("输送成功率 - 羁绊加成", function()
    local dispatcher = General({
        command = 50, dynasty = "蜀", surname = "刘", origin = "涿郡"
    })
    local receiver = General({
        reception = 50, dynasty = "蜀", surname = "关", origin = "河东"
    })
    
    local rate = dispatcher:getDispatchSuccessRate(receiver)
    
    -- 基础70% + 属性20% + 同朝15% = 105% → 限制到95%
    assertEquals(0.95, rate, "成功率应限制在95%")
end)

TestFramework:test("截击成功率 - 武勇影响", function()
    local general = General({bravery = 100})
    local rate = general:getInterceptRate(0) -- 距离为0
    
    -- 基础35% + 100/200 = 50% = 85%
    assertGreaterThan(0.84, rate, "高武勇截击率应很高")
end)

TestFramework:test("截击成功率 - 距离惩罚", function()
    local general = General({bravery = 50})
    local rate = general:getInterceptRate(5) -- 距离5
    
    -- 基础35% + 25% - 50% = 10%
    assertTrue(rate < 0.35, "距离远时截击率应降低")
end)

TestFramework:test("品阶颜色", function()
    local white = General({rarity = Constants.RARITY.WHITE})
    local orange = General({rarity = Constants.RARITY.ORANGE})
    
    local whiteColor = white:getRarityColor()
    local orangeColor = orange:getRarityColor()
    
    assertEquals(0.8, whiteColor[1], "白将颜色错误")
    assertEquals(1.0, orangeColor[1], "橙将颜色错误")
end)

TestFramework:test("显示名称 - 带称号", function()
    local general = General({name = "赵云", title = "常山"})
    assertEquals("常山·赵云", general:getDisplayName(), "显示名称错误")
end)

TestFramework:test("显示名称 - 无称号", function()
    local general = General({name = "无名", title = ""})
    assertEquals("无名", general:getDisplayName(), "显示名称错误")
end)

TestFramework:test("重置回合状态", function()
    local general = General({})
    general.hasTransferred = true
    
    general:resetRound()
    
    assertFalse(general.hasTransferred, "重置后应为false")
end)

-- 运行测试
return TestFramework:run()
