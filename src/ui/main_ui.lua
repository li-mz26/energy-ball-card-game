-- 主UI

local Constants = require("src.utils.constants")

local UI = Class:extend()

function UI:init(game)
    self.game = game
    self.selectedGeneral = nil
    self.draggingGeneral = nil
    self.dragOffset = {x = 0, y = 0}
    
    -- 快捷访问
    self.state = function() return game:getState() end
    self.players = function() return game:getPlayers() end
    self.currentRound = function() return game:getCurrentRound() end
    self.maxRounds = function() return game:getMaxRounds() end
    
    -- 按钮
    self.buttons = {}
    self:createButtons()
end

function UI:createButtons()
    local screenW = love.graphics.getWidth()
    local screenH = love.graphics.getHeight()
    
    -- 确认出征按钮
    table.insert(self.buttons, {
        text = "确认出征",
        x = screenW - 200,
        y = screenH - 100,
        w = 150,
        h = 50,
        action = function() self:confirmDeployment() end,
        visible = function() return self.state() == "deployment" end
    })
    
    -- 自动布阵按钮
    table.insert(self.buttons, {
        text = "自动布阵",
        x = screenW - 380,
        y = screenH - 100,
        w = 150,
        h = 50,
        action = function() self:autoDeploy() end,
        visible = function() return self.state() == "deployment" end
    })
    
    -- 清除布阵按钮
    table.insert(self.buttons, {
        text = "重新布阵",
        x = screenW - 560,
        y = screenH - 100,
        w = 150,
        h = 50,
        action = function() self:clearDeployment() end,
        visible = function() return self.state() == "deployment" end
    })
    
    -- 开始战斗按钮
    table.insert(self.buttons, {
        text = "开始战斗",
        x = screenW / 2 - 75,
        y = screenH - 100,
        w = 150,
        h = 50,
        action = function() self:startBattle() end,
        visible = function() return self.state() == "deployment" and self:isDeploymentComplete() end
    })
end

function UI:draw()
    -- 绘制顶部信息
    self:drawHeader()
    
    -- 根据状态绘制不同内容
    if self.game.state == "deployment" then
        self:drawDeployment()
    elseif self.game.state == "battle" then
        self:drawBattle()
    elseif self.game.state == "result" then
        self:drawResult()
    end
    
    -- 绘制按钮
    self:drawButtons()
    
    -- 绘制拖拽的将领
    if self.draggingGeneral then
        self:drawDraggingGeneral()
    end
end

function UI:drawHeader()
    local text = Constants.COLORS.TEXT
    love.graphics.setColor(text[1], text[2], text[3])
    
    -- 标题
    love.graphics.setFont(love.graphics.newFont(32))
    love.graphics.printf("数风流", 0, 20, love.graphics.getWidth(), "center")
    
    -- 回合信息
    love.graphics.setFont(love.graphics.newFont(20))
    local roundText = string.format("第 %d/%d 轮", self.currentRound(), self.maxRounds())
    love.graphics.print(roundText, 50, 30)
    
    -- 玩家生命值
    local players = self.players()
    if #players >= 2 then
        local p1 = players[1]
        local p2 = players[2]
        
        love.graphics.printf(p1.name .. " 主营: " .. p1.mainCampHealth, 50, 70, 300, "left")
        love.graphics.printf(p2.name .. " 主营: " .. p2.mainCampHealth, love.graphics.getWidth() - 350, 70, 300, "right")
    end
end

function UI:drawDeployment()
    local layout = Constants.FORMATION_LAYOUT
    
    local players = self.players()
    -- 绘制敌方军阵 (简化显示)
    love.graphics.setColor(0.7, 0.3, 0.3)
    love.graphics.printf("【敌方布阵】", 0, layout.ENEMY_Y - 40, love.graphics.getWidth(), "center")
    self:drawFormations(players[2], layout.ENEMY_Y, true)
    
    -- 绘制我方军阵
    love.graphics.setColor(0.3, 0.7, 0.3)
    love.graphics.printf("【我方布阵】", 0, layout.PLAYER_Y - 40, love.graphics.getWidth(), "center")
    self:drawFormations(players[1], layout.PLAYER_Y, false)
    
    -- 绘制手牌
    self:drawHand()
end

