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
-- ASSASSINATION
-- ============================================================================

-- Vanilla Baseline (identical for all 3 Rogue specs in Vanilla)
local vanillaAssassination = ApplyMultiplier({
  STR = 0.5,
  AGI = 1.0,
  STA = 0.1,
  SPI = 0.05,
  ATTACKPOWER = 0.45,
  TOHIT = 9.37931,        -- Pre-multiplied
  EXPERTISE = 1.1,        -- Expertise Rating (from ClassicHawsJon)
  CRIT = 6.885,           -- 8.5 * 0.81
  HASTE = 7.227,          -- 8.03 * 0.9
  ARMORPEN = 0.621,       -- Armor Penetration (from ClassicHawsJon: 3.75 * 0.24 = 0.9, divided by 1.45 for base)
  WEAPONDPS = 2.222,      -- Weapon DPS (from ClassicHawsJon: 3, divided by 1.35 for base)
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
})

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

-- 5. WEAPONDPS more valuable (Deadly Throw 100% weapon damage, but many abilities shifted to AP)
--    Conservative: +35% value
turtleAssassination.WEAPONDPS = vanillaAssassination.WEAPONDPS * 1.35  -- 2.222 → 3

-- 6. ARMORPEN more valuable (Expose Armor earlier access + Armor Cap Removal)
--    Conservative: +45% value
turtleAssassination.ARMORPEN = vanillaAssassination.ARMORPEN * 1.45  -- 0.621 → 0.9

print("TurtleWoW_Rogue_Assassination:")
print("  TOHIT: " .. string.format("%.2f", vanillaAssassination.TOHIT) .. " → " .. string.format("%.2f", turtleAssassination.TOHIT) .. " (+12.5%)")
print("  AP: " .. string.format("%.2f", vanillaAssassination.ATTACKPOWER) .. " → " .. string.format("%.3f", turtleAssassination.ATTACKPOWER) .. " (+35%)")
print("  WEAPONDPS: " .. string.format("%.3f", vanillaAssassination.WEAPONDPS) .. " → " .. string.format("%.2f", turtleAssassination.WEAPONDPS) .. " (+35%)")
print("  ARMORPEN: " .. string.format("%.3f", vanillaAssassination.ARMORPEN) .. " → " .. string.format("%.2f", turtleAssassination.ARMORPEN) .. " (+45% Expose Armor + Cap Removal!)")
print("  CRIT: " .. string.format("%.2f", vanillaAssassination.CRIT) .. " → " .. string.format("%.2f", turtleAssassination.CRIT) .. " (+10%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleAssassination

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Rogue_Assassination", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Rogue_Assassination"] then
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: TurtleWoW_Rogue_Assassination")
  else
    print("Updated StatSet: TurtleWoW_Rogue_Assassination")
  end
end)

-- ============================================================================
-- COMBAT
-- ============================================================================

