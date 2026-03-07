-- 数风流 - 将领数据（续5）
-- 明朝 + 清朝

local Constants = require("src.utils.constants")
local RARITY = Constants.RARITY

local MingQing = {}

-- =====================================================
-- 明朝 (25人)
-- =====================================================
MingQing.MING = {
    {
        name = "朱元璋", title = "明太祖",
        dynasty = "明", surname = "朱", origin = "凤阳",
        rarity = RARITY.ORANGE,
        bravery = 88, command = 98, reception = 95, insight = 10,
        maxHealth = 145
    },
    {
        name = "朱棣", title = "明成祖",
        dynasty = "明", surname = "朱", origin = "凤阳",
        rarity = RARITY.ORANGE,
        bravery = 92, command = 95, reception = 92, insight = 9,
        maxHealth = 140
    },
    {
        name = "徐达", title = "中山王",
        dynasty = "明", surname = "徐", origin = "濠州",
        rarity = RARITY.ORANGE,
        bravery = 92, command = 98, reception = 92, insight = 9,
        maxHealth = 145
    },
    {
        name = "常遇春", title = "开平王",
        dynasty = "明", surname = "常", origin = "怀远",
        rarity = RARITY.ORANGE,
        bravery = 97, command = 92, reception = 85, insight = 8,
        maxHealth = 145
    },
    {
        name = "刘伯温", title = "诚意伯",
        dynasty = "明", surname = "刘", origin = "青田",
        rarity = RARITY.ORANGE,
        bravery = 55, command = 98, reception = 95, insight = 10,
        maxHealth = 105
    },
    {
        name = "李善长", title = "韩国公",
        dynasty = "明", surname = "李", origin = "定远",
        rarity = RARITY.PURPLE,
        bravery = 45, command = 92, reception = 95, insight = 9,
        maxHealth = 100
    },
    {
        name = "蓝玉", title = "凉国公",
        dynasty = "明", surname = "蓝", origin = "定远",
        rarity = RARITY.PURPLE,
        bravery = 95, command = 90, reception = 82, insight = 7,
        maxHealth = 140
    },
    {
        name = "于谦", title = "忠肃",
        dynasty = "明", surname = "于", origin = "钱塘",
        rarity = RARITY.ORANGE,
        bravery = 75, command = 95, reception = 95, insight = 10,
        maxHealth = 120
    },
    {
        name = "王阳明", title = "新建伯",
        dynasty = "明", surname = "王", origin = "余姚",
        rarity = RARITY.ORANGE,
        bravery = 82, command = 95, reception = 95, insight = 10,
        maxHealth = 125
    },
    {
        name = "张居正", title = "太师",
        dynasty = "明", surname = "张", origin = "江陵",
        rarity = RARITY.ORANGE,
        bravery = 60, command = 98, reception = 95, insight = 10,
        maxHealth = 110
    },
    {
        name = "戚继光", title = "武毅",
        dynasty = "明", surname = "戚", origin = "蓬莱",
        rarity = RARITY.PURPLE,
        bravery = 92, command = 95, reception = 90, insight = 9,
        maxHealth = 135
    },
    {
        name = "俞大猷", title = "武襄",
        dynasty = "明", surname = "俞", origin = "晋江",
        rarity = RARITY.PURPLE,
        bravery = 90, command = 92, reception = 88, insight = 9,
        maxHealth = 130
    },
    {
        name = "海瑞", title = "忠介",
        dynasty = "明", surname = "海", origin = "琼山",
        rarity = RARITY.PURPLE,
        bravery = 70, command = 88, reception = 98, insight = 9,
        maxHealth = 105
    },
    {
        name = "郑和", title = "三保太监",
        dynasty = "明", surname = "郑", origin = "昆明",
        rarity = RARITY.PURPLE,
        bravery = 75, command = 95, reception = 95, insight = 9,
        maxHealth = 115
    },
    {
        name = "李时珍", title = "药圣",
        dynasty = "明", surname = "李", origin = "蕲春",
        rarity = RARITY.PURPLE,
        bravery = 50, command = 80, reception = 95, insight = 10,
        maxHealth = 100
    },
    {
        name = "宋应星", title = "奉新",
        dynasty = "明", surname = "宋", origin = "奉新",
        rarity = RARITY.BLUE,
        bravery = 45, command = 78, reception = 92, insight = 10,
        maxHealth = 90
    },
    {
        name = "徐霞客", title = "游记",
        dynasty = "明", surname = "徐", origin = "江阴",
        rarity = RARITY.BLUE,
        bravery = 65, command = 85, reception = 92, insight = 10,
        maxHealth = 100
    },
    {
        name = "唐寅", title = "六如居士",
        dynasty = "明", surname = "唐", origin = "苏州",
        rarity = RARITY.PURPLE,
        bravery = 48, command = 72, reception = 88, insight = 9,
        maxHealth = 88
    },
    {
        name = "文徵明", title = "衡山居士",
        dynasty = "明", surname = "文", origin = "苏州",
        rarity = RARITY.BLUE,
        bravery = 40, command = 75, reception = 92, insight = 9,
        maxHealth = 85
    },
    {
        name = "郑成功", title = "国姓爷",
        dynasty = "明", surname = "郑", origin = "南安",
        rarity = RARITY.ORANGE,
        bravery = 92, command = 95, reception = 92, insight = 9,
        maxHealth = 140
    },
    {
        name = "袁崇焕", title = "督师",
        dynasty = "明", surname = "袁", origin = "东莞",
        rarity = RARITY.PURPLE,
        bravery = 85, command = 92, reception = 88, insight = 8,
        maxHealth = 130
    },
    {
        name = "史可法", title = "忠靖",
        dynasty = "明", surname = "史", origin = "祥符",
        rarity = RARITY.PURPLE,
        bravery = 78, command = 88, reception = 92, insight = 8,
        maxHealth = 115
    },
    {
        name = "严嵩", title = "分宜",
        dynasty = "明", surname = "严", origin = "分宜",
        rarity = RARITY.BLUE,
        bravery = 35, command = 82, reception = 85, insight = 8,
        maxHealth = 90
    },
    {
        name = "魏忠贤", title = "九千岁",
        dynasty = "明", surname = "魏", origin = "肃宁",
        rarity = RARITY.BLUE,
        bravery = 40, command = 80, reception = 82, insight = 7,
        maxHealth = 85
    },
    {
        name = "吴三桂", title = "平西王",
        dynasty = "明", surname = "吴", origin = "江苏",
        rarity = RARITY.PURPLE,
        bravery = 88, command = 88, reception = 80, insight = 7,
        maxHealth = 130
    },
}

