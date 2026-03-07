-- 战略地图UI (StrategyUI)

local Constants = require("src.utils.constants")
local CountyData = require("src.data.county_data")

local StrategyUI = Class:extend()

function StrategyUI:init(game, campaign)
    self.game = game
    self.campaign = campaign
    self.map = campaign.map
    
    -- 视口设置
    self.viewX = 0
    self.viewY = 0
    self.zoom = 1.0
    
    -- 选中的郡县
    self.selectedCounty = nil
    self.hoverCounty = nil
    
    -- 郡县位置（简化地图布局）
    self.countyPositions = self:initCountyPositions()
    
    -- UI元素
    self.buttons = {}
    self:createButtons()
end

-- 初始化郡县位置（基于地理位置的简化布局）
function StrategyUI:initCountyPositions()
    local positions = {}
    
    -- 州的位置基准点
    local stateBases = {
        ["司隶"] = {x = 600, y = 350},
        ["豫州"] = {x = 700, y = 450},
        ["冀州"] = {x = 700, y = 250},
        ["兖州"] = {x = 750, y = 380},
        ["徐州"] = {x = 850, y = 420},
        ["青州"] = {x = 850, y = 280},
        ["荆州"] = {x = 550, y = 550},
        ["扬州"] = {x = 800, y = 600},
        ["益州"] = {x = 300, y = 550},
        ["凉州"] = {x = 200, y = 350},
        ["并州"] = {x = 550, y = 200},
        ["幽州"] = {x = 800, y = 150},
        ["交州"] = {x = 550, y = 750},
    }
    
    -- 为每个郡县分配位置（在州基准点附近随机偏移）
    local countyIndex = {}
    for _, county in ipairs(CountyData.COUNTIES) do
        if not countyIndex[county.state] then
            countyIndex[county.state] = 0
        end
        countyIndex[county.state] = countyIndex[county.state] + 1
        
        local base = stateBases[county.state]
        local angle = (countyIndex[county.state] - 1) * (2 * math.pi / 8)
        local radius = 60 + math.random(40)
        
        positions[county.id] = {
            x = base.x + math.cos(angle) * radius,
            y = base.y + math.sin(angle) * radius
        }
    end
    
    return positions
end

-- 创建按钮
function StrategyUI:createButtons()
    local screenW = love.graphics.getWidth()
    local screenH = love.graphics.getHeight()
    
    -- 结束回合按钮
    table.insert(self.buttons, {
        text = "结束回合",
        x = screenW - 150,
        y = screenH - 80,
        w = 120,
        h = 40,
        action = function() self:endTurn() end,
        visible = function() 
            return self.campaign.phase == "player_turn" 
        end
    })
    
    -- 查看将领按钮
    table.insert(self.buttons, {
        text = "查看将领",
        x = screenW - 290,
        y = screenH - 80,
        w = 120,
        h = 40,
        action = function() self:showGenerals() end,
        visible = function() return true end
    })
end

-- 绘制
function StrategyUI:draw()
    local screenW = love.graphics.getWidth()
    local screenH = love.graphics.getHeight()
    
    -- 绘制背景
    love.graphics.setColor(0.1, 0.12, 0.15)
    love.graphics.rectangle("fill", 0, 0, screenW, screenH)
    
    -- 绘制地图标题
    love.graphics.setColor(0.9, 0.85, 0.7)
    love.graphics.setFont(love.graphics.newFont(24))
    love.graphics.printf("数风流 - 天下统一战", 0, 15, screenW, "center")
    
    -- 绘制州界（简化用圆圈表示）
    self:drawStateRegions()
    
    -- 绘制郡县连接线
    self:drawConnections()
    
    -- 绘制郡县
    self:drawCounties()
    
    -- 绘制UI面板
    self:drawUIPanel()
    
    -- 绘制按钮
    self:drawButtons()
    
    -- 绘制消息
    self:drawMessages()
end

-- 绘制州区域
function StrategyUI:drawStateRegions()
    local stateColors = {
        ["司隶"] = {0.3, 0.3, 0.35, 0.3},
        ["豫州"] = {0.35, 0.3, 0.3, 0.3},
        ["冀州"] = {0.3, 0.35, 0.3, 0.3},
        ["兖州"] = {0.35, 0.35, 0.3, 0.3},
        ["徐州"] = {0.35, 0.3, 0.35, 0.3},
        ["青州"] = {0.3, 0.35, 0.35, 0.3},
        ["荆州"] = {0.35, 0.35, 0.35, 0.3},
        ["扬州"] = {0.3, 0.3, 0.4, 0.3},
        ["益州"] = {0.4, 0.3, 0.3, 0.3},
        ["凉州"] = {0.4, 0.35, 0.3, 0.3},
        ["并州"] = {0.3, 0.4, 0.3, 0.3},
        ["幽州"] = {0.35, 0.3, 0.4, 0.3},
        ["交州"] = {0.3, 0.4, 0.35, 0.3},
    }
    
    love.graphics.setFont(love.graphics.newFont(14))
    
    for state, base in pairs(self:getStateBases()) do
        local color = stateColors[state] or {0.3, 0.3, 0.3, 0.3}
        love.graphics.setColor(color[1], color[2], color[3], color[4])
        love.graphics.circle("fill", base.x, base.y, 120)
        
        love.graphics.setColor(0.6, 0.6, 0.6, 0.5)
        love.graphics.circle("line", base.x, base.y, 120)
        
        -- 州名
        love.graphics.setColor(0.7, 0.7, 0.7)
        love.graphics.printf(state, base.x - 50, base.y - 70, 100, "center")
    end
