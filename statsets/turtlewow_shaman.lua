--[[
  Turtle WoW Shaman StatSets

  Based on Vanilla ClassicHawsJon weights with Turtle WoW adjustments.

  Changes from Vanilla:
  - Hit Cap: 9% → 8% (all specs: +12.5% Hit Rating value)
  - Haste: Baseline adjustments
  - Elemental: Spell Power more valuable (Molten Blast, Earthquake)
  - Elemental: Crit more valuable (Elemental Fury +100% crit damage)
  - Elemental: Fire totems inherit crit/hit
  - Enhancement: Attack Power more valuable (Shock AP scaling)
  - Enhancement: ALL STATS more valuable (Ancestral Knowledge 1-5% total stats)
  - Enhancement: Crit more valuable (Element's Grace)
  - Restoration: Healing Power LESS valuable (Chain Heal nerf)
  - Restoration: Spirit HIGHLY valuable (Improved Water Shield)

  Turtle WoW Hotfixes & 1.18.0 Changes:
  - Fire Totems (1.18.0): Now inherit shaman's spell crit and spell hit
  - Elemental Fury (1.18.0): +5/10% Fire/Nature damage, +50/100% crit damage
  - Molten Blast (1.18.0): 57.14% SP, refreshes Flame Shock
  - Earthquake (1.18.0): 60% SP, new AoE capstone
  - Windfury Weapon (Nov 2024): 20% proc, 0.5s ICD, can proc from Lightning Strike
  - Flurry (Dec 2024): 8/11/14/17/20% attack speed (buffed from 7-15%)
  - Ancestral Knowledge (Dec 2024): 1-5% TOTAL stats (from gear)
  - Lightning Strike (Dec 2024): Now procs Windfury, mana cost increased
  - Stormstrike (Dec 2024): Mana cost increased
  - Shock AP Scaling: Flame 14.5%, Earth/Frost 10%
  - Lightning Strike (April 2025): +5% spell power to Nature portion
  - Chain Heal (1.18.0): SP coefficient 71.42%→61.42% = 0.86× (NERF)
  - Rockbiter Weapon (1.18.0): 30%→35% threat
  - Improved Water Shield (Dec 2024): Changed to 3/6/9 mp5 + % per charge
  - Calming Winds (Aug 2025): 5/10/15%→8/16/25% threat reduction
  - Improved Fire Totems (Aug 2025): +5/10 yards Searing Totem range
  - Ancestral Swiftness (Aug 2025): Damage spells 25% reduced effectiveness

  Patch 1.18.1 Changes:
  Enhancement:
  - Windfury Weapon: Proc chance 20%→25% (+25% more procs = more AP value)
  - Stormstrike: Can no longer proc Windfury twice (nerf)
  - Elemental Weapons rework:
    - Windfury: +1% attack speed per extra attack, stacks 2/4/6 times (HASTE synergy)
    - Flametongue: +10/20/30% Fire damage for 5s on hit (temporary, requires melee)
    - Rockbiter: Now absorb shield (20% physical dealt, 5/10/15% absorb, max 20% HP)
  - Flurry: Now 3 swings after crit (charge-based, CRIT value for uptime)
  - Lightning Strike: Water Shield AP-to-Mana 20:1→18:1 (ATTACKPOWER more efficient)
  Elemental:
  - Elemental Fury: Now also affects Frost spells (FROSTDMG valuable if specced)
  - Earthquake: +15% damage, CD 20s→18s (AoE SP scaling improved)
  - Call of Earth (new): Earth Shield +1/2 charges, +35/70% pushback resistance
  General:
  - Lightning Shield: Mana cost -25% (less MP5 needed for Shield uptime)

  References:
  - docs/turtle-wow-shaman-scaling-changes.md
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
-- ELEMENTAL
-- Fire Totems (1.18.0): Inherit spell crit and spell hit
-- Elemental Fury (1.18.0): +5/10% Fire/Nature damage, +50/100% crit damage
-- Molten Blast (1.18.0): 57.14% SP, refreshes Flame Shock
-- Earthquake (1.18.0): 60% SP, new AoE capstone
-- 1.18.1: Elemental Fury now also affects Frost spells (FROSTDMG valuable)
-- 1.18.1: Earthquake +15% damage, CD 20s→18s (improved AoE SP scaling)
-- 1.18.1: Lightning Shield mana cost -25% (less MP5 pressure)
-- ============================================================================

-- Vanilla Baseline
local vanillaElemental = ApplyMultiplier({
  INT = 0.31,
  SPI = 0.09,
  STA = 0.1,
  AGI = 0.05,
  DMG = 1.0,              -- Generic spell damage
  NATUREDMG = 1.0,        -- Nature damage (same as generic)
  SPELLTOHIT = 7.2,       -- Pre-multiplied
  SPELLCRIT = 8.4,        -- 8.0 * 1.05 (high crit weight!)
  SPELLHASTE = 7.227,     -- 8.03 * 0.9
  SPELLPEN = 0.38,
  MANA = 0.024,
  MANAREG = 1.14,
  HEALTH = 0.01,
  HEALTHREG = 1.0,
  ARMOR = 0.005,
  DEFENSE = 0.075,
  DODGE = 0.472,
  PARRY = 1.1328,
  BLOCK = 0.069,
  RESILIENCE = 0.2,
  FIRERES = 0.24,
  FROSTRES = 0.24,
  ARCANERES = 0.24,
  SHADOWRES = 0.24,
  NATURERES = 0.24,
})

-- Turtle WoW Adjustments for Elemental
local turtleElemental = {}
for k, v in pairs(vanillaElemental) do
  turtleElemental[k] = v
end

-- 1. Spell Hit Cap Adjustment: 9% → 8% (+12.5%), Fire Totems inherit hit (1.18.0)
--    1.125 base * 1.2 for Fire Totem inheritance = 1.2 total
turtleElemental.SPELLTOHIT = vanillaElemental.SPELLTOHIT * 1.2  -- 7.2 → 8.64

-- 2. Spell Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 3. Spell Power more valuable (Molten Blast 57.14%, Earthquake 60%)
--    Conservative: +15% value
turtleElemental.DMG = vanillaElemental.DMG * 1.15  -- 1.0 → 1.15

-- 4. FIREDMG added (Fire Totems inherit crit/hit 1.18.0, Molten Blast 57.14%, Elemental Fury +10%)
--    Fire damage now significant in Elemental rotation
turtleElemental.FIREDMG = 0.75 * DISPLAY_MULTIPLIER  -- New stat for 1.18.0 Fire scaling

-- 5. FROSTDMG added (1.18.1: Elemental Fury now affects Frost spells)
--    Frost damage valuable if specced into Elemental Fury
turtleElemental.FROSTDMG = 0.6 * DISPLAY_MULTIPLIER  -- New stat for 1.18.1 Frost scaling

-- 6. Crit HIGHLY valuable (Elemental Fury: +50/100% crit damage, Fire totems inherit crit)
--    ×1.3 for Elemental Fury +50/100% crit damage + Fire Totem crit inheritance
turtleElemental.SPELLCRIT = vanillaElemental.SPELLCRIT * 1.3  -- 8.4 → 10.92

-- 7. Spell Power more valuable (1.18.1: Earthquake +15% damage, CD reduction)
--    Increase DMG multiplier from 1.15 to 1.2 for improved AoE scaling
turtleElemental.DMG = vanillaElemental.DMG * 1.2  -- 1.0 → 1.2 (was 1.15)

-- 8. Add CASTINGREG support (Meditation items in 1.16.0, medium-high value for Elemental)
--    Elemental is mana-hungry spec
--    1.18.1: Lightning Shield -25% mana cost reduces MP5 pressure slightly
turtleElemental.CASTINGREG = 6.5  -- Slightly reduced from 7.0 due to Lightning Shield cost reduction

-- 9. MANAREG slightly less valuable (1.18.1: Lightning Shield -25% mana cost)
--    Reduce MANAREG multiplier slightly
turtleElemental.MANAREG = vanillaElemental.MANAREG * 0.95  -- 1.14 → 1.08

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_Shaman_Elemental", turtleElemental)
end)

-- ============================================================================
-- ENHANCEMENT
-- Windfury Weapon (Nov 2024): 20% proc, 0.5s ICD
-- Flurry (Dec 2024): 8/11/14/17/20% attack speed (buffed from 7-15%)
-- Ancestral Knowledge (Dec 2024): 1-5% TOTAL stats (from gear)
-- Lightning Strike (Dec 2024): Now procs Windfury, mana cost increased
-- Shock AP Scaling: Flame 14.5%, Earth/Frost 10%
-- Lightning Strike (April 2025): +5% spell power to Nature portion
-- 1.18.1: Windfury Weapon 20%→25% proc (+25% more procs, AP value up)
-- 1.18.1: Stormstrike can no longer proc Windfury twice (nerf)
-- 1.18.1: Elemental Weapons rework (Windfury +attack speed stacking, HASTE synergy)
-- 1.18.1: Flurry now 3 swings after crit (charge-based, CRIT for uptime)
-- 1.18.1: Lightning Strike AP-to-Mana 20:1→18:1 (AP more mana efficient)
-- 1.18.1: Rockbiter now absorb shield (tanking, AP becomes defensive)
-- ============================================================================

-- Vanilla Baseline
local vanillaEnhancement = ApplyMultiplier({
  STR = 1.0,
  AGI = 0.87,
  STA = 0.1,
  INT = 0.34,
  SPI = 0.05,
  ATTACKPOWER = 0.5,
  TOHIT = 6.28414,        -- Pre-multiplied
  EXPERTISE = 1.5,        -- Expertise Rating (from ClassicHawsJon)
  CRIT = 8.33,            -- Physical crit
  HASTE = 5.1392,         -- Physical haste
  ARMORPEN = 0.346,       -- Armor Penetration (3.75 * 0.12 = 0.45, divided by 1.3 for base)
  WEAPONDPS = 2.308,      -- Weapon DPS (from ClassicHawsJon: 3, divided by 1.3 for base)
  DMG = 0.3,              -- Spell damage (hybrid value)
  NATUREDMG = 0.3,        -- Nature damage
  SPELLTOHIT = 1.784,     -- Spell hit (hybrid)
  SPELLCRIT = 2.608,      -- Spell crit (hybrid)
  SPELLHASTE = 0.6424,    -- Spell haste (hybrid)
  SPELLPEN = 0.11,
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

-- Turtle WoW Adjustments for Enhancement
local turtleEnhancement = {}
for k, v in pairs(vanillaEnhancement) do
  turtleEnhancement[k] = v
end

-- 1. Hit Cap Adjustment (Physical): Windfury 25% proc (1.18.1) means more hits = hit cap more important
--    ×1.2 for hit cap + Windfury 25% proc synergy (increased from 1.15)
turtleEnhancement.TOHIT = vanillaEnhancement.TOHIT * 1.2  -- 6.28 → 7.54

-- 2. Spell Hit Cap Adjustment (Hybrid)
turtleEnhancement.SPELLTOHIT = vanillaEnhancement.SPELLTOHIT * 1.125  -- 1.78 → 2.01

-- 3. Haste HIGHLY valuable (Flurry charge-based 1.18.1, Windfury +attack speed stacking)
--    ×1.35 for Flurry charge system + Windfury Elemental Weapons attack speed stacking
turtleEnhancement.HASTE = vanillaEnhancement.HASTE * 1.35  -- 5.14 → 6.94

-- 4. Attack Power HIGHLY valuable (Flame Shock 14.5% AP, Earth/Frost Shock 10% AP, Lightning Strike)
--    1.18.1: Windfury 25% proc (+25%), Lightning Strike AP-to-Mana 20:1→18:1 (+11%)
--    ×1.7 for Shock AP scaling + improved Windfury + better mana efficiency
turtleEnhancement.ATTACKPOWER = vanillaEnhancement.ATTACKPOWER * 1.7  -- 0.5 → 0.85

-- 5. ALL STATS more valuable (Ancestral Knowledge: 1-5% total stats - CRITICAL!)
--    Conservative: +5% value (matches max rank)
turtleEnhancement.STR = vanillaEnhancement.STR * 1.05  -- 1.0 → 1.05
turtleEnhancement.AGI = vanillaEnhancement.AGI * 1.05  -- 0.87 → 0.91
turtleEnhancement.STA = vanillaEnhancement.STA * 1.05  -- 0.1 → 0.105
turtleEnhancement.INT = vanillaEnhancement.INT * 1.0   -- 0.34 → 0.34 (Stormstrike/Lightning Strike mana cost increased)
turtleEnhancement.SPI = vanillaEnhancement.SPI * 1.05  -- 0.05 → 0.0525

-- 6. Crit more valuable (Element's Grace: +2-10% instant spell crit for shocks)
--    1.18.1: Flurry now charge-based (3 swings after crit) - crit maintains uptime
--    Physical crit ×1.2 for Flurry charge uptime, Spell crit ×1.2 for Element's Grace
turtleEnhancement.CRIT = vanillaEnhancement.CRIT * 1.2  -- 8.33 → 10.0
turtleEnhancement.SPELLCRIT = vanillaEnhancement.SPELLCRIT * 1.2  -- 2.61 → 3.13

-- 7. WEAPONDPS HIGHLY valuable (Lightning Strike 60% Phys + 20% Nature weapon dmg, procs Windfury)
--    1.18.1: Windfury 25% proc rate, Stormstrike can't double-proc (mixed)
--    ×1.5 for improved Windfury proc rate
turtleEnhancement.WEAPONDPS = vanillaEnhancement.WEAPONDPS * 1.5  -- 2.308 → 3.46

-- 8. ARMORPEN more valuable (Armor Cap Removal 1.18.0)
--    Conservative: +30% value
turtleEnhancement.ARMORPEN = vanillaEnhancement.ARMORPEN * 1.3  -- 0.346 → 0.45

-- 9. NATUREDMG more valuable (Lightning Strike: +5% spell power scaling April 2025)
--    Conservative: +15% value
turtleEnhancement.NATUREDMG = vanillaEnhancement.NATUREDMG * 1.15  -- 0.3 → 0.345

-- 10. FIREDMG added (1.18.1: Flametongue Elemental Weapons +10/20/30% Fire for 5s)
--     Temporary buff requires melee engagement, moderate value
turtleEnhancement.FIREDMG = 0.25 * DISPLAY_MULTIPLIER  -- New for 1.18.1 Flametongue rework

-- NOTE: Rockbiter rework (1.18.1) creates absorb shield from AP damage dealt.
-- This makes ATTACKPOWER partially defensive for Rockbiter users (tanking/offtank).
-- Consider a separate "Enhancement Tank" set for Rockbiter-focused builds.


-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_Shaman_Enhancement", turtleEnhancement)
end)

-- ============================================================================
-- RESTORATION
-- Chain Heal (1.18.0): SP coefficient 71.42%→61.42% = 0.86× (NERF)
-- Improved Water Shield (Dec 2024): Changed to 3/6/9 mp5 + % per charge
-- 1.18.1: Lightning Shield -25% mana cost (less MP5 needed for Shield uptime)
-- 1.18.1: Call of Earth (new) - Earth Shield +1/2 charges, +35/70% pushback resist
-- ============================================================================

-- Vanilla Baseline
local vanillaRestoration = ApplyMultiplier({
  INT = 1.0,
  SPI = 0.61,             -- Higher than other specs (mana regen)
  STA = 0.1,
  AGI = 0.05,
  HEAL = 0.9,             -- Healing power
  SPELLTOHIT = 0,         -- No hit needed for healing (but has value in docs)
  SPELLCRIT = 3.84,       -- Healing crit
  SPELLHASTE = 5.9422,    -- Healing haste
  MANA = 0.009,
  MANAREG = 1.33,
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

-- Turtle WoW Adjustments for Restoration
local turtleRestoration = {}
for k, v in pairs(vanillaRestoration) do
  turtleRestoration[k] = v
end

-- 1. Spell Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 2. Healing Power LESS valuable (Chain Heal nerf: 71.42% → 61.42% coefficient - CRITICAL)
--    ×0.86 precisely calculated: 61.42/71.42 = 0.86
turtleRestoration.HEAL = vanillaRestoration.HEAL * 0.86  -- 0.9 → 0.774

-- 3. Spirit less valuable (Improved Water Shield changed to mp5 system - less Spirit-dependent)
--    ×1.2 instead of previous 1.5 - mp5 system is more direct mana regen
turtleRestoration.SPI = vanillaRestoration.SPI * 1.2  -- 0.61 → 0.732

-- 4. MANAREG more valuable (Water Shield mp5 system more valuable)
--    1.18.1: Lightning Shield -25% mana cost reduces overall MP5 pressure slightly
--    ×1.1 for direct mp5 scaling with Improved Water Shield (reduced from 1.15)
turtleRestoration.MANAREG = vanillaRestoration.MANAREG * 1.1  -- 1.33 → 1.46

-- 5. Add CASTINGREG support (Meditation items in 1.16.0, HIGH value for Restoration)
--    Resto healers benefit greatly from combat mana regen
--    1.18.1: Lightning Shield -25% mana cost slightly reduces CASTINGREG value
turtleRestoration.CASTINGREG = 13.0  -- Slightly reduced from 14.0 due to Lightning Shield cost reduction

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_Shaman_Restoration", turtleRestoration)
end)

