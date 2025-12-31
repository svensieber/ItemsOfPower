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

  References:
  - docs/turtle-wow-shaman-scaling-changes.md
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
-- ELEMENTAL
-- Fire Totems (1.18.0): Inherit spell crit and spell hit
-- Elemental Fury (1.18.0): +5/10% Fire/Nature damage, +50/100% crit damage
-- Molten Blast (1.18.0): 57.14% SP, refreshes Flame Shock
-- Earthquake (1.18.0): 60% SP, new AoE capstone
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

-- 5. Crit HIGHLY valuable (Elemental Fury: +50/100% crit damage, Fire totems inherit crit)
--    ×1.3 for Elemental Fury +50/100% crit damage + Fire Totem crit inheritance
turtleElemental.SPELLCRIT = vanillaElemental.SPELLCRIT * 1.3  -- 8.4 → 10.92

-- 6. Add CASTINGREG support (Meditation items in 1.16.0, medium-high value for Elemental)
--    Elemental is mana-hungry spec
turtleElemental.CASTINGREG = 7.0  -- Medium-high value for Elemental mana efficiency

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleElemental

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Shaman_Elemental", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Shaman_Elemental"] then
    ItemsOfPower:RegisterSet(set)
  else
  end
end)

-- ============================================================================
-- ENHANCEMENT
-- Windfury Weapon (Nov 2024): 20% proc, 0.5s ICD
-- Flurry (Dec 2024): 8/11/14/17/20% attack speed (buffed from 7-15%)
-- Ancestral Knowledge (Dec 2024): 1-5% TOTAL stats (from gear)
-- Lightning Strike (Dec 2024): Now procs Windfury, mana cost increased
-- Shock AP Scaling: Flame 14.5%, Earth/Frost 10%
-- Lightning Strike (April 2025): +5% spell power to Nature portion
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

-- 1. Hit Cap Adjustment (Physical): Windfury 20% proc means more hits = hit cap more important
--    ×1.15 for hit cap + Windfury synergy
turtleEnhancement.TOHIT = vanillaEnhancement.TOHIT * 1.15  -- 6.28 → 7.22

-- 2. Spell Hit Cap Adjustment (Hybrid)
turtleEnhancement.SPELLTOHIT = vanillaEnhancement.SPELLTOHIT * 1.125  -- 1.78 → 2.01

-- 3. Haste HIGHLY valuable (Flurry 8/11/14/17/20%, Windfury 20% proc + 0.5s ICD synergy)
--    ×1.25 for Flurry buff + Windfury synergy
turtleEnhancement.HASTE = vanillaEnhancement.HASTE * 1.25  -- 5.14 → 6.42

-- 4. Attack Power HIGHLY valuable (Flame Shock 14.5% AP, Earth/Frost Shock 10% AP, Lightning Strike)
--    ×1.5 for Shock AP scaling + Lightning Strike shield scaling
turtleEnhancement.ATTACKPOWER = vanillaEnhancement.ATTACKPOWER * 1.5  -- 0.5 → 0.75

-- 5. ALL STATS more valuable (Ancestral Knowledge: 1-5% total stats - CRITICAL!)
--    Conservative: +5% value (matches max rank)
turtleEnhancement.STR = vanillaEnhancement.STR * 1.05  -- 1.0 → 1.05
turtleEnhancement.AGI = vanillaEnhancement.AGI * 1.05  -- 0.87 → 0.91
turtleEnhancement.STA = vanillaEnhancement.STA * 1.05  -- 0.1 → 0.105
turtleEnhancement.INT = vanillaEnhancement.INT * 1.0   -- 0.34 → 0.34 (Stormstrike/Lightning Strike mana cost increased)
turtleEnhancement.SPI = vanillaEnhancement.SPI * 1.05  -- 0.05 → 0.0525

-- 6. Crit more valuable (Element's Grace: +2-10% instant spell crit for shocks)
--    Physical crit unchanged, Spell crit ×1.2 for Element's Grace
turtleEnhancement.CRIT = vanillaEnhancement.CRIT * 1.1  -- 8.33 → 9.16
turtleEnhancement.SPELLCRIT = vanillaEnhancement.SPELLCRIT * 1.2  -- 2.61 → 3.13

-- 7. WEAPONDPS HIGHLY valuable (Lightning Strike 60% Phys + 20% Nature weapon dmg, procs Windfury)
--    ×1.45 for Lightning Strike + Windfury proc synergy
turtleEnhancement.WEAPONDPS = vanillaEnhancement.WEAPONDPS * 1.45  -- 2.308 → 3.35

-- 8. ARMORPEN more valuable (Armor Cap Removal 1.18.0)
--    Conservative: +30% value
turtleEnhancement.ARMORPEN = vanillaEnhancement.ARMORPEN * 1.3  -- 0.346 → 0.45

-- 9. NATUREDMG more valuable (Lightning Strike: +5% spell power scaling April 2025)
--    Conservative: +15% value
turtleEnhancement.NATUREDMG = vanillaEnhancement.NATUREDMG * 1.15  -- 0.3 → 0.345


-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleEnhancement

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Shaman_Enhancement", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Shaman_Enhancement"] then
    ItemsOfPower:RegisterSet(set)
  else
  end
end)

-- ============================================================================
-- RESTORATION
-- Chain Heal (1.18.0): SP coefficient 71.42%→61.42% = 0.86× (NERF)
-- Improved Water Shield (Dec 2024): Changed to 3/6/9 mp5 + % per charge
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
--    ×1.15 for direct mp5 scaling with Improved Water Shield
turtleRestoration.MANAREG = vanillaRestoration.MANAREG * 1.15  -- 1.33 → 1.53

-- 5. Add CASTINGREG support (Meditation items in 1.16.0, HIGH value for Restoration)
--    Resto healers benefit greatly from combat mana regen
turtleRestoration.CASTINGREG = 14.0  -- High value for Restoration mana sustain

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleRestoration

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Shaman_Restoration", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Shaman_Restoration"] then
    ItemsOfPower:RegisterSet(set)
  else
  end
end)

