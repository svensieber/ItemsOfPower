--[[
  Turtle WoW Warrior StatSets

  Based on Vanilla ClassicHawsJon weights with Turtle WoW adjustments.

  Changes from Vanilla:
  - Hit Cap: 9% → 8% (all specs: +12.5% Hit Rating value)
  - Haste: Baseline adjustments
  - Rage Generation: CRITICAL CHANGE - 90% gear-dependent (AP/Crit/Hit), 10% weapon speed
  - Arms: Crit HIGHLY valuable (Deep Wounds 2x speed, Master of Arms, Enrage)
  - Arms: Attack Power more valuable (Rage gen, Rend 5% AP, Execute)
  - Fury: Haste HIGHLY valuable (Unbridled Wrath 75%/150% 2H, Blood Drinker)
  - Fury: Crit HIGHLY valuable (Enrage 15% damage, Flurry, Rage gen)
  - Fury: Stamina more valuable (Blood Drinker 1-2% max HP healing)
  - Protection: Block Value HIGHLY valuable (Shield Slam scales BV + AP)
  - Protection: Attack Power more valuable (Shield Slam, Rend, Rage gen)
  - Protection: Armor more valuable (75% cap removed)

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
local vanillaArms = ApplyMultiplier({
  STR = 1.0,
  AGI = 0.69,
  STA = 0.1,
  SPI = 0.05,
  ATTACKPOWER = 0.45,
  TOHIT = 9.37931,        -- Pre-multiplied
  CRIT = 7.225,           -- Physical crit
  HASTE = 4.5771,         -- Physical haste
  ARMORIGNORE = 4.125,
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
turtleArms.TOHIT = AdjustHitCap(vanillaArms.TOHIT)  -- 9.38 → 10.55

-- 2. Haste Baseline Check
turtleArms.HASTE = EnsureMinimumHaste(vanillaArms.HASTE, vanillaArms.CRIT, "melee_dps")

-- 3. Critical Strike HIGHLY valuable (Deep Wounds 2x speed, Master of Arms Axe +5%, Enrage, Rage gen)
--    Conservative: +30% value
turtleArms.CRIT = vanillaArms.CRIT * 1.3  -- 7.225 → 9.393

-- 4. Attack Power more valuable (Rage generation 90% gear-dependent - CRITICAL, Rend 5% AP, Execute)
--    Conservative: +20% value
turtleArms.ATTACKPOWER = vanillaArms.ATTACKPOWER * 1.2  -- 0.45 → 0.54

-- 5. Strength: Converts to AP, also affected by rage generation changes
--    Conservative: +15% value (AP + rage benefits)
turtleArms.STR = vanillaArms.STR * 1.15  -- 1.0 → 1.15

-- 6. Agility: Converts to AP + Crit, also affected by changes
--    Conservative: +10% value
turtleArms.AGI = vanillaArms.AGI * 1.1  -- 0.69 → 0.759

print("Turtle WoW - Warrior - Arms:")
print("  TOHIT: " .. string.format("%.2f", vanillaArms.TOHIT) .. " → " .. string.format("%.2f", turtleArms.TOHIT) .. " (+12.5%)")
print("  CRIT: " .. string.format("%.2f", vanillaArms.CRIT) .. " → " .. string.format("%.3f", turtleArms.CRIT) .. " (+30% Deep Wounds 2x!)")
print("  AP: " .. string.format("%.2f", vanillaArms.ATTACKPOWER) .. " → " .. string.format("%.2f", turtleArms.ATTACKPOWER) .. " (+20% Rage gen 90% gear!)")
print("  STR: " .. string.format("%.2f", vanillaArms.STR) .. " → " .. string.format("%.2f", turtleArms.STR) .. " (+15%)")
print("  AGI: " .. string.format("%.2f", vanillaArms.AGI) .. " → " .. string.format("%.3f", turtleArms.AGI) .. " (+10%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleArms

  if not ItemsOfPower.SetByName["Turtle WoW - Warrior - Arms"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Turtle WoW - Warrior - Arms", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Turtle WoW - Warrior - Arms")
  else
    print("StatSet already exists: Turtle WoW - Warrior - Arms")
  end
end)

-- ============================================================================
-- FURY
-- ============================================================================

-- Vanilla Baseline
local vanillaFury = ApplyMultiplier({
  STR = 1.0,
  AGI = 0.57,
  STA = 0.1,
  SPI = 0.05,
  ATTACKPOWER = 0.54,
  TOHIT = 5.34621,        -- Pre-multiplied
  CRIT = 5.95,            -- Physical crit
  HASTE = 3.2923,         -- Physical haste
  ARMORIGNORE = 1.7625,
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
turtleFury.TOHIT = AdjustHitCap(vanillaFury.TOHIT)  -- 5.35 → 6.01

-- 2. Haste Baseline Check
turtleFury.HASTE = EnsureMinimumHaste(vanillaFury.HASTE, vanillaFury.CRIT, "melee_dps")

-- 3. Haste HIGHLY valuable (Unbridled Wrath 75% / 150% for 2H, Blood Drinker all attacks, No Enrage cap)
--    Conservative: +40% value (massive change)
turtleFury.HASTE = turtleFury.HASTE * 1.4  -- 3.29 → 4.61

-- 4. Critical Strike HIGHLY valuable (Enrage 15% damage, Flurry trigger, Rage generation)
--    Conservative: +30% value
turtleFury.CRIT = vanillaFury.CRIT * 1.3  -- 5.95 → 7.735

-- 5. Attack Power more valuable (Rage generation 90% gear-dependent - CRITICAL, Bloodthirst 35% AP)
--    Conservative: +20% value
turtleFury.ATTACKPOWER = vanillaFury.ATTACKPOWER * 1.2  -- 0.54 → 0.648

-- 6. Stamina more valuable (Blood Drinker: 1-2% max HP healing per attack during Enrage/Death Wish/Recklessness)
--    Conservative: +15% value
turtleFury.STA = vanillaFury.STA * 1.15  -- 0.1 → 0.115

-- 7. Strength: Converts to AP, also affected by rage generation
--    Conservative: +15% value
turtleFury.STR = vanillaFury.STR * 1.15  -- 1.0 → 1.15

-- 8. Agility: Converts to AP + Crit, also affected by changes
--    Conservative: +10% value
turtleFury.AGI = vanillaFury.AGI * 1.1  -- 0.57 → 0.627

print("")
print("Turtle WoW - Warrior - Fury:")
print("  TOHIT: " .. string.format("%.2f", vanillaFury.TOHIT) .. " → " .. string.format("%.2f", turtleFury.TOHIT) .. " (+12.5%)")
print("  HASTE: " .. string.format("%.2f", vanillaFury.HASTE) .. " → " .. string.format("%.2f", turtleFury.HASTE) .. " (+40% Unbridled Wrath 75%/150%!)")
print("  CRIT: " .. string.format("%.2f", vanillaFury.CRIT) .. " → " .. string.format("%.3f", turtleFury.CRIT) .. " (+30% Enrage 15%!)")
print("  AP: " .. string.format("%.2f", vanillaFury.ATTACKPOWER) .. " → " .. string.format("%.3f", turtleFury.ATTACKPOWER) .. " (+20% Rage gen!)")
print("  STA: " .. string.format("%.2f", vanillaFury.STA) .. " → " .. string.format("%.3f", turtleFury.STA) .. " (+15% Blood Drinker healing!)")
print("  STR: " .. string.format("%.2f", vanillaFury.STR) .. " → " .. string.format("%.2f", turtleFury.STR) .. " (+15%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleFury

  if not ItemsOfPower.SetByName["Turtle WoW - Warrior - Fury"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Turtle WoW - Warrior - Fury", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Turtle WoW - Warrior - Fury")
  else
    print("StatSet already exists: Turtle WoW - Warrior - Fury")
  end
end)

-- ============================================================================
-- PROTECTION
-- ============================================================================

-- Vanilla Baseline
local vanillaProtection = ApplyMultiplier({
  STR = 0.33,
  AGI = 0.59,
  STA = 1.0,
  SPI = 0.05,
  ATTACKPOWER = 0.06,
  TOHIT = 6.28414,        -- Pre-multiplied
  CRIT = 2.38,
  HASTE = 1.6863,
  ARMORIGNORE = 0.7125,
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
turtleProtection.TOHIT = AdjustHitCap(vanillaProtection.TOHIT)  -- 6.28 → 7.07

-- 2. Haste Baseline Check
turtleProtection.HASTE = EnsureMinimumHaste(vanillaProtection.HASTE, vanillaProtection.CRIT, "tank")

-- 3. Block Value HIGHLY valuable (Shield Slam scales with Block Value + Attack Power - CRITICAL)
--    Conservative: +50% value (becomes primary threat stat)
turtleProtection.BLOCKVALUE = vanillaProtection.BLOCKVALUE * 1.5  -- 0.35 → 0.525

-- 4. Attack Power more valuable (Shield Slam scaling, Rend 5% AP, Rage generation 90% gear)
--    Conservative: +25% value (threat generation)
turtleProtection.ATTACKPOWER = vanillaProtection.ATTACKPOWER * 1.25  -- 0.06 → 0.075

-- 5. Armor more valuable (75% cap removed! Continues with diminishing returns beyond 75%)
--    Conservative: +30% value
turtleProtection.ARMOR = vanillaProtection.ARMOR * 1.3  -- 0.02 → 0.026

-- 6. Critical Strike more valuable (Rage generation, Threat spikes)
--    Conservative: +15% value
turtleProtection.CRIT = vanillaProtection.CRIT * 1.15  -- 2.38 → 2.737

-- 7. Strength: Converts to AP, benefits from Shield Slam
--    Conservative: +20% value (threat scaling)
turtleProtection.STR = vanillaProtection.STR * 1.2  -- 0.33 → 0.396

-- 8. Agility: Converts to AP + Crit + Armor, benefits from changes
--    Conservative: +10% value
turtleProtection.AGI = vanillaProtection.AGI * 1.1  -- 0.59 → 0.649

-- 9. Stamina: Blood Craze healing, survivability
--    Conservative: +10% value
turtleProtection.STA = vanillaProtection.STA * 1.1  -- 1.0 → 1.1

print("")
print("Turtle WoW - Warrior - Protection:")
print("  TOHIT: " .. string.format("%.2f", vanillaProtection.TOHIT) .. " → " .. string.format("%.2f", turtleProtection.TOHIT) .. " (+12.5%)")
print("  BLOCKVALUE: " .. string.format("%.2f", vanillaProtection.BLOCKVALUE) .. " → " .. string.format("%.3f", turtleProtection.BLOCKVALUE) .. " (+50% Shield Slam scaling!)")
print("  AP: " .. string.format("%.2f", vanillaProtection.ATTACKPOWER) .. " → " .. string.format("%.3f", turtleProtection.ATTACKPOWER) .. " (+25% Shield Slam + Rage gen!)")
print("  ARMOR: " .. string.format("%.2f", vanillaProtection.ARMOR) .. " → " .. string.format("%.3f", turtleProtection.ARMOR) .. " (+30% CAP REMOVED!)")
print("  CRIT: " .. string.format("%.2f", vanillaProtection.CRIT) .. " → " .. string.format("%.3f", turtleProtection.CRIT) .. " (+15%)")
print("  STR: " .. string.format("%.2f", vanillaProtection.STR) .. " → " .. string.format("%.3f", turtleProtection.STR) .. " (+20% threat scaling)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleProtection

  if not ItemsOfPower.SetByName["Turtle WoW - Warrior - Protection"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Turtle WoW - Warrior - Protection", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Turtle WoW - Warrior - Protection")
  else
    print("StatSet already exists: Turtle WoW - Warrior - Protection")
  end
end)

print("")
print("All Turtle WoW Warrior StatSets created!")
print("Total: 3 specs")
