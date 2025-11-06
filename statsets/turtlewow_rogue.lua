--[[
  Turtle WoW Rogue StatSets

  Based on Vanilla ClassicHawsJon weights with Turtle WoW adjustments.

  Changes from Vanilla:
  - Hit Cap: 9% → 8% (all specs: +12.5% Hit Rating value)
  - Haste: Baseline adjustments
  - Assassination: Attack Power HIGHLY valuable (Poison AP Scaling)
  - Assassination: Crit more valuable (Relentless Strikes)
  - Combat: Agility more valuable (Blade Rush energy regen)
  - Combat: Crit more valuable (Close Quarters Combat)
  - Subtlety: Attack Power more valuable (Mark for Death, Shadow of Death)
  - Subtlety: Health more valuable (Cloaked in Shadows)

  References:
  - docs/turtle-wow-rogue-scaling-changes.md
  - docs/vanilla-baseline-weights.md
  - tools/turtle_wow_adjustments.lua
]]

-- Initialize pending StatSets queue
if not ItemsOfPower_PendingStatSets then
  ItemsOfPower_PendingStatSets = {}
end

-- ============================================================================
-- ASSASSINATION
-- ============================================================================

-- Vanilla Baseline (identical for all 3 Rogue specs in Vanilla)
local vanillaAssassination = {
  STR = 0.5,
  AGI = 1.0,
  STA = 0.1,
  SPI = 0.05,
  ATTACKPOWER = 0.45,
  TOHIT = 9.37931,        -- Pre-multiplied
  CRIT = 6.885,           -- 8.5 * 0.81
  HASTE = 7.227,          -- 8.03 * 0.9
  ARMORIGNORE = 0.9,      -- 3.75 * 0.24
  HEALTH = 0.01,
  HEALTHREG = 1.0,
  ARMOR = 0.005,
  DEFENSE = 0.075,
  DODGE = 0.472,
  PARRY = 1.1328,         -- 9.44 * 0.12
  RESILIENCE = 0.2,
  FIRERES = 0.24,
  FROSTRES = 0.24,
  ARCANERES = 0.24,
  SHADOWRES = 0.24,
  NATURERES = 0.24,
}

-- Turtle WoW Adjustments for Assassination
local turtleAssassination = {}
for k, v in pairs(vanillaAssassination) do
  turtleAssassination[k] = v
end

-- 1. Hit Cap Adjustment: 9% → 8% (+12.5%)
turtleAssassination.TOHIT = AdjustHitCap(vanillaAssassination.TOHIT)  -- 9.38 → 10.55

-- 2. Haste Baseline Check
turtleAssassination.HASTE = EnsureMinimumHaste(vanillaAssassination.HASTE, vanillaAssassination.CRIT, "melee_dps")

-- 3. Attack Power MORE valuable (Poison AP Scaling - CRITICAL)
--    - Instant Poison: +5% AP per proc
--    - Deadly/Corrosive: +8% AP per stack (40% for 5 stacks)
--    - Envenom: +30% effectiveness multiplier
--    - Noxious Assault: 35% AP direct damage
--    Conservative: +35% value
turtleAssassination.ATTACKPOWER = vanillaAssassination.ATTACKPOWER * 1.35  -- 0.45 → 0.608

-- 4. Crit more valuable (Relentless Strikes: +5% finisher damage per stack, max 25%)
--    Conservative: +10% value
turtleAssassination.CRIT = vanillaAssassination.CRIT * 1.1  -- 6.885 → 7.57

print("Turtle WoW - Rogue - Assassination:")
print("  TOHIT: " .. string.format("%.2f", vanillaAssassination.TOHIT) .. " → " .. string.format("%.2f", turtleAssassination.TOHIT) .. " (+12.5%)")
print("  AP: " .. string.format("%.2f", vanillaAssassination.ATTACKPOWER) .. " → " .. string.format("%.3f", turtleAssassination.ATTACKPOWER) .. " (+35%)")
print("  CRIT: " .. string.format("%.2f", vanillaAssassination.CRIT) .. " → " .. string.format("%.2f", turtleAssassination.CRIT) .. " (+10%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleAssassination

  if not ItemsOfPower.SetByName["Turtle WoW - Rogue - Assassination"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Turtle WoW - Rogue - Assassination", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Turtle WoW - Rogue - Assassination")
  else
    print("StatSet already exists: Turtle WoW - Rogue - Assassination")
  end
end)

-- ============================================================================
-- COMBAT
-- ============================================================================

-- Vanilla Baseline
local vanillaCombat = {
  STR = 0.5,
  AGI = 1.0,
  STA = 0.1,
  SPI = 0.05,
  ATTACKPOWER = 0.45,
  TOHIT = 9.37931,
  CRIT = 6.885,
  HASTE = 7.227,
  ARMORIGNORE = 0.9,
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
}

