# ShuFengliu (ShuFengliu) - 类与对象设计文档

## 1. 概述

本文档定义《ShuFengliu》游戏的面向对象设计，包括核心类结构、接口定义和模块关系。

**设计原则**:
- 单一职责: 每个类负责明确的功能领域
- 开闭原则: 对扩展开放，对修改关闭
- 依赖倒置: 依赖抽象而非具体实现

---

## 2. 核心类图

```
┌─────────────────────────────────────────────────────────────────────┐
│                           Game (游戏主类)                           │
├─────────────────────────────────────────────────────────────────────┤
│ - state: GameState                                                  │
│ - currentRound: number                                              │
│ - maxRounds: number = 3                                             │
├─────────────────────────────────────────────────────────────────────┤
│ + startGame()                                                       │
│ + endGame()                                                         │
│ + update(dt: number)                                                │
│ + draw()                                                            │
└─────────────────────────────────────────────────────────────────────┘
                              │
        ┌─────────────────────┼─────────────────────┐
        ▼                     ▼                     ▼
┌───────────────┐    ┌───────────────┐    ┌───────────────┐
│  BattleField  │    │  RoundManager │    │  UIManager    │
│   (战场)       │    │   (回合管理)   │    │   (UI管理)    │
└───────────────┘    └───────────────┘    └───────────────┘
        │                     │                     │
        ▼                     ▼                     ▼
┌─────────────────────────────────────────────────────────────────────┐
│                          Player (玩家)                              │
├─────────────────────────────────────────────────────────────────────┤
│ - id: string                                                        │
│ - name: string                                                      │
│ - camp: Camp                                                        │
│ - mainCamp: MainCamp                                                │
│ - hand: Hand                                                        │
│ - formations: Formation[4]                                          │
│ - collection: Collection                                            │
├─────────────────────────────────────────────────────────────────────┤
│ + deployGeneral(general: General, formationIdx: number, slotIdx: number) │
│ + removeGeneral(formationIdx: number, slotIdx: number)                │
│ + rearrangeFormations()                                             │
│ + takeDamage(amount: number)                                        │
│ + plunderFrom(opponent: Player)                                     │
└─────────────────────────────────────────────────────────────────────┘
        │
        ├──────────────┬──────────────┬──────────────┬──────────────┐
        ▼              ▼              ▼              ▼              ▼
┌───────────┐  ┌───────────┐  ┌───────────┐  ┌───────────┐  ┌───────────┐
│ MainCamp  │  │   Hand    │  │ Formation │  │ Collection│  │  Prison   │
│  (主营)    │  │  (手牌)   │  │  (军阵)   │  │ (将领收藏) │  │  (俘虏营)  │
└───────────┘  └───────────┘  └───────────┘  └───────────┘  └───────────┘
                                    │
                                    ▼
                            ┌───────────┐
                            │ GeneralSlot│
                            │ (将领槽位) │
                            └───────────┘
                                    │
                                    ▼
                            ┌───────────┐
                            │  General  │
                            │  (将领)   │
                            └───────────┘
                                    │
                                    ▼
                            ┌───────────┐
                            │ Equipment │
                            │  (装备)   │
                            └───────────┘
```

---

## 3. 详细类定义

### 3.1 Game (游戏主类)

```lua
---@class Game
---@field state GameState 当前游戏状态
---@field players Player[] 玩家数组(2人)
---@field currentRound number 当前回合数
---@field maxRounds number 最大回合数
---@field battleField BattleField 战场实例
---@field roundManager RoundManager 回合管理器
---@field uiManager UIManager UI管理器
---@field plunderManager PlunderManager 掠夺管理器
local Game = {}

---初始化游戏
---@param player1Config table 玩家1配置
---@param player2Config table 玩家2配置
function Game:init(player1Config, player2Config) end

---开始游戏
function Game:start() end

---更新游戏逻辑
---@param dt number 帧间隔时间(秒)
function Game:update(dt) end

---渲染游戏画面
function Game:draw() end

---结束游戏，处理掠夺
---@param winner Player 获胜玩家
---@param loser Player 失败玩家
function Game:endGame(winner, loser) end
```

