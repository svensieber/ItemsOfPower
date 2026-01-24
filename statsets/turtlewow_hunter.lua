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
  - Endurance Training: +30% STA → pet (1.18.1: 2-10%, up from 1-5%)
  - Thick Hide: Pet armor +7/14/20% (1.18.1, up from 4/7/10%)
  - Kill Command + Baited Shot (1.18.0): Pet crit-focused rotation
  - Kill Command (1.18.1): Pet attacks for 50% hunter AP on hunter crit
  - Bestial Wrath: RETURNED in 1.18.1 (pet burst damage cooldown)
  - Bestial Swiftness: REMOVED in 1.18.0

  Marksmanship Turtle WoW Changes:
  - Piercing Shots: Crit applies bleed for 15/30% damage (1.17.2)
  - Trueshot Aura: Now baseline +3% AP + 30 flat (1.18.1)
  - Ranged Weapon Specialization: 2-10% damage (1.18.1, up from 1-5%)
  - Lock and Load (1.18.1): New capstone - crit resets Aimed Shot CD
  - Improved Marksmanship (1.18.1): +5/10% Steady/Aimed damage

  Survival Turtle WoW Changes (MAJOR REWORK - Melee Spec):
  - Mongoose Bite Dual Wield (1.18.0): Strikes with BOTH weapons
  - Savage Strikes: +13/25% offhand weapon damage (April 2025)
  - Vicious Strikes: +5/10% weapon damage (Aug 2025, nerfed from +10/20%)
  - Lightning Reflexes: 100% Agi → Melee AP at rank 5
  - Lacerate: 40% AP + bleed (1.18.1, up from 35%)
  - Untamed Trapper: Fire traps scale with melee AP (1.17.2)
  - Rapid Strikes: REMOVED in 1.18.0 (effect moved to baseline Rapid Fire)
  - Alone Against the World (1.18.1): +3/6% damage without pet
  - Surefooted (1.18.1): +1/2/3% hit while dual wielding

  General/All Specs (1.18.1):
  - Aspect of the Viper: 5% max mana every 5s (reduces MP5 need)
  - Steady Shot: Now baseline
  - Volley: 3s cast with 4/5/6% AP scaling (ATTACKPOWER affects AoE)
  - Arcane Shot: Scales with 10-45% ranged weapon damage
  - Rapid Fire: Also -40% cast time on Aimed/Steady Shot

  References:
  - docs/turtle-wow-hunter-scaling-changes.md
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

-- 2. Haste more valuable (Rapid Fire -40% cast time on Aimed/Steady Shot)
--    Conservative: +15% value during cooldown windows
turtleMM.HASTE = vanillaMM.HASTE * 1.15  -- 3.212 → 3.69

-- 3. RANGEDWEAPONDPS more valuable (Steady Shot baseline, Arcane Shot 10-45% scaling)
--    Ranged Weapon Specialization: 2-10% damage (up from 1-5%)
--    Improved Marksmanship: +5/10% Steady/Aimed damage
--    Increased from ×1.2 to ×1.4
turtleMM.RANGEDWEAPONDPS = vanillaMM.RANGEDWEAPONDPS * 1.4  -- 2.167 → 3.03

-- 4. RANGEDATTACKPOWER more valuable (Volley 4/5/6% AP scaling affects AoE)
--    Conservative: +10% value
turtleMM.RANGEDATTACKPOWER = vanillaMM.RANGEDATTACKPOWER * 1.1  -- 0.55 → 0.605

-- 5. ARMORPEN more valuable (Armor Cap Removal 1.18.0)
--    Conservative: +30% value
turtleMM.ARMORPEN = vanillaMM.ARMORPEN * 1.3  -- 1.067 → 1.3875

-- 6. RANGEDCRIT HIGHLY valuable (Piercing Shots bleed, Lock and Load resets Aimed Shot CD)
--    Lock and Load capstone makes crit even more valuable
--    Increased from ×1.25 to ×1.4
turtleMM.RANGEDCRIT = vanillaMM.CRIT * 1.4  -- Use CRIT as base, apply ×1.4
turtleMM.CRIT = vanillaMM.CRIT * 1.4  -- Also increase general CRIT for consistency

-- 7. MANAREG reduced (Aspect of the Viper: 5% max mana every 5s)
--    MP5 less critical with baseline mana sustain
--    Conservative: -15% value
turtleMM.MANAREG = vanillaMM.MANAREG * 0.85  -- 2.4 → 2.04

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_Hunter_Marksmanship", turtleMM)
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

