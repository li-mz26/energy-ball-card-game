-- 常量(Constants)测试

local TestFramework = require("tests.test_framework")
local Constants = require("src.utils.constants")

TestFramework:test("常量 - 游戏配置", function()
    assertEquals(3, Constants.GAME.MAX_ROUNDS, "回合数错误")
    assertEquals(4, Constants.GAME.FORMATION_COUNT, "军阵数错误")
    assertEquals(100, Constants.GAME.MAIN_CAMP_HEALTH, "主营生命值错误")
    assertEquals(10, Constants.GAME.SUPPLY_DAMAGE, "军资伤害错误")
end)

TestFramework:test("常量 - 军阵槽位配置", function()
    local slots = Constants.GAME.FORMATION_SLOTS
    assertEquals(1, slots[1], "先锋应有1槽位")
    assertEquals(3, slots[2], "中军应有3槽位")
    assertEquals(3, slots[3], "后军应有3槽位")
    assertEquals(4, slots[4], "大营应有3槽位")
end)

TestFramework:test("常量 - 军阵名称", function()
    local names = Constants.GAME.FORMATION_NAMES
    assertEquals("先锋", names[1], "第1军阵名称错误")
    assertEquals("中军", names[2], "第2军阵名称错误")
    assertEquals("后军", names[3], "第3军阵名称错误")
    assertEquals("大营", names[4], "第4军阵名称错误")
end)

TestFramework:test("常量 - 羁绊加成", function()
    assertEquals(0.15, Constants.BOND.DYNASTY_BONUS, "同朝加成错误")
    assertEquals(0.10, Constants.BOND.SURNAME_BONUS, "同姓加成错误")
    assertEquals(0.10, Constants.BOND.ORIGIN_BONUS, "同籍加成错误")
    assertEquals(0.05, Constants.BOND.COMBO_BONUS, "叠加加成错误")
    assertEquals(0.95, Constants.BOND.MAX_SUCCESS_RATE, "最大成功率错误")
end)

TestFramework:test("常量 - 品阶配置", function()
    assertEquals(1, Constants.RARITY.WHITE.level, "白品阶等级错误")
    assertEquals(20, Constants.RARITY.WHITE.maxLevel, "白品阶最大等级错误")
    
    assertEquals(5, Constants.RARITY.ORANGE.level, "橙品阶等级错误")
    assertEquals(60, Constants.RARITY.ORANGE.maxLevel, "橙品阶最大等级错误")
end)

TestFramework:test("常量 - 品阶颜色", function()
    local white = Constants.RARITY.WHITE.color
    assertEquals(0.8, white[1], "白品阶R值错误")
    
    local orange = Constants.RARITY.ORANGE.color
    assertEquals(1.0, orange[1], "橙品阶R值错误")
end)

TestFramework:test("常量 - 颜色值存在", function()
    assertTrue(Constants.COLORS.BACKGROUND ~= nil, "背景色应存在")
    assertTrue(Constants.COLORS.ACCENT_RED ~= nil, "强调红色应存在")
    assertTrue(Constants.COLORS.ACCENT_GREEN ~= nil, "强调绿色应存在")
    assertTrue(Constants.COLORS.TEXT ~= nil, "文字颜色应存在")
end)

TestFramework:test("常量 - 屏幕尺寸", function()
    assertEquals(1920, Constants.SCREEN.WIDTH, "屏幕宽度错误")
    assertEquals(1080, Constants.SCREEN.HEIGHT, "屏幕高度错误")
end)

-- 运行测试
return TestFramework:run()