### 3.2 Player (玩家)

```lua
---@class Player
---@field id string 玩家唯一标识
---@field name string 玩家名称
---@field camp Camp 所属阵营
---@field mainCamp MainCamp 玩家主营
---@field hand Hand 手牌区
---@field formations Formation[] 4个军阵
---@field collection Collection 将领收藏
---@field prison Prison 俘虏营
---@field isAI boolean 是否为AI
local Player = {}

---部署将领到指定军阵和槽位
---@param general General 要部署的将领
---@param formationIdx number 军阵索引(1-4)
---@param slotIdx number 槽位索引
---@return boolean 是否部署成功
function Player:deployGeneral(general, formationIdx, slotIdx) end

---从指定位置移除将领
---@param formationIdx number 军阵索引
---@param slotIdx number 槽位索引
---@return General 被移除的将领
function Player:removeGeneral(formationIdx, slotIdx) end

---对主营造成伤害
---@param amount number 伤害值
function Player:takeDamage(amount) end

---从对手处掠夺将领
---@param opponent Player 对手
---@param generalId string 要掠夺的将领ID
function Player:plunderFrom(opponent, generalId) end
```

### 3.3 Camp (阵营枚举)

```lua
---@enum Camp
local Camp = {
    WEI = "wei",       -- 魏
    SHU = "shu",       -- 蜀
    WU = "wu",         -- 吴
    QUN = "qun",       -- 群雄
    OTHER = "other"    -- 其他/架空
}
```

### 3.4 MainCamp (主营)

```lua
---@class MainCamp
---@field maxHealth number 最大生命值
---@field currentHealth number 当前生命值
---@field position Vector2 战场位置
---@field owner Player 所属玩家
local MainCamp = {}

---受到伤害
---@param amount number 伤害值
function MainCamp:takeDamage(amount) end

---判断是否被攻破
---@return boolean
function MainCamp:isDestroyed() end

---获取当前生命值百分比
---@return number 百分比(0-1)
function MainCamp:getHealthPercent() end
```

### 3.5 Formation (军阵)

```lua
---@class Formation
---@field index number 军阵索引(1-4)
---@field name string 军阵名称(先锋/中军/后军/大营)
---@field owner Player 所属玩家
---@field slots GeneralSlot[] 将领槽位数组
---@field maxGenerals number 该军阵最大将领数
local Formation = {}

---获取军阵内将领数量
---@return number
function Formation:getGeneralCount() end

---获取指定槽位
---@param slotIdx number
---@return GeneralSlot
function Formation:getSlot(slotIdx) end

---检查军阵是否已满
---@return boolean
function Formation:isFull() end

---获取所有存活将领
---@return General[]
function Formation:getAliveGenerals() end
```

### 3.6 GeneralSlot (将领槽位)

```lua
---@class GeneralSlot
---@field index number 槽位索引
---@field formation Formation 所属军阵
---@field general General|nil 当前将领
---@field position Vector2 屏幕位置
local GeneralSlot = {}

---放置将领
---@param general General
---@return boolean
function GeneralSlot:placeGeneral(general) end

---清空槽位
---@return General|nil 被清空的将领
function GeneralSlot:clear() end

---是否有将领
---@return boolean
function GeneralSlot:hasGeneral() end

---获取将领(如果存在)
---@return General|nil
function GeneralSlot:getGeneral() end
```

### 3.7 General (将领)