end

-- 获取州基准位置
function StrategyUI:getStateBases()
    return {
        ["司隶"] = {x = 600, y = 350},
        ["豫州"] = {x = 700, y = 450},
        ["冀州"] = {x = 700, y = 250},
        ["兖州"] = {x = 750, y = 380},
        ["徐州"] = {x = 850, y = 420},
        ["青州"] = {x = 850, y = 280},
        ["荆州"] = {x = 550, y = 550},
        ["扬州"] = {x = 800, y = 600},
        ["益州"] = {x = 300, y = 550},
        ["凉州"] = {x = 200, y = 350},
        ["并州"] = {x = 550, y = 200},
        ["幽州"] = {x = 800, y = 150},
        ["交州"] = {x = 550, y = 750},
    }
end

-- 绘制郡县连接
function StrategyUI:drawConnections()
    love.graphics.setColor(0.3, 0.3, 0.35, 0.5)
    love.graphics.setLineWidth(1)
    
    for countyId, pos in pairs(self.countyPositions) do
        local county = self.map:getCounty(countyId)
        if county then
            for _, neighborId in ipairs(county.neighbors) do
                local neighborPos = self.countyPositions[neighborId]
                if neighborPos then
                    love.graphics.line(pos.x, pos.y, neighborPos.x, neighborPos.y)
                end
            end
        end
    end
end

-- 绘制郡县
function StrategyUI:drawCounties()
    local actions = self.campaign:getAvailableActions()
    local canAttack = actions.type == "attack" and actions.targets
    
    for countyId, pos in pairs(self.countyPositions) do
        local county = self.map:getCounty(countyId)
        if not county then goto continue end
        
        local size = 12
        local color = {0.4, 0.4, 0.4}  -- 默认灰色（无主）
        
        -- 根据所属势力着色
        if county.faction then
            color = county.faction.color
        end
        
        -- 高亮可选目标
        local isTarget = false
        if canAttack then
            for _, tid in ipairs(actions.targets) do
                if tid == countyId then
                    isTarget = true
                    break
                end
            end
        end
        
        -- 鼠标悬停效果
        if self.hoverCounty == county then
            size = 16
            love.graphics.setColor(1, 1, 1, 0.3)
            love.graphics.circle("fill", pos.x, pos.y, size + 5)
        end
        
        -- 绘制郡县节点
        if isTarget then
            -- 可攻击目标闪烁效果
            local pulse = (math.sin(love.timer.getTime() * 5) + 1) / 2
            love.graphics.setColor(1, 0.5 + pulse * 0.5, 0.5 + pulse * 0.5)
            love.graphics.circle("fill", pos.x, pos.y, size + 3)
        end
        
        love.graphics.setColor(color[1], color[2], color[3])
        love.graphics.circle("fill", pos.x, pos.y, size)
        
        love.graphics.setColor(0.2, 0.2, 0.2)
        love.graphics.circle("line", pos.x, pos.y, size)
        
        -- 郡县名称
        love.graphics.setFont(love.graphics.newFont(10))
        love.graphics.setColor(0.8, 0.8, 0.8)
        love.graphics.printf(county.name, pos.x - 30, pos.y + size + 2, 60, "center")
        
        ::continue::
    end
end

