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
  - Holy: Spirit more valuable (Spirit of Redemption +10%, Spiritual Guidance)
  - Shadow: Spell Power HIGHLY valuable (Mind Flay 75%, Mind Blast 60%)
  - Shadow: Spirit HIGHLY valuable (Improved Shadowform 15% regen while casting)
  - Shadow: Shadow Mend reworked (1.18.0) - scales with 50% HEAL + 20% shadow SP

  Hotfixes and Patch Changes:
  - Power Word: Shield (1.17.2): 10%→35% coefficient (+250%)
  - Mind Flay (1.17.2): Coefficient 45%→75%
  - Mind Blast (1.17.2): Coefficient 42.85%→60%
  - Pain Spike (1.17.2): Coefficient 42.85%→25%
  - Smite (Nov 2024): Base damage -10% (reverts 1.17.2 buff)
  - Searing Light (Nov 2024): 3s ICD added, mana reduction 40%→20%
  - Resurgent Shield (Dec 2024): Shield SP bonus 6%→10% (+67%)
  - Chastise (April 2025): Duration 6→8s, haste 10/13/15%→13/17/20%
  - Smite (April 2025): Coefficient +5%
  - Pain Spike (April 2025): Coefficient 25%→43%
  - Vampiric Embrace (1.18.0): Cast time reverted to instant
  - Shadow Mend (1.18.0): Reworked to 50% HEAL + 20% shadow SP
  - Searing Light (Aug 2025): Mana reduction 20%→50%

  Patch 1.18.1 Changes:
  - Holy - Spirit of Redemption: Spirit bonus 5%→10% (doubled Spirit multiplier for Holy)
  - Holy - Book of Prayer (new talent): 15/30% mana refund if not repeating spells
  - Holy - Empowered Recovery: +3/6s Renew duration (HoT uptime improved)
  - Holy - Ascendance (new capstone): -33% mana cost, +20% cast speed, +15% healing taken
  - Discipline - Searing Light: Mana cost reduction 50%→60% (slightly less MP5 need)
  - Shadow - Shadow Weaving: Reworked (stacks on Priest, then apply to targets)
  - Shadow - Pain Spike: CD 40s→30s (slight DPS increase)
  - General - Heal/Greater Heal/Flash Heal: ~7-15% base healing increase
  - General - Lightwell: Complete rework to 20% healing amplifier
  - General - Fade: Now also reduces total threat by 15% (in addition to flat amount)
  - Shadow - Improved Fade: Reworked to reduce threat returned when Fade ends by 25/50%

  References:
  - docs/turtle-wow-priest-scaling-changes.md
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
-- DISCIPLINE (HOLY DPS SUPPORT)
-- Smite (Nov 2024): Base damage reverted, (April 2025): +5% coefficient
-- Searing Light (Nov 2024): 3s ICD, (Aug 2025): 50% mana reduction, (1.18.1): 60% mana reduction
-- Resurgent Shield (Dec 2024): Shield SP bonus 6%→10%
-- Chastise (April 2025): Duration 6→8s, haste 13/17/20%
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
--    Conservative: +50% value for generic spell damage (Smite ~+5% coefficient buff 1.17.2)
turtleDiscipline.DMG = turtleDiscipline.DMG * 1.5  -- 0.9 → 1.35

-- 5. Holy Damage more valuable (Smite/Holy Fire primary rotation, Chastise 65% SP)
--    Conservative: +65% value (Chastise 65% SP + Smite buff = combined Holy DPS increase)
turtleDiscipline.HOLYDMG = turtleDiscipline.HOLYDMG * 1.65  -- 0.9 → 1.485

-- 6. Healing Power: Power Word: Shield 10% → 35% coefficient (+250%)
--    Conservative: +100% value (still hybrid with shielding)
turtleDiscipline.HEAL = vanillaDiscipline.HEAL * 2.0  -- 0.72 → 1.44

-- 7. Crit more valuable (Searing Light: crits proc instant Smite, Divinity affects DPS)
--    Conservative: +15% value
turtleDiscipline.SPELLCRIT = vanillaDiscipline.SPELLCRIT * 1.15  -- 2.56 → 2.944

-- 8. Intellect more valuable (Mental Strength: increases total Int + 1-3% casting speed)
--    Conservative: +10% value
turtleDiscipline.INT = vanillaDiscipline.INT * 1.1  -- 1.0 → 1.1

-- 9. Haste more valuable (Mental Strength: +1-3% casting speed, Chastise 13/17/20% haste buff April 2025)
--    Conservative: +25% value
turtleDiscipline.SPELLHASTE = turtleDiscipline.SPELLHASTE * 1.25  -- 4.58 → 5.72

-- 10. Add CASTINGREG support (Meditation items in 1.16.0, medium-high value for Discipline)
--     Discipline is mana-hungry DPS/healer hybrid
turtleDiscipline.CASTINGREG = 8.0  -- Medium-high value for Discipline mana efficiency

