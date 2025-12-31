--[[
  Turtle WoW Rogue StatSets

  Based on Vanilla ClassicHawsJon weights with Turtle WoW adjustments.

  Changes from Vanilla:
  - Hit Cap: 9% → 8% (all specs: +12.5% Hit Rating value)
  - Assassination: Attack Power HIGHLY valuable (Poison AP Scaling)
  - Assassination: Crit more valuable (Relentless Strikes)
  - Combat: Agility more valuable (Blade Rush energy regen)
  - Combat: Crit more valuable (Close Quarters Combat)
  - Subtlety: Attack Power more valuable (Mark for Death, Shadow of Death)
  - Subtlety: Health more valuable (Cloaked in Shadows)

  Turtle WoW Hotfixes & Patches:
  - Poison AP Scaling (Dec 2024): Instant 5%, Deadly/Corrosive 2%/tick (8% total)
  - Relentless Strikes (Dec 2024): +5% finisher damage per stack, max 5 (25%)
  - Surprise Attack (Dec 2024): Reworked from 120% weapon damage to 25% AP
  - Vile Poisons (April 2025): 7/14/20%→10/20/30% poison damage
  - Envenom (April 2025): 25%→30% increased poison effectiveness
  - Deadly Throw (April 2025): Reworked to 100% weapon damage, ranged interrupt
  - Hemorrhage (April 2025): 100%→110% weapon damage
  - Swift Strikes (1.18.0): REMOVED
  - Blade Rush (1.18.0): +2/5% attack speed, Agility reduces energy tick time
  - Blade Flurry (1.18.0): Now baseline toggle, -30% energy regen, -20% damage
  - Corrosive Poison (1.18.0): AP scaling reduced by 5%
  - Hemorrhage (1.18.0): Energy cost 45→40
  - Dust of Disappearance (1.18.0): REMOVED
  - Honor Among Thieves (1.18.0): Own crits trigger, CD 2s→1.5s
  - Shadow of Death (1.18.0): 50-250% AP capacity based on combo points
  - Mark for Death (1.18.0): Party gains 30% rogue AP as AP, 18% as spell power

  LIMITATIONS (Complex mechanics that cannot be fully modeled with static weights):
  - Envenom: "Ramps up the damage of your poisons by 15% per combo point" is dynamic
  - Relentless Strikes: Proc-based energy refund depends on finisher frequency
  - Mark for Death: Party utility (30% AP as AP, 18% as spell power) benefits raid
  - Blade Rush: Agility → energy tick reduction is a complex formula
  - Shadow of Death: 250% AP at 5 CP is situational burst
  These mechanics make Rogue stat weights more approximate than other classes.

  References:
  - docs/turtle-wow-rogue-scaling-changes.md
  - docs/vanilla-baseline-weights.md
  - tools/turtle_wow_adjustments.lua
]]

-- Initialize pending StatSets queue
if not ItemsOfPower_PendingStatSets then
  ItemsOfPower_PendingStatSets = {}
end


-- Helper: Register new set OR update existing set's stats
local function RegisterOrUpdateStatSet(name, stats)
  local existingSet = ItemsOfPower.SetByName[name]
  if existingSet then
    -- Update stats in place (clear old, add new)
    for k in pairs(existingSet.Stats) do
      existingSet.Stats[k] = nil
    end
    for k, v in pairs(stats) do
      existingSet.Stats[k] = v
    end
    ItemsOfPower:ClearCache()
  else
    local set = ItemsOfPower.SetTypes.StatSet:new(name, stats)
    ItemsOfPower:RegisterSet(set)
  end
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
-- Poison AP Scaling (Dec 2024): Instant 5%, Deadly/Corrosive 8% per stack
-- Vile Poisons (April 2025): 10/20/30% poison damage
-- Envenom (April 2025): 30% effectiveness
-- Corrosive Poison (1.18.0): -5% AP scaling
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
turtleAssassination.TOHIT = vanillaAssassination.TOHIT * 1.125  -- 9.38 → 10.55

-- 2. Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 3. Attack Power MORE valuable (Poison AP Scaling - CRITICAL)
--    - Instant Poison: +5% AP per proc
--    - Deadly/Corrosive: +2%/tick (8% total for 4 ticks)
--    - Envenom: +30% effectiveness multiplier (April 2025, was 25%)
--    - Noxious Assault: 35% AP direct damage
--    +60% value
turtleAssassination.ATTACKPOWER = vanillaAssassination.ATTACKPOWER * 1.6  -- 0.45 → 0.72

-- 4. Crit more valuable (Relentless Strikes: +5% finisher damage per stack, max 25%)
--    Conservative: +10% value
turtleAssassination.CRIT = vanillaAssassination.CRIT * 1.1  -- 6.885 → 7.57

