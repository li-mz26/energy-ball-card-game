-- 数风流 - 将领数据（续）
-- 三国 + 晋朝

local Constants = require("src.utils.constants")
local RARITY = Constants.RARITY

local MoreGenerals = {}

-- =====================================================
-- 三国 - 魏 (15人)
-- =====================================================
MoreGenerals.WEI = {
    {
        name = "曹操", title = "魏武帝",
        dynasty = "魏", surname = "曹", origin = "谯县",
        rarity = RARITY.ORANGE,
        bravery = 80, command = 98, reception = 90, insight = 10,
        maxHealth = 135
    },
    {
        name = "司马懿", title = "晋宣帝",
        dynasty = "魏", surname = "司马", origin = "河内",
        rarity = RARITY.ORANGE,
        bravery = 65, command = 98, reception = 92, insight = 10,
        maxHealth = 130
    },
    {
        name = "张辽", title = "前将军",
        dynasty = "魏", surname = "张", origin = "雁门",
        rarity = RARITY.ORANGE,
        bravery = 95, command = 90, reception = 78, insight = 8,
        maxHealth = 135
    },
    {
        name = "郭嘉", title = "祭酒",
        dynasty = "魏", surname = "郭", origin = "颍川",
        rarity = RARITY.PURPLE,
        bravery = 30, command = 95, reception = 88, insight = 10,
        maxHealth = 90
    },
    {
        name = "荀彧", title = "尚书令",
        dynasty = "魏", surname = "荀", origin = "颍川",
        rarity = RARITY.PURPLE,
        bravery = 35, command = 92, reception = 95, insight = 10,
        maxHealth = 95
    },
    {
        name = "贾诩", title = "太尉",
        dynasty = "魏", surname = "贾", origin = "武威",
        rarity = RARITY.PURPLE,
        bravery = 55, command = 90, reception = 85, insight = 10,
        maxHealth = 105
    },
    {
        name = "夏侯惇", title = "大将军",
        dynasty = "魏", surname = "夏侯", origin = "沛国",
        rarity = RARITY.PURPLE,
        bravery = 88, command = 80, reception = 72, insight = 6,
        maxHealth = 125
    },
    {
        name = "典韦", title = "校尉",
        dynasty = "魏", surname = "典", origin = "陈留",
        rarity = RARITY.PURPLE,
        bravery = 98, command = 55, reception = 60, insight = 5,
        maxHealth = 140
    },
    {
        name = "许褚", title = "虎侯",
        dynasty = "魏", surname = "许", origin = "谯县",
        rarity = RARITY.PURPLE,
        bravery = 97, command = 60, reception = 65, insight = 5,
        maxHealth = 140
    },
    {
        name = "徐晃", title = "右将军",
        dynasty = "魏", surname = "徐", origin = "河东",
        rarity = RARITY.PURPLE,
        bravery = 88, command = 85, reception = 78, insight = 7,
        maxHealth = 120
    },
    {
        name = "张郃", title = "征西车骑",
        dynasty = "魏", surname = "张", origin = "河间",
        rarity = RARITY.PURPLE,
        bravery = 86, command = 85, reception = 75, insight = 7,
        maxHealth = 120
    },
    {
        name = "邓艾", title = "太尉",
        dynasty = "魏", surname = "邓", origin = "义阳",
        rarity = RARITY.PURPLE,
        bravery = 85, command = 92, reception = 82, insight = 8,
        maxHealth = 120
    },
    {
        name = "钟会", title = "司徒",
        dynasty = "魏", surname = "钟", origin = "颍川",
        rarity = RARITY.PURPLE,
        bravery = 75, command = 90, reception = 80, insight = 9,
        maxHealth = 115
    },
    {
        name = "曹仁", title = "大司马",
        dynasty = "魏", surname = "曹", origin = "沛国",
        rarity = RARITY.PURPLE,
        bravery = 85, command = 88, reception = 82, insight = 7,
        maxHealth = 125
    },
    {
        name = "夏侯渊", title = "征西将军",
        dynasty = "魏", surname = "夏侯", origin = "沛国",
        rarity = RARITY.BLUE,
        bravery = 88, command = 82, reception = 70, insight = 6,
        maxHealth = 120
    },
}