```lua
---@class General
---@field id string 唯一标识
---@field name string 将领名称
---@field title string 称号(如"常山赵子龙")
---@field rarity Rarity 品阶
---@field level number 等级
---@field exp number 当前经验
---@field maxExp number 升级所需经验
---@field dynasty string 所属朝代(如"汉"、"魏"、"蜀"、"吴")
---@field surname string 姓氏(如"赵"、"关"、"张")
---@field origin string 祖籍/籍贯(如"常山"、"河东"、"涿郡")
---@field camp Camp 所属阵营
---@field maxHealth number 最大生命值
---@field currentHealth number 当前生命值
---@field stats GeneralStats 将领属性
---@field skill Skill|nil 特技
---@field equipment EquipmentSet 装备
---@field slot GeneralSlot|nil 当前所在槽位
---@field hasTransferred boolean 本轮是否已转交过军资
---@field acquiredTime number 获取时间戳(用于掠夺保护)
local General = {}

---受到伤害
---@param amount number
function General:takeDamage(amount) end

---判断是否存活
---@return boolean
function General:isAlive() end

---输送军资
---@param targetSlot GeneralSlot 目标槽位
---@return Supply 创建的军资
function General:dispatchSupply(targetSlot) end

---尝试截击军资
---@param supply Supply
---@param distance number 到路径的距离
---@return boolean 是否截击成功
function General:tryIntercept(supply, distance) end

---接收军资
---@param supply Supply
function General:receiveSupply(supply) end

---获取输送成功率
---@param target General 目标将领
---@param distance number 距离
---@return number 成功率(0-1)
function General:getDispatchSuccessRate(target, distance) end

---获取截击成功率
---@param distance number 到路径距离
---@return number 成功率(0-1)
function General:getInterceptRate(distance) end

---使用特技
function General:useSkill() end

---升级
function General:levelUp() end

---获取升级所需经验
---@return number
function General:getExpToLevel() end

---检查是否可被掠夺
---@return boolean
function General:canBePlundered() end
```

#### 3.7.1 GeneralStats (将领属性)

```lua
---@class GeneralStats
---@field bravery number 武勇(0-100)
---@field command number 调度(0-100)
---@field reception number 接应(0-100)
---@field insight number 洞察(1-10)
local GeneralStats = {}
```


#### 3.7.2 BondSystem (羁绊系统)

```lua
---@class BondSystem
---@field BONUS_DYNASTY number 同朝加成 0.15
---@field BONUS_SURNAME number 同姓加成 0.10
---@field BONUS_ORIGIN number 同籍加成 0.10
---@field BONUS_DYNASTY_SURNAME number 同朝同姓额外加成 0.05
---@field MAX_SUCCESS_RATE number 最大成功率 0.95
local BondSystem = {}

---计算输送成功率加成
---@param sender General 输送方
---@param receiver General 接收方
---@return number 总加成率(0-1)
function BondSystem:calculateBonus(sender, receiver) end

---检查是否同朝
---@param sender General
---@param receiver General
---@return boolean
function BondSystem:isSameDynasty(sender, receiver) end

---检查是否同姓
---@param sender General
---@param receiver General
---@return boolean
function BondSystem:isSameSurname(sender, receiver) end

---检查是否同籍
---@param sender General
---@param receiver General
---@return boolean
function BondSystem:isSameOrigin(sender, receiver) end

---获取羁绊显示信息
---@param sender General
---@param receiver General
---@return table {type: string, bonus: number, description: string}
function BondSystem:getBondInfo(sender, receiver) end
```

#### 3.7.3 Rarity (品阶枚举)

```lua
---@enum Rarity
local Rarity = {
    WHITE = 1,   -- 白
    GREEN = 2,   -- 绿
    BLUE = 3,    -- 蓝
    PURPLE = 4,  -- 紫
    ORANGE = 5   -- 橙
}
```

### 3.8 Supply (军资)

