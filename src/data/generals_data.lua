-- 数风流 - 将领数据
-- 按朝代分类，共260+人物

local Constants = require("src.utils.constants")
local RARITY = Constants.RARITY

local GeneralsData = {}

-- =====================================================
-- 秦朝 (20人)
-- =====================================================
GeneralsData.QIN = {
    {
        name = "嬴政", title = "始皇帝",
        dynasty = "秦", surname = "嬴", origin = "咸阳",
        rarity = RARITY.ORANGE,
        bravery = 85, command = 95, reception = 80, insight = 9,
        maxHealth = 130
    },
    {
        name = "李斯", title = "丞相",
        dynasty = "秦", surname = "李", origin = "上蔡",
        rarity = RARITY.PURPLE,
        bravery = 40, command = 90, reception = 85, insight = 9,
        maxHealth = 100
    },
    {
        name = "王翦", title = "武成侯",
        dynasty = "秦", surname = "王", origin = "频阳",
        rarity = RARITY.ORANGE,
        bravery = 92, command = 95, reception = 80, insight = 8,
        maxHealth = 135
    },
    {
        name = "蒙恬", title = "中华第一勇士",
        dynasty = "秦", surname = "蒙", origin = "蒙山",
        rarity = RARITY.PURPLE,
        bravery = 90, command = 85, reception = 75, insight = 7,
        maxHealth = 125
    },
    {
        name = "赵高", title = "权宦",
        dynasty = "秦", surname = "赵", origin = "邯郸",
        rarity = RARITY.BLUE,
        bravery = 30, command = 75, reception = 80, insight = 8,
        maxHealth = 90
    },
    {
        name = "扶苏", title = "长子",
        dynasty = "秦", surname = "嬴", origin = "咸阳",
        rarity = RARITY.PURPLE,
        bravery = 70, command = 80, reception = 85, insight = 8,
        maxHealth = 110
    },
    {
        name = "胡亥", title = "秦二世",
        dynasty = "秦", surname = "嬴", origin = "咸阳",
        rarity = RARITY.GREEN,
        bravery = 30, command = 40, reception = 50, insight = 3,
        maxHealth = 80
    },
    {
        name = "章邯", title = "雍王",
        dynasty = "秦", surname = "章", origin = "咸阳",
        rarity = RARITY.PURPLE,
        bravery = 85, command = 82, reception = 75, insight = 7,
        maxHealth = 120
    },
    {
        name = "王贲", title = "通武侯",
        dynasty = "秦", surname = "王", origin = "频阳",
        rarity = RARITY.PURPLE,
        bravery = 88, command = 85, reception = 75, insight = 7,
        maxHealth = 125
    },
    {
        name = "李由", title = "三川守",
        dynasty = "秦", surname = "李", origin = "上蔡",
        rarity = RARITY.BLUE,
        bravery = 75, command = 70, reception = 65, insight = 6,
        maxHealth = 105
    },
    {
        name = "蒙毅", title = "上卿",
        dynasty = "秦", surname = "蒙", origin = "蒙山",
        rarity = RARITY.BLUE,
        bravery = 65, command = 80, reception = 85, insight = 8,
        maxHealth = 100
    },
    {
        name = "尉缭", title = "国尉",
        dynasty = "秦", surname = "尉", origin = "大梁",
        rarity = RARITY.PURPLE,
        bravery = 60, command = 92, reception = 80, insight = 9,
        maxHealth = 105
    },
    {
        name = "吕不韦", title = "仲父",
        dynasty = "秦", surname = "吕", origin = "濮阳",
        rarity = RARITY.PURPLE,
        bravery = 40, command = 88, reception = 85, insight = 9,
        maxHealth = 95
    },
    {
        name = "商鞅", title = "商君",
        dynasty = "秦", surname = "公孙", origin = "卫国",
        rarity = RARITY.ORANGE,
        bravery = 50, command = 95, reception = 85, insight = 10,
        maxHealth = 100
    },
    {
        name = "白起", title = "人屠",
        dynasty = "秦", surname = "白", origin = "郿县",
        rarity = RARITY.ORANGE,
        bravery = 98, command = 95, reception = 70, insight = 8,
        maxHealth = 140
    },
    {
        name = "范雎", title = "应侯",
        dynasty = "秦", surname = "范", origin = "芮城",
        rarity = RARITY.PURPLE,
        bravery = 35, command = 88, reception = 82, insight = 9,
        maxHealth = 95
    },
    {
        name = "甘罗", title = "上卿",
        dynasty = "秦", surname = "甘", origin = "下蔡",
        rarity = RARITY.BLUE,
        bravery = 30, command = 85, reception = 80, insight = 9,
        maxHealth = 80
    },
    {
        name = "郑国", title = "水工",
        dynasty = "秦", surname = "郑", origin = "新郑",
        rarity = RARITY.BLUE,
        bravery = 30, command = 80, reception = 85, insight = 8,
        maxHealth = 85
    },
    {
        name = "徐福", title = "方士",
        dynasty = "秦", surname = "徐", origin = "齐地",
        rarity = RARITY.GREEN,
        bravery = 40, command = 60, reception = 70, insight = 7,
        maxHealth = 85
    },
    {
        name = "项燕", title = "楚柱国",
        dynasty = "秦", surname = "项", origin = "下相",
        rarity = RARITY.PURPLE,
        bravery = 88, command = 82, reception = 75, insight = 7,
        maxHealth = 120
    },
}