-- =====================================================
-- 三国 - 蜀 (15人)
-- =====================================================
MoreGenerals.SHU = {
    {
        name = "刘备", title = "昭烈帝",
        dynasty = "蜀", surname = "刘", origin = "涿郡",
        rarity = RARITY.ORANGE,
        bravery = 78, command = 88, reception = 95, insight = 8,
        maxHealth = 130
    },
    {
        name = "诸葛亮", title = "武侯",
        dynasty = "蜀", surname = "诸葛", origin = "琅琊",
        rarity = RARITY.ORANGE,
        bravery = 45, command = 100, reception = 95, insight = 10,
        maxHealth = 105
    },
    {
        name = "关羽", title = "武圣",
        dynasty = "蜀", surname = "关", origin = "河东",
        rarity = RARITY.ORANGE,
        bravery = 98, command = 90, reception = 78, insight = 7,
        maxHealth = 145
    },
    {
        name = "张飞", title = "车骑将军",
        dynasty = "蜀", surname = "张", origin = "涿郡",
        rarity = RARITY.ORANGE,
        bravery = 97, command = 75, reception = 70, insight = 6,
        maxHealth = 140
    },
    {
        name = "赵云", title = "虎威将军",
        dynasty = "蜀", surname = "赵", origin = "常山",
        rarity = RARITY.ORANGE,
        bravery = 96, command = 88, reception = 85, insight = 8,
        maxHealth = 135
    },
    {
        name = "马超", title = "骠骑将军",
        dynasty = "蜀", surname = "马", origin = "扶风",
        rarity = RARITY.PURPLE,
        bravery = 95, command = 80, reception = 70, insight = 6,
        maxHealth = 130
    },
    {
        name = "黄忠", title = "后将军",
        dynasty = "蜀", surname = "黄", origin = "南阳",
        rarity = RARITY.PURPLE,
        bravery = 92, command = 78, reception = 72, insight = 6,
        maxHealth = 120
    },
    {
        name = "庞统", title = "凤雏",
        dynasty = "蜀", surname = "庞", origin = "襄阳",
        rarity = RARITY.PURPLE,
        bravery = 38, command = 92, reception = 85, insight = 9,
        maxHealth = 95
    },
    {
        name = "法正", title = "尚书令",
        dynasty = "蜀", surname = "法", origin = "扶风",
        rarity = RARITY.PURPLE,
        bravery = 55, command = 90, reception = 85, insight = 9,
        maxHealth = 105
    },
    {
        name = "姜维", title = "大将军",
        dynasty = "蜀", surname = "姜", origin = "天水",
        rarity = RARITY.PURPLE,
        bravery = 88, command = 92, reception = 80, insight = 8,
        maxHealth = 125
    },
    {
        name = "魏延", title = "征西大将军",
        dynasty = "蜀", surname = "魏", origin = "义阳",
        rarity = RARITY.PURPLE,
        bravery = 90, command = 82, reception = 65, insight = 7,
        maxHealth = 125
    },
    {
        name = "马岱", title = "平北将军",
        dynasty = "蜀", surname = "马", origin = "扶风",
        rarity = RARITY.BLUE,
        bravery = 82, command = 75, reception = 70, insight = 6,
        maxHealth = 110
    },
    {
        name = "王平", title = "安汉侯",
        dynasty = "蜀", surname = "王", origin = "巴西",
        rarity = RARITY.BLUE,
        bravery = 80, command = 82, reception = 78, insight = 7,
        maxHealth = 115
    },
    {
        name = "关兴", title = "侍中",
        dynasty = "蜀", surname = "关", origin = "河东",
        rarity = RARITY.BLUE,
        bravery = 82, command = 75, reception = 72, insight = 6,
        maxHealth = 110
    },
    {
        name = "张苞", title = "关内侯",
        dynasty = "蜀", surname = "张", origin = "涿郡",
        rarity = RARITY.GREEN,
        bravery = 85, command = 70, reception = 68, insight = 5,
        maxHealth = 115
    },
}