function UI:drawFormations(player, baseY, isEnemy)
    local layout = Constants.FORMATION_LAYOUT
    local startX = layout.START_X
    
    for i, formation in ipairs(player.formations) do
        local x = startX + (i - 1) * (layout.SLOT_WIDTH * 3 + 40)
        
        -- 军阵名称
        love.graphics.setColor(0.8, 0.8, 0.8)
        love.graphics.printf(formation.name, x, baseY - 25, layout.SLOT_WIDTH * 3, "center")
        
        -- 绘制槽位
        for j, slot in ipairs(formation.slots) do
            local slotX = x + (j - 1) * layout.SLOT_WIDTH
            
            -- 槽位背景
            if slot.general then
                -- 有将领
                local color = slot.general:getRarityColor()
                love.graphics.setColor(color[1], color[2], color[3], 0.3)
                love.graphics.rectangle("fill", slotX, baseY, layout.SLOT_WIDTH - 5, layout.SLOT_HEIGHT)
                
                love.graphics.setColor(color[1], color[2], color[3])
                love.graphics.rectangle("line", slotX, baseY, layout.SLOT_WIDTH - 5, layout.SLOT_HEIGHT)
                
                -- 将领名称
                love.graphics.setColor(1, 1, 1)
                love.graphics.setFont(love.graphics.newFont(14))
                love.graphics.printf(slot.general.name, slotX + 5, baseY + 10, layout.SLOT_WIDTH - 15, "center")
                
                -- 生命值
                love.graphics.setFont(love.graphics.newFont(12))
                love.graphics.printf("❤️" .. slot.general.currentHealth, slotX + 5, baseY + 35, layout.SLOT_WIDTH - 15, "center")
            else
                -- 空槽位
                love.graphics.setColor(0.3, 0.3, 0.3)
                love.graphics.rectangle("line", slotX, baseY, layout.SLOT_WIDTH - 5, layout.SLOT_HEIGHT)
                
                love.graphics.setColor(0.5, 0.5, 0.5)
                love.graphics.printf("+", slotX, baseY + layout.SLOT_HEIGHT/2 - 10, layout.SLOT_WIDTH - 5, "center")
            end
        end
    end
end