-- Turtle WoW Adjustments for Combat
local turtleCombat = {}
for k, v in pairs(vanillaCombat) do
  turtleCombat[k] = v
end

-- 1. Hit Cap Adjustment
turtleCombat.TOHIT = AdjustHitCap(vanillaCombat.TOHIT)

-- 2. Haste Baseline Check
turtleCombat.HASTE = EnsureMinimumHaste(vanillaCombat.HASTE, vanillaCombat.CRIT, "melee_dps")

-- 3. Agility MORE valuable (Blade Rush: Agility reduces energy tick time - CRITICAL)
--    - Direct energy generation scaling
--    - +2/5% attack speed
--    Conservative: +25% value
turtleCombat.AGI = vanillaCombat.AGI * 1.25  -- 1.0 → 1.25

-- 4. Crit more valuable (Close Quarters Combat: +2/5% crit for daggers/fist/maces)
--    Conservative: +10% value
turtleCombat.CRIT = vanillaCombat.CRIT * 1.1  -- 6.885 → 7.57

-- 5. Haste slightly more valuable (Blade Rush: +2/5% attack speed)
--    Conservative: +5% value
turtleCombat.HASTE = turtleCombat.HASTE * 1.05  -- 7.227 → 7.59

print("")
print("Turtle WoW - Rogue - Combat:")
print("  TOHIT: " .. string.format("%.2f", vanillaCombat.TOHIT) .. " → " .. string.format("%.2f", turtleCombat.TOHIT) .. " (+12.5%)")
print("  AGI: " .. string.format("%.2f", vanillaCombat.AGI) .. " → " .. string.format("%.2f", turtleCombat.AGI) .. " (+25%)")
print("  CRIT: " .. string.format("%.2f", vanillaCombat.CRIT) .. " → " .. string.format("%.2f", turtleCombat.CRIT) .. " (+10%)")
print("  HASTE: " .. string.format("%.2f", vanillaCombat.HASTE) .. " → " .. string.format("%.2f", turtleCombat.HASTE) .. " (+5%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleCombat

  if not ItemsOfPower.SetByName["Turtle WoW - Rogue - Combat"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Turtle WoW - Rogue - Combat", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Turtle WoW - Rogue - Combat")
  else
    print("StatSet already exists: Turtle WoW - Rogue - Combat")
  end
end)

-- ============================================================================
-- SUBTLETY
-- ============================================================================

-- Vanilla Baseline
local vanillaSubtlety = {
  STR = 0.5,
  AGI = 1.0,
  STA = 0.1,
  SPI = 0.05,
  ATTACKPOWER = 0.45,
  TOHIT = 9.37931,
  CRIT = 6.885,
  HASTE = 7.227,
  ARMORIGNORE = 0.9,
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
}

-- Turtle WoW Adjustments for Subtlety
local turtleSubtlety = {}
for k, v in pairs(vanillaSubtlety) do
  turtleSubtlety[k] = v
end

-- 1. Hit Cap Adjustment
turtleSubtlety.TOHIT = AdjustHitCap(vanillaSubtlety.TOHIT)

-- 2. Haste Baseline Check
turtleSubtlety.HASTE = EnsureMinimumHaste(vanillaSubtlety.HASTE, vanillaSubtlety.CRIT, "melee_dps")

-- 3. Attack Power more valuable (Mark for Death, Shadow of Death)
--    - Mark for Death: Party gains 30% AP as AP, 18% as spell power
--    - Shadow of Death: 250% AP capacity at 5 CP
--    Conservative: +20% value
turtleSubtlety.ATTACKPOWER = vanillaSubtlety.ATTACKPOWER * 1.2  -- 0.45 → 0.54

-- 4. Health more valuable (Cloaked in Shadows: Shield = 6/12% max health)
--    Conservative: +50% value
turtleSubtlety.HEALTH = vanillaSubtlety.HEALTH * 1.5  -- 0.01 → 0.015

print("")
print("Turtle WoW - Rogue - Subtlety:")
print("  TOHIT: " .. string.format("%.2f", vanillaSubtlety.TOHIT) .. " → " .. string.format("%.2f", turtleSubtlety.TOHIT) .. " (+12.5%)")
print("  AP: " .. string.format("%.2f", vanillaSubtlety.ATTACKPOWER) .. " → " .. string.format("%.2f", turtleSubtlety.ATTACKPOWER) .. " (+20%)")
print("  HEALTH: " .. string.format("%.3f", vanillaSubtlety.HEALTH) .. " → " .. string.format("%.3f", turtleSubtlety.HEALTH) .. " (+50%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleSubtlety

  if not ItemsOfPower.SetByName["Turtle WoW - Rogue - Subtlety"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Turtle WoW - Rogue - Subtlety", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Turtle WoW - Rogue - Subtlety")
  else
    print("StatSet already exists: Turtle WoW - Rogue - Subtlety")
  end
end)

print("")
print("All Turtle WoW Rogue StatSets created!")
print("Total: 3 specs")