-- =====================================================
-- 三国 - 吴 (15人)
-- =====================================================
MoreGenerals.WU = {
    {
        name = "孙权", title = "吴大帝",
        dynasty = "吴", surname = "孙", origin = "吴郡",
        rarity = RARITY.ORANGE,
        bravery = 70, command = 92, reception = 90, insight = 9,
        maxHealth = 130
    },
    {
        name = "周瑜", title = "大都督",
        dynasty = "吴", surname = "周", origin = "庐江",
        rarity = RARITY.ORANGE,
        bravery = 78, command = 95, reception = 88, insight = 9,
        maxHealth = 125
    },
    {
        name = "陆逊", title = "丞相",
        dynasty = "吴", surname = "陆", origin = "吴郡",
        rarity = RARITY.ORANGE,
        bravery = 72, command = 96, reception = 92, insight = 10,
        maxHealth = 120
    },
    {
        name = "吕蒙", title = "国士",
        dynasty = "吴", surname = "吕", origin = "汝南",
        rarity = RARITY.PURPLE,
        bravery = 82, command = 90, reception = 85, insight = 9,
        maxHealth = 120
    },
    {
        name = "甘宁", title = "折冲将军",
        dynasty = "吴", surname = "甘", origin = "巴郡",
        rarity = RARITY.PURPLE,
        bravery = 92, command = 85, reception = 70, insight = 7,
        maxHealth = 125
    },
    {
        name = "太史慈", title = "建昌都尉",
        dynasty = "吴", surname = "太史", origin = "东莱",
        rarity = RARITY.PURPLE,
        bravery = 93, command = 82, reception = 75, insight = 7,
        maxHealth = 125
    },
    {
        name = "孙策", title = "长沙桓王",
        dynasty = "吴", surname = "孙", origin = "吴郡",
        rarity = RARITY.PURPLE,
        bravery = 95, command = 88, reception = 80, insight = 8,
        maxHealth = 130
    },
    {
        name = "黄盖", title = "偏将军",
        dynasty = "吴", surname = "黄", origin = "零陵",
        rarity = RARITY.BLUE,
        bravery = 85, command = 80, reception = 78, insight = 7,
        maxHealth = 115
    },
    {
        name = "程普", title = "荡寇将军",
        dynasty = "吴", surname = "程", origin = "右北平",
        rarity = RARITY.BLUE,
        bravery = 84, command = 82, reception = 80, insight = 7,
        maxHealth = 115
    },
    {
        name = "韩当", title = "石城侯",
        dynasty = "吴", surname = "韩", origin = "辽西",
        rarity = RARITY.BLUE,
        bravery = 82, command = 78, reception = 75, insight = 6,
        maxHealth = 110
    },
    {
        name = "周泰", title = "陵阳侯",
        dynasty = "吴", surname = "周", origin = "九江",
        rarity = RARITY.BLUE,
        bravery = 90, command = 75, reception = 70, insight = 6,
        maxHealth = 125
    },
    {
        name = "凌统", title = "偏将军",
        dynasty = "吴", surname = "凌", origin = "吴郡",
        rarity = RARITY.BLUE,
        bravery = 86, command = 78, reception = 72, insight = 6,
        maxHealth = 110
    },
    {
        name = "潘璋", title = "右将军",
        dynasty = "吴", surname = "潘", origin = "东郡",
        rarity = RARITY.BLUE,
        bravery = 82, command = 76, reception = 70, insight = 6,
        maxHealth = 105
    },
    {
        name = "陆抗", title = "大司马",
        dynasty = "吴", surname = "陆", origin = "吴郡",
        rarity = RARITY.PURPLE,
        bravery = 75, command = 92, reception = 88, insight = 9,
        maxHealth = 115
    },
    {
        name = "鲁肃", title = "横江将军",
        dynasty = "吴", surname = "鲁", origin = "临淮",
        rarity = RARITY.PURPLE,
        bravery = 60, command = 88, reception = 92, insight = 9,
        maxHealth = 105
    },
}

