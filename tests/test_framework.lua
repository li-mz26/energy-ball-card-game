-- 简单测试框架

local TestFramework = {
    tests = {},
    results = {passed = 0, failed = 0, errors = {}}
}

function TestFramework:test(name, func)
    table.insert(self.tests, {name = name, func = func})
end

function TestFramework:run()
    print("\n========== 运行测试 ==========\n")
    
    for _, test in ipairs(self.tests) do
        local success, err = pcall(test.func)
        
        if success then
            print("✓ PASS: " .. test.name)
            self.results.passed = self.results.passed + 1
        else
            print("✗ FAIL: " .. test.name)
            print("  Error: " .. tostring(err))
            self.results.failed = self.results.failed + 1
            table.insert(self.results.errors, {name = test.name, error = err})
        end
    end
    
    print("\n========== 测试结果 ==========")
    print(string.format("通过: %d | 失败: %d | 总计: %d", 
        self.results.passed, 
        self.results.failed, 
        #self.tests))
    
    if self.results.failed == 0 then
        print("🎉 所有测试通过！")
    else
        print("⚠️  存在失败的测试")
    end
    
    return self.results.failed == 0
end

-- 断言函数
function assertEquals(expected, actual, message)
    if expected ~= actual then
        error(string.format("%s\n  Expected: %s\n  Actual: %s", 
            message or "断言失败", 
            tostring(expected), 
            tostring(actual)))
    end
end

function assertTrue(value, message)
    if not value then
        error(message or "期望为true，实际为false")
    end
end

function assertFalse(value, message)
    if value then
        error(message or "期望为false，实际为true")
    end
end

function assertGreaterThan(expected, actual, message)
    if actual <= expected then
        error(string.format("%s\n  Expected: > %s\n  Actual: %s", 
            message or "数值过小", 
            tostring(expected), 
            tostring(actual)))
    end
end

return TestFramework
