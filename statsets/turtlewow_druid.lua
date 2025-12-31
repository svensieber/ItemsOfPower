--[[
  Turtle WoW Druid StatSets

  Based on Vanilla ClassicHawsJon weights with Turtle WoW adjustments.

  Changes from Vanilla:
  - Hit Cap: 9% → 8% (all specs: +12.5% Hit Rating value)
  - Armor Cap (1.18.0): Removed, diminishing returns beyond 75%

  Balance Changes:
  - Eclipse (1.18.0): Crit scaling changed - damage bonus = 10% + (60% × crit %)
    At 35% crit = 31% bonus, NOT 120% like before

  Feral Cat Changes:
  - Tiger's Fury: Now generates 10 Energy every 3s (1.18.0)
  - Rip Duration: Scales 10-18s with combo points (1.18.0)
  - Ferocious Bite: Energy conversion now 0.5% damage per point (1.18.0)
  - Ancient Brutality (1.18.0): Energy from Bleed ticks 5/10 → 3/5 (nerf)
  - Open Wounds (1.18.0): Rip +5/10/15%, Claw +10/20/30% per Bleed (reworked)
  - Claw/Shred (April 2025): Only +5% damage, not +15%

  Feral Bear Changes:
  - Swipe AP (Oct/Dec 2024): 8%→6%→4% = 50% nerf to AP scaling
  - Ancient Brutality: Generates rage on dodge (1.17.2)
  - Feral Adrenaline: REMOVED in 1.18.0 (no longer reduces GCD)

  Restoration Changes:
  - Tree of Life Aura (1.17.0): Changed to healing power % multiplier
  - Gift of Nature (1.18.0): Now multiplicative with healing power
  - Emerald Blessing: 5% combat mana regen for raid
  - Tree of Life: +180% armor from items (1.18.0)

  References:
  - docs/turtle-wow-druid-scaling-changes.md
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
-- BALANCE
-- ============================================================================

-- Vanilla Baseline
local vanillaBalance = ApplyMultiplier({
  INT = 0.38,
  SPI = 0.34,
  STA = 0.1,
  AGI = 0.05,
  DMG = 1.0,              -- Generic spell damage
  NATUREDMG = 0.43,       -- Nature damage
  ARCANEDMG = 0.64,       -- Arcane damage
  SPELLTOHIT = 9.68,      -- Pre-multiplied
  SPELLCRIT = 4.96,       -- Spell crit
  SPELLHASTE = 6.424,     -- Spell haste
  SPELLPEN = 0.21,
  MANA = 0.032,
  MANAREG = 0.58,
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

-- Turtle WoW Adjustments for Balance
local turtleBalance = {}
for k, v in pairs(vanillaBalance) do
  turtleBalance[k] = v
end

-- 1. Spell Hit Cap Adjustment: 9% → 8% (+12.5%)
turtleBalance.SPELLTOHIT = vanillaBalance.SPELLTOHIT * 1.125  -- 9.68 → 10.89

-- 2. Spell Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 3. Spell Crit EXTREMELY valuable (Eclipse 1.18.0: Damage = 10% + 60% of crit %)
--    At 35% crit = 31% permanent damage bonus (vs old 25% proc-based buff)
--    Crit now scales the Eclipse bonus itself, making it multiplicative
turtleBalance.SPELLCRIT = vanillaBalance.SPELLCRIT * 1.65  -- 4.96 → 8.18

-- 7. Add CASTINGREG support (Meditation items in 1.16.0, moderate value for casters)
turtleBalance.CASTINGREG = 5.0  -- Medium value for Balance mana efficiency

-- 4. Spell Power more valuable (Wrath +5%, Hurricane improved, Eclipse amplifies)
--    Conservative: +15% value
turtleBalance.DMG = vanillaBalance.DMG * 1.15  -- 1.0 → 1.15

-- 5. Nature Damage more valuable (Wrath/Moonfire/Starfire scaling + Eclipse)
--    Conservative: +20% value (Nature Eclipse benefits)
turtleBalance.NATUREDMG = vanillaBalance.NATUREDMG * 1.2  -- 0.43 → 0.516

-- 6. Arcane Damage more valuable (Starfire scaling + Eclipse)
--    Conservative: +20% value (Arcane Eclipse benefits)
turtleBalance.ARCANEDMG = vanillaBalance.ARCANEDMG * 1.2  -- 0.64 → 0.768


-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleBalance

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Druid_Balance", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Druid_Balance"] then
    ItemsOfPower:RegisterSet(set)
  else
  end
end)

-- ============================================================================
-- FERAL DAMAGE (Cat)
-- ============================================================================

-- Vanilla Baseline
local vanillaFeralDamage = ApplyMultiplier({
  STR = 1.48,
  AGI = 1.0,
  STA = 0.1,
  INT = 0.1,
  SPI = 0.05,
  ATTACKPOWER = 0.59,
  ATTACKPOWERFERAL = 0.59,
  TOHIT = 5.72138,        -- Pre-multiplied
  EXPERTISE = 0.61,       -- Expertise Rating (from ClassicHawsJon)
  CRIT = 5.015,           -- Physical crit
  HASTE = 3.4529,         -- Physical haste
  ARMORPEN = 1.154,       -- Armor Penetration (3.75 * 0.4 = 1.5, divided by 1.3 for base)
  WEAPONDPS = 0.87,       -- Melee Weapon DPS (estimated baseline: 1.0, divided by 1.15 for base)
  HEAL = 0.025,           -- Minor healing (for hybrid)
  MANA = 0.009,
  MANAREG = 0.3,
  HEALTH = 0.01,
  HEALTHREG = 1.0,
  ARMOR = 0.02,
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

-- Turtle WoW Adjustments for Feral Damage
local turtleFeralDamage = {}
for k, v in pairs(vanillaFeralDamage) do
  turtleFeralDamage[k] = v
end

-- 1. Hit Cap Adjustment (Physical)
turtleFeralDamage.TOHIT = vanillaFeralDamage.TOHIT * 1.125  -- 5.72 → 6.44

-- 2. Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 3. Attack Power more valuable (Ferocious Bite 0.5%/energy, Rip +50% at 5CP)
--    Conservative: +35% value
turtleFeralDamage.ATTACKPOWER = vanillaFeralDamage.ATTACKPOWER * 1.35  -- 0.59 → 0.797
turtleFeralDamage.ATTACKPOWERFERAL = vanillaFeralDamage.ATTACKPOWERFERAL * 1.35

-- 4. Agility more valuable (MCP removed, relative stat value up + AP/Crit/Dodge)
--    Conservative: +10% value
turtleFeralDamage.AGI = vanillaFeralDamage.AGI * 1.1  -- 1.0 → 1.1

-- 5. Strength more valuable (MCP removed, AP scaling)
--    Conservative: +10% value
turtleFeralDamage.STR = vanillaFeralDamage.STR * 1.1  -- 1.48 → 1.628

-- 6. Crit more valuable (Primal Fury, Open Wounds synergies)
--    Conservative: +10% value
turtleFeralDamage.CRIT = vanillaFeralDamage.CRIT * 1.1  -- 5.015 → 5.517

-- 7. WEAPONDPS slightly more valuable (Claw/Shred only +5% in April 2025, not +15%)
--    Conservative: +8% value (reduced from +15%, AP dominates)
turtleFeralDamage.WEAPONDPS = vanillaFeralDamage.WEAPONDPS * 1.08  -- 0.87 → 0.94

-- 8. ARMORPEN more valuable (Armor Cap Removal 1.18.0)
--    Conservative: +30% value
turtleFeralDamage.ARMORPEN = vanillaFeralDamage.ARMORPEN * 1.3  -- 1.154 → 1.5


-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleFeralDamage

local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Druid_Feral_Damage", stats)



if not ItemsOfPower.SetByName["TurtleWoW_Druid_Feral_Damage"] then
    ItemsOfPower:RegisterSet(set)
  else
  end
end)

-- ============================================================================
-- FERAL TANK (Bear)
-- ============================================================================

-- Vanilla Baseline
local vanillaFeralTank = ApplyMultiplier({
  STR = 0.2,
  AGI = 0.48,
  STA = 1.0,
  INT = 0.1,
  SPI = 0.05,
  ATTACKPOWER = 0.34,
  ATTACKPOWERFERAL = 0.34,
  TOHIT = 1.50069,        -- Pre-multiplied
  EXPERTISE = 0.18,       -- Expertise Rating (from ClassicHawsJon)
  CRIT = 1.275,
  HASTE = 2.4893,
  ARMORPEN = 0.577,       -- Armor Penetration (3.75 * 0.2 = 0.75, divided by 1.3 for base)
  WEAPONDPS = 0.52,       -- Melee Weapon DPS (estimated baseline: 0.6, divided by 1.15 for base)
  HEAL = 0.025,           -- Minor healing
  NATUREDMG = 0.025,      -- Minor spell damage
  MANA = 0.009,
  MANAREG = 0.3,
  HEALTH = 0.08,
  HEALTHREG = 2.0,
  ARMOR = 0.1,
  DEFENSE = 0.39,
  DODGE = 3.5872,
  RESILIENCE = 0.2,
  FIRERES = 1.2,
  FROSTRES = 1.2,
  ARCANERES = 1.2,
  SHADOWRES = 1.2,
  NATURERES = 1.2,
})

-- Turtle WoW Adjustments for Feral Tank
local turtleFeralTank = {}
for k, v in pairs(vanillaFeralTank) do
  turtleFeralTank[k] = v
end

-- 1. Hit Cap Adjustment (Physical)
turtleFeralTank.TOHIT = vanillaFeralTank.TOHIT * 1.125  -- 1.50 → 1.69

-- 2. Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 3. Armor HIGHLY valuable (cap removed! Continues beyond 75% + Thick Hide)
--    Conservative: +40% value (massive change from vanilla hard cap)
turtleFeralTank.ARMOR = vanillaFeralTank.ARMOR * 1.4  -- 0.1 → 0.14

-- 4. Stamina more valuable (Frenzied Regeneration: 6/7/8% of stamina per rage point)
--    Conservative: +15% value
turtleFeralTank.STA = vanillaFeralTank.STA * 1.15  -- 1.0 → 1.15

-- 5. Dodge HIGHLY valuable (Ancient Brutality: rage on dodge, Feral Swiftness +4%)
--    Conservative: +30% value
turtleFeralTank.DODGE = vanillaFeralTank.DODGE * 1.3  -- 3.5872 → 4.66

-- 6. Attack Power REDUCED (Swipe nerfed 8%→4% = 50% AP value reduction for main AoE!)
--    Conservative: -10% value (Swipe nerf dominates, Maul/Savage Bite still scale)
turtleFeralTank.ATTACKPOWER = vanillaFeralTank.ATTACKPOWER * 0.9  -- 0.34 → 0.306
turtleFeralTank.ATTACKPOWERFERAL = vanillaFeralTank.ATTACKPOWERFERAL * 0.9

-- 7. Agility more valuable (Dodge scaling + AP)
--    Conservative: +10% value
turtleFeralTank.AGI = vanillaFeralTank.AGI * 1.1  -- 0.48 → 0.528

-- 7a. Haste: Feral Adrenaline was REMOVED in 1.18.0, no special haste bonus
--     Using vanilla baseline (no multiplier)

-- 7b. Hit more valuable (Threat consistency critical after Swipe nerfs)
--     Conservative: +20% value
turtleFeralTank.TOHIT = turtleFeralTank.TOHIT * 1.2  -- 1.50 → 1.80

-- 8. WEAPONDPS more valuable (Savage Bite 80% weapon damage, Maul weapon damage)
--    Conservative: +15% value (lower priority than Cat, but still relevant)
turtleFeralTank.WEAPONDPS = vanillaFeralTank.WEAPONDPS * 1.15  -- 0.52 → 0.6

-- 9. ARMORPEN more valuable (Armor Cap Removal 1.18.0)
--    Conservative: +30% value
turtleFeralTank.ARMORPEN = vanillaFeralTank.ARMORPEN * 1.3  -- 0.577 → 0.75


-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleFeralTank

local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Druid_Feral_Tank", stats)



if not ItemsOfPower.SetByName["TurtleWoW_Druid_Feral_Tank"] then
    ItemsOfPower:RegisterSet(set)
  else
  end
end)

-- ============================================================================
-- RESTORATION
-- ============================================================================

-- Vanilla Baseline
local vanillaRestoration = ApplyMultiplier({
  INT = 1.0,
  SPI = 0.87,             -- High spirit value
  STA = 0.1,
  AGI = 0.05,
  HEAL = 1.21,            -- Healing power
  SPELLCRIT = 2.8,        -- Healing crit
  SPELLHASTE = 3.9347,    -- Healing haste
  MANA = 0.09,
  MANAREG = 1.7,
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

-- Turtle WoW Adjustments for Restoration
local turtleRestoration = {}
for k, v in pairs(vanillaRestoration) do
  turtleRestoration[k] = v
end

-- 1. Spell Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 2. Healing Power HIGHLY valuable (Tree of Life Aura + Gift of Nature - DOUBLE MULTIPLICATIVE)
--    - Tree of Life Aura (1.17.0): Changed from flat heal to healing power % multiplier
--    - Gift of Nature (1.18.0): Now increases total healing (multiplicative with healing power)
--    Conservative: +50% value (massive double-scaling change)
turtleRestoration.HEAL = vanillaRestoration.HEAL * 1.5  -- 1.21 → 1.815

-- 3. Spirit more valuable (Emerald Blessing: 5% combat mana regen for raid in 1.17.0)
--    Conservative: +20% value
turtleRestoration.SPI = vanillaRestoration.SPI * 1.2  -- 0.87 → 1.044

-- 4. Armor more valuable (Tree of Life: +180% armor from items in 1.18.0)
--    MAJOR: +80% value (Tree of Life multiplies armor by 2.8x, massive scaling)
turtleRestoration.ARMOR = vanillaRestoration.ARMOR * 1.8  -- 0.005 → 0.009

-- 5. Add CASTINGREG support (Meditation items in 1.16.0, HIGH value for healers)
--    Sustained healing requires mana regen during combat
turtleRestoration.CASTINGREG = 17.0  -- High value for Resto mana sustain

-- 6. Add SPELLHASTE for faster healing (not in vanilla baseline)
turtleRestoration.SPELLHASTE = vanillaRestoration.SPELLHASTE * 1.1  -- Slight boost for HoT tick speed


-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleRestoration

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Druid_Restoration", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Druid_Restoration"] then
    ItemsOfPower:RegisterSet(set)
  else
  end
end)

