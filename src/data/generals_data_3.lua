-- 数风流 - 将领数据（续3）
-- 隋唐 + 五代十国

local Constants = require("src.utils.constants")
local RARITY = Constants.RARITY

local SuiTang = {}

-- =====================================================
-- 隋朝 (15人)
-- =====================================================
SuiTang.SUI = {
    {
        name = "杨坚", title = "隋文帝",
        dynasty = "隋", surname = "杨", origin = "弘农",
        rarity = RARITY.ORANGE,
        bravery = 75, command = 95, reception = 90, insight = 9,
        maxHealth = 130
    },
    {
        name = "杨广", title = "隋炀帝",
        dynasty = "隋", surname = "杨", origin = "长安",
        rarity = RARITY.PURPLE,
        bravery = 72, command = 85, reception = 82, insight = 8,
        maxHealth = 125
    },
    {
        name = "杨素", title = "楚公",
        dynasty = "隋", surname = "杨", origin = "弘农",
        rarity = RARITY.PURPLE,
        bravery = 88, command = 92, reception = 85, insight = 8,
        maxHealth = 125
    },
    {
        name = "韩擒虎", title = "上柱国",
        dynasty = "隋", surname = "韩", origin = "东垣",
        rarity = RARITY.PURPLE,
        bravery = 90, command = 88, reception = 80, insight = 8,
        maxHealth = 125
    },
    {
        name = "贺若弼", title = "宋公",
        dynasty = "隋", surname = "贺若", origin = "洛阳",
        rarity = RARITY.PURPLE,
        bravery = 88, command = 90, reception = 82, insight = 8,
        maxHealth = 120
    },
    {
        name = "史万岁", title = "太平公",
        dynasty = "隋", surname = "史", origin = "京兆",
        rarity = RARITY.PURPLE,
        bravery = 92, command = 88, reception = 78, insight = 7,
        maxHealth = 125
    },
    {
        name = "高颎", title = "齐国公",
        dynasty = "隋", surname = "高", origin = "渤海",
        rarity = RARITY.PURPLE,
        bravery = 60, command = 95, reception = 92, insight = 9,
        maxHealth = 110
    },
    {
        name = "宇文恺", title = "将作大匠",
        dynasty = "隋", surname = "宇文", origin = "朔方",
        rarity = RARITY.BLUE,
        bravery = 45, command = 85, reception = 88, insight = 9,
        maxHealth = 95
    },
    {
        name = "长孙晟", title = "大将军",
        dynasty = "隋", surname = "长孙", origin = "洛阳",
        rarity = RARITY.PURPLE,
        bravery = 88, command = 92, reception = 85, insight = 9,
        maxHealth = 120
    },
    {
        name = "萧皇后", title = "皇后",
        dynasty = "隋", surname = "萧", origin = "兰陵",
        rarity = RARITY.BLUE,
        bravery = 40, command = 75, reception = 90, insight = 9,
        maxHealth = 90
    },
    {
        name = "宇文化及", title = "许公",
        dynasty = "隋", surname = "宇文", origin = "武川",
        rarity = RARITY.BLUE,
        bravery = 75, command = 68, reception = 62, insight = 5,
        maxHealth = 110
    },
    {
        name = "王世充", title = "郑帝",
        dynasty = "隋", surname = "王", origin = "新丰",
        rarity = RARITY.BLUE,
        bravery = 78, command = 78, reception = 75, insight = 7,
        maxHealth = 115
    },
    {
        name = "窦建德", title = "夏王",
        dynasty = "隋", surname = "窦", origin = "贝州",
        rarity = RARITY.PURPLE,
        bravery = 85, command = 88, reception = 88, insight = 8,
        maxHealth = 125
    },
    {
        name = "李密", title = "魏公",
        dynasty = "隋", surname = "李", origin = "长安",
        rarity = RARITY.PURPLE,
        bravery = 72, command = 90, reception = 85, insight = 9,
        maxHealth = 115
    },
    {
        name = "单雄信", title = "大将军",
        dynasty = "隋", surname = "单", origin = "曹州",
        rarity = RARITY.BLUE,
        bravery = 90, command = 78, reception = 72, insight = 6,
        maxHealth = 120
    },
}