```lua
---@class Supply
---@field id string 唯一标识
---@field dispatcher General 输送将领
---@field targetSlot GeneralSlot 目标槽位
---@field path SupplyPath 输送路径
---@field isTransferred boolean 是否已被同阵转交
---@field state SupplyState 当前状态
---@field damage number 伤害值
---@field type SupplyType 军资类型
local Supply = {}

---更新军资状态
---@param dt number
function Supply:update(dt) end

---渲染军资
function Supply:draw() end

---尝试输送到目标
---@return DispatchResult 输送结果
function Supply:attemptDispatch() end

---被截击
---@param interceptor General 截击者
function Supply:beIntercepted(interceptor) end

---标记为已转交
function Supply:markTransferred() end

---对主营造成伤害
function Supply:dealDamageToCamp() end
```

#### 3.8.1 SupplyState (军资状态)

```lua
---@enum SupplyState
local SupplyState = {
    TRANSPORTING = "transporting", -- 输送中
    SUCCESS = "success",           -- 输送成功
    LOST = "lost",                 -- 输送损耗
    INTERCEPTED = "intercepted",   -- 被截击
    TRANSFERRED = "transferred",   -- 同阵转交
    ARRIVED = "arrived",           -- 到达主营
    DESTROYED = "destroyed"        -- 已销毁
}
```

#### 3.8.2 SupplyType (军资类型)

```lua
---@enum SupplyType
local SupplyType = {
    TROOPS = "troops",     -- 兵力
    GRAIN = "grain",       -- 粮草
    SUPPLIES = "supplies"  -- 辎重
}
```

### 3.9 SupplyPath (军资输送路径)

```lua
---@class SupplyPath
---@field waypoints Vector2[] 路径点数组
---@field currentIndex number 当前路径点索引
---@field progress number 当前段进度(0-1)
local SupplyPath = {}

---获取当前位置
---@return Vector2
function SupplyPath:getCurrentPosition() end

---前进到下一位置
---@param distance number 移动距离
---@return boolean 是否到达终点
function SupplyPath:advance(distance) end

---获取最近的敌方将领
---@param enemyFormations Formation[] 敌方军阵数组
---@return General|nil, number 最近将领和距离
function SupplyPath:getNearestEnemy(enemyFormations) end
```

### 3.10 Collection (将领收藏)

```lua
---@class Collection
---@field owner Player 所属玩家
---@field generals General[] 所有将领
---@field maxSize number 收藏上限
local Collection = {}

---添加将领
---@param general General
function Collection:addGeneral(general) end

---移除将领
---@param generalId string
---@return General
function Collection:removeGeneral(generalId) end

---获取将领
---@param generalId string
---@return General|nil
function Collection:getGeneral(generalId) end

---获取所有将领
---@return General[]
function Collection:getAllGenerals() end

---按品阶筛选
---@param rarity Rarity
---@return General[]
function Collection:getByRarity(rarity) end
```

### 3.11 Prison (俘虏营)

```lua
---@class Prison
---@field owner Player 所属玩家
---@field capturedGenerals CapturedGeneral[] 俘虏的将领
local Prison = {}

---添加俘虏
---@param general General
---@param originalOwner Player 原主人
function Prison:addCapture(general, originalOwner) end

---赎回俘虏
---@param generalId string
---@param redeemer Player 赎回者
function Prison:redeemGeneral(generalId, redeemer) end

---释放俘虏(时间到自动释放)
---@param generalId string
function Prison:releaseGeneral(generalId) end

---获取可赎回的将领
---@return CapturedGeneral[]
function Prison:getRedeemableGenerals() end

---更新俘虏状态(倒计时)
---@param dt number
function Prison:update(dt) end
```

#### 3.11.1 CapturedGeneral (被俘将领)

```lua
---@class CapturedGeneral
---@field general General 将领
---@field originalOwner Player 原主人
---@field captureTime number 被俘时间
---@field releaseTime number 释放时间
---@field redeemCost number 赎回费用
local CapturedGeneral = {}

---获取剩余时间
---@return number 秒数
function CapturedGeneral:getRemainingTime() end

---检查是否可赎回
---@return boolean
function CapturedGeneral:canRedeem() end
```

