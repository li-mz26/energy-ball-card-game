# 能量球 (Energy Ball) - 类与对象设计文档

## 1. 概述

本文档定义《能量球》游戏的面向对象设计，包括核心类结构、接口定义和模块关系。

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
        │
        ▼
┌─────────────────────────────────────────────────────────────────────┐
│                          Player (玩家)                              │
├─────────────────────────────────────────────────────────────────────┤
│ - id: string                                                        │
│ - name: string                                                      │
│ - base: Base                                                        │
│ - hand: Hand                                                        │
│ - rows: Row[4]                                                      │
├─────────────────────────────────────────────────────────────────────┤
│ + deployUnit(unit: Unit, rowIndex: number, slotIndex: number)       │
│ + removeUnit(rowIndex: number, slotIndex: number)                   │
│ + rearrangeRows()                                                   │
│ + takeDamage(amount: number)                                        │
└─────────────────────────────────────────────────────────────────────┘
        │
        ├──────────────┬──────────────┬──────────────┐
        ▼              ▼              ▼              ▼
┌───────────┐  ┌───────────┐  ┌───────────┐  ┌───────────┐
│   Base    │  │   Hand    │  │    Row    │  │   Deck    │
│  (大本营)  │  │  (手牌)   │  │  (排/行)  │  │  (牌组)   │
└───────────┘  └───────────┘  └───────────┘  └───────────┘
                                    │
                                    ▼
                            ┌───────────┐
                            │ UnitSlot  │
                            │ (单位槽位) │
                            └───────────┘
                                    │
                                    ▼
                            ┌───────────┐
                            │    Unit   │
                            │   (单位)  │
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

---结束游戏
---@param winner Player 获胜玩家
function Game:endGame(winner) end
```

### 3.2 Player (玩家)

```lua
---@class Player
---@field id string 玩家唯一标识
---@field name string 玩家名称
---@field faction string 阵营("A"或"B")
---@field base Base 玩家大本营
---@field hand Hand 手牌区
---@field rows Row[] 4排单位
---@field deck Deck 牌组
---@field isAI boolean 是否为AI
local Player = {}

---部署单位到指定排和槽位
---@param unit Unit 要部署的单位
---@param rowIndex number 排索引(1-4)
---@param slotIndex number 槽位索引
---@return boolean 是否部署成功
function Player:deployUnit(unit, rowIndex, slotIndex) end

---从指定位置移除单位
---@param rowIndex number 排索引
---@param slotIndex number 槽位索引
---@return Unit 被移除的单位
function Player:removeUnit(rowIndex, slotIndex) end

---对大本营造成伤害
---@param amount number 伤害值
function Player:takeDamage(amount) end

---获取指定排的单位
---@param rowIndex number 排索引
---@return Row 该排对象
function Player:getRow(rowIndex) end
```

### 3.3 Base (大本营)

```lua
---@class Base
---@field maxHealth number 最大生命值
---@field currentHealth number 当前生命值
---@field position Vector2 战场位置
local Base = {}

---受到伤害
---@param amount number 伤害值
function Base:takeDamage(amount) end

---判断是否被摧毁
---@return boolean
function Base:isDestroyed() end

---获取当前生命值百分比
---@return number 百分比(0-1)
function Base:getHealthPercent() end
```

### 3.4 Row (排/行)

```lua
---@class Row
---@field index number 排索引(1-4)
---@field owner Player 所属玩家
---@field slots UnitSlot[] 单位槽位数组
---@field maxUnits number 该排最大单位数
local Row = {}

---获取排内单位数量
---@return number
function Row:getUnitCount() end

---获取指定槽位
---@param slotIndex number
---@return UnitSlot
function Row:getSlot(slotIndex) end

---检查排是否已满
---@return boolean
function Row:isFull() end

---获取所有存活单位
---@return Unit[]
function Row:getAliveUnits() end
```

### 3.5 UnitSlot (单位槽位)

```lua
---@class UnitSlot
---@field index number 槽位索引
---@field row Row 所属排
---@field unit Unit|nil 当前单位
---@field position Vector2 屏幕位置
local UnitSlot = {}

---放置单位
---@param unit Unit
---@return boolean
function UnitSlot:placeUnit(unit) end

---清空槽位
---@return Unit|nil 被清空的单位
function UnitSlot:clear() end

---是否有单位
---@return boolean
function UnitSlot:hasUnit() end

---获取单位(如果存在)
---@return Unit|nil
function UnitSlot:getUnit() end
```

### 3.6 Unit (单位)

```lua
---@class Unit
---@field id string 唯一标识
---@field name string 单位名称
---@field type UnitType 单位类型
---@field maxHealth number 最大生命值
---@field currentHealth number 当前生命值
---@field stats UnitStats 单位属性
---@field skill Skill|nil 特殊技能
---@field slot UnitSlot|nil 当前所在槽位
---@field hasTransferred boolean 本回合是否已转移过能量球
local Unit = {}

---受到伤害
---@param amount number
function Unit:takeDamage(amount) end

