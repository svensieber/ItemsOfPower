--[[
  Turtle WoW Warlock StatSets

  Based on Vanilla ClassicHawsJon weights with Turtle WoW adjustments.

  Changes from Vanilla:
  - Spell Hit Cap: 9% → 8% (all specs: +12.5% Spell Hit value)
  - Spell Haste: Baseline adjustments

  Affliction Talents:
  - Siphon Life: SP coefficient 50%→100% (April 2025)
  - Dark Harvest: 25% SP, accelerates DoTs by 30% while channeling
  - Rapid Deterioration: Haste affects DoT tick speed at 50/100% efficiency
  - Soul Siphon: +2/4/6% damage per Affliction effect (max 4 = 24%)

  Demonology Talents:
  - Demonic Precision: 30/60/90% hit and crit transfer to demons
  - Fel Intellect: 10/20/30% of total Int → demons (Dec 2024)
  - Fel Stamina: 10-50% of total Sta → demons (Dec 2024)
  - Demon AP Scaling (Aug 2025): 20-60% spell damage as demon AP
  - Unleashed Potential: 5-15% spell damage → demons on crits (3 stacks, 20s)
  - Imp Firebolt: 10-40% SP coefficient by rank

  Destruction Talents:
  - Improved Shadow Bolt (Dec 2024): +20% Shadow damage, 20-100% proc on CRIT
  - Improved Soul Fire: +10% Fire damage for 30s, 100% proc on cast
  - Soul Fire: Coefficient 125%→114% (1.18.0)

  References:
  - docs/turtle-wow-warlock-scaling-changes.md
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
-- AFFLICTION
-- ============================================================================

-- Vanilla Baseline
local vanillaAffliction = ApplyMultiplier({
  INT = 0.4,
  SPI = 0.1,
  STA = 0.1,
  AGI = 0.05,
  DMG = 1.0,              -- Generic spell damage
  SHADOWDMG = 0.91,       -- Shadow damage priority
  FIREDMG = 0.35,         -- Fire damage (lower)
  SPELLTOHIT = 9.6,       -- Pre-multiplied
  SPELLCRIT = 3.12,       -- 8.0 * 0.39
  SPELLHASTE = 6.2634,    -- 8.03 * 0.78
  SPELLPEN = 0.08,
  MANA = 0.03,
  MANAREG = 1.0,
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

-- Turtle WoW Adjustments for Affliction
local turtleAffliction = {}
for k, v in pairs(vanillaAffliction) do
  turtleAffliction[k] = v
end

-- 1. Spell Hit Cap Adjustment: 9% → 8% (+12.5%)
turtleAffliction.SPELLTOHIT = vanillaAffliction.SPELLTOHIT * 1.125  -- 9.6 → 10.8

-- 2. Spell Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 3. Spell Power (DMG) HIGHLY valuable (Siphon Life 50%→100% April 2025, Dark Harvest 25%)
--    +50% value (Siphon Life coefficient doubled is massive)
turtleAffliction.DMG = vanillaAffliction.DMG * 1.5  -- 1.0 → 1.5

-- 4. Haste more valuable (Rapid Deterioration: Haste affects DoT tick speed at 50/100%)
--    +30% value (DoT haste scaling is significant)
turtleAffliction.SPELLHASTE = turtleAffliction.SPELLHASTE * 1.3  -- 6.26 → 8.14

-- 5. Add CASTINGREG support (Meditation items in 1.16.0, medium value for Affliction)
--    Affliction has Life Tap sustain, but CASTINGREG still valuable
turtleAffliction.CASTINGREG = 5.0  -- Medium value for Affliction mana efficiency

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleAffliction

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Warlock_Affliction", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Warlock_Affliction"] then
    ItemsOfPower:RegisterSet(set)
  else
  end
end)

-- ============================================================================
-- DEMONOLOGY
-- ============================================================================

-- Vanilla Baseline
local vanillaDemonology = ApplyMultiplier({
  INT = 0.4,
  SPI = 0.5,              -- Higher than Affliction (mana regen)
  STA = 0.1,
  AGI = 0.05,
  DMG = 1.0,
  SHADOWDMG = 0.8,        -- Shadow damage
  FIREDMG = 0.8,          -- Fire damage (equal to Shadow)
  SPELLTOHIT = 9.6,
  SPELLCRIT = 5.28,       -- 8.0 * 0.66
  SPELLHASTE = 5.621,     -- 8.03 * 0.7
  SPELLPEN = 0.08,
  MANA = 0.03,
  MANAREG = 1.0,
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

-- Turtle WoW Adjustments for Demonology
local turtleDemonology = {}
for k, v in pairs(vanillaDemonology) do
  turtleDemonology[k] = v
end

-- 1. Spell Hit Cap Adjustment + Demonic Precision (30/60/90% hit transfer to demons)
--    +30% value (base 12.5% hit cap + demon hit transfer)
turtleDemonology.SPELLTOHIT = vanillaDemonology.SPELLTOHIT * 1.3

-- 2. Spell Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 3. Spell Power (DMG) HIGHLY valuable (Demon AP Scaling - CRITICAL)
--    - Demon AP Scaling (Aug 2025): 20-60% spell damage as demon AP
--    - Unleashed Potential: 5-15% spell damage → demons (3 stacks)
--    - Imp Firebolt: 10-40% spell power coefficient
--    +55% value
turtleDemonology.DMG = vanillaDemonology.DMG * 1.55  -- 1.0 → 1.55

-- 4. Intellect more valuable (Fel Intellect: 10/20/30% total Int → demons Dec 2024)
--    +40% value
turtleDemonology.INT = vanillaDemonology.INT * 1.4  -- 0.4 → 0.56

-- 5. Stamina more valuable (Fel Stamina: 10-50% total Sta → demons Dec 2024)
--    +60% value
turtleDemonology.STA = vanillaDemonology.STA * 1.6  -- 0.1 → 0.16

-- 6. Crit more valuable (Demonic Precision 30-90% crit transfer, Unleashed Potential stacks on crit)
--    +35% value
turtleDemonology.SPELLCRIT = vanillaDemonology.SPELLCRIT * 1.35  -- 5.28 → 7.13

-- 7. Add CASTINGREG support (Meditation items in 1.16.0, medium value for Demonology)
turtleDemonology.CASTINGREG = 5.0  -- Medium value for Demonology mana efficiency

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleDemonology

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Warlock_Demonology", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Warlock_Demonology"] then
    ItemsOfPower:RegisterSet(set)
  else
  end
end)

-- ============================================================================
-- DESTRUCTION
-- ============================================================================

-- Vanilla Baseline
local vanillaDestruction = ApplyMultiplier({
  INT = 0.34,
  SPI = 0.25,
  STA = 0.1,
  AGI = 0.05,
  DMG = 1.0,
  SHADOWDMG = 0.95,       -- Shadow damage priority (Shadow Bolt)
  FIREDMG = 0.23,         -- Fire damage (lower)
  SPELLTOHIT = 12.8,      -- HIGHEST of all caster specs!
  SPELLCRIT = 6.96,       -- 8.0 * 0.87
  SPELLHASTE = 9.2345,    -- 8.03 * 1.15
  SPELLPEN = 0.08,
  MANA = 0.028,
  MANAREG = 0.65,
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

-- Turtle WoW Adjustments for Destruction
local turtleDestruction = {}
for k, v in pairs(vanillaDestruction) do
  turtleDestruction[k] = v
end

-- 1. Spell Hit Cap Adjustment
turtleDestruction.SPELLTOHIT = vanillaDestruction.SPELLTOHIT * 1.125  -- 12.8 → 14.4

-- 2. Spell Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 3. Spell Power (DMG) more valuable (Soul Fire 114%, Improved Shadow Bolt)
--    Conservative: +15% value
turtleDestruction.DMG = vanillaDestruction.DMG * 1.15  -- 1.0 → 1.15

-- 4. Crit HIGHLY valuable (Improved Shadow Bolt Dec 2024: 20-100% proc on crit - CRITICAL)
--    +35% value
turtleDestruction.SPELLCRIT = vanillaDestruction.SPELLCRIT * 1.35  -- 6.96 → 9.40

-- 5. Shadow Damage more valuable (Improved Shadow Bolt: +20% Shadow damage debuff)
--    +20% value
turtleDestruction.SHADOWDMG = vanillaDestruction.SHADOWDMG * 1.2  -- 0.95 → 1.14

-- 6. Fire Damage more valuable (Improved Soul Fire: +10% Fire damage for 30s)
--    +20% value
turtleDestruction.FIREDMG = vanillaDestruction.FIREDMG * 1.2  -- 0.23 → 0.276

-- 7. Add CASTINGREG support (Meditation items in 1.16.0, low-medium value for Destruction)
--    Destruction has Life Tap + Improved Soul Fire regen
turtleDestruction.CASTINGREG = 4.0  -- Low-medium value for Destruction mana efficiency

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleDestruction

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Warlock_Destruction", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Warlock_Destruction"] then
    ItemsOfPower:RegisterSet(set)
  else
  end
end)

