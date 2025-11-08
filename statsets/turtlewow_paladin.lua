--[[
  Turtle WoW Paladin StatSets

  Based on Vanilla ClassicHawsJon weights with Turtle WoW adjustments.

  Changes from Vanilla:
  - Hit Cap: 9% → 8% (all specs: +12.5% Hit Rating value)
  - Holy: Spell Power more valuable (Holy Strike, Daybreak, Holy Shock)
  - Holy: Crit more valuable (Daybreak procs)
  - Protection: Spell Power more valuable (Consecration 0.119, Holy Shield threat)
  - Protection: Block Value more valuable (Righteous Strikes boost)
  - Protection: Stamina more valuable (Righteous Defense mitigation)
  - Retribution: Spell Power HIGHLY valuable (Seal of Righteousness buff)
  - Retribution: Strength more valuable (Holy Strike buff)
  - Retribution: Haste more valuable (Zeal multiplicative)
  - Retribution: Crit more valuable (Vengeance stacks)

  References:
  - docs/turtle-wow-paladin-scaling-changes.md
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
-- HOLY
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
turtleHoly.SPELLHASTE = EnsureMinimumHaste(vanillaHoly.SPELLHASTE, vanillaHoly.SPELLCRIT, "healer")

-- 2. Healing Power slightly more valuable (Blessed Strikes healing scaling +25% healing power)
--    Conservative: +10% value
turtleHoly.HEAL = vanillaHoly.HEAL * 1.1  -- 0.54 → 0.594

-- 3. Spell Power more valuable (Holy Strike 43%, Daybreak 43%, Holy Shock 43%)
--    Conservative: +15% value (starting from new baseline of 0.3)
turtleHoly.DMG = turtleHoly.DMG * 1.15  -- 0.3 → 0.345

-- 4. Crit more valuable (Daybreak procs, Holy Shock resets via Blessed Strikes)
--    Conservative: +15% value
turtleHoly.SPELLCRIT = vanillaHoly.SPELLCRIT * 1.15  -- 3.68 → 4.23

print("Turtle WoW - Paladin - Holy:")
print("  HEAL: " .. string.format("%.2f", vanillaHoly.HEAL) .. " → " .. string.format("%.3f", turtleHoly.HEAL) .. " (+10%)")
print("  DMG: NEW → " .. string.format("%.3f", turtleHoly.DMG) .. " (Holy Strike, Daybreak)")
print("  SPELLCRIT: " .. string.format("%.2f", vanillaHoly.SPELLCRIT) .. " → " .. string.format("%.2f", turtleHoly.SPELLCRIT) .. " (+15%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleHoly

  local set = ItemsOfPower.SetTypes.StatSet:new("Turtle WoW - Paladin - Holy", stats)



  if not ItemsOfPower.SetByName["Turtle WoW - Paladin - Holy"] then
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Turtle WoW - Paladin - Holy")
  else
    print("Updated StatSet: Turtle WoW - Paladin - Holy")
  end
end)

-- ============================================================================
-- PROTECTION
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
turtleProtection.TOHIT = AdjustHitCap(vanillaProtection.TOHIT)  -- 1.50 → 1.69

-- 2. Spell Hit Cap Adjustment
turtleProtection.SPELLTOHIT = AdjustSpellHitCap(vanillaProtection.SPELLTOHIT)  -- 6.24 → 7.02

-- 3. Haste Baseline Check
turtleProtection.HASTE = EnsureMinimumHaste(vanillaProtection.HASTE, vanillaProtection.CRIT, "tank")

-- 4. Spell Power more valuable (Consecration 0.119, Holy Shield 15% threat scaling)
--    Conservative: +25% value
turtleProtection.DMG = vanillaProtection.DMG * 1.25  -- 0.44 → 0.55
turtleProtection.HOLYDMG = vanillaProtection.HOLYDMG * 1.25  -- 0.44 → 0.55

-- 5. Block Value HIGHLY valuable (Righteous Strikes: +2-10% blocked damage per Zeal stack)
--    Conservative: +30% value
turtleProtection.BLOCKVALUE = vanillaProtection.BLOCKVALUE * 1.3  -- 0.15 → 0.195

-- 6. Stamina more valuable (Righteous Defense: -3-10% damage taken)
--    Conservative: +10% value
turtleProtection.STA = vanillaProtection.STA * 1.1  -- 1.0 → 1.1

-- 7. Block Chance more valuable (Reckoning proc rate doubled: 10-50%)
--    Conservative: +15% value
turtleProtection.BLOCK = vanillaProtection.BLOCK * 1.15  -- 4.14 → 4.76

-- 8. WEAPONDPS more valuable (Crusader Strike weapon damage + threat generation)
--    Conservative: +40% value
turtleProtection.WEAPONDPS = vanillaProtection.WEAPONDPS * 1.4  -- 1.264 → 1.77

-- 9. ARMORPEN more valuable (Armor Cap Removal 1.18.0)
--    Conservative: +30% value
turtleProtection.ARMORPEN = vanillaProtection.ARMORPEN * 1.3  -- 0.069 → 0.09

print("")
print("Turtle WoW - Paladin - Protection:")
print("  SPELLTOHIT: " .. string.format("%.2f", vanillaProtection.SPELLTOHIT) .. " → " .. string.format("%.2f", turtleProtection.SPELLTOHIT) .. " (+12.5%)")
print("  DMG: " .. string.format("%.2f", vanillaProtection.DMG) .. " → " .. string.format("%.2f", turtleProtection.DMG) .. " (+25%)")
print("  BLOCKVALUE: " .. string.format("%.2f", vanillaProtection.BLOCKVALUE) .. " → " .. string.format("%.3f", turtleProtection.BLOCKVALUE) .. " (+30%)")
print("  WEAPONDPS: " .. string.format("%.3f", vanillaProtection.WEAPONDPS) .. " → " .. string.format("%.2f", turtleProtection.WEAPONDPS) .. " (+40% Crusader Strike!)")
print("  ARMORPEN: " .. string.format("%.3f", vanillaProtection.ARMORPEN) .. " → " .. string.format("%.2f", turtleProtection.ARMORPEN) .. " (+30% Armor Cap Removed!)")
print("  STA: " .. string.format("%.2f", vanillaProtection.STA) .. " → " .. string.format("%.2f", turtleProtection.STA) .. " (+10%)")
print("  BLOCK: " .. string.format("%.2f", vanillaProtection.BLOCK) .. " → " .. string.format("%.2f", turtleProtection.BLOCK) .. " (+15%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleProtection

  local set = ItemsOfPower.SetTypes.StatSet:new("Turtle WoW - Paladin - Protection", stats)



  if not ItemsOfPower.SetByName["Turtle WoW - Paladin - Protection"] then
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Turtle WoW - Paladin - Protection")
  else
    print("Updated StatSet: Turtle WoW - Paladin - Protection")
  end
end)

-- ============================================================================
-- RETRIBUTION
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
turtleRetribution.TOHIT = AdjustHitCap(vanillaRetribution.TOHIT)  -- 7.88 → 8.86

-- 2. Spell Hit Cap Adjustment (hybrid spec)
turtleRetribution.SPELLTOHIT = AdjustSpellHitCap(vanillaRetribution.SPELLTOHIT)  -- 1.68 → 1.89

-- 3. Haste Baseline Check
turtleRetribution.HASTE = EnsureMinimumHaste(vanillaRetribution.HASTE, vanillaRetribution.CRIT, "melee_dps")

-- 4. Spell Power HIGHLY valuable (Seal of Righteousness: 12.8% × weapon speed for 2H, Crusader Strike, Holy Strike)
--    Conservative: +40% value
turtleRetribution.DMG = vanillaRetribution.DMG * 1.4  -- 0.33 → 0.462
turtleRetribution.HOLYDMG = vanillaRetribution.HOLYDMG * 1.4  -- 0.33 → 0.462

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

-- 8. WEAPONDPS HIGHLY valuable (Weapon Normalization Dec 2024 - speed matters less, raw DPS critical!)
--    Conservative: +60% value
turtleRetribution.WEAPONDPS = vanillaRetribution.WEAPONDPS * 1.6  -- 3.375 → 5.4

-- 9. ARMORPEN more valuable (Armor Cap Removal 1.18.0)
--    Conservative: +30% value
turtleRetribution.ARMORPEN = vanillaRetribution.ARMORPEN * 1.3  -- 0.069 → 0.09

print("")
print("Turtle WoW - Paladin - Retribution:")
print("  TOHIT: " .. string.format("%.2f", vanillaRetribution.TOHIT) .. " → " .. string.format("%.2f", turtleRetribution.TOHIT) .. " (+12.5%)")
print("  DMG: " .. string.format("%.2f", vanillaRetribution.DMG) .. " → " .. string.format("%.3f", turtleRetribution.DMG) .. " (+40%)")
print("  WEAPONDPS: " .. string.format("%.3f", vanillaRetribution.WEAPONDPS) .. " → " .. string.format("%.2f", turtleRetribution.WEAPONDPS) .. " (+60% NORMALIZATION CRITICAL!)")
print("  ARMORPEN: " .. string.format("%.3f", vanillaRetribution.ARMORPEN) .. " → " .. string.format("%.2f", turtleRetribution.ARMORPEN) .. " (+30% Armor Cap Removed!)")
print("  STR: " .. string.format("%.2f", vanillaRetribution.STR) .. " → " .. string.format("%.2f", turtleRetribution.STR) .. " (+15%)")
print("  HASTE: " .. string.format("%.2f", vanillaRetribution.HASTE) .. " → " .. string.format("%.2f", turtleRetribution.HASTE) .. " (+20%)")
print("  CRIT: " .. string.format("%.2f", vanillaRetribution.CRIT) .. " → " .. string.format("%.2f", turtleRetribution.CRIT) .. " (+15%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleRetribution

  local set = ItemsOfPower.SetTypes.StatSet:new("Turtle WoW - Paladin - Retribution", stats)



  if not ItemsOfPower.SetByName["Turtle WoW - Paladin - Retribution"] then
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Turtle WoW - Paladin - Retribution")
  else
    print("Updated StatSet: Turtle WoW - Paladin - Retribution")
  end
end)

print("")
print("All Turtle WoW Paladin StatSets created!")
print("Total: 3 specs")
