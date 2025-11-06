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

-- ============================================================================
-- MARKSMANSHIP
-- ============================================================================

-- Vanilla Baseline
local vanillaMM = {
  STR = 0.05,
  AGI = 1.0,
  STA = 0.1,
  INT = 0.9,
  SPI = 0.05,
  ATTACKPOWER = 0.55,
  RANGEDATTACKPOWER = 0.55,
  TOHIT = 9.37931,        -- Pre-multiplied
  CRIT = 5.1,             -- 8.5 * 0.6
  HASTE = 3.212,          -- 8.03 * 0.4
  ARMORIGNORE = 1.3875,   -- 3.75 * 0.37
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
}

-- Turtle WoW Adjustments for Marksmanship
local turtleMM = {}
for k, v in pairs(vanillaMM) do
  turtleMM[k] = v
end

-- 1. Hit Cap Adjustment: 9% → 8% (+12.5%)
turtleMM.TOHIT = AdjustHitCap(vanillaMM.TOHIT)  -- 9.38 → 10.55

-- 2. Haste Baseline Check (ensure minimum 65% of Crit for ranged DPS)
turtleMM.HASTE = EnsureMinimumHaste(vanillaMM.HASTE, vanillaMM.CRIT, "ranged_dps")

-- 3. NO other changes for MM (devs happy with current state)

print("Turtle WoW - Hunter - Marksmanship:")
print("  TOHIT: " .. string.format("%.2f", vanillaMM.TOHIT) .. " → " .. string.format("%.2f", turtleMM.TOHIT) .. " (+12.5%)")
print("  HASTE: " .. string.format("%.2f", vanillaMM.HASTE) .. " → " .. string.format("%.2f", turtleMM.HASTE))

-- Create StatSet
do
  local stats = turtleMM

  if not ItemsOfPower.SetByName["Turtle WoW - Hunter - Marksmanship"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Turtle WoW - Hunter - Marksmanship", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Turtle WoW - Hunter - Marksmanship")
  else
    print("StatSet already exists: Turtle WoW - Hunter - Marksmanship")
  end
end

-- ============================================================================
-- BEAST MASTERY
-- ============================================================================

-- Vanilla Baseline
local vanillaBM = {
  STR = 0.05,
  AGI = 1.0,
  STA = 0.1,
  INT = 0.8,
  SPI = 0.05,
  ATTACKPOWER = 0.43,
  RANGEDATTACKPOWER = 0.43,
  TOHIT = 9.37931,
  CRIT = 6.8,             -- 8.5 * 0.8
  HASTE = 4.015,          -- 8.03 * 0.5
  ARMORIGNORE = 0.6375,   -- 3.75 * 0.17
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
}

-- Turtle WoW Adjustments for Beast Mastery
local turtleBM = {}
for k, v in pairs(vanillaBM) do
  turtleBM[k] = v
end

-- 1. Hit Cap Adjustment
turtleBM.TOHIT = AdjustHitCap(vanillaBM.TOHIT)

-- 2. Haste Baseline Check
turtleBM.HASTE = EnsureMinimumHaste(vanillaBM.HASTE, vanillaBM.CRIT, "ranged_dps")

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

print("")
print("Turtle WoW - Hunter - Beast Mastery:")
print("  TOHIT: " .. string.format("%.2f", vanillaBM.TOHIT) .. " → " .. string.format("%.2f", turtleBM.TOHIT) .. " (+12.5%)")
print("  CRIT: " .. string.format("%.2f", vanillaBM.CRIT) .. " → " .. string.format("%.2f", turtleBM.CRIT) .. " (+15%)")
print("  RAP: " .. string.format("%.2f", vanillaBM.RANGEDATTACKPOWER) .. " → " .. string.format("%.3f", turtleBM.RANGEDATTACKPOWER) .. " (+20%)")
print("  STA: " .. string.format("%.2f", vanillaBM.STA) .. " → " .. string.format("%.2f", turtleBM.STA) .. " (+10%)")

-- Create StatSet
do
  local stats = turtleBM

  if not ItemsOfPower.SetByName["Turtle WoW - Hunter - Beast Mastery"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Turtle WoW - Hunter - Beast Mastery", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Turtle WoW - Hunter - Beast Mastery")
  else
    print("StatSet already exists: Turtle WoW - Hunter - Beast Mastery")
  end
end

-- ============================================================================
-- SURVIVAL
-- ============================================================================

-- Vanilla Baseline
local vanillaSV = {
  STR = 0.05,
  AGI = 1.0,
  STA = 0.1,
  INT = 0.8,
  SPI = 0.05,
  ATTACKPOWER = 0.55,
  RANGEDATTACKPOWER = 0.55,
  TOHIT = 9.37931,
  CRIT = 5.525,           -- 8.5 * 0.65
  HASTE = 3.212,          -- 8.03 * 0.4
  ARMORIGNORE = 1.05,     -- 3.75 * 0.28
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
}

-- Turtle WoW Adjustments for Survival
local turtleSV = {}
for k, v in pairs(vanillaSV) do
  turtleSV[k] = v
end

-- 1. Hit Cap Adjustment
turtleSV.TOHIT = AdjustHitCap(vanillaSV.TOHIT)

-- 2. Haste Baseline Check
turtleSV.HASTE = EnsureMinimumHaste(vanillaSV.HASTE, vanillaSV.CRIT, "ranged_dps")

-- 3. Crit more valuable (Lacerate procs after crit)
--    Conservative: +10% value
turtleSV.CRIT = vanillaSV.CRIT * 1.1  -- 5.525 → 6.08

print("")
print("Turtle WoW - Hunter - Survival:")
print("  TOHIT: " .. string.format("%.2f", vanillaSV.TOHIT) .. " → " .. string.format("%.2f", turtleSV.TOHIT) .. " (+12.5%)")
print("  CRIT: " .. string.format("%.2f", vanillaSV.CRIT) .. " → " .. string.format("%.2f", turtleSV.CRIT) .. " (+10%)")

-- Create StatSet
do
  local stats = turtleSV

  if not ItemsOfPower.SetByName["Turtle WoW - Hunter - Survival"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Turtle WoW - Hunter - Survival", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Turtle WoW - Hunter - Survival")
  else
    print("StatSet already exists: Turtle WoW - Hunter - Survival")
  end
end

print("")
print("All Turtle WoW Hunter StatSets created!")
print("Total: 3 specs")
