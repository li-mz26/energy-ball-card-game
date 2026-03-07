-- 数风流 (Shu Fengliu) - 主入口文件

function love.load()
    -- 设置随机种子
    math.randomseed(os.time())
    
    -- 加载核心模块
    local Class = require("src.utils.class")
    _G.Class = Class
    
    -- 创建游戏实例
    local Game = require("src.core.game")
    _G.game = Game:new()
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
end