-- 11. Searing Light mana reduction 50%→60% (1.18.1): Slightly less MP5 need for Smite builds
--     Conservative: -5% value for MANAREG
turtleDiscipline.MANAREG = turtleDiscipline.MANAREG * 0.95  -- 1.19 → 1.13

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_Priest_Discipline", turtleDiscipline)
end)

-- ============================================================================
-- HOLY
-- Spirit of Redemption (1.18.1): Spirit bonus 5%→10%
-- Book of Prayer (1.18.1): 15/30% mana refund if not repeating spells
-- Empowered Recovery (1.18.1): +3/6s Renew duration
-- Ascendance (1.18.1): -33% mana cost, +20% cast speed, +15% healing taken
-- Base Healing (1.18.1): Heal/Greater Heal/Flash Heal ~7-15% buff
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
--    - 1.18.1: Base healing of Heal/Greater Heal/Flash Heal buffed ~7-15%
--      This makes +HEAL stat relatively less dominant (base healing matters more)
--    Compromise: +10% (down from +15% due to base healing buff)
turtleHoly.HEAL = vanillaHoly.HEAL * 1.10  -- 0.81 → 0.891

-- 3. Spirit more valuable (Spirit of Redemption +10% in 1.18.1, Spiritual Guidance conversion)
--    1.18.1: Spirit of Redemption doubled from 5%→10%
--    Conservative: +20% value (up from +10%)
turtleHoly.SPI = vanillaHoly.SPI * 1.2  -- 0.73 → 0.876

-- 4. Add minor Spell Damage for hybrid play (Inner Fire +74 spell damage)
--    Conservative: Low value since Holy focuses on healing
turtleHoly.DMG = 0.1  -- Minor spell damage for hybrid Smite usage
turtleHoly.HOLYDMG = 0.15  -- Holy damage for Smite/Holy Fire hybrid usage

-- 5. Add CASTINGREG support (Meditation items in 1.16.0, HIGH value for Holy healers)
turtleHoly.CASTINGREG = 15.0  -- High value for Holy Priest mana sustain

-- 6. Haste more valuable with Ascendance (1.18.1): +20% cast speed during cooldown
--    Haste stacks multiplicatively with the buff, making it more valuable during burst windows
--    Conservative: +10% value
turtleHoly.SPELLHASTE = turtleHoly.SPELLHASTE * 1.10  -- 4.818 → 5.30

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_Priest_Holy", turtleHoly)
end)

-- ============================================================================
-- SHADOW
-- Mind Flay (1.17.2): Coefficient 45%→75%
-- Mind Blast (1.17.2): Coefficient 42.85%→60%
-- Pain Spike (1.17.2→April 2025): 42.85%→25%→43%, (1.18.1): CD 40s→30s
-- Vampiric Embrace (1.18.0): Cast time reverted to instant
-- Shadow Mend (1.18.0): Reworked to 50% HEAL + 20% shadow SP
-- Shadow Weaving (1.18.1): Reworked - stacks on Priest, then apply to targets
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

-- 3. Spell Power HIGHLY valuable (Inner Fire +74, Mind Flay 45% → 75%, Mind Blast 42.85% → 60%, Pain Spike 43% April 2025)
--    1.18.1: Pain Spike CD 40s→30s (slight DPS increase, +25% uptime on that ability)
--    Conservative: +42% value (up from +40%)
turtleShadow.DMG = vanillaShadow.DMG * 1.42  -- 1.0 → 1.42

-- 4. Shadow Damage more valuable (Mind Flay 75% primary filler, Mind Blast, Pain Spike 43%)
--    1.18.1: Pain Spike CD reduction means more Shadow damage casts
--    Conservative: +47% value (up from +45%)
turtleShadow.SHADOWDMG = vanillaShadow.SHADOWDMG * 1.47  -- 1.0 → 1.47

-- 5. Spirit HIGHLY valuable (Improved Shadowform: 15% mana regen continues while casting - CRITICAL)
--    Conservative: +100% value (massive change from vanilla)
turtleShadow.SPI = vanillaShadow.SPI * 2.0  -- 0.21 → 0.42

-- 6. Add Healing Power for Shadow Mend (1.18.0 rework: 50% HEAL + 20% shadow SP)
--    Conservative: Low value since Shadow focuses on DPS
--    Note: 20% shadow SP component already covered by SHADOWDMG value
turtleShadow.HEAL = 0.15  -- Minor healing power for Shadow Mend utility

-- 7. Add CASTINGREG support (Meditation items in 1.16.0, medium value for Shadow)
--    Shadow already has Improved Shadowform for regen, but CASTINGREG stacks
turtleShadow.CASTINGREG = 5.0  -- Medium value for Shadow mana efficiency

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_Priest_Shadow", turtleShadow)
end)