-- 3. Stamina HIGHLY valuable (Endurance Training: 2-10% pet health, up from 1-5%)
--    Pet survival = raid DPS. Increased from ×1.35 to ×1.5
turtleBM.STA = vanillaBM.STA * 1.5

-- 4. Armor more valuable (Thick Hide: +7/14/20% pet armor, up from 4/7/10%)
--    Increased from ×1.2 to ×1.35
turtleBM.ARMOR = vanillaBM.ARMOR * 1.35  -- 0.005 → 0.00675

-- 5. Crit HIGHLY valuable (Kill Command: pet attacks for 50% hunter AP on hunter crit)
--    Bestial Wrath returned: pet burst damage cooldown synergizes with crit
--    Increased from ×1.15 to ×1.35
turtleBM.CRIT = vanillaBM.CRIT * 1.35  -- 6.8 → 9.18

-- 6. Ranged AP EXTREMELY valuable (Spirit Bond + Kill Command 50% AP to pet on crit)
--    Effective: 1 RAP = 1.65 pet AP value. Increased from ×1.5 to ×1.65
turtleBM.RANGEDATTACKPOWER = vanillaBM.RANGEDATTACKPOWER * 1.65
turtleBM.ATTACKPOWER = vanillaBM.ATTACKPOWER * 1.65

-- 7. RANGEDWEAPONDPS more valuable (Baited Shot 125% weapon damage, Arcane Shot 10-45% scaling)
--    Increased from ×1.15 to ×1.25
turtleBM.RANGEDWEAPONDPS = vanillaBM.RANGEDWEAPONDPS * 1.25  -- 2.087 → 2.61

-- 8. ARMORPEN more valuable (Armor Cap Removal 1.18.0)
--    Conservative: +30% value
turtleBM.ARMORPEN = vanillaBM.ARMORPEN * 1.3  -- 0.490 → 0.6375

-- 9. Haste more valuable (Rapid Fire -40% cast time on Aimed/Steady Shot)
--    Conservative: +10% value
turtleBM.HASTE = vanillaBM.HASTE * 1.1  -- 4.015 → 4.42

-- 10. MANAREG reduced (Aspect of the Viper: 5% max mana every 5s)
--     MP5 less critical with baseline mana sustain
--     Conservative: -15% value
turtleBM.MANAREG = vanillaBM.MANAREG * 0.85  -- 2.4 → 2.04

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_Hunter_Beast_Mastery", turtleBM)
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

-- 1. Hit Cap Adjustment: Surefooted +1/2/3% hit while dual wielding
--    Dual wield hit cap easier to reach, but still valuable
--    Reduced from ×1.25 to ×1.15
turtleSV.TOHIT = vanillaSV.TOHIT * 1.15

-- 2. Haste more valuable (Rapid Fire -40% cast time on Aimed/Steady Shot)
--    Conservative: +10% value
turtleSV.HASTE = vanillaSV.HASTE * 1.1  -- 3.212 → 3.53

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
--    Alone Against the World: +3/6% damage without pet synergizes
--    Example: 300 Agi = 330 Agi + 330 Melee AP with full talent
--    MAJOR: +50% value (increased from ×1.45 to ×1.5)
turtleSV.AGI = vanillaSV.AGI * 1.5  -- 1.0 → 1.5

-- 7. ARMORPEN more valuable (Armor Cap Removal 1.18.0)
--    Conservative: +30% value
turtleSV.ARMORPEN = vanillaSV.ARMORPEN * 1.3  -- 0.808 → 1.05

-- 8. ATTACKPOWER HIGHLY valuable (Lacerate 40% AP + bleed, up from 35%)
--    Untamed Trapper, Vicious Strikes, Alone Against the World +6% damage
--    Increased from ×1.45 to ×1.55
turtleSV.ATTACKPOWER = vanillaSV.ATTACKPOWER * 1.55
turtleSV.RANGEDATTACKPOWER = vanillaSV.RANGEDATTACKPOWER * 1.55

-- 9. MANAREG reduced (Aspect of the Viper: 5% max mana every 5s)
--     Melee spec has lower mana needs anyway
--     Conservative: -20% value
turtleSV.MANAREG = vanillaSV.MANAREG * 0.8  -- 2.4 → 1.92

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_Hunter_Survival", turtleSV)
end)