### 3.12 Hand (手牌)

```lua
---@class Hand
---@field owner Player 所属玩家
---@field cards GeneralCard[] 手牌数组
---@field maxSize number 最大手牌数
local Hand = {}

---添加卡牌
---@param card GeneralCard
function Hand:addCard(card) end

---移除卡牌
---@param index number
---@return GeneralCard
function Hand:removeCard(index) end

---获取卡牌
---@param index number
---@return GeneralCard
function Hand:getCard(index) end

---获取手牌数量
---@return number
function Hand:getCount() end
```

### 3.13 Equipment (装备)

```lua
---@class Equipment
---@field id string 装备ID
---@field name string 装备名称
---@field type EquipmentType 装备类型
---@field rarity Rarity 品阶
---@field stats table 属性加成
local Equipment = {}
```

#### 3.13.1 EquipmentType (装备类型)

```lua
---@enum EquipmentType
local EquipmentType = {
    WEAPON = "weapon",     -- 武器(+武勇)
    MOUNT = "mount",       -- 坐骑(+调度)
    TACTIC = "tactic",     -- 兵法(+接应)
    TREASURE = "treasure"  -- 宝物(特殊效果)
}
```

### 3.14 EquipmentSet (装备套装)

```lua
---@class EquipmentSet
---@field weapon Equipment|nil 武器
---@field mount Equipment|nil 坐骑
---@field tactic Equipment|nil 兵法
---@field treasure Equipment|nil 宝物
local EquipmentSet = {}

---装备物品
---@param equipment Equipment
function EquipmentSet:equip(equipment) end

---卸下装备
---@param type EquipmentType
---@return Equipment|nil
function EquipmentSet:unequip(type) end

---获取总属性加成
---@return table
function EquipmentSet:getTotalStats() end
```

### 3.15 RoundManager (回合管理器)

```lua
---@class RoundManager
---@field currentRound number 当前回合(1-3)
@field currentPhase RoundPhase 当前阶段
---@field attacker Player 当前进攻方
---@field defender Player 当前防守方
---@field phaseTimer number 阶段计时器
local RoundManager = {}

---开始新回合
function RoundManager:startRound() end

---切换到下一阶段
function RoundManager:nextPhase() end

---切换到布阵阶段
function RoundManager:startDeploymentPhase() end

---切换到进攻阶段
function RoundManager:startAttackPhase() end

---交换攻防
function RoundManager:swapRoles() end

---结束当前回合
function RoundManager:endRound() end
```

#### 3.15.1 RoundPhase (回合阶段)

```lua
---@enum RoundPhase
local RoundPhase = {
    DEPLOYMENT = "deployment",   -- 布阵阶段
    ATTACK = "attack",           -- 进攻阶段
    DEFENSE = "defense",         -- 防守阶段
    RESOLUTION = "resolution"    -- 结算阶段
}
```

### 3.16 PlunderManager (掠夺管理器)

```lua
---@class PlunderManager
---@field rules PlunderRules 掠夺规则
local PlunderManager = {}

---处理战后掠夺
---@param winner Player 获胜方
---@param loser Player 失败方
function PlunderManager:processPlunder(winner, loser) end

---检查将领是否可被掠夺
---@param general General
---@param winner Player 潜在掠夺者
---@return boolean
function PlunderManager:canPlunder(general, winner) end

---执行掠夺
---@param general General
---@param from Player 原主人
---@param to Player 新主人
function PlunderManager:plunderGeneral(general, from, to) end

---检查掠夺限制
---@param player Player
---@return boolean, string 是否可掠夺，原因
function PlunderManager:checkPlunderLimit(player) end
```

### 3.17 BattleField (战场)

