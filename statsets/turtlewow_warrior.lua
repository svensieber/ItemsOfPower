--[[
  Turtle WoW Warrior StatSets

  Based on Vanilla ClassicHawsJon weights with Turtle WoW adjustments.

  Changes from Vanilla:
  - Hit Cap: 9% → 8% (all specs: +12.5% Hit Rating value)
  - Rage Generation (1.17.2): 90% gear-dependent (AP/Crit/Hit/WeaponDPS), 10% weapon speed
  - Armor Cap (1.18.0): Removed, diminishing returns beyond 75%

  Arms Changes:
  - Deep Wounds (1.17.2): 1.5s ticks (2× speed), 6s duration, Boss armor NOW applies
  - Slam (Dec 2024): 2.5s cast, continues swing timer, replaces Decisive Strike
  - Execute (1.18.0): CD removed, Precision Cut +45% base damage
  - Boundless Anger: +10/20/30 max rage (100→130)
  - Master of Arms Mace (Dec 2024): ArPen nerf 600→360 @ level 60

  Fury Changes:
  - Enrage (Nov 2024): Damage bonus 25%→15%, duration 12s→8s, no swing cap
  - Blood Drinker (1.18.0): ALL attacks heal 1-2% max HP (not just crits)
  - Bloodthirst (Dec 2024): No self-damage, 35% AP scaling, +10% movement speed
  - Unbridled Wrath: 15-75% proc, DOUBLED for 2H (150%)
  - Flurry (1.18.0): Also reduces Slam cast time

  Protection Changes:
  - Shield Slam (1.17.2): Scales with AP + Block Value, moved to row 5
  - Improved Shield Slam (Oct 2024): CD 4.5s, +70% block for 5s after use
  - Concussion Blow (Dec 2024): CD 45s→20s, 100% armor pen, 2s stun
  - Reprisal: Revenge +50% damage, 100% rage refund on success
  - Shield Specialization: +1-5 rage per block

  References:
  - docs/turtle-wow-warrior-scaling-changes.md
  - docs/vanilla-baseline-weights.md
  - tools/turtle_wow_adjustments.lua
]]

-- Initialize pending StatSets queue
if not ItemsOfPower_PendingStatSets then
  ItemsOfPower_PendingStatSets = {}
end

-- Display Multiplier: Scale all weights for better readability
-- Increase this value to make differences between items more visible
local DISPLAY_MULTIPLIER = 10

-- Helper function to apply display multiplier to all stat weights
local function ApplyMultiplier(statTable)
  local result = {}
  for k, v in pairs(statTable) do
    result[k] = v * DISPLAY_MULTIPLIER
  end
  return result
end

-- ============================================================================
-- ARMS
-- ============================================================================

-- Vanilla Baseline
-- NOTE: EXPERTISE was removed - it's a Cataclysm stat that doesn't exist in Vanilla/Turtle WoW.
-- Weapon Skill is handled differently in Vanilla (linear scaling in Turtle WoW since patch 1.17.2).
local vanillaArms = ApplyMultiplier({
  STR = 1.0,
  AGI = 0.69,
  STA = 0.1,
  SPI = 0.05,
  ATTACKPOWER = 0.45,
  TOHIT = 9.37931,        -- Pre-multiplied
  CRIT = 7.225,           -- Physical crit
  HASTE = 4.5771,         -- Physical haste
  ARMORPEN = 2.75,        -- Armor Penetration (from ClassicHawsJon: 1.1 * 3.75 = 4.125, divided by 1.5 for base)
  WEAPONDPS = 2.795,      -- Weapon DPS (from ClassicHawsJon: 5.31, divided by 1.9 for base)
  HEALTH = 0.01,
  HEALTHREG = 1.0,
  ARMOR = 0.005,
  DEFENSE = 0.075,
  DODGE = 0.472,
  PARRY = 0.472,
  RESILIENCE = 0.2,
  FIRERES = 0.24,
  FROSTRES = 0.24,
  ARCANERES = 0.24,
  SHADOWRES = 0.24,
  NATURERES = 0.24,
})

-- Turtle WoW Adjustments for Arms
local turtleArms = {}
for k, v in pairs(vanillaArms) do
  turtleArms[k] = v
end

-- 1. Hit Cap Adjustment (Physical): 9% → 8% (+12.5%)
turtleArms.TOHIT = vanillaArms.TOHIT * 1.125  -- 9.38 → 10.55

-- 2. Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 3. Critical Strike more valuable (Deep Wounds 2x speed, but Boss armor NOW mitigates)
--    Net effect: +40% vs non-bosses, but reduced vs bosses → Conservative: +40% value
turtleArms.CRIT = vanillaArms.CRIT * 1.4  -- 7.225 → 10.115

