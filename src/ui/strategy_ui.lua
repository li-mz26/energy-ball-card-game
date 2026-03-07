-- 战略地图UI

local CountyData = require("src.data.county_data")
local Constants = require("src.utils.constants")

local StrategyUI = Class:extend()

function StrategyUI:init(game)
    self.game = game
    self.campaign = nil  -- 战役管理器
    
    -- 选中的郡县
    self.selectedCounty = nil
    
    -- 相机/视口
    self.camera = {x = 0, y = 0, zoom = 1}
    
    -- 按钮
    self.buttons = {}
    self:createButtons()
end

function StrategyUI:createButtons()
    local screenW = love.graphics.getWidth()
    local screenH = love.graphics.getHeight()
    
    -- 结束回合按钮
    table.insert(self.buttons, {
        text = "结束回合",
        x = screenW - 180,
        y = screenH - 80,
        w = 140,
        h = 50,
        action = function() self:endTurn() end,
        visible = function() 
            return self.campaign and self.campaign.state == "strategy" 
        end
    })
    
    -- 查看将领按钮
    table.insert(self.buttons, {
        text = "将领池",
        x = 30,
        y = screenH - 80,
        w = 120,
        h = 50,
        action = function() self:showGenerals() end,
        visible = function() return self.campaign ~= nil end
    })
    
    -- 历史记录按钮
    table.insert(self.buttons, {
        text = "战报",
        x = 170,
        y = screenH - 80,
        w = 100,
        h = 50,
        action = function() self:showHistory() end,
        visible = function() return self.campaign ~= nil end
    })
end

-- 设置战役管理器
function StrategyUI:setCampaign(campaign)
    self.campaign = campaign
end

function StrategyUI:draw()
    if not self.campaign then return end
    
    -- 绘制背景
    love.graphics.setColor(0.1, 0.12, 0.15)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    
    -- 绘制地图
    self:drawMap()
    
    -- 绘制UI面板
    self:drawPanels()
    
    -- 绘制按钮
    self:drawButtons()
    
    -- 绘制提示信息
    self:drawTooltip()
end

function StrategyUI:drawMap()
    local counties = CountyData:getAllCounties()
    
    -- 绘制连接线
    love.graphics.setColor(0.3, 0.3, 0.35)
    love.graphics.setLineWidth(2)
    for _, county in ipairs(counties) do
        local neighbors = CountyData:getNeighbors(county.id)
        for _, neighbor in ipairs(neighbors) do
            -- 只画一次（避免重复）
            if county.id < neighbor.id then
                love.graphics.line(county.x, county.y, neighbor.x, neighbor.y)
            end
        end
    end
    
    -- 绘制郡县节点
    for _, county in ipairs(counties) do
        local color = self.campaign:getCountyColor(county.id)
        local isPlayer = self.campaign.playerFaction and 
                        self.campaign.playerFaction:controlsCounty(county.id)
        local isSelected = self.selectedCounty == county.id
        local isAttackable = self:isAttackable(county.id)
        
        -- 节点大小
        local radius = 25
        if isSelected then radius = 30 end
        
        -- 高亮可攻击目标
        if isAttackable then
            love.graphics.setColor(1, 0.3, 0.3, 0.5)
            love.graphics.circle("fill", county.x, county.y, radius + 8)
        end
        
        -- 绘制节点
        love.graphics.setColor(color[1], color[2], color[3])
        love.graphics.circle("fill", county.x, county.y, radius)
        
        -- 边框
        if isPlayer then
            love.graphics.setColor(1, 1, 0)
            love.graphics.setLineWidth(3)
        else
            love.graphics.setColor(0.5, 0.5, 0.5)
            love.graphics.setLineWidth(1)
        end
        love.graphics.circle("line", county.x, county.y, radius)
        
        -- 郡县名称
        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(love.graphics.newFont(14))
        love.graphics.printf(county.name, county.x - 40, county.y + radius + 5, 80, "center")
    end
end

