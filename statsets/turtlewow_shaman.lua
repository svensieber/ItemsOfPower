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

-- 1. Spell Hit Cap Adjustment: 9% → 8% (+12.5%)
turtleElemental.SPELLTOHIT = AdjustSpellHitCap(vanillaElemental.SPELLTOHIT)  -- 7.2 → 8.1

-- 2. Spell Haste Baseline Check
turtleElemental.SPELLHASTE = EnsureMinimumHaste(vanillaElemental.SPELLHASTE, vanillaElemental.SPELLCRIT, "caster_dps")

-- 3. Spell Power more valuable (Molten Blast 57.14%, Earthquake 60%)
--    Conservative: +15% value
turtleElemental.DMG = vanillaElemental.DMG * 1.15  -- 1.0 → 1.15

-- 4. Crit HIGHLY valuable (Elemental Fury: +50/100% crit damage, Fire totems inherit crit)
--    Conservative: +15% value
turtleElemental.SPELLCRIT = vanillaElemental.SPELLCRIT * 1.15  -- 8.4 → 9.66

print("TurtleWoW_Shaman_Elemental:")
print("  SPELLTOHIT: " .. string.format("%.2f", vanillaElemental.SPELLTOHIT) .. " → " .. string.format("%.2f", turtleElemental.SPELLTOHIT) .. " (+12.5%)")
print("  DMG: " .. string.format("%.2f", vanillaElemental.DMG) .. " → " .. string.format("%.2f", turtleElemental.DMG) .. " (+15%)")
print("  SPELLCRIT: " .. string.format("%.2f", vanillaElemental.SPELLCRIT) .. " → " .. string.format("%.2f", turtleElemental.SPELLCRIT) .. " (+15%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleElemental

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Shaman_Elemental", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Shaman_Elemental"] then
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: TurtleWoW_Shaman_Elemental")
  else
    print("Updated StatSet: TurtleWoW_Shaman_Elemental")
  end
end)

-- ============================================================================
-- ENHANCEMENT
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

-- 1. Hit Cap Adjustment (Physical)
turtleEnhancement.TOHIT = AdjustHitCap(vanillaEnhancement.TOHIT)  -- 6.28 → 7.07

-- 2. Spell Hit Cap Adjustment (Hybrid)
turtleEnhancement.SPELLTOHIT = AdjustSpellHitCap(vanillaEnhancement.SPELLTOHIT)  -- 1.78 → 2.01

-- 3. Haste Baseline Check
turtleEnhancement.HASTE = EnsureMinimumHaste(vanillaEnhancement.HASTE, vanillaEnhancement.CRIT, "melee_dps")

-- 4. Attack Power more valuable (Shock AP scaling: 10% Earth/Frost, 8.5% + 6% Flame Shock)
--    Conservative: +20% value
turtleEnhancement.ATTACKPOWER = vanillaEnhancement.ATTACKPOWER * 1.2  -- 0.5 → 0.6

-- 5. ALL STATS more valuable (Ancestral Knowledge: 1-5% total stats - CRITICAL!)
--    Conservative: +5% value (matches max rank)
turtleEnhancement.STR = vanillaEnhancement.STR * 1.05  -- 1.0 → 1.05
turtleEnhancement.AGI = vanillaEnhancement.AGI * 1.05  -- 0.87 → 0.91
turtleEnhancement.STA = vanillaEnhancement.STA * 1.05  -- 0.1 → 0.105
turtleEnhancement.INT = vanillaEnhancement.INT * 1.05  -- 0.34 → 0.357
turtleEnhancement.SPI = vanillaEnhancement.SPI * 1.05  -- 0.05 → 0.0525

