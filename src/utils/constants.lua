-- 常量配置

local Constants = {}

-- 游戏配置
Constants.GAME = {
    MAX_ROUNDS = 3,
    FORMATION_COUNT = 4,
    FORMATION_SLOTS = {1, 3, 3, 3},
    FORMATION_NAMES = {"先锋", "中军", "后军", "大营"},
    MAIN_CAMP_HEALTH = 100,
    SUPPLY_DAMAGE = 10,
    BASE_DISPATCH_SUCCESS_RATE = 0.70, -- 70%基础成功率
}

-- 羁绊加成
Constants.BOND = {
    DYNASTY_BONUS = 0.15,      -- 同朝 +15%
    SURNAME_BONUS = 0.10,      -- 同姓 +10%
    ORIGIN_BONUS = 0.10,       -- 同籍 +10%
    COMBO_BONUS = 0.05,        -- 同朝同姓额外 +5%
    MAX_SUCCESS_RATE = 0.95,   -- 最大95%
}

-- 品阶
Constants.RARITY = {
    WHITE = {level = 1, name = "白", maxLevel = 20, color = {0.8, 0.8, 0.8}},
    GREEN = {level = 2, name = "绿", maxLevel = 30, color = {0.2, 0.8, 0.2}},
    BLUE = {level = 3, name = "蓝", maxLevel = 40, color = {0.2, 0.5, 1.0}},
    PURPLE = {level = 4, name = "紫", maxLevel = 50, color = {0.6, 0.2, 0.8}},
    ORANGE = {level = 5, name = "橙", maxLevel = 60, color = {1.0, 0.6, 0.0}},
}

-- 颜色
Constants.COLORS = {
    BACKGROUND = {0.1, 0.1, 0.12},      -- 玄黑
    PANEL = {0.15, 0.15, 0.18},          -- 次级背景
    ACCENT_RED = {0.79, 0.22, 0.17},     -- 朱砂红
    ACCENT_GREEN = {0.29, 0.49, 0.35},   -- 青铜绿
    ACCENT_GOLD = {0.83, 0.65, 0.46},    -- 古铜金
    TEXT = {0.96, 0.96, 0.86},           -- 宣纸黄
    TEXT_DIM = {0.6, 0.6, 0.6},
}

-- 屏幕尺寸
Constants.SCREEN = {
    WIDTH = 1920,
    HEIGHT = 1080,
    SCALE = 1,
}

-- 军阵位置配置 (相对于屏幕)
Constants.FORMATION_LAYOUT = {
    PLAYER_Y = 400,          -- 我方军阵Y位置
    ENEMY_Y = 250,           -- 敌方军阵Y位置
    START_X = 360,           -- 第一个军阵X位置
    SLOT_WIDTH = 180,        -- 槽位宽度
    SLOT_HEIGHT = 120,       -- 槽位高度
    SLOT_GAP = 20,           -- 槽位间距
}

return Constants
