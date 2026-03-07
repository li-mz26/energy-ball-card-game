-- 东汉末年十三州郡县数据
-- 共13州，约100郡县，覆盖整个汉朝疆域

local CountyData = {}

-- 州列表
CountyData.STATES = {
    "司隶", "豫州", "冀州", "兖州", "徐州", 
    "青州", "荆州", "扬州", "益州", "凉州", 
    "并州", "幽州", "交州"
}

-- 特产类型
local SPECIALTIES = {
    WARRIOR = "warrior",      -- 武将型 (武勇+5)
    STRATEGIST = "strategist", -- 谋士型 (调度+5)
    DEFENDER = "defender",    -- 防守型 (接应+5)
    CAVALRY = "cavalry",      -- 骑兵型 (洞察+1)
    NAVAL = "naval",          -- 水军型 (输送+5%)
    BALANCED = "balanced"     -- 均衡型 (全属性+2)
}

CountyData.COUNTIES = {
    -- =====================================================
    -- 司隶校尉部（京畿地区）
    -- =====================================================
    {id = "luoyang", name = "洛阳", state = "司隶", neighbors = {"hula", "henan", "hongnong"}, specialty = SPECIALTIES.BALANCED, desc = "东汉都城，天下之中"},
    {id = "hula", name = "河南", state = "司隶", neighbors = {"luoyang", "hedong", "hongnong"}, specialty = SPECIALTIES.STRATEGIST, desc = "帝都近畿，人文荟萃"},
    {id = "hongnong", name = "弘农", state = "司隶", neighbors = {"luoyang", "hula", "jingzhao"}, specialty = SPECIALTIES.DEFENDER, desc = "函谷关所在，关中门户"},
    {id = "jingzhao", name = "京兆", state = "司隶", neighbors = {"hongnong", "fufeng", "zuopingyi"}, specialty = SPECIALTIES.BALANCED, desc = "长安故地，西京所在"},
    {id = "fufeng", name = "右扶风", state = "司隶", neighbors = {"jingzhao", "zuopingyi", "tianshui"}, specialty = SPECIALTIES.WARRIOR, desc = "班超故里，将门辈出"},
    {id = "zuopingyi", name = "左冯翊", state = "司隶", neighbors = {"jingzhao", "fufeng", "hedong"}, specialty = SPECIALTIES.WARRIOR, desc = "关中重镇"},
    {id = "hedong", name = "河东", state = "司隶", neighbors = {"zuopingyi", "hula", "taishan"}, specialty = SPECIALTIES.WARRIOR, desc = "关羽故里，盐铁重镇"},
    
    -- =====================================================
    -- 豫州（中原核心）
    -- =====================================================
    {id = "yingchuan", name = "颍川", state = "豫州", neighbors = {"luoyang", "runan", "xuchang", "chenliu"}, specialty = SPECIALTIES.STRATEGIST, desc = "谋士之乡，荀彧、郭嘉、陈群故里"},
    {id = "runan", name = "汝南", state = "豫州", neighbors = {"yingchuan", "nanyang", "xuchang", "peiguo"}, specialty = SPECIALTIES.WARRIOR, desc = "袁氏四世三公，许劭月旦评"},
    {id = "xuchang", name = "颍阴", state = "豫州", neighbors = {"yingchuan", "runan", "chenliu"}, specialty = SPECIALTIES.STRATEGIST, desc = "曹操迎献帝，挟天子以令诸侯"},
    {id = "chenliu", name = "陈留", state = "豫州", neighbors = {"yingchuan", "xuchang", "dongjun", "liangguo"}, specialty = SPECIALTIES.BALANCED, desc = "曹操起兵之地，张邈陈宫据此"},
    {id = "peiguo", name = "沛国", state = "豫州", neighbors = {"runan", "xuzhou", "xiapi"}, specialty = SPECIALTIES.WARRIOR, desc = "曹氏、夏侯氏故里"},
    {id = "liangguo", name = "梁国", state = "豫州", neighbors = {"chenliu", "peiguo", "yuzhou"}, specialty = SPECIALTIES.BALANCED, desc = "汉梁孝王封地"},
    
    -- =====================================================
    -- 冀州（河北核心）
    -- =====================================================
    {id = "yejun", name = "邺城", state = "冀州", neighbors = {"henei", "zhaoguo", "changshan"}, specialty = SPECIALTIES.STRATEGIST, desc = "袁绍、曹操霸府所在，曹魏龙兴之地"},
    {id = "zhaoguo", name = "赵国", state = "冀州", neighbors = {"yejun", "changshan", "weijun"}, specialty = SPECIALTIES.WARRIOR, desc = "战国赵地，豪侠辈出"},
    {id = "weijun", name = "魏郡", state = "冀州", neighbors = {"zhaoguo", "yuzhou", "yangping"}, specialty = SPECIALTIES.WARRIOR, desc = "曹操起家之地"},
    {id = "changshan", name = "常山", state = "冀州", neighbors = {"yejun", "zhaoguo", "zhongshan"}, specialty = SPECIALTIES.WARRIOR, desc = "赵云故里，真定所在"},
    {id = "zhongshan", name = "中山", state = "冀州", neighbors = {"changshan", "hejian", "bohai"}, specialty = SPECIALTIES.CAVALRY, desc = "刘备祖地，中山靖王之后"},
    {id = "hejian", name = "河间", state = "冀州", neighbors = {"zhongshan", "bohai", "anping"}, specialty = SPECIALTIES.WARRIOR, desc = "张郃故里"},
    {id = "bohai", name = "渤海", state = "冀州", neighbors = {"zhongshan", "hejian", "pingyuan"}, specialty = SPECIALTIES.NAVAL, desc = "袁绍起家之地，海滨渔盐"},
    {id = "qinghe", name = "清河", state = "冀州", neighbors = {"yejun", "weijun", "pingyuan"}, specialty = SPECIALTIES.STRATEGIST, desc = "崔氏世族所在"},
    
    -- =====================================================
    -- 兖州
    -- =====================================================
    {id = "dongjun", name = "东郡", state = "兖州", neighbors = {"chenliu", "jiyin", "taishan"}, specialty = SPECIALTIES.WARRIOR, desc = "曹操曾任东郡太守"},
    {id = "jiyin", name = "济阴", state = "兖州", neighbors = {"dongjun", "shanyang", "chenliu"}, specialty = SPECIALTIES.BALANCED, desc = "菏泽水泽，农商并重"},
    {id = "shanyang", name = "山阳", state = "兖州", neighbors = {"jiyin", "taishan", "peiguo"}, specialty = SPECIALTIES.BALANCED, desc = "刘表、高平王氏故里"},
    {id = "taishan", name = "泰山", state = "兖州", neighbors = {"dongjun", "shanyang", "qingzhou"}, specialty = SPECIALTIES.WARRIOR, desc = "五岳之首，豪杰辈出"},
    {id = "renqiu", name = "任城", state = "兖州", neighbors = {"dongjun", "jiyin"}, specialty = SPECIALTIES.WARRIOR, desc = "吕布曾任奋武将军屯任城"},
    
    -- =====================================================
    -- 徐州
    -- =====================================================
    {id = "xiapi", name = "下邳", state = "徐州", neighbors = {"peiguo", "guangling", "donghai"}, specialty = SPECIALTIES.STRATEGIST, desc = "吕布殒命白门楼，关羽土山约三事"},
    {id = "donghai", name = "东海", state = "徐州", neighbors = {"xiapi", "langye", "guangling"}, specialty = SPECIALTIES.NAVAL, desc = "海滨之地，糜竺世居于此"},
    {id = "langye", name = "琅琊", state = "徐州", neighbors = {"donghai", "qingzhou", "guangling"}, specialty = SPECIALTIES.STRATEGIST, desc = "诸葛亮、王祥故里，琅琊王氏发源地"},
    {id = "guangling", name = "广陵", state = "徐州", neighbors = {"donghai", "langye", "jiujiang"}, specialty = SPECIALTIES.NAVAL, desc = "张纮、陈琳故里，江都所在"},
    {id = "pengcheng", name = "彭城", state = "徐州", neighbors = {"peiguo", "xiapi", "shanyang"}, specialty = SPECIALTIES.WARRIOR, desc = "西楚霸王故都，刘裕故里"},
    
    -- =====================================================
    -- 青州
    -- =====================================================
    {id = "linzi", name = "齐国", state = "青州", neighbors = {"taishan", "beihai", "liaodong"}, specialty = SPECIALTIES.NAVAL, desc = "战国齐都，太公封地"},
    {id = "beihai", name = "北海", state = "青州", neighbors = {"linzi", "pingyuan", "langye"}, specialty = SPECIALTIES.STRATEGIST, desc = "孔融任北海相，郑玄故里"},
    {id = "pingyuan", name = "平原", state = "青州", neighbors = {"beihai", "bohai", "qinghe"}, specialty = SPECIALTIES.WARRIOR, desc = "刘备曾任平原令，管辂故里"},
    {id = "liaodong", name = "辽东", state = "青州", neighbors = {"linzi", "beihai", "changli"}, specialty = SPECIALTIES.CAVALRY, desc = "公孙度割据之地，太史慈故里"},
    
    -- =====================================================
    -- 荆州
    -- =====================================================
    {id = "xiangyang", name = "襄阳", state = "荆州", neighbors = {"nanyang", "jingzhou", "yicheng"}, specialty = SPECIALTIES.DEFENDER, desc = "铁打的襄阳，天下之腰，诸葛亮隐居隆中"},
    {id = "jingzhou", name = "南郡", state = "荆州", neighbors = {"xiangyang", "yicheng", "nanjun"}, specialty = SPECIALTIES.NAVAL, desc = "刘备借荆州，关羽水淹七军"},
    {id = "nanjun", name = "江陵", state = "荆州", neighbors = {"jingzhou", "yicheng", "lingling"}, specialty = SPECIALTIES.DEFENDER, desc = "荆州治所，吕蒙白衣渡江"},
    {id = "nanyang", name = "南阳", state = "荆州", neighbors = {"runan", "xiangyang", "hanzhong"}, specialty = SPECIALTIES.BALANCED, desc = "南都帝乡，刘秀故里，张仲景故里"},
    {id = "yicheng", name = "宜城", state = "荆州", neighbors = {"xiangyang", "jingzhou", "nanjun"}, specialty = SPECIALTIES.STRATEGIST, desc = "马良、马谡兄弟故里"},
    {id = "lingling", name = "零陵", state = "荆州", neighbors = {"nanjun", "changsha", "guiyang"}, specialty = SPECIALTIES.NAVAL, desc = "黄忠曾守零陵，刘度地盘"},
    {id = "changsha", name = "长沙", state = "荆州", neighbors = {"lingling", "guiyang", "jiangxia"}, specialty = SPECIALTIES.WARRIOR, desc = "孙坚曾任长沙太守，黄忠故里"},
    {id = "guiyang", name = "桂阳", state = "荆州", neighbors = {"lingling", "changsha", "wuling"}, specialty = SPECIALTIES.BALANCED, desc = "赵子龙计取桂阳"},
    {id = "wuling", name = "武陵", state = "荆州", neighbors = {"guiyang", "changsha", "yiling"}, specialty = SPECIALTIES.DEFENDER, desc = "五溪蛮地，潘濬治所"},
    {id = "yiling", name = "夷陵", state = "荆州", neighbors = {"wuling", "nanjun", "yidao"}, specialty = SPECIALTIES.DEFENDER, desc = "陆逊火烧连营，刘备托孤白帝城"},
    {id = "yidao", name = "夷道", state = "荆州", neighbors = {"yiling", "nanjun"}, specialty = SPECIALTIES.DEFENDER, desc = "长江三峡要塞"},
    {id = "jiangxia", name = "江夏", state = "荆州", neighbors = {"changsha", "xunyang", "nanjun"}, specialty = SPECIALTIES.NAVAL, desc = "黄祖守江夏，孙权攻伐多年"},
    
    -- =====================================================
    -- 扬州
    -- =====================================================
    {id = "shouchun", name = "寿春", state = "扬州", neighbors = {"lujiang", "jiujiang", "guangling"}, specialty = SPECIALTIES.WARRIOR, desc = "袁术称帝之地，淮南重镇"},
    {id = "lujiang", name = "庐江", state = "扬州", neighbors = {"shouchun", "jiujiang", "danyang"}, specialty = SPECIALTIES.WARRIOR, desc = "周瑜故里，周氏世居"},
    {id = "jiujiang", name = "九江", state = "扬州", neighbors = {"shouchun", "lujiang", "guangling"}, specialty = SPECIALTIES.NAVAL, desc = "华歆曾任九江太守"},
    {id = "danyang", name = "丹阳", state = "扬州", neighbors = {"lujiang", "wujun", "yuzhang"}, specialty = SPECIALTIES.CAVALRY, desc = "丹阳兵闻名天下，孙策起家之地"},
    {id = "wujun", name = "吴郡", state = "扬州", neighbors = {"danyang", "yuzhang", "kuaiji"}, specialty = SPECIALTIES.NAVAL, desc = "孙氏故里，江东核心"},
    {id = "kuaiji", name = "会稽", state = "扬州", neighbors = {"wujun", "yuzhang", "minyue"}, specialty = SPECIALTIES.STRATEGIST, desc = "王朗曾任太守，虞翻、顾雍故里"},
    {id = "yuzhang", name = "豫章", state = "扬州", neighbors = {"danyang", "wujun", "kuaiji", "xunyang"}, specialty = SPECIALTIES.BALANCED, desc = "华歆、徐稚故里"},
    {id = "xunyang", name = "浔阳", state = "扬州", neighbors = {"yuzhang", "jiangxia", "chaisang"}, specialty = SPECIALTIES.NAVAL, desc = "长江要塞，江州上游"},
    {id = "chaisang", name = "柴桑", state = "扬州", neighbors = {"xunyang", "jiangxia", "lingling"}, specialty = SPECIALTIES.NAVAL, desc = "周瑜屯兵之地，鄱阳湖口"},
    {id = "jianye", name = "建业", state = "扬州", neighbors = {"danyang", "wujun"}, specialty = SPECIALTIES.BALANCED, desc = "孙权定都建业，石头城"},
    
    -- =====================================================
    -- 益州
    -- =====================================================
    {id = "chengdu", name = "蜀郡", state = "益州", neighbors = {"hanzhong", "guanghan", "jiaming"}, specialty = SPECIALTIES.DEFENDER, desc = "成都平原，天府之国"},
    {id = "guanghan", name = "广汉", state = "益州", neighbors = {"chengdu", "zitong", "hanzhong"}, specialty = SPECIALTIES.STRATEGIST, desc = "严颜、张任故里"},
    {id = "zitong", name = "梓潼", state = "益州", neighbors = {"guanghan", "chengdu", "jiangzhou"}, specialty = SPECIALTIES.DEFENDER, desc = "蜀汉北伐粮草基地"},
    {id = "jianwei", name = "犍为", state = "益州", neighbors = {"chengdu", "yizhou", "jiangzhou"}, specialty = SPECIALTIES.BALANCED, desc = "李严治所"},
    {id = "yizhou", name = "益州郡", state = "益州", neighbors = {"jianwei", "yongchang", "nanzhong"}, specialty = SPECIALTIES.DEFENDER, desc = "滇池所在，诸葛亮南征平定"},
    {id = "yongchang", name = "永昌", state = "益州", neighbors = {"yizhou", "nanzhong"}, specialty = SPECIALTIES.DEFENDER, desc = "西南边陲，吕凯守土"},
    {id = "nanzhong", name = "南中", state = "益州", neighbors = {"yizhou", "yongchang", "jiaozhou"}, specialty = SPECIALTIES.WARRIOR, desc = "蛮夷之地，孟获、祝融"},
    {id = "jiangzhou", name = "巴郡", state = "益州", neighbors = {"zitong", "jianwei", "yongan"}, specialty = SPECIALTIES.NAVAL, desc = "严颜、甘宁故里，巴郡猛将"},
    {id = "yongan", name = "永安", state = "益州", neighbors = {"jiangzhou", "yiling", "yidao"}, specialty = SPECIALTIES.DEFENDER, desc = "刘备托孤白帝城，李严镇守"},
    {id = "baishui", name = "白水", state = "益州", neighbors = {"hanzhong", "guanghan", "zitong"}, specialty = SPECIALTIES.CAVALRY, desc = "杨任、杨昂守关之地"},
    {id = "hanzhong", name = "汉中", state = "益州", neighbors = {"nanyang", "chengdu", "baishui", "wudu"}, specialty = SPECIALTIES.DEFENDER, desc = "蜀道咽喉，刘邦发迹地，刘备称王"},
    {id = "wudu", name = "武都", state = "益州", neighbors = {"hanzhong", "tianshui", "yinping"}, specialty = SPECIALTIES.CAVALRY, desc = "氐族聚居地，张鲁、曹操争夺"},
    {id = "yinping", name = "阴平", state = "益州", neighbors = {"wudu", "longxi", "hanzhong"}, specialty = SPECIALTIES.CAVALRY, desc = "邓艾偷渡阴平，蜀汉灭亡"},
    
    -- =====================================================
    -- 凉州
    -- =====================================================
    {id = "wuwei", name = "武威", state = "凉州", neighbors = {"zhaowu", "jincheng", "zhangye"}, specialty = SPECIALTIES.CAVALRY, desc = "西凉铁骑，马超故里"},
    {id = "zhaowu", name = "酒泉", state = "凉州", neighbors = {"wuwei", "zhangye", "dunhuang"}, specialty = SPECIALTIES.CAVALRY, desc = "霍去病倾酒入泉"},
    {id = "zhangye", name = "张掖", state = "凉州", neighbors = {"wuwei", "zhaowu", "jincheng"}, specialty = SPECIALTIES.CAVALRY, desc = "张国臂掖，以通西域"},
    {id = "jincheng", name = "金城", state = "凉州", neighbors = {"wuwei", "zhangye", "longxi"}, specialty = SPECIALTIES.CAVALRY, desc = "韩遂、马腾起兵之地"},
    {id = "longxi", name = "陇西", state = "凉州", neighbors = {"jincheng", "tianshui", "yinping"}, specialty = SPECIALTIES.CAVALRY, desc = "董卓、李傕故里"},
    {id = "tianshui", name = "天水", state = "凉州", neighbors = {"longxi", "fufeng", "wudu"}, specialty = SPECIALTIES.STRATEGIST, desc = "姜维故里，赵云故乡"},
    {id = "dunhuang", name = "敦煌", state = "凉州", neighbors = {"zhaowu", "yiwu"}, specialty = SPECIALTIES.CAVALRY, desc = "丝路明珠，西域门户"},
    {id = "yiwu", name = "伊吾", state = "凉州", neighbors = {"dunhuang"}, specialty = SPECIALTIES.CAVALRY, desc = "西域都护府前沿"},
    
    -- =====================================================
    -- 并州
    -- =====================================================
    {id = "jinyang", name = "太原", state = "并州", neighbors = {"shangdang", "xihe", "yanmen"}, specialty = SPECIALTIES.WARRIOR, desc = "晋阳古城，王氏世族"},
    {id = "shangdang", name = "上党", state = "并州", neighbors = {"jinyang", "heinei", "xihe"}, specialty = SPECIALTIES.DEFENDER, desc = "太行天险，必争之地"},
    {id = "xihe", name = "西河", state = "并州", neighbors = {"jinyang", "shangdang", "zuopingyi"}, specialty = SPECIALTIES.CAVALRY, desc = "吕布、张杨活动之地"},
    {id = "yanmen", name = "雁门", state = "并州", neighbors = {"jinyang", "daijun"}, specialty = SPECIALTIES.CAVALRY, desc = "飞将军李广守边之地"},
    {id = "daijun", name = "代郡", state = "并州", neighbors = {"yanmen", "zhongshan"}, specialty = SPECIALTIES.CAVALRY, desc = "赵武灵王胡服骑射之地"},
    {id = "shangjun", name = "上郡", state = "并州", neighbors = {"xihe", "zuopingyi", "beidi"}, specialty = SPECIALTIES.CAVALRY, desc = "董卓起家之地"},
    
    -- =====================================================
    -- 幽州
    -- =====================================================
    {id = "zhuo", name = "涿郡", state = "幽州", neighbors = {"daijun", "guangyang", "yuyang"}, specialty = SPECIALTIES.WARRIOR, desc = "刘备、张飞故里"},
    {id = "guangyang", name = "广阳", state = "幽州", neighbors = {"zhuo", "yuyang", "daijun"}, specialty = SPECIALTIES.BALANCED, desc = "蓟城所在，幽州治所"},
    {id = "yuyang", name = "渔阳", state = "幽州", neighbors = {"guangyang", "zhuo", "liaoxi"}, specialty = SPECIALTIES.CAVALRY, desc = "张纯、张举之乱"},
    {id = "liaoxi", name = "辽西", state = "幽州", neighbors = {"yuyang", "liaodong", "changli"}, specialty = SPECIALTIES.CAVALRY, desc = "公孙瓒起家之地"},
    {id = "liaodong", name = "辽东", state = "幽州", neighbors = {"liaoxi", "changli", "lelang"}, specialty = SPECIALTIES.NAVAL, desc = "公孙度割据之地"},
    {id = "changli", name = "昌黎", state = "幽州", neighbors = {"liaoxi", "liaodong"}, specialty = SPECIALTIES.CAVALRY, desc = "慕容氏故里"},
    {id = "lelang", name = "乐浪", state = "幽州", neighbors = {"liaodong"}, specialty = SPECIALTIES.NAVAL, desc = "汉四郡之一，朝鲜北部"},
    {id = "xuantu", name = "玄菟", state = "幽州", neighbors = {"liaodong"}, specialty = SPECIALTIES.CAVALRY, desc = "汉四郡之一，高句丽交界"},
    
    -- =====================================================
    -- 交州
    -- =====================================================
    {id = "guangxin", name = "广信", state = "交州", neighbors = {"nanhai", "cangwu", "yulin"}, specialty = SPECIALTIES.NAVAL, desc = "交州治所，苍梧故地"},
    {id = "nanhai", name = "南海", state = "交州", neighbors = {"guangxin", "cangwu", "jiaozhi"}, specialty = SPECIALTIES.NAVAL, desc = "番禺所在，南越国都"},
    {id = "cangwu", name = "苍梧", state = "交州", neighbors = {"guangxin", "nanhai", "yulin"}, specialty = SPECIALTIES.NAVAL, desc = "士燮割据之地"},
    {id = "yulin", name = "郁林", state = "交州", neighbors = {"guangxin", "cangwu", "jiaozhi"}, specialty = SPECIALTIES.DEFENDER, desc = "广西中部"},
    {id = "jiaozhi", name = "交趾", state = "交州", neighbors = {"nanhai", "yulin", "jiuzhen"}, specialty = SPECIALTIES.NAVAL, desc = "红河三角洲，越南北部"},
    {id = "jiuzhen", name = "九真", state = "交州", neighbors = {"jiaozhi", "rikang"}, specialty = SPECIALTIES.NAVAL, desc = "越南中部"},
    {id = "rikang", name = "日南", state = "交州", neighbors = {"jiuzhen"}, specialty = SPECIALTIES.NAVAL, desc = "最南端郡，今越南广治"},
}

