-- 数风流 - 所有将领数据合并

local Constants = require("src.utils.constants")
local General = require("src.entities.general")

-- 加载各朝代数据
local Data1 = require("src.data.generals_data")
local Data2 = require("src.data.generals_data_2")
local Data3 = require("src.data.generals_data_3")
local Data4 = require("src.data.generals_data_4")
local Data5 = require("src.data.generals_data_5")

local AllGenerals = {}

-- 统计信息
AllGenerals.stats = {
    total = 0,
    byDynasty = {},
    byRarity = {白 = 0, 绿 = 0, 蓝 = 0, 紫 = 0, 橙 = 0}
}

-- 合并所有数据
local function mergeData(dataTable)
    local merged = {}
    for _, dynastyData in pairs(dataTable) do
        if type(dynastyData) == "table" then
            for _, generalData in ipairs(dynastyData) do
                table.insert(merged, generalData)
                
                -- 统计
                AllGenerals.stats.total = AllGenerals.stats.total + 1
                
                -- 按朝代统计
                local dynasty = generalData.dynasty or "未知"
                AllGenerals.stats.byDynasty[dynasty] = (AllGenerals.stats.byDynasty[dynasty] or 0) + 1
                
                -- 按品阶统计
                local rarityName = generalData.rarity and generalData.rarity.name or "未知"
                if AllGenerals.stats.byRarity[rarityName] then
                    AllGenerals.stats.byRarity[rarityName] = AllGenerals.stats.byRarity[rarityName] + 1
                end
            end
        end
    end
    return merged
end

-- 合并所有数据
local allRawData = {}
for _, data in ipairs({Data1, Data2, Data3, Data4, Data5}) do
    for _, generalData in ipairs(mergeData(data)) do
        table.insert(allRawData, generalData)
    end
end

-- 创建General实例
function AllGenerals:createGeneral(data)
    return General(data)
end

-- 获取所有将领数据（原始数据）
function AllGenerals:getAllRawData()
    return allRawData
end

-- 获取所有将领实例
function AllGenerals:getAllGenerals()
    local generals = {}
    for _, data in ipairs(allRawData) do
        table.insert(generals, self:createGeneral(data))
    end
    return generals
end

-- 按朝代获取
function AllGenerals:getByDynasty(dynasty)
    local result = {}
    for _, data in ipairs(allRawData) do
        if data.dynasty == dynasty then
            table.insert(result, self:createGeneral(data))
        end
    end
    return result
end

-- 按品阶获取
function AllGenerals:getByRarity(rarityLevel)
    local result = {}
    for _, data in ipairs(allRawData) do
        if data.rarity and data.rarity.level == rarityLevel then
            table.insert(result, self:createGeneral(data))
        end
    end
    return result
end

-- 按姓氏获取
function AllGenerals:getBySurname(surname)
    local result = {}
    for _, data in ipairs(allRawData) do
        if data.surname == surname then
            table.insert(result, self:createGeneral(data))
        end
    end
    return result
end

-- 按祖籍获取
function AllGenerals:getByOrigin(origin)
    local result = {}
    for _, data in ipairs(allRawData) do
        if data.origin == origin then
            table.insert(result, self:createGeneral(data))
        end
    end
    return result
end

-- 随机获取指定数量的将领
function AllGenerals:getRandomGenerals(count)
    local all = self:getAllGenerals()
    local result = {}
    
    -- Fisher-Yates洗牌
    for i = #all, 2, -1 do
        local j = math.random(i)
        all[i], all[j] = all[j], all[i]
    end
    
    -- 取前count个
    for i = 1, math.min(count, #all) do
        table.insert(result, all[i])
    end
    
    return result
end

-- 打印统计信息
function AllGenerals:printStats()
    print("\n========== 数风流 - 将领统计 ==========")
    print("总计: " .. self.stats.total .. " 人\n")
    
    print("【按朝代分布】")
    for dynasty, count in pairs(self.stats.byDynasty) do
        print(string.format("  %s: %d人", dynasty, count))
    end
    
    print("\n【按品阶分布】")
    for rarity, count in pairs(self.stats.byRarity) do
        print(string.format("  %s将: %d人", rarity, count))
    end
    print("========================================\n")
end

-- 初始化时打印统计
AllGenerals:printStats()

return AllGenerals