-- 4. Attack Power more valuable (Rage gen 90% gear, Rend 5% AP/tick, Execute AP scaling)
--    Conservative: +35% value
turtleArms.ATTACKPOWER = vanillaArms.ATTACKPOWER * 1.35  -- 0.45 → 0.608

-- 4a. Haste now valuable (Unbridled Wrath procs, Slam rotation, but Slam 2.5s cast limits)
--     Conservative: +15% value
turtleArms.HASTE = turtleArms.HASTE * 1.15  -- 4.58 → 5.26

-- 5. Strength: Converts to AP, also affected by rage generation changes
--    Conservative: +15% value (AP + rage benefits)
turtleArms.STR = vanillaArms.STR * 1.15  -- 1.0 → 1.15

-- 6. Agility: Converts to AP + Crit, also affected by changes
--    Conservative: +10% value
turtleArms.AGI = vanillaArms.AGI * 1.1  -- 0.69 → 0.759

-- 7. WEAPONDPS HIGHLY valuable (Rage Generation 90% gear-dependent - CRITICAL CHANGE)
--    Conservative: +90% value
turtleArms.WEAPONDPS = vanillaArms.WEAPONDPS * 1.9  -- 2.795 → 5.31

-- 8. ARMORPEN more valuable (Armor Cap Removal good, but Master of Arms Mace nerfed 600→360)
--    Conservative: +35% value (reduced from +50% due to Mace nerf)
turtleArms.ARMORPEN = vanillaArms.ARMORPEN * 1.35  -- 2.75 → 3.7125


-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleArms

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Warrior_Arms", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Warrior_Arms"] then
    ItemsOfPower:RegisterSet(set)
  else
  end
end)

-- ============================================================================
-- FURY
-- ============================================================================

-- Vanilla Baseline
-- NOTE: EXPERTISE was removed - it's a Cataclysm stat that doesn't exist in Vanilla/Turtle WoW.
local vanillaFury = ApplyMultiplier({
  STR = 1.0,
  AGI = 0.57,
  STA = 0.1,
  SPI = 0.05,
  ATTACKPOWER = 0.54,
  TOHIT = 5.34621,        -- Pre-multiplied
  CRIT = 5.95,            -- Physical crit
  HASTE = 3.2923,         -- Physical haste
  ARMORPEN = 1.175,       -- Armor Penetration (from ClassicHawsJon: 0.47 * 3.75 = 1.7625, divided by 1.5 for base)
  WEAPONDPS = 2.747,      -- Weapon DPS (from ClassicHawsJon: 5.22, divided by 1.9 for base)
  HEALTH = 0.01,
  HEALTHREG = 1.0,
  ARMOR = 0.005,
  DEFENSE = 0.075,
  DODGE = 0.472,
  PARRY = 1.1328,
  RESILIENCE = 0.2,
  FIRERES = 0.24,
  FROSTRES = 0.24,
  ARCANERES = 0.24,
  SHADOWRES = 0.24,
  NATURERES = 0.24,
})

-- Turtle WoW Adjustments for Fury
local turtleFury = {}
for k, v in pairs(vanillaFury) do
  turtleFury[k] = v
end

-- 1. Hit Cap Adjustment (Physical): 9% → 8% (+12.5%)
turtleFury.TOHIT = vanillaFury.TOHIT * 1.125  -- 5.35 → 6.01

-- 2. Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 3. Haste HIGHLY valuable (Unbridled Wrath 75%/150% 2H, Blood Drinker per-attack heal, Flurry reduces Slam)
--    Conservative: +50% value (massive synergies)
turtleFury.HASTE = turtleFury.HASTE * 1.5  -- 3.29 → 4.94

-- 4. Critical Strike still valuable (Enrage nerfed 25%→15%, but Flurry+Slam synergy compensates)
--    Conservative: +20% value (reduced from +30% due to Enrage nerf)
turtleFury.CRIT = vanillaFury.CRIT * 1.2  -- 5.95 → 7.14

-- 5. Attack Power more valuable (Bloodthirst 35% AP up from 30%, Rage gen 90% gear)
--    Conservative: +30% value
turtleFury.ATTACKPOWER = vanillaFury.ATTACKPOWER * 1.3  -- 0.54 → 0.702

-- 6. Stamina HIGHLY valuable (Blood Drinker 1.18.0: ALL attacks heal 1-2% max HP during Enrage)
--    Conservative: +35% value (massive sustain scaling)
turtleFury.STA = vanillaFury.STA * 1.35  -- 0.1 → 0.135

-- 7. Strength: Converts to AP, also affected by rage generation
--    Conservative: +15% value
turtleFury.STR = vanillaFury.STR * 1.15  -- 1.0 → 1.15

-- 8. Agility: Converts to AP + Crit, also affected by changes
--    Conservative: +10% value
turtleFury.AGI = vanillaFury.AGI * 1.1  -- 0.57 → 0.627