-- =====================================================
-- 唐朝 (25人)
-- =====================================================
SuiTang.TANG = {
    {
        name = "李渊", title = "唐高祖",
        dynasty = "唐", surname = "李", origin = "陇西",
        rarity = RARITY.ORANGE,
        bravery = 75, command = 92, reception = 90, insight = 9,
        maxHealth = 130
    },
    {
        name = "李世民", title = "唐太宗",
        dynasty = "唐", surname = "李", origin = "陇西",
        rarity = RARITY.ORANGE,
        bravery = 92, command = 98, reception = 95, insight = 10,
        maxHealth = 140
    },
    {
        name = "武则天", title = "则天皇帝",
        dynasty = "唐", surname = "武", origin = "并州",
        rarity = RARITY.ORANGE,
        bravery = 70, command = 95, reception = 92, insight = 10,
        maxHealth = 130
    },
    {
        name = "李隆基", title = "唐玄宗",
        dynasty = "唐", surname = "李", origin = "陇西",
        rarity = RARITY.ORANGE,
        bravery = 82, command = 92, reception = 90, insight = 9,
        maxHealth = 135
    },
    {
        name = "李靖", title = "卫国公",
        dynasty = "唐", surname = "李", origin = "三原",
        rarity = RARITY.ORANGE,
        bravery = 90, command = 100, reception = 92, insight = 10,
        maxHealth = 140
    },
    {
        name = "李勣", title = "英国公",
        dynasty = "唐", surname = "李", origin = "曹州",
        rarity = RARITY.ORANGE,
        bravery = 92, command = 95, reception = 88, insight = 9,
        maxHealth = 140
    },
    {
        name = "秦琼", title = "胡国公",
        dynasty = "唐", surname = "秦", origin = "齐州",
        rarity = RARITY.PURPLE,
        bravery = 95, command = 85, reception = 80, insight = 7,
        maxHealth = 135
    },
    {
        name = "尉迟恭", title = "鄂国公",
        dynasty = "唐", surname = "尉迟", origin = "朔州",
        rarity = RARITY.PURPLE,
        bravery = 96, command = 82, reception = 78, insight = 6,
        maxHealth = 140
    },
    {
        name = "程咬金", title = "卢国公",
        dynasty = "唐", surname = "程", origin = "东阿",
        rarity = RARITY.PURPLE,
        bravery = 88, command = 78, reception = 75, insight = 6,
        maxHealth = 130
    },
    {
        name = "房玄龄", title = "梁国公",
        dynasty = "唐", surname = "房", origin = "齐州",
        rarity = RARITY.PURPLE,
        bravery = 42, command = 95, reception = 95, insight = 10,
        maxHealth = 100
    },
    {
        name = "杜如晦", title = "蔡国公",
        dynasty = "唐", surname = "杜", origin = "京兆",
        rarity = RARITY.PURPLE,
        bravery = 45, command = 93, reception = 92, insight = 9,
        maxHealth = 100
    },
    {
        name = "魏征", title = "郑国公",
        dynasty = "唐", surname = "魏", origin = "巨鹿",
        rarity = RARITY.PURPLE,
        bravery = 40, command = 88, reception = 95, insight = 10,
        maxHealth = 95
    },
    {
        name = "长孙无忌", title = "赵国公",
        dynasty = "唐", surname = "长孙", origin = "洛阳",
        rarity = RARITY.PURPLE,
        bravery = 55, command = 92, reception = 90, insight = 9,
        maxHealth = 110
    },
    {
        name = "狄仁杰", title = "梁国公",
        dynasty = "唐", surname = "狄", origin = "太原",
        rarity = RARITY.PURPLE,
        bravery = 60, command = 92, reception = 95, insight = 10,
        maxHealth = 105
    },
    {
        name = "郭子仪", title = "汾阳王",
        dynasty = "唐", surname = "郭", origin = "华阴",
        rarity = RARITY.ORANGE,
        bravery = 88, command = 95, reception = 95, insight = 9,
        maxHealth = 140
    },
    {
        name = "李光弼", title = "临淮王",
        dynasty = "唐", surname = "李", origin = "营州",
        rarity = RARITY.PURPLE,
        bravery = 90, command = 95, reception = 88, insight = 9,
        maxHealth = 135
    },
    {
        name = "安禄山", title = "大燕皇帝",
        dynasty = "唐", surname = "安", origin = "营州",
        rarity = RARITY.PURPLE,
        bravery = 82, command = 85, reception = 80, insight = 7,
        maxHealth = 130
    },
    {
        name = "史思明", title = "大燕皇帝",
        dynasty = "唐", surname = "史", origin = "营州",
        rarity = RARITY.BLUE,
        bravery = 85, command = 82, reception = 78, insight = 7,
        maxHealth = 125
    },
    {
        name = "李白", title = "诗仙",
        dynasty = "唐", surname = "李", origin = "碎叶",
        rarity = RARITY.PURPLE,
        bravery = 55, command = 65, reception = 85, insight = 10,
        maxHealth = 95
    },
    {
        name = "杜甫", title = "诗圣",
        dynasty = "唐", surname = "杜", origin = "巩县",
        rarity = RARITY.PURPLE,
        bravery = 45, command = 60, reception = 88, insight = 10,
        maxHealth = 85
    },
    {
        name = "韩愈", title = "文起八代",
        dynasty = "唐", surname = "韩", origin = "河阳",
        rarity = RARITY.PURPLE,
        bravery = 50, command = 75, reception = 92, insight = 9,
        maxHealth = 90
    },
    {
        name = "白居易", title = "诗魔",
        dynasty = "唐", surname = "白", origin = "下邽",
        rarity = RARITY.PURPLE,
        bravery = 48, command = 78, reception = 90, insight = 9,
        maxHealth = 90
    },
    {
        name = "玄奘", title = "三藏法师",
        dynasty = "唐", surname = "陈", origin = "偃师",
        rarity = RARITY.PURPLE,
        bravery = 60, command = 70, reception = 95, insight = 10,
        maxHealth = 95
    },
    {
        name = "鉴真", title = "过海大师",
        dynasty = "唐", surname = "淳于", origin = "扬州",
        rarity = RARITY.BLUE,
        bravery = 55, command = 72, reception = 92, insight = 9,
        maxHealth = 90
    },
    {
        name = "杨贵妃", title = "贵妃",
        dynasty = "唐", surname = "杨", origin = "蒲州",
        rarity = RARITY.BLUE,
        bravery = 35, command = 60, reception = 88, insight = 8,
        maxHealth = 85
    },
}