-- 5. WEAPONDPS more valuable (Deadly Throw 100% weapon damage April 2025, Noxious Assault)
--    +55% value
turtleAssassination.WEAPONDPS = vanillaAssassination.WEAPONDPS * 1.55  -- 2.222 → 3.44

-- 6. ARMORPEN more valuable (Expose Armor earlier access + Armor Cap Removal)
--    Conservative: +45% value
turtleAssassination.ARMORPEN = vanillaAssassination.ARMORPEN * 1.45  -- 0.621 → 0.9


-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_Rogue_Assassination", turtleAssassination)
end)

-- ============================================================================
-- COMBAT
-- Surprise Attack (Dec 2024): Reworked to 25% AP (was 120% weapon damage)
-- Swift Strikes (1.18.0): REMOVED
-- Blade Rush (1.18.0): +2/5% attack speed, Agility reduces energy tick time
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
turtleCombat.TOHIT = vanillaCombat.TOHIT * 1.125

-- 2. Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 3. Agility MORE valuable (Blade Rush 1.18.0: Agility reduces energy tick time - CRITICAL)
--    - Direct energy generation scaling
--    - +2/5% attack speed
--    +40% value
turtleCombat.AGI = vanillaCombat.AGI * 1.4  -- 1.0 → 1.4

-- 4. Attack Power more valuable (Surprise Attack now 25% AP, Poisons scale with AP)
--    Lower than Assassination (which focuses on poison stacking)
turtleCombat.ATTACKPOWER = vanillaCombat.ATTACKPOWER * 1.25  -- 0.45 → 0.56

-- 5. Crit more valuable (Close Quarters Combat: +2/5% crit for daggers/fist/maces)
--    Conservative: +10% value
turtleCombat.CRIT = vanillaCombat.CRIT * 1.1  -- 6.885 → 7.57

-- 6. Haste: No documented bonus - using vanilla baseline

-- 7. WEAPONDPS more valuable (Deadly Throw 100% weapon damage, Surprise Attack)
--    +50% value
turtleCombat.WEAPONDPS = vanillaCombat.WEAPONDPS * 1.5  -- 2.222 → 3.33

-- 7. ARMORPEN more valuable (Expose Armor earlier access + Armor Cap Removal)
--    Conservative: +45% value
turtleCombat.ARMORPEN = vanillaCombat.ARMORPEN * 1.45  -- 0.621 → 0.9


-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_Rogue_Combat", turtleCombat)
end)

-- ============================================================================
-- SUBTLETY
-- Hemorrhage (April 2025): 100%→110% weapon damage
-- Hemorrhage (1.18.0): Energy cost 45→40
-- Dust of Disappearance (1.18.0): REMOVED
-- Honor Among Thieves (1.18.0): Own crits trigger, CD 2s→1.5s
-- Shadow of Death (1.18.0): 50-250% AP capacity
-- Mark for Death (1.18.0): 30% AP→party AP, 18%→spell power
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
turtleSubtlety.TOHIT = vanillaSubtlety.TOHIT * 1.125

-- 2. Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 3. Attack Power more valuable (Mark for Death, Shadow of Death 1.18.0)
--    - Mark for Death: Party gains 30% AP as AP, 18% as spell power
--    - Shadow of Death: 50-250% AP capacity based on combo points
--    +35% value
turtleSubtlety.ATTACKPOWER = vanillaSubtlety.ATTACKPOWER * 1.35  -- 0.45 → 0.608

-- 4. Crit more valuable (Relentless Strikes triggers from crits, Honor Among Thieves energy)
--    Conservative: +10% value
turtleSubtlety.CRIT = vanillaSubtlety.CRIT * 1.1  -- 6.885 → 7.57

-- 5. Health more valuable (Cloaked in Shadows: Shield = 6/12% max health)
--    Conservative: +50% value
turtleSubtlety.HEALTH = vanillaSubtlety.HEALTH * 1.5  -- 0.01 → 0.015

-- 6. WEAPONDPS more valuable (Hemorrhage 110% weapon damage, but many abilities shifted to AP)
--    Conservative: +35% value
turtleSubtlety.WEAPONDPS = vanillaSubtlety.WEAPONDPS * 1.35  -- 2.222 → 3

-- 6. ARMORPEN more valuable (Expose Armor earlier access + Armor Cap Removal)
--    Conservative: +45% value
turtleSubtlety.ARMORPEN = vanillaSubtlety.ARMORPEN * 1.45  -- 0.621 → 0.9


-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_Rogue_Subtlety", turtleSubtlety)
end)

