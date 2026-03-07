-- 郡县数据 - 中国古代主要郡县
-- 包含相邻关系、特产、地形等信息

local RARITY = require("src.utils.constants").RARITY

local CountyData = {}

-- 郡县定义
CountyData.counties = {
    -- 北方
    {id = "youzhou", name = "幽州", region = "北", x = 400, y = 100, 
     specialty = "骑兵", bonusType = "bravery", bonusValue = 5,
     desc = "燕赵多慷慨悲歌之士"},
    
    {id = "bingzhou", name = "并州", region = "北", x = 300, y = 200,
     specialty = "弓兵", bonusType = "insight", bonusValue = 1,
     desc = "天下之肩背"},
    
    {id = "jizhou", name = "冀州", region = "北", x = 400, y = 250,
     specialty = "豪杰", bonusType = "command", bonusValue = 5,
     desc = "九州之首，天下之中"},
    
    {id = "qingzhou", name = "青州", region = "北", x = 550, y = 280,
     specialty = "勇猛", bonusType = "bravery", bonusValue = 5,
     desc = "齐地多勇士"},
    
    -- 中原
    {id = "xuzhou", name = "徐州", region = "中", x = 650, y = 350,
     specialty = "精兵", bonusType = "command", bonusValue = 5,
     desc = "兵家必争之地"},
    
    {id = "yanzhou", name = "兖州", region = "中", x = 500, y = 380,
     specialty = "谋士", bonusType = "insight", bonusValue = 1,
     desc = "河济之间，四通八达"},
    
    {id = "yuzhou", name = "豫州", region = "中", x = 450, y = 450,
     specialty = "智者", bonusType = "command", bonusValue = 5,
     desc = "天下至中，帝王所居"},
    
    {id = "sili", name = "司隶", region = "中", x = 320, y = 400,
     specialty = "全能", bonusType = "reception", bonusValue = 5,
     desc = "京师重地，皇朝根本"},
    
    -- 关中
    {id = "guanzhong", name = "关中", region = "西", x = 250, y = 350,
     specialty = "勇将", bonusType = "bravery", bonusValue = 5,
     desc = "四塞之地，天府之国"},
    
    {id = "liangzhou", name = "凉州", region = "西", x = 100, y = 350,
     specialty = "铁骑", bonusType = "bravery", bonusValue = 5,
     desc = "天下要冲，国家藩卫"},
    
    {id = "yizhou", name = "益州", region = "西", x = 150, y = 550,
     specialty = "奇谋", bonusType = "insight", bonusValue = 1,
     desc = "沃野千里，天府之土"},
    
    {id = "hanzhong", name = "汉中", region = "西", x = 280, y = 480,
     specialty = "险守", bonusType = "reception", bonusValue = 5,
     desc = "高祖因之以成帝业"},
    
    -- 荆楚
    {id = "jingzhou", name = "荆州", region = "南", x = 380, y = 550,
     specialty = "水军", bonusType = "command", bonusValue = 5,
     desc = "北据汉沔，利尽南海"},
    
    {id = "yangzhou", name = "扬州", region = "南", x = 600, y = 500,
     specialty = "富饶", bonusType = "reception", bonusValue = 5,
     desc = "江淮之间，广陵大镇"},
    
    {id = "jiangdong", name = "江东", region = "南", x = 700, y = 550,
     specialty = "舟师", bonusType = "command", bonusValue = 5,
     desc = "江表之虎臣"},
    
    {id = "jiaozhou", name = "交州", region = "南", x = 450, y = 750,
     specialty = "蛮勇", bonusType = "bravery", bonusValue = 5,
     desc = "百越之地，山高皇帝远"},
}

