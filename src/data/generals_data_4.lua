-- 数风流 - 将领数据（续4）
-- 宋朝 + 元朝

local Constants = require("src.utils.constants")
local RARITY = Constants.RARITY

local SongYuan = {}

-- =====================================================
-- 宋朝 (25人)
-- =====================================================
SongYuan.SONG = {
    {
        name = "赵匡胤", title = "宋太祖",
        dynasty = "宋", surname = "赵", origin = "洛阳",
        rarity = RARITY.ORANGE,
        bravery = 90, command = 96, reception = 92, insight = 9,
        maxHealth = 140
    },
    {
        name = "赵光义", title = "宋太宗",
        dynasty = "宋", surname = "赵", origin = "洛阳",
        rarity = RARITY.PURPLE,
        bravery = 78, command = 90, reception = 88, insight = 8,
        maxHealth = 125
    },
    {
        name = "赵普", title = "昭勋",
        dynasty = "宋", surname = "赵", origin = "幽州",
        rarity = RARITY.PURPLE,
        bravery = 45, command = 95, reception = 95, insight = 10,
        maxHealth = 100
    },
    {
        name = "曹彬", title = "济阳王",
        dynasty = "宋", surname = "曹", origin = "真定",
        rarity = RARITY.PURPLE,
        bravery = 82, command = 95, reception = 92, insight = 9,
        maxHealth = 120
    },
    {
        name = "潘美", title = "郑王",
        dynasty = "宋", surname = "潘", origin = "大名",
        rarity = RARITY.BLUE,
        bravery = 80, command = 85, reception = 80, insight = 7,
        maxHealth = 115
    },
    {
        name = "杨业", title = "杨令公",
        dynasty = "宋", surname = "杨", origin = "麟州",
        rarity = RARITY.PURPLE,
        bravery = 92, command = 88, reception = 82, insight = 7,
        maxHealth = 130
    },
    {
        name = "寇准", title = "莱国公",
        dynasty = "宋", surname = "寇", origin = "华州",
        rarity = RARITY.PURPLE,
        bravery = 60, command = 92, reception = 95, insight = 9,
        maxHealth = 105
    },
    {
        name = "范仲淹", title = "范文正",
        dynasty = "宋", surname = "范", origin = "苏州",
        rarity = RARITY.ORANGE,
        bravery = 68, command = 95, reception = 95, insight = 10,
        maxHealth = 115
    },
    {
        name = "欧阳修", title = "文忠",
        dynasty = "宋", surname = "欧阳", origin = "庐陵",
        rarity = RARITY.PURPLE,
        bravery = 45, command = 85, reception = 92, insight = 10,
        maxHealth = 95
    },
    {
        name = "王安石", title = "荆公",
        dynasty = "宋", surname = "王", origin = "临川",
        rarity = RARITY.PURPLE,
        bravery = 55, command = 92, reception = 90, insight = 10,
        maxHealth = 100
    },
    {
        name = "司马光", title = "温国公",
        dynasty = "宋", surname = "司马", origin = "夏县",
        rarity = RARITY.PURPLE,
        bravery = 48, command = 90, reception = 92, insight = 10,
        maxHealth = 95
    },
    {
        name = "苏轼", title = "东坡",
        dynasty = "宋", surname = "苏", origin = "眉山",
        rarity = RARITY.PURPLE,
        bravery = 52, command = 82, reception = 90, insight = 10,
        maxHealth = 95
    },
    {
        name = "岳飞", title = "武穆",
        dynasty = "宋", surname = "岳", origin = "汤阴",
        rarity = RARITY.ORANGE,
        bravery = 98, command = 95, reception = 92, insight = 8,
        maxHealth = 145
    },
    {
        name = "韩世忠", title = "蕲王",
        dynasty = "宋", surname = "韩", origin = "延安",
        rarity = RARITY.PURPLE,
        bravery = 92, command = 92, reception = 88, insight = 8,
        maxHealth = 135
    },
    {
        name = "张俊", title = "循王",
        dynasty = "宋", surname = "张", origin = "凤翔",
        rarity = RARITY.BLUE,
        bravery = 85, command = 85, reception = 82, insight = 7,
        maxHealth = 120
    },
    {
        name = "刘光世", title = "鄜王",
        dynasty = "宋", surname = "刘", origin = "保安",
        rarity = RARITY.BLUE,
        bravery = 82, command = 82, reception = 80, insight = 7,
        maxHealth = 115
    },
    {
        name = "李纲", title = "忠定",
        dynasty = "宋", surname = "李", origin = "邵武",
        rarity = RARITY.PURPLE,
        bravery = 75, command = 90, reception = 92, insight = 9,
        maxHealth = 110
    },
    {
        name = "宗泽", title = "忠简",
        dynasty = "宋", surname = "宗", origin = "义乌",
        rarity = RARITY.PURPLE,
        bravery = 85, command = 90, reception = 90, insight = 8,
        maxHealth = 120
    },
    {
        name = "狄青", title = "武襄",
        dynasty = "宋", surname = "狄", origin = "汾州",
        rarity = RARITY.PURPLE,
        bravery = 95, command = 88, reception = 82, insight = 7,
        maxHealth = 135
    },
    {
        name = "包拯", title = "孝肃",
        dynasty = "宋", surname = "包", origin = "合肥",
        rarity = RARITY.PURPLE,
        bravery = 65, command = 92, reception = 95, insight = 10,
        maxHealth = 105
    },
    {
        name = "沈括", title = "存中",
        dynasty = "宋", surname = "沈", origin = "钱塘",
        rarity = RARITY.PURPLE,
        bravery = 50, command = 88, reception = 92, insight = 10,
        maxHealth = 95
    },
    {
        name = "毕昇", title = "发明家",
        dynasty = "宋", surname = "毕", origin = "蕲州",
        rarity = RARITY.BLUE,
        bravery = 35, command = 75, reception = 88, insight = 9,
        maxHealth = 80
    },
    {
        name = "朱熹", title = "文公",
        dynasty = "宋", surname = "朱", origin = "婺源",
        rarity = RARITY.ORANGE,
        bravery = 48, command = 88, reception = 95, insight = 10,
        maxHealth = 95
    },
    {
        name = "陆九渊", title = "象山",
        dynasty = "宋", surname = "陆", origin = "金溪",
        rarity = RARITY.PURPLE,
        bravery = 50, command = 85, reception = 92, insight = 10,
        maxHealth = 92
    },
    {
        name = "辛弃疾", title = "稼轩",
        dynasty = "宋", surname = "辛", origin = "历城",
        rarity = RARITY.PURPLE,
        bravery = 88, command = 90, reception = 88, insight = 9,
        maxHealth = 120
    },
}