-- =====================================================
-- 五代十国 (15人)
-- =====================================================
SuiTang.WUDAI = {
    {
        name = "朱温", title = "梁太祖",
        dynasty = "五代", surname = "朱", origin = "砀山",
        rarity = RARITY.PURPLE,
        bravery = 82, command = 88, reception = 82, insight = 7,
        maxHealth = 125
    },
    {
        name = "李克用", title = "晋王",
        dynasty = "五代", surname = "李", origin = "沙陀",
        rarity = RARITY.PURPLE,
        bravery = 92, command = 90, reception = 85, insight = 8,
        maxHealth = 135
    },
    {
        name = "李存勖", title = "唐庄宗",
        dynasty = "五代", surname = "李", origin = "晋阳",
        rarity = RARITY.PURPLE,
        bravery = 88, command = 92, reception = 85, insight = 8,
        maxHealth = 130
    },
    {
        name = "石敬瑭", title = "晋高祖",
        dynasty = "五代", surname = "石", origin = "太原",
        rarity = RARITY.BLUE,
        bravery = 78, command = 82, reception = 78, insight = 6,
        maxHealth = 115
    },
    {
        name = "刘知远", title = "汉高祖",
        dynasty = "五代", surname = "刘", origin = "太原",
        rarity = RARITY.BLUE,
        bravery = 80, command = 85, reception = 85, insight = 7,
        maxHealth = 120
    },
    {
        name = "郭威", title = "周太祖",
        dynasty = "五代", surname = "郭", origin = "邢州",
        rarity = RARITY.PURPLE,
        bravery = 85, command = 92, reception = 90, insight = 9,
        maxHealth = 130
    },
    {
        name = "柴荣", title = "周世宗",
        dynasty = "五代", surname = "柴", origin = "邢州",
        rarity = RARITY.ORANGE,
        bravery = 88, command = 95, reception = 92, insight = 9,
        maxHealth = 135
    },
    {
        name = "赵匡胤", title = "宋太祖",
        dynasty = "五代", surname = "赵", origin = "洛阳",
        rarity = RARITY.ORANGE,
        bravery = 90, command = 96, reception = 92, insight = 9,
        maxHealth = 140
    },
    {
        name = "钱镠", title = "吴越王",
        dynasty = "五代", surname = "钱", origin = "杭州",
        rarity = RARITY.BLUE,
        bravery = 75, command = 88, reception = 90, insight = 8,
        maxHealth = 115
    },
    {
        name = "杨行密", title = "吴王",
        dynasty = "五代", surname = "杨", origin = "庐州",
        rarity = RARITY.BLUE,
        bravery = 82, command = 88, reception = 85, insight = 8,
        maxHealth = 120
    },
    {
        name = "冯道", title = "长乐老",
        dynasty = "五代", surname = "冯", origin = "瀛州",
        rarity = RARITY.BLUE,
        bravery = 40, command = 88, reception = 92, insight = 9,
        maxHealth = 95
    },
    {
        name = "王彦章", title = "王铁枪",
        dynasty = "五代", surname = "王", origin = "寿张",
        rarity = RARITY.BLUE,
        bravery = 95, command = 82, reception = 75, insight = 6,
        maxHealth = 130
    },
    {
        name = "周德威", title = "名将",
        dynasty = "五代", surname = "周", origin = "朔州",
        rarity = RARITY.BLUE,
        bravery = 88, command = 90, reception = 82, insight = 8,
        maxHealth = 120
    },
    {
        name = "李嗣源", title = "唐明宗",
        dynasty = "五代", surname = "李", origin = "应州",
        rarity = RARITY.BLUE,
        bravery = 85, command = 88, reception = 88, insight = 8,
        maxHealth = 125
    },
    {
        name = "孟知祥", title = "蜀高祖",
        dynasty = "五代", surname = "孟", origin = "邢州",
        rarity = RARITY.BLUE,
        bravery = 78, command = 85, reception = 85, insight = 7,
        maxHealth = 115
    },
}

return SuiTang