-- =====================================================
-- 晋朝 (20人)
-- =====================================================
MoreGenerals.JIN = {
    {
        name = "司马炎", title = "晋武帝",
        dynasty = "晋", surname = "司马", origin = "河内",
        rarity = RARITY.ORANGE,
        bravery = 70, command = 90, reception = 88, insight = 8,
        maxHealth = 125
    },
    {
        name = "司马昭", title = "晋文帝",
        dynasty = "晋", surname = "司马", origin = "河内",
        rarity = RARITY.PURPLE,
        bravery = 68, command = 92, reception = 88, insight = 9,
        maxHealth = 120
    },
    {
        name = "杜预", title = "征南大将军",
        dynasty = "晋", surname = "杜", origin = "京兆",
        rarity = RARITY.PURPLE,
        bravery = 78, command = 92, reception = 88, insight = 9,
        maxHealth = 115
    },
    {
        name = "羊祜", title = "太傅",
        dynasty = "晋", surname = "羊", origin = "泰山",
        rarity = RARITY.PURPLE,
        bravery = 72, command = 90, reception = 92, insight = 9,
        maxHealth = 110
    },
    {
        name = "王濬", title = "龙骧将军",
        dynasty = "晋", surname = "王", origin = "弘农",
        rarity = RARITY.BLUE,
        bravery = 80, command = 88, reception = 82, insight = 8,
        maxHealth = 115
    },
    {
        name = "王导", title = "丞相",
        dynasty = "晋", surname = "王", origin = "琅琊",
        rarity = RARITY.PURPLE,
        bravery = 45, command = 92, reception = 95, insight = 9,
        maxHealth = 100
    },
    {
        name = "谢安", title = "太傅",
        dynasty = "晋", surname = "谢", origin = "陈郡",
        rarity = RARITY.PURPLE,
        bravery = 60, command = 95, reception = 95, insight = 10,
        maxHealth = 105
    },
    {
        name = "谢玄", title = "康乐公",
        dynasty = "晋", surname = "谢", origin = "陈郡",
        rarity = RARITY.PURPLE,
        bravery = 88, command = 92, reception = 85, insight = 8,
        maxHealth = 120
    },
    {
        name = "王羲之", title = "书圣",
        dynasty = "晋", surname = "王", origin = "琅琊",
        rarity = RARITY.PURPLE,
        bravery = 35, command = 75, reception = 90, insight = 9,
        maxHealth = 85
    },
    {
        name = "顾恺之", title = "画圣",
        dynasty = "晋", surname = "顾", origin = "晋陵",
        rarity = RARITY.PURPLE,
        bravery = 30, command = 70, reception = 88, insight = 9,
        maxHealth = 80
    },
    {
        name = "陶渊明", title = "五柳先生",
        dynasty = "晋", surname = "陶", origin = "柴桑",
        rarity = RARITY.PURPLE,
        bravery = 35, command = 60, reception = 85, insight = 9,
        maxHealth = 85
    },
    {
        name = "祖逖", title = "镇西将军",
        dynasty = "晋", surname = "祖", origin = "范阳",
        rarity = RARITY.PURPLE,
        bravery = 90, command = 88, reception = 85, insight = 8,
        maxHealth = 120
    },
    {
        name = "桓温", title = "大司马",
        dynasty = "晋", surname = "桓", origin = "谯国",
        rarity = RARITY.PURPLE,
        bravery = 85, command = 90, reception = 82, insight = 8,
        maxHealth = 125
    },
    {
        name = "王猛", title = "丞相",
        dynasty = "晋", surname = "王", origin = "北海",
        rarity = RARITY.ORANGE,
        bravery = 60, command = 98, reception = 92, insight = 10,
        maxHealth = 110
    },
    {
        name = "慕容垂", title = "成武皇帝",
        dynasty = "晋", surname = "慕容", origin = "昌黎",
        rarity = RARITY.ORANGE,
        bravery = 95, command = 95, reception = 85, insight = 9,
        maxHealth = 135
    },
    {
        name = "苻坚", title = "秦天王",
        dynasty = "晋", surname = "苻", origin = "略阳",
        rarity = RARITY.PURPLE,
        bravery = 75, command = 88, reception = 90, insight = 8,
        maxHealth = 120
    },
    {
        name = "刘裕", title = "宋武帝",
        dynasty = "晋", surname = "刘", origin = "彭城",
        rarity = RARITY.ORANGE,
        bravery = 92, command = 95, reception = 88, insight = 9,
        maxHealth = 135
    },
    {
        name = "石勒", title = "赵明帝",
        dynasty = "晋", surname = "石", origin = "上党",
        rarity = RARITY.PURPLE,
        bravery = 88, command = 90, reception = 85, insight = 8,
        maxHealth = 125
    },
    {
        name = "张重华", title = "桓王",
        dynasty = "晋", surname = "张", origin = "安定",
        rarity = RARITY.BLUE,
        bravery = 70, command = 78, reception = 80, insight = 7,
        maxHealth = 105
    },
    {
        name = "陶侃", title = "长沙公",
        dynasty = "晋", surname = "陶", origin = "鄱阳",
        rarity = RARITY.BLUE,
        bravery = 82, command = 88, reception = 88, insight = 8,
        maxHealth = 115
    },
}

return MoreGenerals
