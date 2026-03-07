-- 军阵(Formation)测试

local TestFramework = require("tests.test_framework")
local Formation = require("src.entities.formation")
local General = require("src.entities.general")

-- 加载类系统
local Class = require("src.utils.class")
_G.Class = Class

TestFramework:test("军阵创建 - 先锋(1槽位)", function()
    local formation = Formation(1, nil)
    
    assertEquals("先锋", formation.name, "军阵名称错误")
    assertEquals(1, formation.maxSlots, "先锋应有1个槽位")
    assertEquals(1, #formation.slots, "槽位数组长度错误")
end)

TestFramework:test("军阵创建 - 中军(3槽位)", function()
    local formation = Formation(2, nil)
    
    assertEquals("中军", formation.name, "军阵名称错误")
    assertEquals(3, formation.maxSlots, "中军应有3个槽位")
    assertEquals(3, #formation.slots, "槽位数组长度错误")
end)

TestFramework:test("放置将领 - 成功", function()
    local formation = Formation(1, nil)
    local general = General({name = "测试将"})
    
    local result = formation:placeGeneral(general, 1)
    
    assertTrue(result, "放置应成功")
    assertEquals(general, formation:getGeneral(1), "将领应存在于槽位1")
    assertEquals(formation, general.slot.formation, "将领应记录所在军阵")
end)

TestFramework:test("放置将领 - 槽位已被占用", function()
    local formation = Formation(1, nil)
    local g1 = General({name = "将1"})
    local g2 = General({name = "将2"})
    
    formation:placeGeneral(g1, 1)
    local result = formation:placeGeneral(g2, 1)
    
    assertFalse(result, "应无法放置到已占用槽位")
    assertEquals(g1, formation:getGeneral(1), "槽位1仍应是原将领")
end)

TestFramework:test("放置将领 - 无效槽位", function()
    local formation = Formation(1, nil)
    local general = General({name = "测试将"})
    
    local result1 = formation:placeGeneral(general, 0)
    local result2 = formation:placeGeneral(general, 2)
    
    assertFalse(result1, "槽位0应无效")
    assertFalse(result2, "槽位2应无效(先锋只有1个槽位)")
end)

TestFramework:test("移除将领", function()
    local formation = Formation(2, nil)
    local general = General({name = "测试将"})
    
    formation:placeGeneral(general, 1)
    local removed = formation:removeGeneral(1)
    
    assertEquals(general, removed, "应返回被移除的将领")
    assertEquals(nil, formation:getGeneral(1), "槽位应为空")
    assertEquals(nil, general.slot, "将领应清除槽位引用")
end)

TestFramework:test("移除将领 - 空槽位", function()
    local formation = Formation(1, nil)
    local removed = formation:removeGeneral(1)
    
    assertEquals(nil, removed, "空槽位移除应返回nil")
end)

TestFramework:test("检查军阵是否已满", function()
    local formation = Formation(2, nil) -- 3槽位
    
    assertFalse(formation:isFull(), "初始应为未满")
    
    formation:placeGeneral(General({name = "将1"}), 1)
    assertFalse(formation:isFull(), "1/3应为未满")
    
    formation:placeGeneral(General({name = "将2"}), 2)
    formation:placeGeneral(General({name = "将3"}), 3)
    assertTrue(formation:isFull(), "3/3应为已满")
end)

TestFramework:test("获取将领数量", function()
    local formation = Formation(3, nil) -- 3槽位
    
    assertEquals(0, formation:getGeneralCount(), "初始应为0")
    
    formation:placeGeneral(General({name = "将1"}), 1)
    formation:placeGeneral(General({name = "将2"}), 2)
    assertEquals(2, formation:getGeneralCount(), "应有2名将领")
end)

TestFramework:test("获取存活将领", function()
    local formation = Formation(2, nil)
    local g1 = General({name = "存活将", maxHealth = 100})
    local g2 = General({name = "阵亡将", maxHealth = 100})
    
    g2:takeDamage(100) -- 击杀
    
    formation:placeGeneral(g1, 1)
    formation:placeGeneral(g2, 2)
    
    local alive = formation:getAliveGenerals()
    
    assertEquals(1, #alive, "应只有1名存活将领")
    assertEquals(g1, alive[1], "存活将领应是g1")
end)

TestFramework:test("获取第一个空槽位", function()
    local formation = Formation(2, nil)
    
    assertEquals(1, formation:getFirstEmptySlot(), "初始第一个空槽应为1")
    
    formation:placeGeneral(General({name = "将1"}), 1)
    assertEquals(2, formation:getFirstEmptySlot(), "槽位1被占后应为2")
    
    formation:placeGeneral(General({name = "将2"}), 2)
    assertEquals(nil, formation:getFirstEmptySlot(), "满时应返回nil")
end)

TestFramework:test("清空军阵", function()
    local formation = Formation(2, nil)
    local g1 = General({name = "将1"})
    local g2 = General({name = "将2"})
    
    formation:placeGeneral(g1, 1)
    formation:placeGeneral(g2, 2)
    
    local removed = formation:clear()
    
    assertEquals(2, #removed, "应返回2名将领")
    assertEquals(0, formation:getGeneralCount(), "军阵应为空")
    assertEquals(nil, g1.slot, "将领1应清除引用")
    assertEquals(nil, g2.slot, "将领2应清除引用")
end)

TestFramework:test("多军阵独立性", function()
    local vanguard = Formation(1, nil) -- 先锋 1槽位
    local center = Formation(2, nil)   -- 中军 3槽位
    
    assertEquals(1, vanguard.maxSlots, "先锋槽位数错误")
    assertEquals(3, center.maxSlots, "中军槽位数错误")
    
    -- 互不影响
    local general = General({name = "测试将"})
    vanguard:placeGeneral(general, 1)
    
    assertEquals(general, vanguard:getGeneral(1), "先锋应有将领")
    assertEquals(nil, center:getGeneral(1), "中军应为空")
end)

-- 运行测试
return TestFramework:run()
