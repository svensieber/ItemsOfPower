--[[
  Turtle WoW Warlock StatSets

  Based on Vanilla ClassicHawsJon weights with Turtle WoW adjustments.

  Changes from Vanilla:
  - Spell Hit Cap: 9% → 8% (all specs: +12.5% Spell Hit value)
  - Spell Haste: Baseline adjustments
  - Affliction: Spell Power more valuable (Siphon Life 100%, Dark Harvest)
  - Affliction: Haste more valuable (Rapid Deterioration DoT tick speed)
  - Demonology: Spell Power HIGHLY valuable (Demon AP Scaling 20-60%)
  - Demonology: Intellect more valuable (Fel Intellect 30% transfer)
  - Demonology: Stamina more valuable (Fel Stamina 50% transfer)
  - Demonology: Crit more valuable (Unleashed Potential stacks)
  - Destruction: Crit HIGHLY valuable (Improved Shadow Bolt proc on crit)
  - Destruction: Shadow Damage more valuable (Improved Shadow Bolt +20%)

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
turtleAffliction.SPELLTOHIT = AdjustSpellHitCap(vanillaAffliction.SPELLTOHIT)  -- 9.6 → 10.8

-- 2. Spell Haste Baseline Check
turtleAffliction.SPELLHASTE = EnsureMinimumHaste(vanillaAffliction.SPELLHASTE, vanillaAffliction.SPELLCRIT, "caster_dps")

-- 3. Spell Power (DMG) more valuable (Siphon Life 100%, Drain Soul 20%, Dark Harvest 25%)
--    Conservative: +15% value
turtleAffliction.DMG = vanillaAffliction.DMG * 1.15  -- 1.0 → 1.15

-- 4. Haste more valuable (Rapid Deterioration: Haste affects DoT tick speed at 50/100%)
--    Conservative: +10% value
turtleAffliction.SPELLHASTE = turtleAffliction.SPELLHASTE * 1.1  -- 6.26 → 6.89

print("Turtle WoW - Warlock - Affliction:")
print("  SPELLTOHIT: " .. string.format("%.2f", vanillaAffliction.SPELLTOHIT) .. " → " .. string.format("%.2f", turtleAffliction.SPELLTOHIT) .. " (+12.5%)")
print("  DMG: " .. string.format("%.2f", vanillaAffliction.DMG) .. " → " .. string.format("%.2f", turtleAffliction.DMG) .. " (+15%)")
print("  SPELLHASTE: " .. string.format("%.2f", vanillaAffliction.SPELLHASTE) .. " → " .. string.format("%.2f", turtleAffliction.SPELLHASTE) .. " (+10%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleAffliction

  local set = ItemsOfPower.SetTypes.StatSet:new("Turtle WoW - Warlock - Affliction", stats)



  if not ItemsOfPower.SetByName["Turtle WoW - Warlock - Affliction"] then
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Turtle WoW - Warlock - Affliction")
  else
    print("Updated StatSet: Turtle WoW - Warlock - Affliction")
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

-- 1. Spell Hit Cap Adjustment
turtleDemonology.SPELLTOHIT = AdjustSpellHitCap(vanillaDemonology.SPELLTOHIT)

-- 2. Spell Haste Baseline Check
turtleDemonology.SPELLHASTE = EnsureMinimumHaste(vanillaDemonology.SPELLHASTE, vanillaDemonology.SPELLCRIT, "caster_dps")

-- 3. Spell Power (DMG) HIGHLY valuable (Demon AP Scaling - CRITICAL)
--    - Unleashed Potential: 5-15% spell damage → demons (3 stacks)
--    - Demon AP: 20-60% spell damage as demon AP (August 2025)
--    - Imp Firebolt: 10-40% spell power coefficient
--    Conservative: +40% value
turtleDemonology.DMG = vanillaDemonology.DMG * 1.4  -- 1.0 → 1.4

-- 4. Intellect more valuable (Fel Intellect: 10-30% total → demons)
--    Conservative: +30% value
turtleDemonology.INT = vanillaDemonology.INT * 1.3  -- 0.4 → 0.52

-- 5. Stamina more valuable (Fel Stamina: 10-50% total → demons)
--    Conservative: +50% value
turtleDemonology.STA = vanillaDemonology.STA * 1.5  -- 0.1 → 0.15

-- 6. Crit more valuable (Demonic Precision 30-90% transfer, Unleashed Potential stacks on crit)
--    Conservative: +20% value
turtleDemonology.SPELLCRIT = vanillaDemonology.SPELLCRIT * 1.2  -- 5.28 → 6.34

print("")
print("Turtle WoW - Warlock - Demonology:")
print("  SPELLTOHIT: " .. string.format("%.2f", vanillaDemonology.SPELLTOHIT) .. " → " .. string.format("%.2f", turtleDemonology.SPELLTOHIT) .. " (+12.5%)")
print("  DMG: " .. string.format("%.2f", vanillaDemonology.DMG) .. " → " .. string.format("%.2f", turtleDemonology.DMG) .. " (+40%)")
print("  INT: " .. string.format("%.2f", vanillaDemonology.INT) .. " → " .. string.format("%.2f", turtleDemonology.INT) .. " (+30%)")
print("  STA: " .. string.format("%.2f", vanillaDemonology.STA) .. " → " .. string.format("%.2f", turtleDemonology.STA) .. " (+50%)")
print("  SPELLCRIT: " .. string.format("%.2f", vanillaDemonology.SPELLCRIT) .. " → " .. string.format("%.2f", turtleDemonology.SPELLCRIT) .. " (+20%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleDemonology

  local set = ItemsOfPower.SetTypes.StatSet:new("Turtle WoW - Warlock - Demonology", stats)



  if not ItemsOfPower.SetByName["Turtle WoW - Warlock - Demonology"] then
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Turtle WoW - Warlock - Demonology")
  else
    print("Updated StatSet: Turtle WoW - Warlock - Demonology")
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
turtleDestruction.SPELLTOHIT = AdjustSpellHitCap(vanillaDestruction.SPELLTOHIT)  -- 12.8 → 14.4

-- 2. Spell Haste Baseline Check
turtleDestruction.SPELLHASTE = EnsureMinimumHaste(vanillaDestruction.SPELLHASTE, vanillaDestruction.SPELLCRIT, "caster_dps")

-- 3. Spell Power (DMG) more valuable (Soul Fire 114%, Improved Shadow Bolt)
--    Conservative: +15% value
turtleDestruction.DMG = vanillaDestruction.DMG * 1.15  -- 1.0 → 1.15

-- 4. Crit HIGHLY valuable (Improved Shadow Bolt: 20-100% proc on crit - CRITICAL)
--    Conservative: +20% value
turtleDestruction.SPELLCRIT = vanillaDestruction.SPELLCRIT * 1.2  -- 6.96 → 8.35

-- 5. Shadow Damage more valuable (Improved Shadow Bolt: +20% Shadow damage debuff)
--    Conservative: +20% value
turtleDestruction.SHADOWDMG = vanillaDestruction.SHADOWDMG * 1.2  -- 0.95 → 1.14

-- 6. Fire Damage slightly more valuable (Improved Soul Fire: +10% Fire damage)
--    Conservative: +10% value
turtleDestruction.FIREDMG = vanillaDestruction.FIREDMG * 1.1  -- 0.23 → 0.253

print("")
print("Turtle WoW - Warlock - Destruction:")
print("  SPELLTOHIT: " .. string.format("%.2f", vanillaDestruction.SPELLTOHIT) .. " → " .. string.format("%.2f", turtleDestruction.SPELLTOHIT) .. " (+12.5%)")
print("  DMG: " .. string.format("%.2f", vanillaDestruction.DMG) .. " → " .. string.format("%.2f", turtleDestruction.DMG) .. " (+15%)")
print("  SPELLCRIT: " .. string.format("%.2f", vanillaDestruction.SPELLCRIT) .. " → " .. string.format("%.2f", turtleDestruction.SPELLCRIT) .. " (+20%)")
print("  SHADOWDMG: " .. string.format("%.2f", vanillaDestruction.SHADOWDMG) .. " → " .. string.format("%.2f", turtleDestruction.SHADOWDMG) .. " (+20%)")
print("  FIREDMG: " .. string.format("%.2f", vanillaDestruction.FIREDMG) .. " → " .. string.format("%.3f", turtleDestruction.FIREDMG) .. " (+10%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleDestruction

  local set = ItemsOfPower.SetTypes.StatSet:new("Turtle WoW - Warlock - Destruction", stats)



  if not ItemsOfPower.SetByName["Turtle WoW - Warlock - Destruction"] then
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Turtle WoW - Warlock - Destruction")
  else
    print("Updated StatSet: Turtle WoW - Warlock - Destruction")
  end
end)

print("")
print("All Turtle WoW Warlock StatSets created!")
print("Total: 3 specs")