function StrategyUI:drawPanels()
    local screenW = love.graphics.getWidth()
    
    -- 顶部信息栏
    love.graphics.setColor(0.15, 0.15, 0.2, 0.9)
    love.graphics.rectangle("fill", 0, 0, screenW, 80)
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(love.graphics.newFont(24))
    love.graphics.print("数风流 - 天下统一战", 20, 15)
    
    -- 回合信息
    love.graphics.setFont(love.graphics.newFont(18))
    local info = string.format("第 %d 轮回 - 第 %d 回合", 
        self.campaign.round, self.campaign.turn)
    love.graphics.print(info, 250, 20)
    
    -- 玩家信息
    if self.campaign.playerFaction then
        local pf = self.campaign.playerFaction
        love.graphics.setColor(pf.color[1], pf.color[2], pf.color[3])
        love.graphics.print(pf.name, 500, 20)
        
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(string.format("郡县: %d | 将领: %d/%d", 
            #pf.counties, #pf.generals, pf.maxGenerals), 500, 45)
    end
    
    -- 选中郡县信息
    if self.selectedCounty then
        self:drawCountyInfo()
    end
end

function StrategyUI:drawCountyInfo()
    local county = CountyData:getCounty(self.selectedCounty)
    if not county then return end
    
    local owner = self.campaign:getCountyOwner(self.selectedCounty)
    local screenW = love.graphics.getWidth()
    
    -- 信息面板
    love.graphics.setColor(0.2, 0.2, 0.25, 0.95)
    love.graphics.rectangle("fill", screenW - 280, 100, 260, 200)
    love.graphics.setColor(0.5, 0.5, 0.6)
    love.graphics.rectangle("line", screenW - 280, 100, 260, 200)
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.print(county.name, screenW - 260, 120)
    
    love.graphics.setFont(love.graphics.newFont(14))
    
    -- 归属
    local ownerName = owner and owner.name or "无归属"
    love.graphics.print("归属: " .. ownerName, screenW - 260, 155)
    
    -- 特产
    love.graphics.print("特产: " .. county.specialty, screenW - 260, 180)
    
    -- 描述
    love.graphics.printf(county.desc, screenW - 260, 210, 220, "left")
    
    -- 操作提示
    if self:isAttackable(self.selectedCounty) then
        love.graphics.setColor(1, 0.8, 0.2)
        love.graphics.print("[点击进攻]", screenW - 260, 270)
    end
end

function StrategyUI:drawButtons()
    for _, btn in ipairs(self.buttons) do
        if btn.visible and btn.visible() then
            -- 按钮背景
            love.graphics.setColor(0.25, 0.35, 0.5)
            love.graphics.rectangle("fill", btn.x, btn.y, btn.w, btn.h)
            
            -- 边框
            love.graphics.setColor(0.4, 0.55, 0.75)
            love.graphics.rectangle("line", btn.x, btn.y, btn.w, btn.h)
            
            -- 文字
            love.graphics.setColor(1, 1, 1)
            love.graphics.setFont(love.graphics.newFont(16))
            love.graphics.printf(btn.text, btn.x, btn.y + 15, btn.w, "center")
        end
    end
end

function StrategyUI:drawTooltip()
    -- 绘制鼠标悬停提示
end

-- 检查郡县是否可进攻
function StrategyUI:isAttackable(countyId)
    if not self.campaign or not self.campaign.playerFaction then
        return false
    end
    
    if self.campaign.state ~= "strategy" then
        return false
    end
    
    if self.campaign.playerFaction.hasActed then
        return false
    end
    
    local pf = self.campaign.playerFaction
    
    -- 是否相邻
    local isAdjacent = false
    for _, myCountyId in ipairs(pf.counties) do
        if CountyData:isAdjacent(myCountyId, countyId) then
            isAdjacent = true
            break
        end
    end
    
    if not isAdjacent then
        return false
    end
    
    -- 是否不属于己方
    return not pf:controlsCounty(countyId)
end

-- 处理鼠标点击
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
    self:handleCountyClick(x, y)
end

function StrategyUI:handleCountyClick(x, y)
    local counties = CountyData:getAllCounties()
    
    for _, county in ipairs(counties) do
        local dx = x - county.x
        local dy = y - county.y
        local dist = math.sqrt(dx * dx + dy * dy)
        
        if dist <= 30 then  -- 点击范围内
            if self.selectedCounty == county.id then
                -- 再次点击选中项，尝试进攻
                if self:isAttackable(county.id) then
                    self:attackCounty(county.id)
                end
            else
                -- 选中
                self.selectedCounty = county.id
                print("选中: " .. county.name)
            end
            return
        end
    end
    
    -- 点击空白处取消选择
    self.selectedCounty = nil
end

-- 进攻郡县
function StrategyUI:attackCounty(countyId)
    if not self.campaign then return end
    
    local success, msg = self.campaign:playerSelectTarget(countyId)
    if success then
        local county = CountyData:getCounty(countyId)
        print("决定进攻: " .. county.name)
        
        -- AI行动
        self.campaign:aiActions()
        
        -- 开始执行战斗
        self.campaign:executeBattles()
    else
        print("无法进攻: " .. (msg or "未知原因"))
    end
end

-- 结束回合
function StrategyUI:endTurn()
    if not self.campaign then return end
    
    -- 如果玩家还没行动，直接跳过
    if not self.campaign.playerFaction.hasActed then
        self.campaign.playerFaction.hasActed = true
    end
    
    -- AI行动
    self.campaign:aiActions()
    
    -- 执行战斗
    self.campaign:executeBattles()
end

-- 显示将领池
function StrategyUI:showGenerals()
    print("显示将领池...")
    -- TODO: 打开将领管理界面
end

-- 显示历史
function StrategyUI:showHistory()
    print("显示历史记录...")
    -- TODO: 打开历史记录界面
end

function StrategyUI:keypressed(key)
    if key == "space" then
        self:endTurn()
    elseif key == "g" then
        self:showGenerals()
    end
end

return StrategyUI
