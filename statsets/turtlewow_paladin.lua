--[[
  Turtle WoW Paladin StatSets

  Based on Vanilla ClassicHawsJon weights with Turtle WoW adjustments.

  Changes from Vanilla:
  - Hit Cap: 9% → 8% (all specs: +12.5% Hit Rating value)
  - Holy: Spell Power more valuable (Holy Strike, Daybreak, Holy Shock)
  - Holy: Crit more valuable (Daybreak procs)
  - Holy: Illumination nerfed 100%→60% (1.17.2) - Spirit/mp5 more valuable
  - Protection: Spell Power NERFED (Holy Shield SP coefficient 33%→15%)
  - Protection: Block Value more valuable (Righteous Strikes rework Nov 2024)
  - Protection: Block Chance NERFED (Redoubt halved Nov 2024)
  - Protection: Stamina more valuable (Righteous Defense mitigation)
  - Retribution: Spell Power BUFFED (Seal of Righteousness 2H: +27% net after April 2025)
  - Retribution: Judgement of Righteousness uses melee hit/crit (April 2025)
  - Retribution: Strength more valuable (Holy Strike buff)
  - Retribution: Haste more valuable (Zeal multiplicative)
  - Retribution: Crit more valuable (Vengeance stacks)

  Hotfixes and Patch Changes:
  - Shield of the Righteous (Oct 2024): CD 3→5 min, DR 40%→30%
  - Sacred Duty (Oct 2024): REMOVED from game
  - Crusader Strike (Nov 2024): -10% weapon damage
  - Redoubt (Nov 2024): Block chance 6/12/18/24/30%→3/6/9/12/15% (HALVED)
  - Righteous Strikes (Nov 2024): Zeal now boosts block VALUE not block chance
  - Holy Shield (Dec 2024): Block 50%→45%, SP 33%→15%, threat 45%→30%
  - Weapon Normalization (Dec 2024): Speed matters less, raw DPS critical
  - Seal of Righteousness (April 2025): 2H 0.098→0.128 (+31% buff!)
  - Judgement of Righteousness (April 2025): Now uses melee hit/crit
  - Reckoning (April 2025): Proc rate DOUBLED (5-25%→10-50%)
  - Crusader Strike (1.18.0): SP coefficient 33%→20%
  - Seal of Righteousness (1.18.0): 2H 0.128→0.125 (minor nerf)
  - Daybreak (1.18.0): Reworked to 43% SP delayed heal

  References:
  - docs/turtle-wow-paladin-scaling-changes.md
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
-- HOLY
-- Daybreak (1.18.0): Reworked to 43% SP delayed heal
-- ============================================================================

-- Vanilla Baseline
local vanillaHoly = ApplyMultiplier({
  INT = 1.0,
  SPI = 0.28,
  STA = 0.1,
  AGI = 0.05,
  HEAL = 0.54,            -- Healing power
  SPELLCRIT = 3.68,       -- Healing crit
  SPELLHASTE = 3.1317,    -- Healing haste
  MANA = 0.009,
  MANAREG = 1.24,
  HEALTH = 0.01,
  HEALTHREG = 1.0,
  ARMOR = 0.005,
  DEFENSE = 0.075,
  DODGE = 0.472,
  PARRY = 0.472,
  BLOCK = 0.069,
  RESILIENCE = 0.2,
  FIRERES = 0.24,
  FROSTRES = 0.24,
  ARCANERES = 0.24,
  SHADOWRES = 0.24,
  NATURERES = 0.24,
})

-- Turtle WoW Adjustments for Holy
local turtleHoly = {}
for k, v in pairs(vanillaHoly) do
  turtleHoly[k] = v
end

-- Add Spell Damage (not in vanilla Holy weights)
turtleHoly.DMG = 0.3  -- Spell power for Holy Strike, Daybreak

-- 1. Spell Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 2. Healing Power slightly more valuable (Blessed Strikes healing scaling +25% healing power)
--    Conservative: +10% value
turtleHoly.HEAL = vanillaHoly.HEAL * 1.1  -- 0.54 → 0.594

-- 3. Spell Power more valuable (Holy Strike 43%, Daybreak 43%, Holy Shock 43%)
--    Conservative: +15% value (starting from new baseline of 0.3)
turtleHoly.DMG = turtleHoly.DMG * 1.15  -- 0.3 → 0.345

-- 4. Crit more valuable (Daybreak procs, Holy Shock resets via Blessed Strikes)
--    Conservative: +15% value
turtleHoly.SPELLCRIT = vanillaHoly.SPELLCRIT * 1.15  -- 3.68 → 4.23

-- 5. Spirit more valuable (Illumination nerf shifts mana sustain toward Spirit/mp5)
--    Conservative: +30% value
turtleHoly.SPI = vanillaHoly.SPI * 1.3  -- 0.28 → 0.36

-- 6. Add Hit for Judgements and Holy Strike uptime (hybrid healing style)
turtleHoly.SPELLTOHIT = 2.0 * DISPLAY_MULTIPLIER  -- Low but not zero
turtleHoly.TOHIT = 1.5 * DISPLAY_MULTIPLIER       -- Melee hit for Holy Strike

-- 7. Add CASTINGREG support (Meditation items in 1.16.0, HIGH value for Holy healers)
turtleHoly.CASTINGREG = 15.0  -- High value for Holy Paladin mana sustain


-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_Paladin_Holy", turtleHoly)
end)

-- ============================================================================
-- PROTECTION
-- Shield of the Righteous (Oct 2024): CD 3→5 min, DR 40%→30%
-- Redoubt (Nov 2024): Block chance HALVED
-- Righteous Strikes (Nov 2024): Reworked from block chance to block value
-- Holy Shield (Dec 2024): Block 50%→45%, SP 33%→15%
-- Reckoning (April 2025): Proc rate DOUBLED (5-25%→10-50%)
-- ============================================================================

-- Vanilla Baseline
local vanillaProtection = ApplyMultiplier({
  STR = 0.2,
  AGI = 0.6,
  STA = 1.0,
  INT = 0.5,
  SPI = 0.05,
  ATTACKPOWER = 0.06,
  TOHIT = 1.50069,        -- Pre-multiplied
  EXPERTISE = 0.27,       -- Expertise Rating (from ClassicHawsJon)
  CRIT = 1.275,
  HASTE = 4.015,
  ARMORPEN = 0.069,       -- Armor Penetration (from ClassicHawsJon: 0.09, divided by 1.3 for base)
  WEAPONDPS = 1.264,      -- Weapon DPS (from ClassicHawsJon: 1.77, divided by 1.4 for base)
  DMG = 0.44,             -- Spell damage
  HOLYDMG = 0.44,         -- Holy damage (same as generic)
  SPELLTOHIT = 6.24,      -- Spell hit (threat)
  SPELLCRIT = 4.8,
  SPELLHASTE = 0.9636,
  SPELLPEN = 0.03,
  MANA = 0.045,
  MANAREG = 1.0,
  HEALTH = 0.09,
  HEALTHREG = 2.0,
  ARMOR = 0.02,
  DEFENSE = 1.05,
  DODGE = 6.608,
  PARRY = 5.664,
  BLOCK = 4.14,           -- Block chance
  BLOCKVALUE = 0.15,      -- Block value
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

-- 1. Hit Cap Adjustment (Physical)
turtleProtection.TOHIT = vanillaProtection.TOHIT * 1.125  -- 1.50 → 1.69

-- 2. Spell Hit Cap Adjustment
turtleProtection.SPELLTOHIT = vanillaProtection.SPELLTOHIT * 1.125  -- 6.24 → 7.02

-- 3. Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 4. Spell Power MAJOR NERF (Holy Shield 33%→15% SP, Shield of the Righteous CD 3→5 min, DR 40%→30%)
--    Combined nerfs severely reduce spell damage value for Protection
turtleProtection.DMG = vanillaProtection.DMG * 0.5  -- 0.44 → 0.22
turtleProtection.HOLYDMG = vanillaProtection.HOLYDMG * 0.5  -- 0.44 → 0.22

-- 5. Block Value HIGHLY valuable (Righteous Strikes BV scaling)
--    Shield of the Righteous DR-nerf (40%→30%) reduces effectiveness slightly
turtleProtection.BLOCKVALUE = vanillaProtection.BLOCKVALUE * 1.45  -- 0.15 → 0.2175

-- 6. Stamina more valuable (Righteous Defense: -3-10% damage taken)
--    Conservative: +10% value
turtleProtection.STA = vanillaProtection.STA * 1.1  -- 1.0 → 1.1

-- 7. Block Chance: Reckoning DOUBLED but Redoubt HALVED, Righteous Strikes shifted to BV
--    Net effect: Slightly more valuable due to Reckoning, but gains offset by Redoubt nerf
turtleProtection.BLOCK = vanillaProtection.BLOCK * 1.1  -- 4.14 → 4.55

-- 10. Add CASTINGREG support (Meditation items in 1.16.0, medium value for Prot)
turtleProtection.CASTINGREG = 6.0  -- Medium value for Protection mana

-- 8. WEAPONDPS more valuable (Crusader Strike weapon damage + threat generation)
--    Conservative: +40% value
turtleProtection.WEAPONDPS = vanillaProtection.WEAPONDPS * 1.4  -- 1.264 → 1.77

-- 9. ARMORPEN more valuable (Armor Cap Removal 1.18.0)
--    Conservative: +30% value
turtleProtection.ARMORPEN = vanillaProtection.ARMORPEN * 1.3  -- 0.069 → 0.09


-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_Paladin_Protection", turtleProtection)
end)

-- ============================================================================
-- RETRIBUTION
-- Crusader Strike (Nov 2024): -10% weapon damage
-- Weapon Normalization (Dec 2024): Speed matters less, raw DPS critical
-- Seal of Righteousness (April 2025): 2H 0.098→0.128 (+31% buff!)
-- Judgement of Righteousness (April 2025): Now uses melee hit/crit
-- Crusader Strike (1.18.0): SP coefficient 33%→20%
-- Seal of Righteousness (1.18.0): 2H 0.128→0.125 (net +27% vs Dec 2024)
-- ============================================================================

-- Vanilla Baseline
local vanillaRetribution = ApplyMultiplier({
  STR = 1.0,
  AGI = 0.64,
  STA = 0.1,
  INT = 0.34,
  SPI = 0.05,
  ATTACKPOWER = 0.41,
  TOHIT = 7.87862,        -- Pre-multiplied
  EXPERTISE = 0.87,       -- Expertise Rating (from ClassicHawsJon)
  CRIT = 5.61,
  HASTE = 2.00750,
  ARMORPEN = 0.069,       -- Armor Penetration (from ClassicHawsJon: 0.09, divided by 1.3 for base)
  WEAPONDPS = 3.375,      -- Weapon DPS (from ClassicHawsJon: 5.4, divided by 1.6 for base)
  DMG = 0.33,             -- Spell damage
  HOLYDMG = 0.33,         -- Holy damage
  SPELLTOHIT = 1.68,
  SPELLCRIT = 0.96,
  SPELLHASTE = 0.3212,
  SPELLPEN = 0.015,
  MANA = 0.032,
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

-- Turtle WoW Adjustments for Retribution
local turtleRetribution = {}
for k, v in pairs(vanillaRetribution) do
  turtleRetribution[k] = v
end

-- 1. Hit Cap Adjustment
turtleRetribution.TOHIT = vanillaRetribution.TOHIT * 1.125  -- 7.88 → 8.86

-- 2. Spell Hit Cap Adjustment (hybrid spec)
turtleRetribution.SPELLTOHIT = vanillaRetribution.SPELLTOHIT * 1.125  -- 1.68 → 1.89

-- 3. Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 4. Spell Power BUFFED (Seal of Righteousness April 2025: +31%, then 1.18.0: -2.4% = net +27%)
--    Crusader Strike SP nerfed (33%→20%) but SoR buff outweighs it for 2H
--    Conservative: +35% value
turtleRetribution.DMG = vanillaRetribution.DMG * 1.35  -- 0.33 → 0.45
turtleRetribution.HOLYDMG = vanillaRetribution.HOLYDMG * 1.35  -- 0.33 → 0.45

-- 5. Strength more valuable (Holy Strike: +4-20% Strength buff for 20 seconds)
--    Conservative: +15% value
turtleRetribution.STR = vanillaRetribution.STR * 1.15  -- 1.0 → 1.15

-- 6. Haste more valuable (Zeal: 9-15% baked in, item haste multiplicative)
--    Conservative: +20% value
turtleRetribution.HASTE = turtleRetribution.HASTE * 1.2  -- 2.01 → 2.41

-- 7. Crit more valuable (Vengeance: 1-5% damage per stack, 3 max stacks)
--    Conservative: +15% value
turtleRetribution.CRIT = vanillaRetribution.CRIT * 1.15  -- 5.61 → 6.45
turtleRetribution.SPELLCRIT = vanillaRetribution.SPELLCRIT * 1.15  -- 0.96 → 1.10

-- 8. WEAPONDPS valuable (Crusader Strike -10% weapon damage Nov 2024, balanced with Weapon Normalization)
--    Net effect: +45% value (reduced from +60%)
turtleRetribution.WEAPONDPS = vanillaRetribution.WEAPONDPS * 1.45  -- 3.375 → 4.89

-- 9. ARMORPEN more valuable (Armor Cap Removal 1.18.0)
--    Conservative: +30% value
turtleRetribution.ARMORPEN = vanillaRetribution.ARMORPEN * 1.3  -- 0.069 → 0.09

-- 10. Add CASTINGREG support (Meditation items in 1.16.0, low-medium value for Ret)
turtleRetribution.CASTINGREG = 4.0  -- Low-medium value for Retribution mana


-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_Paladin_Retribution", turtleRetribution)
end)