-- 获取统计信息
function CountyData:getStats()
    local stats = {
        total = 0,
        byState = {}
    }
    
    for _, county in ipairs(self.COUNTIES) do
        stats.total = stats.total + 1
        stats.byState[county.state] = (stats.byState[county.state] or 0) + 1
    end
    
    return stats
end

-- 打印统计
function CountyData:printStats()
    local stats = self:getStats()
    print("\n========== 东汉十三州郡县统计 ==========")
    print("总计: " .. stats.total .. " 郡县\n")
    
    for _, state in ipairs(self.STATES) do
        local count = stats.byState[state] or 0
        print(string.format("%s: %d郡", state, count))
    end
    print("========================================\n")
end

-- 根据ID获取郡县
function CountyData:getById(id)
    for _, county in ipairs(self.COUNTIES) do
        if county.id == id then
            return county
        end
    end
    return nil
end

-- 根据州获取郡县
function CountyData:getByState(state)
    local result = {}
    for _, county in ipairs(self.COUNTIES) do
        if county.state == state then
            table.insert(result, county)
        end
    end
    return result
end

-- 获取特产加成
function CountyData:getSpecialtyBonus(specialty)
    local bonuses = {
        warrior = {attr = "bravery", value = 5, desc = "武勇+5"},
        strategist = {attr = "command", value = 5, desc = "调度+5"},
        defender = {attr = "reception", value = 5, desc = "接应+5"},
        cavalry = {attr = "insight", value = 1, desc = "洞察+1"},
        naval = {attr = "dispatch", value = 0.05, desc = "输送成功率+5%"},
        balanced = {attr = "all", value = 2, desc = "全属性+2"}
    }
    return bonuses[specialty] or bonuses.balanced
end

-- 初始化时打印统计
CountyData:printStats()

return CountyData