```lua
---@class BattleField
---@field playerA Player 玩家A
---@field playerB Player 玩家B
---@field activeSupplies Supply[] 活跃的军资
---@field attackChains AttackChain[] 正在执行的攻击链
local BattleField = {}

---初始化战场
---@param playerA Player
---@param playerB Player
function BattleField:init(playerA, playerB) end

---获取指定玩家的军阵
---@param player Player
---@return Formation[]
function BattleField:getFormations(player) end

---获取对阵关系
---@param formationIdx number
---@return Formation, Formation 己方军阵和敌方军阵
function BattleField:getMatchup(formationIdx) end

---创建攻击链
---@param attacker Player
---@return AttackChain
function BattleField:createAttackChain(attacker) end

---更新所有军资
---@param dt number
function BattleField:updateSupplies(dt) end

---渲染战场
function BattleField:draw() end
```

### 3.18 AttackChain (攻击链)

```lua
---@class AttackChain
---@field attacker Player 进攻方
---@field defender Player 防守方
---@field currentFormation number 当前军阵索引
---@field supplies Supply[] 军资数组
---@field isComplete boolean 是否完成
local AttackChain = {}

---添加军资到链
---@param supply Supply
function AttackChain:addSupply(supply) end

---执行下一步输送
function AttackChain:executeStep() end

---结算最终伤害
function AttackChain:resolveDamage() end
```

### 3.19 Skill (特技基类)

```lua
---@class Skill
---@field name string 特技名称
---@field description string 特技描述
---@field cooldown number 冷却回合
---@field currentCooldown number 当前冷却
local Skill = {}

---使用特技
---@param user General 使用者
---@param target any 目标
function Skill:use(user, target) end

---检查是否可用
---@return boolean
function Skill:isAvailable() end

---进入冷却
function Skill:startCooldown() end

---更新冷却
function Skill:updateCooldown() end
```

#### 3.19.1 具体技能实现示例

```lua
---@class LoneRiderRescueSkill : Skill
---单骑救主 - 首次截击必定成功
local LoneRiderRescueSkill = setmetatable({}, {__index = Skill})

function LoneRiderRescueSkill:use(user, target)
    user.nextInterceptGuaranteed = true
end

---@class MarchLikeWindSkill : Skill
---行军如风 - 输送损耗降低40%
local MarchLikeWindSkill = setmetatable({}, {__index = Skill})

function MarchLikeWindSkill:use(user, target)
    user.dispatchLossReduction = 0.4
end
```

---

## 4. 管理器类

### 4.1 UIManager (UI管理器)

```lua
---@class UIManager
---@field screens table<string, Screen> 屏幕集合
---@field currentScreen Screen 当前屏幕
---@field modalStack Screen[] 模态窗口栈
local UIManager = {}

---切换屏幕
---@param screenName string
function UIManager:switchTo(screenName) end

---显示模态窗口
---@param modal Screen
function UIManager:showModal(modal) end

---关闭模态窗口
function UIManager:closeModal() end

---处理输入事件
---@param x number
---@param y number
---@param button number
function UIManager:handleMousePress(x, y, button) end

---渲染当前UI
function UIManager:draw() end
```

### 4.2 AnimationManager (动画管理器)

```lua
---@class AnimationManager
---@field animations Animation[] 动画数组
local AnimationManager = {}

---播放动画
---@param animation Animation
function AnimationManager:play(animation) end

---更新所有动画
---@param dt number
function AnimationManager:update(dt) end

---渲染所有动画
function AnimationManager:draw() end
```

### 4.3 EventManager (事件管理器)

```lua
---@class EventManager
---@field listeners table<string, function[]> 事件监听器
local EventManager = {}

---订阅事件
---@param eventName string
---@param callback function
function EventManager:on(eventName, callback) end

---触发事件
---@param eventName string
---@param ... any 事件参数
function EventManager:emit(eventName, ...) end
```

---

## 5. 数据结构

### 5.1 Vector2 (二维向量)