-- Vanilla Baseline
local vanillaCombat = ApplyMultiplier({
  STR = 0.5,
  AGI = 1.0,
  STA = 0.1,
  SPI = 0.05,
  ATTACKPOWER = 0.45,
  TOHIT = 9.37931,
  EXPERTISE = 1.1,        -- Expertise Rating (from ClassicHawsJon)
  CRIT = 6.885,
  HASTE = 7.227,
  ARMORPEN = 0.621,       -- Armor Penetration (from ClassicHawsJon: 3.75 * 0.24 = 0.9, divided by 1.45 for base)
  WEAPONDPS = 2.222,      -- Weapon DPS (from ClassicHawsJon: 3, divided by 1.35 for base)
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

-- 6. WEAPONDPS more valuable (Deadly Throw, Surprise Attack, but many abilities shifted to AP)
--    Conservative: +35% value
turtleCombat.WEAPONDPS = vanillaCombat.WEAPONDPS * 1.35  -- 2.222 → 3

-- 7. ARMORPEN more valuable (Expose Armor earlier access + Armor Cap Removal)
--    Conservative: +45% value
turtleCombat.ARMORPEN = vanillaCombat.ARMORPEN * 1.45  -- 0.621 → 0.9

print("")
print("TurtleWoW_Rogue_Combat:")
print("  TOHIT: " .. string.format("%.2f", vanillaCombat.TOHIT) .. " → " .. string.format("%.2f", turtleCombat.TOHIT) .. " (+12.5%)")
print("  AGI: " .. string.format("%.2f", vanillaCombat.AGI) .. " → " .. string.format("%.2f", turtleCombat.AGI) .. " (+25% Blade Rush Energy!)")
print("  WEAPONDPS: " .. string.format("%.3f", vanillaCombat.WEAPONDPS) .. " → " .. string.format("%.2f", turtleCombat.WEAPONDPS) .. " (+35%)")
print("  ARMORPEN: " .. string.format("%.3f", vanillaCombat.ARMORPEN) .. " → " .. string.format("%.2f", turtleCombat.ARMORPEN) .. " (+45% Expose Armor + Cap Removal!)")
print("  CRIT: " .. string.format("%.2f", vanillaCombat.CRIT) .. " → " .. string.format("%.2f", turtleCombat.CRIT) .. " (+10%)")
print("  HASTE: " .. string.format("%.2f", vanillaCombat.HASTE) .. " → " .. string.format("%.2f", turtleCombat.HASTE) .. " (+5%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleCombat

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Rogue_Combat", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Rogue_Combat"] then
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: TurtleWoW_Rogue_Combat")
  else
    print("Updated StatSet: TurtleWoW_Rogue_Combat")
  end
end)

-- ============================================================================
-- SUBTLETY
-- ============================================================================

-- Vanilla Baseline
local vanillaSubtlety = ApplyMultiplier({
  STR = 0.5,
  AGI = 1.0,
  STA = 0.1,
  SPI = 0.05,
  ATTACKPOWER = 0.45,
  TOHIT = 9.37931,
  EXPERTISE = 1.1,        -- Expertise Rating (from ClassicHawsJon)
  CRIT = 6.885,
  HASTE = 7.227,
  ARMORPEN = 0.621,       -- Armor Penetration (from ClassicHawsJon: 3.75 * 0.24 = 0.9, divided by 1.45 for base)
  WEAPONDPS = 2.222,      -- Weapon DPS (from ClassicHawsJon: 3, divided by 1.35 for base)
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

-- 5. WEAPONDPS more valuable (Hemorrhage 110% weapon damage, but many abilities shifted to AP)
--    Conservative: +35% value
turtleSubtlety.WEAPONDPS = vanillaSubtlety.WEAPONDPS * 1.35  -- 2.222 → 3

-- 6. ARMORPEN more valuable (Expose Armor earlier access + Armor Cap Removal)
--    Conservative: +45% value
turtleSubtlety.ARMORPEN = vanillaSubtlety.ARMORPEN * 1.45  -- 0.621 → 0.9

print("")
print("TurtleWoW_Rogue_Subtlety:")
print("  TOHIT: " .. string.format("%.2f", vanillaSubtlety.TOHIT) .. " → " .. string.format("%.2f", turtleSubtlety.TOHIT) .. " (+12.5%)")
print("  AP: " .. string.format("%.2f", vanillaSubtlety.ATTACKPOWER) .. " → " .. string.format("%.2f", turtleSubtlety.ATTACKPOWER) .. " (+20% Mark for Death!)")
print("  WEAPONDPS: " .. string.format("%.3f", vanillaSubtlety.WEAPONDPS) .. " → " .. string.format("%.2f", turtleSubtlety.WEAPONDPS) .. " (+35% Hemorrhage!)")
print("  ARMORPEN: " .. string.format("%.3f", vanillaSubtlety.ARMORPEN) .. " → " .. string.format("%.2f", turtleSubtlety.ARMORPEN) .. " (+45% Expose Armor + Cap Removal!)")
print("  HEALTH: " .. string.format("%.3f", vanillaSubtlety.HEALTH) .. " → " .. string.format("%.3f", turtleSubtlety.HEALTH) .. " (+50%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleSubtlety

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Rogue_Subtlety", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Rogue_Subtlety"] then
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: TurtleWoW_Rogue_Subtlety")
  else
    print("Updated StatSet: TurtleWoW_Rogue_Subtlety")
  end
end)

print("")
print("All Turtle WoW Rogue StatSets created!")
print("Total: 3 specs")