-- 9. WEAPONDPS HIGHLY valuable (Rage Generation 90% gear-dependent - CRITICAL CHANGE)
--    Conservative: +90% value
turtleFury.WEAPONDPS = vanillaFury.WEAPONDPS * 1.9  -- 2.747 → 5.22

-- 10. ARMORPEN more valuable (Armor Cap Removal 1.18.0)
--     Conservative: +35% value
turtleFury.ARMORPEN = vanillaFury.ARMORPEN * 1.35  -- 1.175 → 1.586


-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleFury

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Warrior_Fury", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Warrior_Fury"] then
    ItemsOfPower:RegisterSet(set)
  else
  end
end)

-- ============================================================================
-- PROTECTION
-- ============================================================================

-- Vanilla Baseline
-- NOTE: EXPERTISE was removed - it's a Cataclysm stat that doesn't exist in Vanilla/Turtle WoW.
local vanillaProtection = ApplyMultiplier({
  STR = 0.33,
  AGI = 0.59,
  STA = 1.0,
  SPI = 0.05,
  ATTACKPOWER = 0.06,
  TOHIT = 6.28414,        -- Pre-multiplied
  CRIT = 2.38,
  HASTE = 1.6863,
  ARMORPEN = 0.475,       -- Armor Penetration (from ClassicHawsJon: 0.19 * 3.75 = 0.7125, divided by 1.5 for base)
  WEAPONDPS = 1.647,      -- Weapon DPS (from ClassicHawsJon: 3.13, divided by 1.9 for base)
  HEALTH = 0.09,
  HEALTHREG = 2.0,
  ARMOR = 0.02,
  DEFENSE = 1.215,
  DODGE = 6.608,
  PARRY = 5.4752,
  BLOCK = 4.071,
  BLOCKVALUE = 0.35,
  RESILIENCE = 0.2,
  FIRERES = 1.2,
  FROSTRES = 1.2,
  ARCANERES = 1.2,
  SHADOWRES = 1.2,
  NATURERES = 1.2,
})

-- Turtle WoW Adjustments for Protection
local turtleProtection = {}
for k, v in pairs(vanillaProtection) do
  turtleProtection[k] = v
end

-- 1. Hit Cap Adjustment (Physical): 9% → 8% (+12.5%)
turtleProtection.TOHIT = vanillaProtection.TOHIT * 1.125  -- 6.28 → 7.07

-- 2. Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 3. Block Value HIGHLY valuable (Shield Slam scales BV + AP, Improved Shield Slam 4.5s CD)
--    Conservative: +70% value (becomes primary threat stat)
turtleProtection.BLOCKVALUE = vanillaProtection.BLOCKVALUE * 1.7  -- 0.35 → 0.595

-- 4. Attack Power HIGHLY valuable (Shield Slam AP, Rend 5% AP, Reprisal Revenge +50%)
--    Conservative: +45% value (threat generation)
turtleProtection.ATTACKPOWER = vanillaProtection.ATTACKPOWER * 1.45  -- 0.06 → 0.087

-- 5. Armor more valuable (75% cap removed + Toughness +15% shield absorption)
--    Conservative: +35% value
turtleProtection.ARMOR = vanillaProtection.ARMOR * 1.35  -- 0.02 → 0.027

-- 6. Critical Strike more valuable (Shield Specialization rage on block, threat spikes)
--    Conservative: +25% value
turtleProtection.CRIT = vanillaProtection.CRIT * 1.25  -- 2.38 → 2.975

-- 7. Strength: Converts to AP, benefits from Shield Slam
--    Conservative: +20% value (threat scaling)
turtleProtection.STR = vanillaProtection.STR * 1.2  -- 0.33 → 0.396

-- 8. Agility: Converts to AP + Crit + Armor, benefits from changes
--    Conservative: +10% value
turtleProtection.AGI = vanillaProtection.AGI * 1.1  -- 0.59 → 0.649

-- 9. Stamina: Blood Craze healing 2/4/6% HP (up from 1/2/3%), survivability
--    Conservative: +20% value
turtleProtection.STA = vanillaProtection.STA * 1.2  -- 1.0 → 1.2

-- 10. WEAPONDPS HIGHLY valuable (Rage Generation 90% gear-dependent + Shield Slam - CRITICAL)
--     Conservative: +90% value
turtleProtection.WEAPONDPS = vanillaProtection.WEAPONDPS * 1.9  -- 1.647 → 3.13

-- 11. ARMORPEN HIGHLY valuable (Armor Cap Removal + Concussion Blow 100% armor pen, 20s CD)
--     Conservative: +60% value
turtleProtection.ARMORPEN = vanillaProtection.ARMORPEN * 1.6  -- 0.475 → 0.76


-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleProtection

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Warrior_Protection", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Warrior_Protection"] then
    ItemsOfPower:RegisterSet(set)
  else
  end
end)