```lua
---@class Vector2
---@field x number
---@field y number
local Vector2 = {}

function Vector2:new(x, y) end
function Vector2:distance(other) end
function Vector2:add(other) end
function Vector2:multiply(scalar) end
```

### 5.2 DispatchResult (输送结果)

```lua
---@class DispatchResult
---@field success boolean 是否成功
---@field type DispatchResultType 结果类型
---@field interceptor General|nil 截击者(如果被截击)
---@field newTarget General|nil 转交后的新目标(如果转交)
local DispatchResult = {}
```

### 5.3 PlunderRules (掠夺规则)

```lua
---@class PlunderRules
---@field maxPlunderPerWeek number 每周最大被掠夺次数
---@field protectionTimeByRarity table<Rarity, number> 各品阶保护时间
---@field newGeneralProtectionTime number 新将领保护时间(秒)
---@field redeemCostMultiplier number 赎回费用倍率
local PlunderRules = {}
```

---

## 6. 模块关系图

```
                    ┌─────────────┐
                    │    main     │
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │    Game     │
                    └──────┬──────┘
                           │
        ┌──────────────────┼──────────────────┐
        │                  │                  │
   ┌────▼────┐      ┌──────▼──────┐    ┌─────▼─────┐
   │ Battle  │      │    Round    │    │    UI     │
   │ Field   │      │  Manager    │    │  Manager  │
   └────┬────┘      └──────┬──────┘    └─────┬─────┘
        │                  │                  │
   ┌────┴────┐      ┌──────┴──────┐    ┌─────┴─────┐
   │         │      │             │    │           │
┌──▼──┐   ┌──▼──┐ ┌─▼────┐   ┌────▼─┐ ┌─▼────┐  ┌──▼───┐
│Player│   │Supply│ │Deploy│   │Attack│ │Screen│  │Widget│
│      │   │      │ │Phase │   │Phase │ │      │  │      │
└──┬───┘   └──────┘ └──────┘   └──────┘ └──────┘  └──────┘
   │
┌──┴───┬────────┬────────┬────────┐
│      │        │        │        │
▼      ▼        ▼        ▼        ▼
Main  General   Hand   Collection Prison
Camp  │
      ▼
   Equipment
```

---

## 7. 配置常量

```lua
-- 游戏配置
local CONFIG = {
    MAX_ROUNDS = 3,
    FORMATION_COUNT = 4,
    FORMATION_SLOTS = {1, 3, 3, 3}, -- 每军阵槽位数
    FORMATION_NAMES = {"先锋", "中军", "后军", "大营"},
    MAIN_CAMP_HEALTH = 100,
    SUPPLY_DAMAGE = 10,
    
    -- 概率基础值
    BASE_LOSS_RATE = 0.25,
    BASE_INTERCEPT_RATE = 0.35,
    
    -- 动画时间
    ANIMATION_SUPPLY_MOVE = 0.8,
    ANIMATION_PHASE_TRANSITION = 0.3,
    
    -- UI配置
    UI_SLOT_SIZE = {width = 120, height = 180},
    UI_GRID_GAP = 20,
    
    -- 掠夺配置
    MAX_PLUNDER_PER_WEEK = 3,
    NEW_GENERAL_PROTECTION = 86400, -- 24小时
    CAPTURE_DURATION = 86400, -- 24小时
    REDEEM_COST_MULTIPLIER = 0.4,
    
    -- 品阶保护时间(秒)
    PROTECTION_TIME = {
        [Rarity.WHITE] = 0,
        [Rarity.GREEN] = 43200,    -- 12小时
        [Rarity.BLUE] = 86400,     -- 24小时
        [Rarity.PURPLE] = 172800,  -- 48小时
        [Rarity.ORANGE] = 259200   -- 72小时
    }
}
```

---

**文档版本**: 2.0  
**更新日期**: 2026-03-07  
**作者**: 技术设计团队