-- =====================================================
-- 汉朝 (西汉+东汉，25人)
-- =====================================================
GeneralsData.HAN = {
    {
        name = "刘邦", title = "汉高祖",
        dynasty = "汉", surname = "刘", origin = "沛县",
        rarity = RARITY.ORANGE,
        bravery = 75, command = 92, reception = 88, insight = 9,
        maxHealth = 125
    },
    {
        name = "项羽", title = "西楚霸王",
        dynasty = "汉", surname = "项", origin = "下相",
        rarity = RARITY.ORANGE,
        bravery = 100, command = 85, reception = 70, insight = 7,
        maxHealth = 150
    },
    {
        name = "韩信", title = "兵仙",
        dynasty = "汉", surname = "韩", origin = "淮阴",
        rarity = RARITY.ORANGE,
        bravery = 85, command = 100, reception = 80, insight = 10,
        maxHealth = 140
    },
    {
        name = "张良", title = "谋圣",
        dynasty = "汉", surname = "张", origin = "城父",
        rarity = RARITY.ORANGE,
        bravery = 35, command = 95, reception = 90, insight = 10,
        maxHealth = 95
    },
    {
        name = "萧何", title = "相国",
        dynasty = "汉", surname = "萧", origin = "沛县",
        rarity = RARITY.PURPLE,
        bravery = 40, command = 90, reception = 95, insight = 9,
        maxHealth = 100
    },
    {
        name = "曹参", title = "平阳侯",
        dynasty = "汉", surname = "曹", origin = "沛县",
        rarity = RARITY.PURPLE,
        bravery = 85, command = 82, reception = 78, insight = 7,
        maxHealth = 120
    },
    {
        name = "周勃", title = "绛侯",
        dynasty = "汉", surname = "周", origin = "沛县",
        rarity = RARITY.BLUE,
        bravery = 82, command = 78, reception = 75, insight = 6,
        maxHealth = 115
    },
    {
        name = "卫青", title = "大将军",
        dynasty = "汉", surname = "卫", origin = "平阳",
        rarity = RARITY.ORANGE,
        bravery = 90, command = 95, reception = 85, insight = 8,
        maxHealth = 135
    },
    {
        name = "霍去病", title = "冠军侯",
        dynasty = "汉", surname = "霍", origin = "平阳",
        rarity = RARITY.ORANGE,
        bravery = 98, command = 92, reception = 75, insight = 8,
        maxHealth = 140
    },
    {
        name = "李广", title = "飞将军",
        dynasty = "汉", surname = "李", origin = "成纪",
        rarity = RARITY.PURPLE,
        bravery = 92, command = 80, reception = 75, insight = 7,
        maxHealth = 125
    },
    {
        name = "董仲舒", title = "大儒",
        dynasty = "汉", surname = "董", origin = "广川",
        rarity = RARITY.PURPLE,
        bravery = 30, command = 75, reception = 90, insight = 9,
        maxHealth = 90
    },
    {
        name = "张骞", title = "博望侯",
        dynasty = "汉", surname = "张", origin = "城固",
        rarity = RARITY.PURPLE,
        bravery = 70, command = 88, reception = 85, insight = 9,
        maxHealth = 110
    },
    {
        name = "苏武", title = "中郎将",
        dynasty = "汉", surname = "苏", origin = "长安",
        rarity = RARITY.BLUE,
        bravery = 65, command = 75, reception = 90, insight = 8,
        maxHealth = 100
    },
    {
        name = "司马迁", title = "太史公",
        dynasty = "汉", surname = "司马", origin = "龙门",
        rarity = RARITY.PURPLE,
        bravery = 35, command = 80, reception = 88, insight = 10,
        maxHealth = 90
    },
    {
        name = "王莽", title = "新始祖",
        dynasty = "汉", surname = "王", origin = "魏郡",
        rarity = RARITY.PURPLE,
        bravery = 55, command = 85, reception = 82, insight = 8,
        maxHealth = 110
    },
    {
        name = "刘秀", title = "汉光武帝",
        dynasty = "汉", surname = "刘", origin = "蔡阳",
        rarity = RARITY.ORANGE,
        bravery = 82, command = 95, reception = 90, insight = 9,
        maxHealth = 130
    },
    {
        name = "邓禹", title = "云台首将",
        dynasty = "汉", surname = "邓", origin = "南阳",
        rarity = RARITY.PURPLE,
        bravery = 75, command = 88, reception = 85, insight = 9,
        maxHealth = 115
    },
    {
        name = "马援", title = "伏波将军",
        dynasty = "汉", surname = "马", origin = "扶风",
        rarity = RARITY.PURPLE,
        bravery = 88, command = 85, reception = 80, insight = 8,
        maxHealth = 120
    },
    {
        name = "班超", title = "定远侯",
        dynasty = "汉", surname = "班", origin = "扶风",
        rarity = RARITY.PURPLE,
        bravery = 85, command = 90, reception = 85, insight = 9,
        maxHealth = 120
    },
    {
        name = "张衡", title = "科圣",
        dynasty = "汉", surname = "张", origin = "南阳",
        rarity = RARITY.PURPLE,
        bravery = 40, command = 82, reception = 88, insight = 10,
        maxHealth = 95
    },
    {
        name = "蔡伦", title = "龙亭侯",
        dynasty = "汉", surname = "蔡", origin = "桂阳",
        rarity = RARITY.BLUE,
        bravery = 35, command = 75, reception = 85, insight = 8,
        maxHealth = 90
    },
    {
        name = "华佗", title = "神医",
        dynasty = "汉", surname = "华", origin = "谯县",
        rarity = RARITY.PURPLE,
        bravery = 40, command = 70, reception = 95, insight = 10,
        maxHealth = 90
    },
    {
        name = "曹操", title = "魏武帝",
        dynasty = "汉", surname = "曹", origin = "谯县",
        rarity = RARITY.ORANGE,
        bravery = 80, command = 98, reception = 90, insight = 10,
        maxHealth = 135
    },
    {
        name = "刘备", title = "昭烈帝",
        dynasty = "汉", surname = "刘", origin = "涿郡",
        rarity = RARITY.ORANGE,
        bravery = 78, command = 85, reception = 92, insight = 8,
        maxHealth = 130
    },
    {
        name = "董卓", title = "太师",
        dynasty = "汉", surname = "董", origin = "临洮",
        rarity = RARITY.BLUE,
        bravery = 82, command = 70, reception = 65, insight = 5,
        maxHealth = 125
    },
}

-- 返回所有朝代数据
function GeneralsData:getAllGenerals()
    local all = {}
    for dynasty, generals in pairs(self) do
        if type(generals) == "table" and dynasty ~= "getAllGenerals" then
            for _, general in ipairs(generals) do
                table.insert(all, general)
            end
        end
    end
    return all
end

-- 按朝代获取
function GeneralsData:getByDynasty(dynasty)
    return self[dynasty] or {}
end

return GeneralsData