-- =====================================================
-- 元朝 (20人)
-- =====================================================
SongYuan.YUAN = {
    {
        name = "成吉思汗", title = "元太祖",
        dynasty = "元", surname = "孛儿只斤", origin = "蒙古",
        rarity = RARITY.ORANGE,
        bravery = 98, command = 100, reception = 95, insight = 9,
        maxHealth = 150
    },
    {
        name = "窝阔台", title = "元太宗",
        dynasty = "元", surname = "孛儿只斤", origin = "蒙古",
        rarity = RARITY.PURPLE,
        bravery = 85, command = 92, reception = 90, insight = 8,
        maxHealth = 130
    },
    {
        name = "忽必烈", title = "元世祖",
        dynasty = "元", surname = "孛儿只斤", origin = "蒙古",
        rarity = RARITY.ORANGE,
        bravery = 88, command = 95, reception = 92, insight = 9,
        maxHealth = 140
    },
    {
        name = "耶律楚材", title = "中书令",
        dynasty = "元", surname = "耶律", origin = "契丹",
        rarity = RARITY.PURPLE,
        bravery = 55, command = 95, reception = 95, insight = 10,
        maxHealth = 105
    },
    {
        name = "伯颜", title = "淮王",
        dynasty = "元", surname = "伯", origin = "蒙古",
        rarity = RARITY.PURPLE,
        bravery = 90, command = 95, reception = 88, insight = 9,
        maxHealth = 135
    },
    {
        name = "郭侃", title = "名将",
        dynasty = "元", surname = "郭", origin = "华州",
        rarity = RARITY.PURPLE,
        bravery = 92, command = 92, reception = 85, insight = 8,
        maxHealth = 130
    },
    {
        name = "史天泽", title = "镇阳王",
        dynasty = "元", surname = "史", origin = "永清",
        rarity = RARITY.BLUE,
        bravery = 85, command = 90, reception = 88, insight = 8,
        maxHealth = 120
    },
    {
        name = "张弘范", title = "蒙古汉军",
        dynasty = "元", surname = "张", origin = "易州",
        rarity = RARITY.BLUE,
        bravery = 88, command = 88, reception = 82, insight = 7,
        maxHealth = 120
    },
    {
        name = "刘秉忠", title = "赵国公",
        dynasty = "元", surname = "刘", origin = "邢州",
        rarity = RARITY.PURPLE,
        bravery = 50, command = 95, reception = 92, insight = 10,
        maxHealth = 100
    },
    {
        name = "许衡", title = "魏国公",
        dynasty = "元", surname = "许", origin = "河内",
        rarity = RARITY.PURPLE,
        bravery = 45, command = 88, reception = 95, insight = 10,
        maxHealth = 95
    },
    {
        name = "关汉卿", title = "曲圣",
        dynasty = "元", surname = "关", origin = "大都",
        rarity = RARITY.PURPLE,
        bravery = 40, command = 70, reception = 88, insight = 9,
        maxHealth = 85
    },
    {
        name = "马致远", title = "曲状元",
        dynasty = "元", surname = "马", origin = "大都",
        rarity = RARITY.BLUE,
        bravery = 38, command = 68, reception = 85, insight = 9,
        maxHealth = 82
    },
    {
        name = "王实甫", title = "戏曲家",
        dynasty = "元", surname = "王", origin = "定兴",
        rarity = RARITY.BLUE,
        bravery = 35, command = 65, reception = 85, insight = 9,
        maxHealth = 80
    },
    {
        name = "赵孟頫", title = "松雪道人",
        dynasty = "元", surname = "赵", origin = "吴兴",
        rarity = RARITY.PURPLE,
        bravery = 45, command = 75, reception = 92, insight = 9,
        maxHealth = 88
    },
    {
        name = "黄道婆", title = "纺织家",
        dynasty = "元", surname = "黄", origin = "松江",
        rarity = RARITY.BLUE,
        bravery = 40, command = 70, reception = 92, insight = 9,
        maxHealth = 85
    },
    {
        name = "郭守敬", title = "太史令",
        dynasty = "元", surname = "郭", origin = "邢台",
        rarity = RARITY.PURPLE,
        bravery = 45, command = 92, reception = 95, insight = 10,
        maxHealth = 95
    },
    {
        name = "马可波罗", title = "旅行家",
        dynasty = "元", surname = "马可", origin = "威尼斯",
        rarity = RARITY.BLUE,
        bravery = 55, command = 75, reception = 90, insight = 9,
        maxHealth = 90
    },
    {
        name = "脱脱", title = "太师",
        dynasty = "元", surname = "脱", origin = "蒙古",
        rarity = RARITY.PURPLE,
        bravery = 72, command = 92, reception = 90, insight = 9,
        maxHealth = 115
    },
    {
        name = "刘福通", title = "红巾军首领",
        dynasty = "元", surname = "刘", origin = "颍州",
        rarity = RARITY.BLUE,
        bravery = 82, command = 85, reception = 82, insight = 7,
        maxHealth = 110
    },
    {
        name = "张士诚", title = "吴王",
        dynasty = "元", surname = "张", origin = "泰州",
        rarity = RARITY.BLUE,
        bravery = 78, command = 85, reception = 85, insight = 7,
        maxHealth = 115
    },
}

return SongYuan
