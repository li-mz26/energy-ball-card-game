-- 测试主入口
-- 运行所有测试: love tests

function love.load()
    print("\n========================================")
    print("      数风流 - 测试套件")
    print("========================================\n")
    
    -- 添加src到package.path
    package.path = package.path .. ";./src/?.lua;./src/?/init.lua"
    
    local allPassed = true
    
    -- 运行各个测试模块
    local testModules = {
        "tests.test_constants",
        "tests.test_general",
        "tests.test_formation",
        "tests.test_player",
        "tests.test_battle",
    }
    
    for _, moduleName in ipairs(testModules) do
        print("\n>>> 运行: " .. moduleName)
        local success, result = pcall(function()
            return require(moduleName)
        end)
        
        if not success then
            print("加载测试模块失败: " .. tostring(result))
            allPassed = false
        else
            if not result then
                allPassed = false
            end
        end
    end
    
    print("\n========================================")
    if allPassed then
        print("    🎉 所有测试通过！")
    else
        print("    ⚠️  存在失败的测试")
    end
    print("========================================\n")
    
    -- 自动退出
    love.event.quit()
end

function love.update(dt)
end

function love.draw()
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("测试完成，请查看控制台输出", 0, 300, love.graphics.getWidth(), "center")
end
