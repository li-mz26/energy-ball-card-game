-- 郡县类 (County)

local CountyData = require("src.data.county_data")

local County = Class:extend()

function County:init(data)
    self.id = data.id
    self.name = data.name
    self.state = data.state  -- 所属州
    self.neighbors = data.neighbors or {}
    self.specialty = data.specialty or "balanced"
    self.description = data.desc or ""
    
    -- 动态状态
    self.owner = nil  -- 所属势力ID
    self.faction = nil  -- 所属势力引用
end

-- 获取相邻郡县
function County:getNeighbors()
    return self.neighbors
end

-- 检查是否与指定郡县相邻
function County:isAdjacentTo(countyId)
    for _, neighborId in ipairs(self.neighbors) do
        if neighborId == countyId then
            return true
        end
    end
    return false
end

-- 设置所属势力
function County:setOwner(faction)
    self.faction = faction
    self.owner = faction and faction.id or nil
end

-- 获取特产加成
function County:getSpecialtyBonus()
    return CountyData:getSpecialtyBonus(self.specialty)
end

-- 是否被占领
function County:isOccupied()
    return self.owner ~= nil
end

-- 获取显示信息
function County:getInfo()
    local ownerName = self.faction and self.faction.name or "无主"
    local bonus = self:getSpecialtyBonus()
    
    return string.format("%s (%s) - %s\n特产: %s (%s)\n%s",
        self.name,
        self.region,
        ownerName,
        self.specialty,
        bonus.desc,
        self.description
    )
end

return County