function UI:drawHand()
    local player = self.players()[1]
    local startY = love.graphics.getHeight() - 200
    local cardWidth = 100
    local cardHeight = 140
    local gap = 15
    local startX = 50
    
    love.graphics.setColor(0.8, 0.8, 0.8)
    love.graphics.printf("手牌 (" .. #player.hand .. ")", 50, startY - 30, 200, "left")
    
    for i, general in ipairs(player.hand) do
        local x = startX + (i - 1) * (cardWidth + gap)
        local y = startY
        
        -- 卡牌背景
        local color = general:getRarityColor()
        
        -- 选中高亮
        if self.selectedGeneral == general then
            love.graphics.setColor(1, 1, 0, 0.5)
            love.graphics.rectangle("fill", x - 5, y - 5, cardWidth + 10, cardHeight + 10)
        end
        
        love.graphics.setColor(color[1], color[2], color[3], 0.3)
        love.graphics.rectangle("fill", x, y, cardWidth, cardHeight)
        
        love.graphics.setColor(color[1], color[2], color[3])
        love.graphics.rectangle("line", x, y, cardWidth, cardHeight)
        
        -- 将领信息
        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(love.graphics.newFont(14))
        love.graphics.printf(general.name, x + 5, y + 10, cardWidth - 10, "center")
        
        love.graphics.setFont(love.graphics.newFont(11))
        love.graphics.printf(general.dynasty .. "·" .. general.surname, x + 5, y + 35, cardWidth - 10, "center")
        love.graphics.printf(general.origin, x + 5, y + 55, cardWidth - 10, "center")
        
        -- 属性
        love.graphics.printf(string.format("武%d 调%d", general.bravery, general.command), x + 5, y + 85, cardWidth - 10, "center")
    end
end

function UI:drawDraggingGeneral()
    if not self.draggingGeneral then return end
    
    local mx, my = love.mouse.getPosition()
    local cardWidth = 100
    local cardHeight = 140
    
    local color = self.draggingGeneral:getRarityColor()
    love.graphics.setColor(color[1], color[2], color[3], 0.7)
    love.graphics.rectangle("fill", mx - cardWidth/2, my - cardHeight/2, cardWidth, cardHeight)
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(love.graphics.newFont(14))
    love.graphics.printf(self.draggingGeneral.name, mx - cardWidth/2, my - 30, cardWidth, "center")
end

function UI:drawButtons()
    for _, btn in ipairs(self.buttons) do
        if btn.visible and btn.visible() then
            -- 按钮背景
            love.graphics.setColor(0.2, 0.4, 0.6)
            love.graphics.rectangle("fill", btn.x, btn.y, btn.w, btn.h)
            
            -- 按钮边框
            love.graphics.setColor(0.4, 0.6, 0.8)
            love.graphics.rectangle("line", btn.x, btn.y, btn.w, btn.h)
            
            -- 按钮文字
            love.graphics.setColor(1, 1, 1)
            love.graphics.setFont(love.graphics.newFont(16))
            love.graphics.printf(btn.text, btn.x, btn.y + 15, btn.w, "center")
        end
    end
end

function UI:drawBattle()
    local players = self.players()
    local bs = self.game.quickBattle.battleSystem
    if not bs then return end
    
    -- 绘制战斗信息
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(love.graphics.newFont(24))
    love.graphics.printf("战斗中...", 0, 200, love.graphics.getWidth(), "center")
    
    -- 显示消息
    if bs.messageTimer > 0 then
        love.graphics.setFont(love.graphics.newFont(20))
        love.graphics.printf(bs.message, 0, 300, love.graphics.getWidth(), "center")
    end
    
    -- 显示伤害
    love.graphics.setFont(love.graphics.newFont(18))
    love.graphics.printf("预计伤害: " .. bs.damageDealt, 0, 350, love.graphics.getWidth(), "center")
end

function UI:drawResult()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(love.graphics.newFont(36))
    love.graphics.printf("战斗结束", 0, 300, love.graphics.getWidth(), "center")
    
    local players = self.players()
    local p1 = players[1]
    local p2 = players[2]
    
    local result = ""
    if p1.mainCampHealth > p2.mainCampHealth then
        result = p1.name .. " 获胜！"
    elseif p2.mainCampHealth > p1.mainCampHealth then
        result = p2.name .. " 获胜！"
    else
        result = "平局"
    end
    
    love.graphics.setFont(love.graphics.newFont(28))
    love.graphics.printf(result, 0, 380, love.graphics.getWidth(), "center")
end

function UI:mousepressed(x, y, button)
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
    
    -- 布阵阶段：选择手牌中的将领
    if self.state() == "deployment" then
        self:handleHandClick(x, y)
    end
end

function UI:handleHandClick(x, y)
    local player = self.players()[1]
    local startY = love.graphics.getHeight() - 200
    local cardWidth = 100
    local cardHeight = 140
    local gap = 15
    local startX = 50
    
    for i, general in ipairs(player.hand) do
        local cardX = startX + (i - 1) * (cardWidth + gap)
        if x >= cardX and x <= cardX + cardWidth and
           y >= startY and y <= startY + cardHeight then
            
            if self.selectedGeneral == general then
                -- 取消选择
                self.selectedGeneral = nil
            else
                -- 选择将领
                self.selectedGeneral = general
                print("选择了: " .. general.name)
            end
            return
        end
    end
    
    -- 检查是否点击了军阵槽位
    if self.selectedGeneral then
        local player = self.players()[1]
        local formations = player.formations
        local startX = layout.START_X
        
        for i, formation in ipairs(formations) do
            local formX = startX + (i - 1) * (layout.SLOT_WIDTH * 3 + 40)
            
            for j, slot in ipairs(formation.slots) do
                local slotX = formX + (j - 1) * layout.SLOT_WIDTH
                
                if x >= slotX and x <= slotX + layout.SLOT_WIDTH - 5 and
                   y >= layout.PLAYER_Y and y <= layout.PLAYER_Y + layout.SLOT_HEIGHT then
                    
                    -- 尝试放置
                    if slot.general == nil then
                        player:deployGeneral(self.selectedGeneral, i, j)
                        self.selectedGeneral = nil
                        print("部署到 " .. formation.name .. " 第" .. j .. "位")
                    else
                        print("该位置已有将领")
                    end
                    return
                end
            end
        end
    end
end

function UI:tryPlaceGeneral(x, y)
    local layout = Constants.FORMATION_LAYOUT
    local player = self.players()[1]
    local startX = layout.START_X
    
    for i, formation in ipairs(player.formations) do
        local formX = startX + (i - 1) * (layout.SLOT_WIDTH * 3 + 40)
        
        for j, slot in ipairs(formation.slots) do
            local slotX = formX + (j - 1) * layout.SLOT_WIDTH
            
            if x >= slotX and x <= slotX + layout.SLOT_WIDTH - 5 and
               y >= layout.PLAYER_Y and y <= layout.PLAYER_Y + layout.SLOT_HEIGHT then
                
                -- 尝试放置
                if slot.general == nil then
                    player:deployGeneral(self.selectedGeneral, i, j)
                    self.selectedGeneral = nil
                    print("部署到 " .. formation.name .. " 第" .. j .. "位")
                else
                    print("该位置已有将领")
                end
                return
            end
        end
    end
    
    -- 点击空白处取消选择
    self.selectedGeneral = nil
end

function UI:mousereleased(x, y, button)
    -- 释放拖拽
    if self.draggingGeneral then
        self:tryPlaceGeneral(x, y)
        self.draggingGeneral = nil
    end
end

function UI:keypressed(key)
    -- 空格键快速开始战斗（调试）
    if key == "space" and self.state() == "deployment" then
        self:autoDeploy()
        self:startBattle()
    end
end

-- 自动布阵
function UI:autoDeploy()
    local player = self.players()[1]
    player:clearFormations()
    
    for _, general in ipairs(player.generals) do
        local formations = player.formations
        for i, formation in ipairs(formations) do
            local slotIdx = formation:getFirstEmptySlot()
            if slotIdx then
                player:deployGeneral(general, i, slotIdx)
                break
            end
        end
    end
    
    print("自动布阵完成")
end

-- 清除布阵
function UI:clearDeployment()
    local player = self.players()[1]
    player:clearFormations()
    self.selectedGeneral = nil
    print("清除布阵")
end

-- 检查布阵是否完成
function UI:isDeploymentComplete()
    local player = self.players()[1]
    local formations = player.formations
    for _, formation in ipairs(formations) do
        if formation:getGeneralCount() < formation.maxSlots then
            return false
        end
    end
    return true
end

-- 确认出征
function UI:confirmDeployment()
    if self:isDeploymentComplete() then
        self:startBattle()
    else
        print("请完成所有布阵")
    end
end

-- 开始战斗
function UI:startBattle()
    self.game:startBattle()
end

return UI