---判断是否存活
---@return boolean
function Unit:isAlive() end

---发送能量球
---@param targetSlot UnitSlot 目标槽位
---@return EnergyBall 创建的能量球
function Unit:sendEnergyBall(targetSlot) end

---尝试拦截能量球
---@param energyBall EnergyBall
---@param distance number 到路径的距离
---@return boolean 是否拦截成功
function Unit:tryIntercept(energyBall, distance) end

---接收能量球
---@param energyBall EnergyBall
function Unit:receiveEnergyBall(energyBall) end

---获取发送成功率
---@param target Unit 目标单位
---@param distance number 距离
---@return number 成功率(0-1)
function Unit:getSendSuccessRate(target, distance) end

---获取拦截成功率
---@param distance number 到路径距离
---@return number 成功率(0-1)
function Unit:getInterceptRate(distance) end

---使用特殊技能
function Unit:useSkill() end
```

#### 3.6.1 UnitStats (单位属性)

```lua
---@class UnitStats
---@field sendPower number 发送能力(0-100)
---@field receivePower number 接收能力(0-100)
---@field interceptPower number 拦截能力(0-100)
---@field perceptionRange number 感知范围(1-10)
local UnitStats = {}
```

#### 3.6.2 UnitType (单位类型枚举)

```lua
---@enum UnitType
local UnitType = {
    COURIER = "courier",       -- 传令兵
    RECEIVER = "receiver",     -- 接收员
    INTERCEPTOR = "interceptor", -- 拦截者
    DISRUPTOR = "disruptor",   -- 干扰者
    CAPACITOR = "capacitor"    -- 储能者
}
```

### 3.7 EnergyBall (能量球)

```lua
---@class EnergyBall
---@field id string 唯一标识
---@field sender Unit 发送单位
---@field targetSlot UnitSlot 目标槽位
---@field path EnergyBallPath 传递路径
---@field isTransferred boolean 是否已被同排转移
---@field state EnergyBallState 当前状态
---@field damage number 伤害值
local EnergyBall = {}

---更新能量球状态
---@param dt number
function EnergyBall:update(dt) end

---渲染能量球
function EnergyBall:draw() end

---尝试发送到目标
---@return SendResult 发送结果
function EnergyBall:attemptSend() end

---被拦截
---@param interceptor Unit 拦截者
function EnergyBall:beIntercepted(interceptor) end

---标记为已转移
function EnergyBall:markTransferred() end

---对大本营造成伤害
function EnergyBall:dealDamageToBase() end
```

#### 3.7.1 EnergyBallState (能量球状态)

```lua
---@enum EnergyBallState
local EnergyBallState = {
    FLYING = "flying",           -- 飞行中
    SUCCESS = "success",         -- 发送成功
    FAILED = "failed",           -- 发送失误
    INTERCEPTED = "intercepted", -- 被拦截
    TRANSFERRED = "transferred", -- 同排转移
    ARRIVED = "arrived",         -- 到达大本营
    DESTROYED = "destroyed"      -- 已销毁
}
```

### 3.8 EnergyBallPath (能量球路径)

```lua
---@class EnergyBallPath
---@field waypoints Vector2[] 路径点数组
---@field currentIndex number 当前路径点索引
---@field progress number 当前段进度(0-1)
local EnergyBallPath = {}

---获取当前位置
---@return Vector2
function EnergyBallPath:getCurrentPosition() end

---前进到下一位置
---@param distance number 移动距离
---@return boolean 是否到达终点
function EnergyBallPath:advance(distance) end

---获取最近的敌方单位
---@param enemyRows Row[] 敌方排数组
---@return Unit|nil, number 最近单位和距离
function EnergyBallPath:getNearestEnemy(enemyRows) end
```

### 3.9 Hand (手牌)

```lua
---@class Hand
---@field owner Player 所属玩家
---@field cards UnitCard[] 手牌数组
---@field maxSize number 最大手牌数
local Hand = {}

---添加卡牌
---@param card UnitCard
function Hand:addCard(card) end

---移除卡牌
---@param index number
---@return UnitCard
function Hand:removeCard(index) end

---获取卡牌
---@param index number
---@return UnitCard
function Hand:getCard(index) end

---洗牌
function Hand:shuffle() end

---获取手牌数量
---@return number
function Hand:getCount() end
```

### 3.10 Deck (牌组)

```lua
---@class Deck
---@field owner Player 所属玩家
---@field cards UnitCard[] 所有卡牌
---@field graveyard UnitCard[] 墓地(已使用/击败的单位)
local Deck = {}

---初始化牌组
---@param cardList UnitCard[]
function Deck:init(cardList) end

---抽卡
---@return UnitCard|nil
function Deck:draw() end

---将单位送入墓地
---@param card UnitCard
function Deck:addToGraveyard(card) end

---洗牌
function Deck:shuffle() end
```

### 3.11 RoundManager (回合管理器)

```lua
---@class RoundManager
---@field currentRound number 当前回合(1-3)
---@field currentPhase RoundPhase 当前阶段
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

