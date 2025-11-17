--[[
  Turtle WoW Priest StatSets

  Based on Vanilla ClassicHawsJon weights with Turtle WoW adjustments.

  Changes from Vanilla:
  - Spell Hit Cap: 9% → 8% (Shadow: +12.5% Spell Hit value)
  - Spell Haste: Baseline adjustments
  - Inner Fire: NOW grants Spell Damage (13-74) instead of AP - CRITICAL
  - Discipline: COMPLETE REWORK into Holy DPS support spec
  - Discipline: Spell Power HIGHLY valuable (Smite, Holy Fire, Resurgent Shield)
  - Discipline: Crit more valuable (Searing Light instant Smite procs)
  - Holy: Healing baseline -15%, but Spiritual Healing +30% compensates
  - Holy: Spirit more valuable (Spirit of Redemption +5%, Spiritual Guidance)
  - Shadow: Spell Power HIGHLY valuable (Mind Flay 75%, Mind Blast 60%)
  - Shadow: Spirit HIGHLY valuable (Improved Shadowform 15% regen while casting)
  - Power Word: Shield: 10% → 35% coefficient (+250%)

  References:
  - docs/turtle-wow-priest-scaling-changes.md
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
-- DISCIPLINE (HOLY DPS SUPPORT)
-- ============================================================================

-- Vanilla Baseline
local vanillaDiscipline = ApplyMultiplier({
  INT = 1.0,
  SPI = 0.48,
  STA = 0.1,
  AGI = 0.05,
  HEAL = 0.72,            -- Healing power (hybrid spec)
  SPELLCRIT = 2.56,       -- Healing/spell crit
  SPELLHASTE = 4.5771,    -- Spell haste
  MANA = 0.09,
  MANAREG = 1.19,
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

-- Turtle WoW Adjustments for Discipline
local turtleDiscipline = {}
for k, v in pairs(vanillaDiscipline) do
  turtleDiscipline[k] = v
end

-- 1. Add Spell Damage stats (not in vanilla Discipline - it was hybrid healer/support)
--    Discipline is now HOLY DPS spec in Turtle WoW
turtleDiscipline.DMG = 0.9             -- Generic spell damage (baseline for DPS spec)
turtleDiscipline.HOLYDMG = 0.9         -- Holy damage (same as generic)
turtleDiscipline.SPELLTOHIT = 7.0      -- Spell hit (baseline for DPS spec)

-- 2. Spell Hit Cap Adjustment: 9% → 8% (+12.5%) for DPS role
turtleDiscipline.SPELLTOHIT = turtleDiscipline.SPELLTOHIT * 1.125  -- 7.0 → 7.88

-- 3. Spell Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 4. Spell Power HIGHLY valuable (Inner Fire +74, Smite +10%, Holy Fire 100%, Resurgent Shield, Enlighten)
--    Conservative: +40% value for generic spell damage
turtleDiscipline.DMG = turtleDiscipline.DMG * 1.4  -- 0.9 → 1.26

-- 5. Holy Damage more valuable (Smite/Holy Fire primary rotation)
--    Conservative: +45% value
turtleDiscipline.HOLYDMG = turtleDiscipline.HOLYDMG * 1.45  -- 0.9 → 1.305

-- 6. Healing Power: Power Word: Shield 10% → 35% coefficient (+250%)
--    Conservative: +100% value (still hybrid with shielding)
turtleDiscipline.HEAL = vanillaDiscipline.HEAL * 2.0  -- 0.72 → 1.44

-- 7. Crit more valuable (Searing Light: crits proc instant Smite, Divinity affects DPS)
--    Conservative: +15% value
turtleDiscipline.SPELLCRIT = vanillaDiscipline.SPELLCRIT * 1.15  -- 2.56 → 2.944

-- 8. Intellect more valuable (Mental Strength: increases total Int + 1-3% casting speed)
--    Conservative: +10% value
turtleDiscipline.INT = vanillaDiscipline.INT * 1.1  -- 1.0 → 1.1

-- 9. Haste more valuable (Mental Strength: +1-3% casting speed)
--    Conservative: +10% value
turtleDiscipline.SPELLHASTE = turtleDiscipline.SPELLHASTE * 1.1  -- 4.58 → 5.04


-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleDiscipline

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Priest_Discipline", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Priest_Discipline"] then
    ItemsOfPower:RegisterSet(set)
  else
  end
end)

-- ============================================================================
-- HOLY
-- ============================================================================

-- Vanilla Baseline
local vanillaHoly = ApplyMultiplier({
  INT = 1.0,
  SPI = 0.73,
  STA = 0.1,
  AGI = 0.05,
  HEAL = 0.81,            -- Healing power
  SPELLCRIT = 1.92,       -- Healing crit
  SPELLHASTE = 4.818,     -- Healing haste
  MANA = 0.09,
  MANAREG = 1.35,
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

-- Turtle WoW Adjustments for Holy
local turtleHoly = {}
for k, v in pairs(vanillaHoly) do
  turtleHoly[k] = v
end

-- 1. Spell Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 2. Healing Power: COMPLEX calculation
--    - Baseline: -15% for ranks above level 30
--    - Spiritual Healing: +30% (requires 5 points)
--    - Swift Recovery: +6% with Renew active (requires 2 points)
--    - Net with deep spec: -15% + 30% + 6% = +21%
--    - Conservative approach: Assume medium spec (+15% total for net 0%)
--    - Actually, let's use +10% to represent average deep Holy investment
turtleHoly.HEAL = vanillaHoly.HEAL * 1.1  -- 0.81 → 0.891

-- 3. Spirit more valuable (Spirit of Redemption +5%, Spiritual Guidance conversion)
--    Conservative: +10% value
turtleHoly.SPI = vanillaHoly.SPI * 1.1  -- 0.73 → 0.803

-- 4. Add minor Spell Damage for hybrid play (Inner Fire +74 spell damage)
--    Conservative: Low value since Holy focuses on healing
turtleHoly.DMG = 0.1  -- Minor spell damage for hybrid Smite usage


-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleHoly

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Priest_Holy", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Priest_Holy"] then
    ItemsOfPower:RegisterSet(set)
  else
  end
end)

-- ============================================================================
-- SHADOW
-- ============================================================================

-- Vanilla Baseline
local vanillaShadow = ApplyMultiplier({
  INT = 0.19,
  SPI = 0.21,
  STA = 0.1,
  AGI = 0.05,
  DMG = 1.0,              -- Generic spell damage
  SHADOWDMG = 1.0,        -- Shadow damage
  SPELLTOHIT = 8.96,      -- Pre-multiplied
  SPELLCRIT = 6.08,       -- Spell crit
  SPELLHASTE = 5.2195,    -- Spell haste
  SPELLPEN = 0.08,
  MANA = 0.017,
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

-- Turtle WoW Adjustments for Shadow
local turtleShadow = {}
for k, v in pairs(vanillaShadow) do
  turtleShadow[k] = v
end

-- 1. Spell Hit Cap Adjustment: 9% → 8% (+12.5%)
turtleShadow.SPELLTOHIT = vanillaShadow.SPELLTOHIT * 1.125  -- 8.96 → 10.08

-- 2. Spell Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 3. Spell Power HIGHLY valuable (Inner Fire +74, Mind Flay 45% → 75%, Mind Blast 42.85% → 60%)
--    Conservative: +30% value
turtleShadow.DMG = vanillaShadow.DMG * 1.3  -- 1.0 → 1.3

-- 4. Shadow Damage more valuable (Mind Flay primary filler, Mind Blast)
--    Conservative: +35% value (Mind Flay is main spell)
turtleShadow.SHADOWDMG = vanillaShadow.SHADOWDMG * 1.35  -- 1.0 → 1.35

-- 5. Spirit HIGHLY valuable (Improved Shadowform: 15% mana regen continues while casting - CRITICAL)
--    Conservative: +100% value (massive change from vanilla)
turtleShadow.SPI = vanillaShadow.SPI * 2.0  -- 0.21 → 0.42

-- 6. Add Healing Power for Shadow Mend (50% healing power + 20% shadow spell power)
--    Conservative: Low value since Shadow focuses on DPS
turtleShadow.HEAL = 0.15  -- Minor healing power for Shadow Mend utility


-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleShadow

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Priest_Shadow", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Priest_Shadow"] then
    ItemsOfPower:RegisterSet(set)
  else
  end
end)

