--[[
  Turtle WoW Warlock StatSets

  Based on Vanilla ClassicHawsJon weights with Turtle WoW adjustments.

  Changes from Vanilla:
  - Spell Hit Cap: 9% → 8% (all specs: +12.5% Spell Hit value)
  - Spell Haste: Baseline adjustments
  - Affliction: Spell Power HIGHLY valuable (Siphon Life 100%, DoT haste scaling)
  - Demonology: Stats transfer to demons (INT, STA, Hit, Crit, Spell Damage)
  - Destruction: Crit HIGHLY valuable (Improved Shadow Bolt proc on crit)

  Turtle WoW Hotfixes & Patches:
  - Soul Fire (1.17.2): Coefficient 100%→125%, CD 60s→30s
  - Drain Soul (Nov 2024): Coefficient 16.67%→20%, even damage per tick
  - Dark Harvest (Nov 2024): Coefficient 20%→25%
  - Improved Shadow Bolt (Dec 2024): +20% Shadow damage, 20-100% proc on CRIT
  - Improved Soul Fire (Dec 2024): +8% Fire damage, 100% proc on cast
  - Fel Intellect (Dec 2024): 10/20/30% of total Int → demons
  - Fel Stamina (Dec 2024): 10-50% of total Sta → demons
  - Demonic Precision (Dec 2024): 30/60/90% hit AND crit transfer to demons
  - Unleashed Potential (Dec 2024): 5-15% spell damage → demons on crits (3 stacks)
  - Soul Siphon (Dec 2024): +2/4/6% damage per Affliction effect (max 4 = 24%)
  - Siphon Life (April 2025): Coefficient 50%→100%
  - Dark Harvest (April 2025): DoT acceleration 20%→30%
  - Imp Firebolt (April 2025): 10-40% SP coefficient by rank
  - Improved Soul Fire (1.18.0): +8%→+10% Fire damage
  - Soul Fire (1.18.0): Coefficient 125%→114%
  - Rain of Fire (1.18.0): Tick speed 2s→1s (same total damage)
  - Spellstone (1.18.0): Reworked to active dispel + magic shield
  - Drain Soul (1.18.0): Mana cost reworked (initial + per second)
  - Demon AP Scaling (Aug 2025): Voidwalker 20%, Succubus 40%, Felhunter 30%,
    Infernal 60%, Felguard 60%, Doomguard 30% of spell damage as demon AP
  - Voidstone (Aug 2025): New stone, -10% spell threat for 30 minutes

  Patch 1.18.1 Changes:
  - Hellfire (1.18.1): Coefficient 2.2%→4.125% per tick (+88% buff, massive for AoE/Demo)
  - Searing Pain (1.18.1): GCD 1.5s→1s (faster casting for Destro)
  - Curse of Recklessness (1.18.1): GCD 1.5s→1s
  - Soul Link (1.18.1): Damage transfer 25%→20% (less pet survivability)
  - Master Demonologist (1.18.1): Greater Demons healing reduction removed (QoL)
  - Sinister Pursuit (1.18.1): Moved from Affliction to Demonology
  - Master Conjuror (1.18.1): Removed from Affliction
  - Tier 3 4pc (1.18.1): Curse of Agony +100% damage first 4 ticks (front-loaded)
  - Tier 3.5 3pc (1.18.1): Siphon Life mana return 50%→25% (mana sustain nerf)
  - Curse of Exhaustion (1.18.1): Mana cost 8%→14%
  - Curse of Tongues R1 (1.18.1): Reduction 50%→30%
  - Felhunter/Infernal (1.18.1): -30% armor

  References:
  - docs/turtle-wow-warlock-scaling-changes.md
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
-- AFFLICTION
-- Siphon Life (April 2025): Coefficient 50%→100%
-- Dark Harvest (Nov 2024): 25% SP, (April 2025): 30% DoT haste
-- Rapid Deterioration: Haste affects DoT tick speed at 50/100% efficiency
-- Soul Siphon (Dec 2024): +2/4/6% per Affliction effect (max 4 = 24%)
-- 1.18.1: Sinister Pursuit moved to Demonology, Master Conjuror removed
-- 1.18.1: Tier 3 4pc CoA +100% damage first 4 ticks (front-loaded)
-- 1.18.1: Tier 3.5 3pc Siphon Life mana return 50%→25% (mana sustain nerf)
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

-- 6. Mana Regen slightly less valuable (1.18.1: Tier 3.5 3pc Siphon Life mana 50%→25%)
--    -10% value (less mana sustain from gear set bonus)
turtleAffliction.MANAREG = vanillaAffliction.MANAREG * 0.9  -- Slightly less valuable due to set nerf

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_Warlock_Affliction", turtleAffliction)
end)

-- ============================================================================
-- DEMONOLOGY
-- Fel Intellect (Dec 2024): 10/20/30% total Int → demons
-- Fel Stamina (Dec 2024): 10-50% total Sta → demons
-- Demonic Precision (Dec 2024): 30/60/90% hit AND crit transfer to demons
-- Unleashed Potential (Dec 2024): 5-15% spell damage → demons (3 stacks)
-- Imp Firebolt (April 2025): 10-40% SP coefficient by rank
-- Demon AP Scaling (Aug 2025): 20-60% spell damage as demon AP
-- 1.18.1: Hellfire coefficient 2.2%→4.125% per tick (+88% MASSIVE AoE buff)
-- 1.18.1: Soul Link damage transfer 25%→20% (slight survivability nerf)
-- 1.18.1: Master Demonologist Greater Demons healing reduction removed (QoL)
-- 1.18.1: Sinister Pursuit moved from Affliction to Demonology
-- 1.18.1: Felhunter/Infernal -30% armor (pet survivability nerf)
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
--    - Hellfire (1.18.1): Coefficient 2.2%→4.125% (+88% AoE buff)
--    +70% value (increased from 55% due to Hellfire buff)
turtleDemonology.DMG = vanillaDemonology.DMG * 1.70  -- 1.0 → 1.70

-- 4. Intellect more valuable (Fel Intellect: 10/20/30% total Int → demons Dec 2024)
--    +40% value
turtleDemonology.INT = vanillaDemonology.INT * 1.4  -- 0.4 → 0.56

-- 5. Stamina more valuable (Fel Stamina: 10-50% total Sta → demons Dec 2024)
--    1.18.1: Soul Link 25%→20% transfer = slight nerf to personal survivability
--    +50% value (reduced from 60% due to Soul Link nerf)
turtleDemonology.STA = vanillaDemonology.STA * 1.5  -- 0.1 → 0.15

-- 6. Crit more valuable (Demonic Precision 30-90% crit transfer, Unleashed Potential stacks on crit)
--    +35% value
turtleDemonology.SPELLCRIT = vanillaDemonology.SPELLCRIT * 1.35  -- 5.28 → 7.13

-- 7. Add CASTINGREG support (Meditation items in 1.16.0, medium value for Demonology)
turtleDemonology.CASTINGREG = 5.0  -- Medium value for Demonology mana efficiency

-- 8. Fire Damage more valuable (1.18.1: Hellfire coefficient +88%)
--    +40% value for Fire damage (Hellfire is Fire school)
turtleDemonology.FIREDMG = vanillaDemonology.FIREDMG * 1.4  -- 0.8 → 1.12

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_Warlock_Demonology", turtleDemonology)
end)

-- ============================================================================
-- DESTRUCTION
-- Soul Fire (1.17.2): Coefficient 100%→125%, CD 60s→30s
-- Improved Shadow Bolt (Dec 2024): +20% Shadow damage, 20-100% proc on CRIT
-- Improved Soul Fire (Dec 2024): +8% Fire damage, 100% proc on cast
-- Improved Soul Fire (1.18.0): +8%→+10% Fire damage
-- Soul Fire (1.18.0): Coefficient 125%→114%
-- 1.18.1: Searing Pain GCD 1.5s→1s (faster casting, slight DPS increase)
-- 1.18.1: Hellfire coefficient 2.2%→4.125% per tick (+88% AoE option)
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

-- 8. Haste slightly more valuable (1.18.1: Searing Pain GCD 1.5s→1s)
--    +5% value (faster Searing Pain spam option)
turtleDestruction.SPELLHASTE = vanillaDestruction.SPELLHASTE * 1.05  -- 9.23 → 9.70

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_Warlock_Destruction", turtleDestruction)
end)

