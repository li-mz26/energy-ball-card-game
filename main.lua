-- 数风流 (Shu Fengliu) - MVP
-- 主入口文件

function love.load()
    -- 设置随机种子
    math.randomseed(os.time())
    
    -- 加载核心模块
    local Class = require("src.utils.class")
    _G.Class = Class
    
    local Game = require("src.core.game")
    _G.game = Game:new()
    _G.game:init()
end

function love.update(dt)
    if _G.game then
        _G.game:update(dt)
    end
end

function love.draw()
    if _G.game then
        _G.game:draw()
    end
end

function love.mousepressed(x, y, button)
    if _G.game then
        _G.game:mousepressed(x, y, button)
    end
end

function love.mousereleased(x, y, button)
    if _G.game then
        _G.game:mousereleased(x, y, button)
    end
end

function love.keypressed(key)
    if _G.game then
        _G.game:keypressed(key)
    end
    
    -- 调试快捷键
    if key == "escape" then
        love.event.quit()
    elseif key == "r" then
        -- 重启游戏
        love.load()
    end
end
