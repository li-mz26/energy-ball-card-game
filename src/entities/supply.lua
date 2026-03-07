-- 军资类 (Supply)

local Supply = Class:extend()

function Supply:init(dispatcher, targetSlot)
    self.id = math.random(1000000)
    self.dispatcher = dispatcher
    self.targetSlot = targetSlot
    self.targetGeneral = targetSlot and targetSlot.general or nil
    
    self.state = "moving" -- moving, success, lost, intercepted, transferred, arrived
    self.progress = 0
    self.path = {}
    
    -- 动画相关
    self.position = {x = 0, y = 0}
    self.visualProgress = 0
end

-- 尝试输送到目标
function Supply:attemptDispatch()
    if not self.targetGeneral or not self.targetGeneral:isAlive() then
        self.state = "lost"
        return false
    end
    
    -- 计算成功率
    local successRate = self.dispatcher:getDispatchSuccessRate(self.targetGeneral)
    local roll = math.random()
    
    if roll <= successRate then
        self.state = "success"
        return true
    else
        self.state = "lost"
        return false
    end
end

-- 更新动画
function Supply:update(dt)
    if self.state == "moving" then
        self.visualProgress = self.visualProgress + dt * 2  -- 2秒完成
        if self.visualProgress >= 1 then
            self.visualProgress = 1
        end
    end
end

return Supply
