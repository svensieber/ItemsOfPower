--[[
  Turtle WoW Hunter StatSets

  Based on Vanilla ClassicHawsJon weights with Turtle WoW adjustments.

  Changes from Vanilla:
  - Hit Cap: 9% → 8% (all specs: +12.5% Hit Rating value)
  - Haste: Baseline adjustments
  - Beast Mastery: Stamina/Armor more valuable (pet scaling)
  - Beast Mastery: Crit more valuable (Kill Command, Baited Shot)
  - Marksmanship: Minimal changes (devs happy with current state)
  - Survival: Crit slightly more valuable (Lacerate procs)

  References:
  - docs/turtle-wow-hunter-scaling-changes.md
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
-- MARKSMANSHIP
-- ============================================================================

-- Vanilla Baseline
local vanillaMM = ApplyMultiplier({
  STR = 0.05,
  AGI = 1.0,
  STA = 0.1,
  INT = 0.9,
  SPI = 0.05,
  ATTACKPOWER = 0.55,
  RANGEDATTACKPOWER = 0.55,
  TOHIT = 9.37931,        -- Pre-multiplied
  EXPERTISE = 0.05,       -- Expertise Rating (from ClassicHawsJon - very low for ranged)
  CRIT = 5.1,             -- 8.5 * 0.6
  HASTE = 3.212,          -- 8.03 * 0.4
  ARMORPEN = 1.067,       -- Armor Penetration (3.75 * 0.37 = 1.3875, divided by 1.3 for base)
  RANGEDWEAPONDPS = 2.167,  -- Ranged Weapon DPS (from ClassicHawsJon: 2.6, divided by 1.2 for base)
  -- WEAPONDPS not included - melee weapon is only a stat stick for ranged specs
  MANA = 0.085,
  MANAREG = 2.4,
  HEALTH = 0.01,
  HEALTHREG = 1.0,
  ARMOR = 0.005,
  DEFENSE = 0.075,        -- 1.5 * 0.05
  DODGE = 0.472,          -- 9.44 * 0.05
  PARRY = 0.472,
  RESILIENCE = 0.2,
  FIRERES = 0.24,         -- 0.04 + 0.2 (AllResist distributed)
  FROSTRES = 0.24,
  ARCANERES = 0.24,
  SHADOWRES = 0.24,
  NATURERES = 0.24,
})

-- Turtle WoW Adjustments for Marksmanship
local turtleMM = {}
for k, v in pairs(vanillaMM) do
  turtleMM[k] = v
end

-- 1. Hit Cap Adjustment: 9% → 8% (+12.5%)
turtleMM.TOHIT = vanillaMM.TOHIT * 1.125  -- 9.38 → 10.55

-- 2. Haste Baseline Check (ensure minimum 65% of Crit for ranged DPS)
-- Haste baseline check removed (vanilla values are correct)

-- 3. RANGEDWEAPONDPS more valuable (Steady Shot 100% weapon dmg main rotation)
--    Conservative: +20% value
turtleMM.RANGEDWEAPONDPS = vanillaMM.RANGEDWEAPONDPS * 1.2  -- 2.167 → 2.6

-- 4. ARMORPEN more valuable (Armor Cap Removal 1.18.0)
--    Conservative: +30% value
turtleMM.ARMORPEN = vanillaMM.ARMORPEN * 1.3  -- 1.067 → 1.3875

print("TurtleWoW_Hunter_Marksmanship:")
print("  TOHIT: " .. string.format("%.2f", vanillaMM.TOHIT) .. " → " .. string.format("%.2f", turtleMM.TOHIT) .. " (+12.5%)")
print("  HASTE: " .. string.format("%.2f", vanillaMM.HASTE) .. " → " .. string.format("%.2f", turtleMM.HASTE))
print("  RANGEDWEAPONDPS: " .. string.format("%.3f", vanillaMM.RANGEDWEAPONDPS) .. " → " .. string.format("%.2f", turtleMM.RANGEDWEAPONDPS) .. " (+20% Steady Shot!)")
print("  ARMORPEN: " .. string.format("%.3f", vanillaMM.ARMORPEN) .. " → " .. string.format("%.4f", turtleMM.ARMORPEN) .. " (+30%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleMM
  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Hunter_Marksmanship", stats)

  if not ItemsOfPower.SetByName["TurtleWoW_Hunter_Marksmanship"] then
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: TurtleWoW_Hunter_Marksmanship")
  else
    print("Updated StatSet: TurtleWoW_Hunter_Marksmanship")
  end
end)

-- ============================================================================
-- BEAST MASTERY
-- ============================================================================

-- Vanilla Baseline
local vanillaBM = ApplyMultiplier({
  STR = 0.05,
  AGI = 1.0,
  STA = 0.1,
  INT = 0.8,
  SPI = 0.05,
  ATTACKPOWER = 0.43,
  RANGEDATTACKPOWER = 0.43,
  TOHIT = 9.37931,
  EXPERTISE = 0.05,       -- Expertise Rating (from ClassicHawsJon - very low for ranged)
  CRIT = 6.8,             -- 8.5 * 0.8
  HASTE = 4.015,          -- 8.03 * 0.5
  ARMORPEN = 0.490,       -- Armor Penetration (3.75 * 0.17 = 0.6375, divided by 1.3 for base)
  RANGEDWEAPONDPS = 2.087,  -- Ranged Weapon DPS (from ClassicHawsJon: 2.4, divided by 1.15 for base)
  -- WEAPONDPS not included - melee weapon is only a stat stick for ranged specs
  MANA = 0.075,
  MANAREG = 2.4,
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

-- Turtle WoW Adjustments for Beast Mastery
local turtleBM = {}
for k, v in pairs(vanillaBM) do
  turtleBM[k] = v
end

-- 1. Hit Cap Adjustment
turtleBM.TOHIT = vanillaBM.TOHIT * 1.125

-- 2. Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 3. Stamina more valuable (pet gets 30% via Endurance Training)
--    Conservative: +10% value
turtleBM.STA = vanillaBM.STA * 1.1  -- 0.1 → 0.11

-- 4. Armor more valuable (pet gets 36% via Thick Hide)
--    Conservative: +20% value
turtleBM.ARMOR = vanillaBM.ARMOR * 1.2  -- 0.005 → 0.006

-- 5. Crit more valuable (Kill Command, Baited Shot triggers)
--    Conservative: +15% value
turtleBM.CRIT = vanillaBM.CRIT * 1.15  -- 6.8 → 7.82

-- 6. Ranged AP more valuable (pet gets 12-25% as Melee AP + 7-15% as Spell Power via Spirit Bond)
--    Conservative: +20% value
turtleBM.RANGEDATTACKPOWER = vanillaBM.RANGEDATTACKPOWER * 1.2  -- 0.43 → 0.516
turtleBM.ATTACKPOWER = vanillaBM.ATTACKPOWER * 1.2

-- 7. RANGEDWEAPONDPS more valuable (Baited Shot 125% weapon damage after pet crit)
--    Conservative: +15% value
turtleBM.RANGEDWEAPONDPS = vanillaBM.RANGEDWEAPONDPS * 1.15  -- 2.087 → 2.4

-- 8. ARMORPEN more valuable (Armor Cap Removal 1.18.0)
--    Conservative: +30% value
turtleBM.ARMORPEN = vanillaBM.ARMORPEN * 1.3  -- 0.490 → 0.6375

print("")
print("TurtleWoW_Hunter_Beast_Mastery:")
print("  TOHIT: " .. string.format("%.2f", vanillaBM.TOHIT) .. " → " .. string.format("%.2f", turtleBM.TOHIT) .. " (+12.5%)")
print("  CRIT: " .. string.format("%.2f", vanillaBM.CRIT) .. " → " .. string.format("%.2f", turtleBM.CRIT) .. " (+15%)")
print("  RAP: " .. string.format("%.2f", vanillaBM.RANGEDATTACKPOWER) .. " → " .. string.format("%.3f", turtleBM.RANGEDATTACKPOWER) .. " (+20%)")
print("  STA: " .. string.format("%.2f", vanillaBM.STA) .. " → " .. string.format("%.2f", turtleBM.STA) .. " (+10%)")
print("  RANGEDWEAPONDPS: " .. string.format("%.3f", vanillaBM.RANGEDWEAPONDPS) .. " → " .. string.format("%.2f", turtleBM.RANGEDWEAPONDPS) .. " (+15% Baited Shot!)")
print("  ARMORPEN: " .. string.format("%.3f", vanillaBM.ARMORPEN) .. " → " .. string.format("%.4f", turtleBM.ARMORPEN) .. " (+30%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleBM

__local_set_=_ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Hunter_Beast_Mastery",_stats)



__if_not_ItemsOfPower.SetByName["TurtleWoW_Hunter_Beast_Mastery"]_then
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: TurtleWoW_Hunter_Beast Mastery")
  else
    print("Updated StatSet: TurtleWoW_Hunter_Beast Mastery")
  end
end)

-- ============================================================================
-- SURVIVAL
-- ============================================================================

-- Vanilla Baseline
local vanillaSV = ApplyMultiplier({
  STR = 0.05,
  AGI = 1.0,
  STA = 0.1,
  INT = 0.8,
  SPI = 0.05,
  ATTACKPOWER = 0.55,
  RANGEDATTACKPOWER = 0.55,
  TOHIT = 9.37931,
  EXPERTISE = 0.05,       -- Expertise Rating (from ClassicHawsJon - very low for ranged)
  CRIT = 5.525,           -- 8.5 * 0.65
  HASTE = 3.212,          -- 8.03 * 0.4
  ARMORPEN = 0.808,       -- Armor Penetration (3.75 * 0.28 = 1.05, divided by 1.3 for base)
  RANGEDWEAPONDPS = 2.4,  -- Ranged Weapon DPS (from ClassicHawsJon - low for melee spec)
  WEAPONDPS = 0.714,      -- Melee Weapon DPS (from ClassicHawsJon: 1, divided by 1.4 for base)
  MANA = 0.075,
  MANAREG = 2.4,
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

-- Turtle WoW Adjustments for Survival
local turtleSV = {}
for k, v in pairs(vanillaSV) do
  turtleSV[k] = v
end

-- 1. Hit Cap Adjustment
turtleSV.TOHIT = vanillaSV.TOHIT * 1.125

-- 2. Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 3. Crit more valuable (Lacerate procs after crit)
--    Conservative: +10% value
turtleSV.CRIT = vanillaSV.CRIT * 1.1  -- 5.525 → 6.08

-- 4. WEAPONDPS (Melee) HIGHLY valuable (Mongoose Bite 60% + Carve 70% + Wing Clip 35% + Dual Wield!)
--    Conservative: +40% value
turtleSV.WEAPONDPS = vanillaSV.WEAPONDPS * 1.4  -- 0.714 → 1.0

-- 5. ARMORPEN more valuable (Armor Cap Removal 1.18.0)
--    Conservative: +30% value
turtleSV.ARMORPEN = vanillaSV.ARMORPEN * 1.3  -- 0.808 → 1.05

print("")
print("TurtleWoW_Hunter_Survival:")
print("  TOHIT: " .. string.format("%.2f", vanillaSV.TOHIT) .. " → " .. string.format("%.2f", turtleSV.TOHIT) .. " (+12.5%)")
print("  CRIT: " .. string.format("%.2f", vanillaSV.CRIT) .. " → " .. string.format("%.2f", turtleSV.CRIT) .. " (+10%)")
print("  WEAPONDPS (Melee): " .. string.format("%.3f", vanillaSV.WEAPONDPS) .. " → " .. string.format("%.2f", turtleSV.WEAPONDPS) .. " (+40% Mongoose/Carve + Dual Wield!)")
print("  ARMORPEN: " .. string.format("%.3f", vanillaSV.ARMORPEN) .. " → " .. string.format("%.2f", turtleSV.ARMORPEN) .. " (+30%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleSV

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Hunter_Survival", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Hunter_Survival"] then
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: TurtleWoW_Hunter_Survival")
  else
    print("Updated StatSet: TurtleWoW_Hunter_Survival")
  end
end)

print("")
print("All Turtle WoW Hunter StatSets created!")
print("Total: 3 specs")