-- 邻接关系（定义地图连接）
CountyData.adjacency = {
    youzhou = {"bingzhou", "jizhou"},
    bingzhou = {"youzhou", "jizhou", "guanzhong", "liangzhou"},
    jizhou = {"youzhou", "bingzhou", "qingzhou", "yanzhou", "yuzhou"},
    qingzhou = {"jizhou", "xuzhou", "yanzhou"},
    xuzhou = {"qingzhou", "yanzhou", "yuzhou"},
    yanzhou = {"jizhou", "qingzhou", "xuzhou", "yuzhou", "sili"},
    yuzhou = {"jizhou", "xuzhou", "yanzhou", "sili", "jingzhou"},
    sili = {"yanzhou", "yuzhou", "guanzhong", "hanzhong"},
    guanzhong = {"bingzhou", "sili", "liangzhou", "hanzhong"},
    liangzhou = {"bingzhou", "guanzhong"},
    yizhou = {"hanzhong", "jiaozhou"},
    hanzhong = {"sili", "guanzhong", "yizhou", "jingzhou"},
    jingzhou = {"yuzhou", "sili", "hanzhong", "yangzhou"},
    yangzhou = {"jingzhou", "jiangdong", "jiaozhou"},
    jiangdong = {"yangzhou", "jiaozhou"},
    jiaozhou = {"yizhou", "yangzhou", "jiangdong"},
}

-- 郡县特产将领（历史名将出生于此）
CountyData.specialtyGenerals = {
    youzhou = {{name = "张飞", dynasty = "汉"}, {name = "刘备", dynasty = "汉"}},
    bingzhou = {{name = "吕布", dynasty = "汉"}, {name = "张辽", dynasty = "魏"}},
    jizhou = {{name = "赵云", dynasty = "汉"}, {name = "张郃", dynasty = "魏"}},
    qingzhou = {{name = "太史慈", dynasty = "吴"}, {name = "孔明", dynasty = "蜀"}},
    xuzhou = {{name = "孙权", dynasty = "吴"}, {name = "鲁肃", dynasty = "吴"}},
    yanzhou = {{name = "曹操", dynasty = "魏"}, {name = "典韦", dynasty = "魏"}},
    yuzhou = {{name = "郭嘉", dynasty = "魏"}, {name = "荀彧", dynasty = "魏"}},
    sili = {{name = "贾诩", dynasty = "魏"}, {name = "董卓", dynasty = "汉"}},
    guanzhong = {{name = "马超", dynasty = "蜀"}, {name = "韩遂", dynasty = "汉"}},
    liangzhou = {{name = "马腾", dynasty = "汉"}, {name = "庞德", dynasty = "魏"}},
    yizhou = {{name = "诸葛亮", dynasty = "蜀"}, {name = "法正", dynasty = "蜀"}},
    hanzhong = {{name = "魏延", dynasty = "蜀"}, {name = "张鲁", dynasty = "汉"}},
    jingzhou = {{name = "关羽", dynasty = "蜀"}, {name = "庞统", dynasty = "蜀"}},
    yangzhou = {{name = "周瑜", dynasty = "吴"}, {name = "张昭", dynasty = "吴"}},
    jiangdong = {{name = "孙策", dynasty = "吴"}, {name = "甘宁", dynasty = "吴"}},
    jiaozhou = {{name = "士燮", dynasty = "汉"}, {name = "吕岱", dynasty = "吴"}},
}

-- 获取郡县信息
function CountyData:getCounty(id)
    for _, county in ipairs(self.counties) do
        if county.id == id then
            return county
        end
    end
    return nil
end

-- 获取相邻郡县
function CountyData:getNeighbors(id)
    local neighbors = {}
    local adjList = self.adjacency[id]
    if adjList then
        for _, neighborId in ipairs(adjList) do
            table.insert(neighbors, self:getCounty(neighborId))
        end
    end
    return neighbors
end

-- 检查两个郡县是否相邻
function CountyData:isAdjacent(id1, id2)
    local adjList = self.adjacency[id1]
    if adjList then
        for _, id in ipairs(adjList) do
            if id == id2 then
                return true
            end
        end
    end
    return false
end

-- 获取所有郡县
function CountyData:getAllCounties()
    return self.counties
end

-- 获取特产将领
function CountyData:getSpecialtyGenerals(countyId)
    return self.specialtyGenerals[countyId] or {}
end

return CountyData