-- 绘制UI面板
function StrategyUI:drawUIPanel()
    local screenW = love.graphics.getWidth()
    local screenH = love.graphics.getHeight()
    
    -- 顶部信息栏
    love.graphics.setColor(0.15, 0.15, 0.18, 0.9)
    love.graphics.rectangle("fill", 0, 60, screenW, 60)
    
    love.graphics.setFont(love.graphics.newFont(16))
    love.graphics.setColor(0.9, 0.85, 0.7)
    
    -- 左侧：轮回和回合
    local campaign = self.campaign
    love.graphics.print("轮回: " .. campaign.round, 20, 70)
    love.graphics.print("回合: " .. campaign.turn, 20, 95)
    
    -- 中间：当前阶段
    local phaseText = {
        select_start = "选择出生地点",
        player_turn = "玩家回合 - 选择进攻目标",
        ai_turn = "AI回合",
        battle = "战斗中",
        end_turn = "回合结算"
    }
    local text = phaseText[campaign.phase] or campaign.phase
    love.graphics.printf(text, 0, 80, screenW, "center")
    
    -- 右侧：势力信息
    local player = campaign.playerFaction
    if player then
        love.graphics.print("势力: " .. player.name, screenW - 250, 70)
        love.graphics.print("郡县: " .. player:getCountyCount(), screenW - 250, 95)
        love.graphics.print("将领: " .. #player.generals .. "/11", screenW - 150, 70)
    end
    
    -- 底部信息栏
    love.graphics.setColor(0.15, 0.15, 0.18, 0.9)
    love.graphics.rectangle("fill", 0, screenH - 120, screenW, 120)
    
    -- 选中郡县信息
    if self.selectedCounty then
        self:drawCountyInfo(self.selectedCounty, 20, screenH - 110)
    elseif self.hoverCounty then
        self:drawCountyInfo(self.hoverCounty, 20, screenH - 110)
    end
end

-- 绘制郡县详细信息
function StrategyUI:drawCountyInfo(county, x, y)
    love.graphics.setFont(love.graphics.newFont(14))
    love.graphics.setColor(0.9, 0.85, 0.7)
    
    local owner = county.faction and county.faction.name or "无主"
    love.graphics.print(county.name .. " (" .. county.state .. ")", x, y)
    love.graphics.print("所属: " .. owner, x, y + 20)
    
    local bonus = county:getSpecialtyBonus()
    love.graphics.print("特产: " .. bonus.desc, x, y + 40)
    
    love.graphics.setFont(love.graphics.newFont(11))
    love.graphics.setColor(0.7, 0.7, 0.7)
    love.graphics.print(county.description, x, y + 65, 0, 1, 1, 0, 0, 400)
end

-- 绘制按钮
function StrategyUI:drawButtons()
    love.graphics.setFont(love.graphics.newFont(14))
    
    for _, btn in ipairs(self.buttons) do
        if btn.visible and btn.visible() then
            -- 按钮背景
            love.graphics.setColor(0.25, 0.3, 0.4)
            love.graphics.rectangle("fill", btn.x, btn.y, btn.w, btn.h)
            
            -- 边框
            love.graphics.setColor(0.4, 0.5, 0.7)
            love.graphics.rectangle("line", btn.x, btn.y, btn.w, btn.h)
            
            -- 文字
            love.graphics.setColor(0.9, 0.9, 0.9)
            love.graphics.printf(btn.text, btn.x, btn.y + 12, btn.w, "center")
        end
    end
end

-- 绘制消息
function StrategyUI:drawMessages()
    local messages = self.campaign:getCurrentMessages()
    if #messages == 0 then return end
    
    local screenW = love.graphics.getWidth()
    local y = 150
    
    love.graphics.setFont(love.graphics.newFont(12))
    
    for i, text in ipairs(messages) do
        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle("fill", screenW/2 - 200, y + (i-1) * 25, 400, 22)
        
        love.graphics.setColor(0.9, 0.85, 0.7)
        love.graphics.printf(text, screenW/2 - 190, y + (i-1) * 25 + 3, 380, "center")
    end
end

-- 鼠标点击处理
function StrategyUI:mousepressed(x, y, button)
    if button ~= 1 then return end
    
    -- 检查按钮点击
    for _, btn in ipairs(self.buttons) do
        if btn.visible and btn.visible() then
            if x >= btn.x and x <= btn.x + btn.w and
               y >= btn.y and y <= btn.y + btn.h then
                btn.action()
                return
            end
        end
    end
    
    -- 检查郡县点击
    local clickedCounty = self:getCountyAt(x, y)
    if clickedCounty then
        self:handleCountyClick(clickedCounty)
    end
end

-- 鼠标移动处理
function StrategyUI:mousemoved(x, y)
    self.hoverCounty = self:getCountyAt(x, y)
end

-- 获取鼠标位置的郡县
function StrategyUI:getCountyAt(x, y)
    for countyId, pos in pairs(self.countyPositions) do
        local dx = x - pos.x
        local dy = y - pos.y
        local dist = math.sqrt(dx * dx + dy * dy)
        
        if dist <= 20 then
            return self.map:getCounty(countyId)
        end
    end
    return nil
end

-- 处理郡县点击
function StrategyUI:handleCountyClick(county)
    self.selectedCounty = county
    
    local actions = self.campaign:getAvailableActions()
    
    if actions.type == "select_start" then
        -- 选择出生点
        self.campaign:selectStartCounty(county.id)
    elseif actions.type == "attack" then
        -- 检查是否是可攻击目标
        for _, tid in ipairs(actions.targets) do
            if tid == county.id then
                self.campaign:selectAttackTarget(county.id)
                return
            end
        end
    end
end

-- 结束回合
function StrategyUI:endTurn()
    -- 如果有待进行的战斗，开始战斗
    if #self.campaign.pendingBattles > 0 then
        self.campaign:startBattles()
    else
        self.campaign:processAITurns()
    end
end

-- 显示将领
function StrategyUI:showGenerals()
    -- 切换到将领查看界面
    if self.game then
        self.game:showGeneralPool()
    end
end

return StrategyUI