#### 3.11.1 RoundPhase (回合阶段)

```lua
---@enum RoundPhase
local RoundPhase = {
    DEPLOYMENT = "deployment",   -- 布阵阶段
    ATTACK = "attack",           -- 进攻阶段
    DEFENSE = "defense",         -- 防守阶段
    RESOLUTION = "resolution"    -- 结算阶段
}
```

### 3.12 BattleField (战场)

```lua
---@class BattleField
---@field playerA Player 玩家A
---@field playerB Player 玩家B
---@field activeEnergyBalls EnergyBall[] 活跃的能量球
---@field attackChains AttackChain[] 正在执行的攻击链
local BattleField = {}

---初始化战场
---@param playerA Player
---@param playerB Player
function BattleField:init(playerA, playerB) end

---获取指定玩家的排
---@param player Player
---@return Row[]
function BattleField:getRows(player) end

---获取对阵关系
---@param rowIndex number
---@return Row, Row 己方排和敌方排
function BattleField:getMatchup(rowIndex) end

---创建攻击链
---@param attacker Player
---@return AttackChain
function BattleField:createAttackChain(attacker) end

---更新所有能量球
---@param dt number
function BattleField:updateEnergyBalls(dt) end

---渲染战场
function BattleField:draw() end
```

### 3.13 AttackChain (攻击链)

```lua
---@class AttackChain
---@field attacker Player 进攻方
---@field defender Player 防守方
---@field currentRow number 当前排索引
---@field energyBalls EnergyBall[] 能量球数组
---@field isComplete boolean 是否完成
local AttackChain = {}

---添加能量球到链
---@param energyBall EnergyBall
function AttackChain:addEnergyBall(energyBall) end

---执行下一步传递
function AttackChain:executeStep() end

---结算最终伤害
function AttackChain:resolveDamage() end
```

### 3.14 Skill (技能基类)

```lua
---@class Skill
---@field name string 技能名称
---@field description string 技能描述
---@field cooldown number 冷却回合
---@field currentCooldown number 当前冷却
local Skill = {}

---使用技能
---@param user Unit 使用者
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

#### 3.14.1 具体技能实现示例

```lua
---@class EmergencyTransferSkill : Skill
---紧急传递 - 首次发送必定成功
local EmergencyTransferSkill = setmetatable({}, {__index = Skill})

function EmergencyTransferSkill:use(user, target)
    -- 标记单位的下一次发送必定成功
    user.nextSendGuaranteed = true
end

---@class PreciseInterceptSkill : Skill
---精准拦截 - 拦截范围+1
local PreciseInterceptSkill = setmetatable({}, {__index = Skill})

function PreciseInterceptSkill:use(user, target)
    -- 临时增加拦截范围
    user.stats.interceptRange = user.stats.interceptRange + 1
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

### 5.2 SendResult (发送结果)

```lua
---@class SendResult
---@field success boolean 是否成功
---@result type SendResultType 结果类型
---@result interceptor Unit|nil 拦截者(如果被拦截)
---@result newTarget Unit|nil 转移后的新目标(如果转移)
local SendResult = {}
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
   │ Battle  │      │   Round     │    │    UI     │
   │ Field   │      │  Manager    │    │  Manager  │
   └────┬────┘      └──────┬──────┘    └─────┬─────┘
        │                  │                  │
   ┌────┴────┐      ┌──────┴──────┐    ┌─────┴─────┐
   │         │      │             │    │           │
┌──▼──┐   ┌──▼──┐ ┌─▼────┐   ┌────▼─┐ ┌─▼────┐  ┌──▼───┐
│Player│   │Energy│ │Deploy│   │Attack│ │Screen│  │Widget│
│      │   │ Ball │ │Phase │   │Phase │ │      │  │      │
└──┬───┘   └──────┘ └──────┘   └──────┘ └──────┘  └──────┘
   │
┌──┴───┬────────┬────────┐
│      │        │        │
▼      ▼        ▼        ▼
Base  Unit     Hand     Deck
      │
      ▼
   Skill
```

---

## 7. 配置常量

```lua
-- 游戏配置
local CONFIG = {
    MAX_ROUNDS = 3,
    ROW_COUNT = 4,
    ROW_SLOTS = {1, 3, 3, 3}, -- 每排槽位数
    BASE_HEALTH = 100,
    ENERGY_BALL_DAMAGE = 10,
    
    -- 概率基础值
    BASE_MISS_RATE = 0.30,
    BASE_INTERCEPT_RATE = 0.40,
    
    -- 动画时间
    ANIMATION_BALL_FLY = 0.5,
    ANIMATION_PHASE_TRANSITION = 0.3,
    
    -- UI配置
    UI_SLOT_SIZE = {width = 120, height = 160},
    UI_GRID_GAP = 20,
}
```

---

**文档版本**: 1.0  
**创建日期**: 2026-03-07  
**作者**: 技术设计团队