-- =====================================================
-- 清朝 (25人)
-- =====================================================
MingQing.QING = {
    {
        name = "努尔哈赤", title = "清太祖",
        dynasty = "清", surname = "爱新觉罗", origin = "建州",
        rarity = RARITY.ORANGE,
        bravery = 95, command = 98, reception = 92, insight = 9,
        maxHealth = 145
    },
    {
        name = "皇太极", title = "清太宗",
        dynasty = "清", surname = "爱新觉罗", origin = "建州",
        rarity = RARITY.ORANGE,
        bravery = 88, command = 96, reception = 95, insight = 9,
        maxHealth = 140
    },
    {
        name = "多尔衮", title = "摄政王",
        dynasty = "清", surname = "爱新觉罗", origin = "建州",
        rarity = RARITY.ORANGE,
        bravery = 90, command = 95, reception = 90, insight = 9,
        maxHealth = 140
    },
    {
        name = "康熙", title = "清圣祖",
        dynasty = "清", surname = "爱新觉罗", origin = "北京",
        rarity = RARITY.ORANGE,
        bravery = 82, command = 98, reception = 95, insight = 10,
        maxHealth = 140
    },
    {
        name = "雍正", title = "清世宗",
        dynasty = "清", surname = "爱新觉罗", origin = "北京",
        rarity = RARITY.ORANGE,
        bravery = 75, command = 96, reception = 95, insight = 10,
        maxHealth = 130
    },
    {
        name = "乾隆", title = "清高宗",
        dynasty = "清", surname = "爱新觉罗", origin = "北京",
        rarity = RARITY.ORANGE,
        bravery = 80, command = 92, reception = 92, insight = 9,
        maxHealth = 135
    },
    {
        name = "年羹尧", title = "抚远大将军",
        dynasty = "清", surname = "年", origin = "怀远",
        rarity = RARITY.PURPLE,
        bravery = 90, command = 92, reception = 85, insight = 7,
        maxHealth = 130
    },
    {
        name = "隆科多", title = "太保",
        dynasty = "清", surname = "佟佳", origin = "满洲",
        rarity = RARITY.BLUE,
        bravery = 70, command = 85, reception = 85, insight = 7,
        maxHealth = 110
    },
    {
        name = "和珅", title = "文华殿大学士",
        dynasty = "清", surname = "钮祜禄", origin = "满洲",
        rarity = RARITY.BLUE,
        bravery = 55, command = 88, reception = 88, insight = 9,
        maxHealth = 100
    },
    {
        name = "刘墉", title = "文清",
        dynasty = "清", surname = "刘", origin = "诸城",
        rarity = RARITY.PURPLE,
        bravery = 60, command = 92, reception = 95, insight = 10,
        maxHealth = 105
    },
    {
        name = "纪晓岚", title = "文达",
        dynasty = "清", surname = "纪", origin = "献县",
        rarity = RARITY.PURPLE,
        bravery = 50, command = 88, reception = 95, insight = 10,
        maxHealth = 95
    },
    {
        name = "曾国藩", title = "文正",
        dynasty = "清", surname = "曾", origin = "湘乡",
        rarity = RARITY.ORANGE,
        bravery = 72, command = 95, reception = 95, insight = 10,
        maxHealth = 120
    },
    {
        name = "李鸿章", title = "文忠",
        dynasty = "清", surname = "李", origin = "合肥",
        rarity = RARITY.ORANGE,
        bravery = 70, command = 92, reception = 92, insight = 9,
        maxHealth = 115
    },
    {
        name = "左宗棠", title = "文襄",
        dynasty = "清", surname = "左", origin = "湘阴",
        rarity = RARITY.ORANGE,
        bravery = 82, command = 95, reception = 92, insight = 9,
        maxHealth = 125
    },
    {
        name = "张之洞", title = "文襄",
        dynasty = "清", surname = "张", origin = "南皮",
        rarity = RARITY.PURPLE,
        bravery = 60, command = 92, reception = 95, insight = 9,
        maxHealth = 110
    },
    {
        name = "林则徐", title = "文忠",
        dynasty = "清", surname = "林", origin = "侯官",
        rarity = RARITY.PURPLE,
        bravery = 75, command = 92, reception = 95, insight = 9,
        maxHealth = 115
    },
    {
        name = "邓世昌", title = "壮节",
        dynasty = "清", surname = "邓", origin = "番禺",
        rarity = RARITY.BLUE,
        bravery = 90, command = 85, reception = 88, insight = 7,
        maxHealth = 115
    },
    {
        name = "袁世凯", title = "洪宪皇帝",
        dynasty = "清", surname = "袁", origin = "项城",
        rarity = RARITY.PURPLE,
        bravery = 78, command = 90, reception = 88, insight = 8,
        maxHealth = 125
    },
    {
        name = "郑板桥", title = "板桥",
        dynasty = "清", surname = "郑", origin = "兴化",
        rarity = RARITY.BLUE,
        bravery = 55, command = 78, reception = 90, insight = 9,
        maxHealth = 90
    },
    {
        name = "曹雪芹", title = "梦阮",
        dynasty = "清", surname = "曹", origin = "南京",
        rarity = RARITY.PURPLE,
        bravery = 40, command = 68, reception = 90, insight = 10,
        maxHealth = 85
    },
    {
        name = "蒲松龄", title = "柳泉居士",
        dynasty = "清", surname = "蒲", origin = "淄川",
        rarity = RARITY.BLUE,
        bravery = 42, command = 65, reception = 88, insight = 10,
        maxHealth = 82
    },
    {
        name = "吴敬梓", title = "粒民",
        dynasty = "清", surname = "吴", origin = "全椒",
        rarity = RARITY.BLUE,
        bravery = 40, command = 70, reception = 88, insight = 9,
        maxHealth = 85
    },
    {
        name = "纳兰性德", title = "楞伽山人",
        dynasty = "清", surname = "叶赫那拉", origin = "满洲",
        rarity = RARITY.BLUE,
        bravery = 55, command = 75, reception = 90, insight = 9,
        maxHealth = 88
    },
    {
        name = "洪秀全", title = "天王",
        dynasty = "清", surname = "洪", origin = "花县",
        rarity = RARITY.BLUE,
        bravery = 68, command = 85, reception = 88, insight = 7,
        maxHealth = 115
    },
    {
        name = "慈禧太后", title = "孝钦显皇后",
        dynasty = "清", surname = "叶赫那拉", origin = "满洲",
        rarity = RARITY.PURPLE,
        bravery = 65, command = 92, reception = 90, insight = 9,
        maxHealth = 115
    },
}

return MingQing