-- 6. Crit more valuable (Element's Grace: +2-10% instant spell crit for shocks)
--    Conservative: +10% value
turtleEnhancement.CRIT = vanillaEnhancement.CRIT * 1.1  -- 8.33 → 9.16
turtleEnhancement.SPELLCRIT = vanillaEnhancement.SPELLCRIT * 1.1  -- 2.61 → 2.87

-- 7. Haste slightly more valuable (Flurry buffed, Bloodlust buffed)
--    Conservative: +5% value
turtleEnhancement.HASTE = turtleEnhancement.HASTE * 1.05  -- 5.14 → 5.40

-- 8. WEAPONDPS more valuable (Lightning Strike 80% weapon dmg + Windfury proc synergy)
--    Conservative: +30% value
turtleEnhancement.WEAPONDPS = vanillaEnhancement.WEAPONDPS * 1.3  -- 2.308 → 3.0

-- 9. ARMORPEN more valuable (Armor Cap Removal 1.18.0)
--    Conservative: +30% value
turtleEnhancement.ARMORPEN = vanillaEnhancement.ARMORPEN * 1.3  -- 0.346 → 0.45

print("")
print("TurtleWoW_Shaman_Enhancement:")
print("  TOHIT: " .. string.format("%.2f", vanillaEnhancement.TOHIT) .. " → " .. string.format("%.2f", turtleEnhancement.TOHIT) .. " (+12.5%)")
print("  AP: " .. string.format("%.2f", vanillaEnhancement.ATTACKPOWER) .. " → " .. string.format("%.2f", turtleEnhancement.ATTACKPOWER) .. " (+20%)")
print("  ALL STATS: +5% (Ancestral Knowledge)")
print("  CRIT: " .. string.format("%.2f", vanillaEnhancement.CRIT) .. " → " .. string.format("%.2f", turtleEnhancement.CRIT) .. " (+10%)")
print("  HASTE: " .. string.format("%.2f", vanillaEnhancement.HASTE) .. " → " .. string.format("%.2f", turtleEnhancement.HASTE) .. " (+5%)")
print("  WEAPONDPS: " .. string.format("%.3f", vanillaEnhancement.WEAPONDPS) .. " → " .. string.format("%.2f", turtleEnhancement.WEAPONDPS) .. " (+30% Lightning Strike + Windfury!)")
print("  ARMORPEN: " .. string.format("%.3f", vanillaEnhancement.ARMORPEN) .. " → " .. string.format("%.2f", turtleEnhancement.ARMORPEN) .. " (+30% Armor Cap Removal!)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleEnhancement

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Shaman_Enhancement", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Shaman_Enhancement"] then
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: TurtleWoW_Shaman_Enhancement")
  else
    print("Updated StatSet: TurtleWoW_Shaman_Enhancement")
  end
end)

-- ============================================================================
-- RESTORATION
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
turtleRestoration.SPELLHASTE = EnsureMinimumHaste(vanillaRestoration.SPELLHASTE, vanillaRestoration.SPELLCRIT, "healer")

-- 2. Healing Power LESS valuable (Chain Heal nerf: 71.42% → 61.42% coefficient - CRITICAL)
--    Conservative: -10% value
turtleRestoration.HEAL = vanillaRestoration.HEAL * 0.9  -- 0.9 → 0.81

-- 3. Spirit HIGHLY valuable (Improved Water Shield: +15% mana regen while casting - CRITICAL!)
--    Conservative: +50% value
turtleRestoration.SPI = vanillaRestoration.SPI * 1.5  -- 0.61 → 0.915

print("")
print("TurtleWoW_Shaman_Restoration:")
print("  HEAL: " .. string.format("%.2f", vanillaRestoration.HEAL) .. " → " .. string.format("%.2f", turtleRestoration.HEAL) .. " (-10%)")
print("  SPI: " .. string.format("%.2f", vanillaRestoration.SPI) .. " → " .. string.format("%.3f", turtleRestoration.SPI) .. " (+50%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleRestoration

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Shaman_Restoration", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Shaman_Restoration"] then
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: TurtleWoW_Shaman_Restoration")
  else
    print("Updated StatSet: TurtleWoW_Shaman_Restoration")
  end
end)

print("")
print("All Turtle WoW Shaman StatSets created!")
print("Total: 3 specs")
