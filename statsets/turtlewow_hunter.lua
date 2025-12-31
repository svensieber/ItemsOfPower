--[[
  Turtle WoW Hunter StatSets

  Based on Vanilla ClassicHawsJon weights with Turtle WoW adjustments.

  Changes from Vanilla:
  - Hit Cap: 9% → 8% (all specs: +12.5% Hit Rating value)
  - Haste: Baseline adjustments
  - Beast Mastery: Stamina/Armor more valuable (pet scaling)
  - Beast Mastery: Crit more valuable (Kill Command, Baited Shot)
  - Marksmanship: Ranged Crit more valuable (Piercing Shots bleed)
  - Survival: MAJOR REWORK - Now primarily melee spec with Dual Wield

  Beast Mastery Turtle WoW Changes:
  - Spirit Bond (2pt): 25% RAP → pet Melee AP, 15% RAP → pet Spell Power
  - Bestial Precision (2pt): +4/8% phys hit, +9/18% spell hit, +5/10 weapon skill → pet
  - Endurance Training: +30% STA → pet
  - Kill Command + Baited Shot (1.18.0): Pet crit-focused rotation
  - Bestial Wrath: REMOVED in 1.18.0
  - Bestial Swiftness: REMOVED in 1.18.0

  Marksmanship Turtle WoW Changes:
  - Piercing Shots: Crit applies bleed for 15/30% damage (1.17.2)
  - Trueshot Aura: Now 55 + 5% of recipient's AP (1.17.2)

  Survival Turtle WoW Changes (MAJOR REWORK - Melee Spec):
  - Mongoose Bite Dual Wield (1.18.0): Strikes with BOTH weapons
  - Savage Strikes: +13/25% offhand weapon damage (April 2025)
  - Vicious Strikes: +5/10% weapon damage (Aug 2025, nerfed from +10/20%)
  - Lightning Reflexes: 100% Agi → Melee AP at rank 5
  - Lacerate: 35% AP + bleed for 20% damage (1.18.0)
  - Untamed Trapper: Fire traps scale with melee AP (1.17.2)
  - Rapid Strikes: REMOVED in 1.18.0 (effect moved to baseline Rapid Fire)

  References:
  - docs/turtle-wow-hunter-scaling-changes.md
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
-- MARKSMANSHIP
-- ============================================================================

-- Vanilla Baseline
local vanillaMM = ApplyMultiplier({
  STR = 0.05,
  AGI = 1.0,
  STA = 0.1,
  INT = 0.35,  -- Cast-intensive spec (Steady/Aimed/Multi) needs larger mana buffer
  SPI = 0.05,
  ATTACKPOWER = 0.55,
  RANGEDATTACKPOWER = 0.55,
  TOHIT = 9.37931,        -- Pre-multiplied
  EXPERTISE = 0.05,       -- Expertise Rating (very low for ranged)
  CRIT = 5.1,             -- 8.5 * 0.6
  HASTE = 3.212,          -- 8.03 * 0.4
  ARMORPEN = 1.067,       -- Armor Penetration (3.75 * 0.37 = 1.3875, divided by 1.3 for base)
  RANGEDWEAPONDPS = 2.167,  -- Ranged Weapon DPS (from ClassicHawsJon: 2.6, divided by 1.2 for base)
  -- WEAPONDPS not included - melee weapon is only a stat stick for ranged specs
  MANA = 0.085,
  MANAREG = 2.4,
  HEALTH = 0.01,
  HEALTHREG = 1.0,
  ARMOR = 0.005,
  DEFENSE = 0.075,        -- 1.5 * 0.05
  DODGE = 0.472,          -- 9.44 * 0.05
  PARRY = 0.472,
  RESILIENCE = 0.2,
  FIRERES = 0.24,         -- 0.04 + 0.2 (AllResist distributed)
  FROSTRES = 0.24,
  ARCANERES = 0.24,
  SHADOWRES = 0.24,
  NATURERES = 0.24,
})

-- Turtle WoW Adjustments for Marksmanship
local turtleMM = {}
for k, v in pairs(vanillaMM) do
  turtleMM[k] = v
end

-- 1. Hit Cap Adjustment: 9% → 8% (+12.5%)
turtleMM.TOHIT = vanillaMM.TOHIT * 1.125  -- 9.38 → 10.55

-- 2. Haste Baseline Check (ensure minimum 65% of Crit for ranged DPS)
-- Haste baseline check removed (vanilla values are correct)

-- 3. RANGEDWEAPONDPS more valuable (Steady Shot 100% weapon dmg main rotation)
--    Conservative: +20% value
turtleMM.RANGEDWEAPONDPS = vanillaMM.RANGEDWEAPONDPS * 1.2  -- 2.167 → 2.6

-- 4. ARMORPEN more valuable (Armor Cap Removal 1.18.0)
--    Conservative: +30% value
turtleMM.ARMORPEN = vanillaMM.ARMORPEN * 1.3  -- 1.067 → 1.3875

-- 5. RANGEDCRIT more valuable (Piercing Shots: crit applies bleed for 15/30% damage)
--    Increased from ×1.15 to ×1.25
turtleMM.RANGEDCRIT = vanillaMM.CRIT * 1.25  -- Use CRIT as base, apply ×1.25

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleMM
  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Hunter_Marksmanship", stats)

  if not ItemsOfPower.SetByName["TurtleWoW_Hunter_Marksmanship"] then
    ItemsOfPower:RegisterSet(set)
  end
end)

-- ============================================================================
-- BEAST MASTERY
-- ============================================================================

-- Vanilla Baseline
local vanillaBM = ApplyMultiplier({
  STR = 0.05,
  AGI = 1.0,
  STA = 0.1,
  INT = 0.25,  -- Pet-focused spec, hunter mana demand lower
  SPI = 0.05,
  ATTACKPOWER = 0.43,
  RANGEDATTACKPOWER = 0.43,
  TOHIT = 9.37931,
  EXPERTISE = 0.05,       -- Expertise Rating (very low for ranged)
  CRIT = 6.8,             -- 8.5 * 0.8
  HASTE = 4.015,          -- 8.03 * 0.5
  ARMORPEN = 0.490,       -- Armor Penetration (3.75 * 0.17 = 0.6375, divided by 1.3 for base)
  RANGEDWEAPONDPS = 2.087,  -- Ranged Weapon DPS (from ClassicHawsJon: 2.4, divided by 1.15 for base)
  -- WEAPONDPS not included - melee weapon is only a stat stick for ranged specs
  MANA = 0.075,
  MANAREG = 2.4,
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

-- Turtle WoW Adjustments for Beast Mastery
local turtleBM = {}
for k, v in pairs(vanillaBM) do
  turtleBM[k] = v
end

-- 1. Hit Cap Adjustment: Bestial Precision +4/8% phys hit → pet
--    Increased from ×1.125 to ×1.2 (pet hit stacking)
turtleBM.TOHIT = vanillaBM.TOHIT * 1.2

-- 2. SPELLTOHIT: Bestial Precision +9/18% spell hit → pet
--    Pet Lightning Breath/Fire Breath benefit from spell hit transfer
--    NOTE: Fixed value (not multiplier) because vanilla BM has no SPELLTOHIT baseline
--    Value 2.0 = ~18% of TOHIT value, reflecting pet-only benefit (not hunter attacks)
turtleBM.SPELLTOHIT = 2.0 * DISPLAY_MULTIPLIER

-- 3. Stamina HIGHLY valuable (Endurance Training: +30% STA → pet)
--    Pet survival = raid DPS. Increased from ×1.1 to ×1.35
turtleBM.STA = vanillaBM.STA * 1.35

-- 4. Armor more valuable (pet gets 36% via Thick Hide)
--    Conservative: +20% value
turtleBM.ARMOR = vanillaBM.ARMOR * 1.2  -- 0.005 → 0.006

-- 5. Crit more valuable (Kill Command, Baited Shot triggers)
--    Pet crit-focused rotation (1.18.0). Conservative: +15% value
turtleBM.CRIT = vanillaBM.CRIT * 1.15  -- 6.8 → 7.82

-- 6. Ranged AP HIGHLY valuable (Spirit Bond: 25% RAP → pet Melee AP, 15% RAP → pet Spell Power)
--    Effective: 1 RAP = 1.4 pet AP value. Increased from ×1.2 to ×1.5
turtleBM.RANGEDATTACKPOWER = vanillaBM.RANGEDATTACKPOWER * 1.5
turtleBM.ATTACKPOWER = vanillaBM.ATTACKPOWER * 1.5

-- 7. RANGEDWEAPONDPS more valuable (Baited Shot 125% weapon damage after pet crit)
--    Conservative: +15% value
turtleBM.RANGEDWEAPONDPS = vanillaBM.RANGEDWEAPONDPS * 1.15  -- 2.087 → 2.4

-- 8. ARMORPEN more valuable (Armor Cap Removal 1.18.0)
--    Conservative: +30% value
turtleBM.ARMORPEN = vanillaBM.ARMORPEN * 1.3  -- 0.490 → 0.6375

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleBM

local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Hunter_Beast_Mastery", stats)



if not ItemsOfPower.SetByName["TurtleWoW_Hunter_Beast_Mastery"] then
    ItemsOfPower:RegisterSet(set)
  end
end)

-- ============================================================================
-- SURVIVAL
-- ============================================================================

-- Vanilla Baseline
local vanillaSV = ApplyMultiplier({
  STR = 0.30,  -- Lower than AP: AGI gives 2 AP via Lightning Reflexes, STR only 1
  AGI = 1.0,
  STA = 0.1,
  INT = 0.20,  -- Reduced from 0.8: Melee spec, minimal mana needs
  SPI = 0.05,
  ATTACKPOWER = 0.55,
  RANGEDATTACKPOWER = 0.55,
  TOHIT = 9.37931,
  EXPERTISE = 0.80,       -- Expertise Rating (high for melee spec)
  CRIT = 5.525,           -- 8.5 * 0.65
  HASTE = 3.212,          -- 8.03 * 0.4
  ARMORPEN = 0.808,       -- Armor Penetration (3.75 * 0.28 = 1.05, divided by 1.3 for base)
  RANGEDWEAPONDPS = 2.4,  -- Ranged Weapon DPS (from ClassicHawsJon - low for melee spec)
  WEAPONDPS = 0.714,      -- Melee Weapon DPS (from ClassicHawsJon: 1, divided by 1.4 for base)
  MANA = 0.075,
  MANAREG = 2.4,
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

-- Turtle WoW Adjustments for Survival (MAJOR REWORK - Melee Spec)
local turtleSV = {}
for k, v in pairs(vanillaSV) do
  turtleSV[k] = v
end

-- 1. Hit Cap Adjustment: Dual Wield requires more hit (9% cap remains but more attacks)
--    Increased from ×1.125 to ×1.25
turtleSV.TOHIT = vanillaSV.TOHIT * 1.25

-- 2. Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 3. Crit more valuable (Lacerate procs after crit)
--    Conservative: +10% value
turtleSV.CRIT = vanillaSV.CRIT * 1.1  -- 5.525 → 6.08

-- 4. WEAPONDPS (Melee) EXTREMELY valuable (Mongoose Bite Dual Wield strikes BOTH weapons!)
--    Savage Strikes: +13/25% offhand weapon damage (April 2025)
--    Vicious Strikes: +5/10% weapon damage (Aug 2025, nerfed from +10/20%)
--    MAJOR: +100% value (reduced from ×2.2 to ×2.0 due to Aug 2025 nerf)
turtleSV.WEAPONDPS = vanillaSV.WEAPONDPS * 2.0  -- 0.714 → 1.43

-- 5. RANGEDWEAPONDPS also valuable (Mongoose Bite uses ranged weapon in melee)
--    Conservative: +15% value
turtleSV.RANGEDWEAPONDPS = vanillaSV.RANGEDWEAPONDPS * 1.15  -- 2.4 → 2.76

-- 6. Agility EXTREMELY valuable (Lightning Reflexes: 100% Agi → Melee AP at rank 5)
--    Example: 300 Agi = 330 Agi + 330 Melee AP with full talent
--    MAJOR: +45% value (increased from ×1.25 to ×1.45)
turtleSV.AGI = vanillaSV.AGI * 1.45  -- 1.0 → 1.45

-- 7. ARMORPEN more valuable (Armor Cap Removal 1.18.0)
--    Conservative: +30% value
turtleSV.ARMORPEN = vanillaSV.ARMORPEN * 1.3  -- 0.808 → 1.05

-- 8. ATTACKPOWER HIGHLY valuable (Lacerate 35% AP + bleed, Untamed Trapper, Vicious Strikes)
--    New multiplier: ×1.45
turtleSV.ATTACKPOWER = vanillaSV.ATTACKPOWER * 1.45
turtleSV.RANGEDATTACKPOWER = vanillaSV.RANGEDATTACKPOWER * 1.45

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleSV

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Hunter_Survival", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Hunter_Survival"] then
    ItemsOfPower:RegisterSet(set)
  end
end)
