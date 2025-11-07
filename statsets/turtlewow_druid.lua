--[[
  Turtle WoW Druid StatSets

  Based on Vanilla ClassicHawsJon weights with Turtle WoW adjustments.

  Changes from Vanilla:
  - Hit Cap: 9% → 8% (all specs: +12.5% Hit Rating value)
  - Haste: Baseline adjustments
  - Balance: Crit EXTREMELY valuable (Eclipse: 10% + 60% of crit %)
  - Balance: Spell Power more valuable (Wrath +5%, Hurricane improved)
  - Feral Cat: Attack Power more valuable (Ferocious Bite 0.5% per energy)
  - Feral Cat: Agility more valuable (MCP removed, relative stat value up)
  - Feral Cat: Rip duration scaling (10-18s = +50% damage at 5 CP)
  - Feral Bear: Armor HIGHLY valuable (cap removed, continues beyond 75%)
  - Feral Bear: Stamina more valuable (Frenzied Regeneration scaling)
  - Feral Bear: Dodge more valuable (Ancient Brutality rage generation)
  - Restoration: Healing Power HIGHLY valuable (Tree of Life + Gift of Nature)
  - Restoration: Spirit more valuable (Emerald Blessing 5% combat regen)
  - Restoration: Armor more valuable (Tree of Life +180% from items)

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
turtleBalance.SPELLTOHIT = AdjustSpellHitCap(vanillaBalance.SPELLTOHIT)  -- 9.68 → 10.89

-- 2. Spell Haste Baseline Check
turtleBalance.SPELLHASTE = EnsureMinimumHaste(vanillaBalance.SPELLHASTE, vanillaBalance.SPELLCRIT, "caster_dps")

-- 3. Spell Crit EXTREMELY valuable (Eclipse: Damage = 10% + 60% of crit % - CRITICAL)
--    At 30% crit = 28% damage bonus, at 40% crit = 34% damage bonus
--    Conservative: +50% value (massive multiplicative scaling)
turtleBalance.SPELLCRIT = vanillaBalance.SPELLCRIT * 1.5  -- 4.96 → 7.44

-- 4. Spell Power more valuable (Wrath +5%, Hurricane improved, Eclipse amplifies)
--    Conservative: +15% value
turtleBalance.DMG = vanillaBalance.DMG * 1.15  -- 1.0 → 1.15

-- 5. Nature Damage more valuable (Wrath/Moonfire/Starfire scaling + Eclipse)
--    Conservative: +20% value (Nature Eclipse benefits)
turtleBalance.NATUREDMG = vanillaBalance.NATUREDMG * 1.2  -- 0.43 → 0.516

-- 6. Arcane Damage more valuable (Starfire scaling + Eclipse)
--    Conservative: +20% value (Arcane Eclipse benefits)
turtleBalance.ARCANEDMG = vanillaBalance.ARCANEDMG * 1.2  -- 0.64 → 0.768

print("Turtle WoW - Druid - Balance:")
print("  SPELLTOHIT: " .. string.format("%.2f", vanillaBalance.SPELLTOHIT) .. " → " .. string.format("%.2f", turtleBalance.SPELLTOHIT) .. " (+12.5%)")
print("  SPELLCRIT: " .. string.format("%.2f", vanillaBalance.SPELLCRIT) .. " → " .. string.format("%.2f", turtleBalance.SPELLCRIT) .. " (+50% Eclipse scaling!)")
print("  DMG: " .. string.format("%.2f", vanillaBalance.DMG) .. " → " .. string.format("%.2f", turtleBalance.DMG) .. " (+15%)")
print("  NATUREDMG: " .. string.format("%.2f", vanillaBalance.NATUREDMG) .. " → " .. string.format("%.3f", turtleBalance.NATUREDMG) .. " (+20%)")
print("  ARCANEDMG: " .. string.format("%.2f", vanillaBalance.ARCANEDMG) .. " → " .. string.format("%.3f", turtleBalance.ARCANEDMG) .. " (+20%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleBalance

  local set = ItemsOfPower.SetTypes.StatSet:new("Turtle WoW - Druid - Balance", stats)



  if not ItemsOfPower.SetByName["Turtle WoW - Druid - Balance"] then
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Turtle WoW - Druid - Balance")
  else
    print("Updated StatSet: Turtle WoW - Druid - Balance")
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
  CRIT = 5.015,           -- Physical crit
  HASTE = 3.4529,         -- Physical haste
  ARMORIGNORE = 1.5,
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
turtleFeralDamage.TOHIT = AdjustHitCap(vanillaFeralDamage.TOHIT)  -- 5.72 → 6.44

-- 2. Haste Baseline Check
turtleFeralDamage.HASTE = EnsureMinimumHaste(vanillaFeralDamage.HASTE, vanillaFeralDamage.CRIT, "melee_dps")

-- 3. Attack Power more valuable (Ferocious Bite: 0.5% per energy point - better scaling)
--    Conservative: +20% value
turtleFeralDamage.ATTACKPOWER = vanillaFeralDamage.ATTACKPOWER * 1.2  -- 0.59 → 0.708
turtleFeralDamage.ATTACKPOWERFERAL = vanillaFeralDamage.ATTACKPOWERFERAL * 1.2

-- 4. Agility more valuable (MCP removed, relative stat value up + AP/Crit/Dodge)
--    Conservative: +10% value
turtleFeralDamage.AGI = vanillaFeralDamage.AGI * 1.1  -- 1.0 → 1.1

-- 5. Strength more valuable (MCP removed, AP scaling)
--    Conservative: +10% value
turtleFeralDamage.STR = vanillaFeralDamage.STR * 1.1  -- 1.48 → 1.628

-- 6. Crit more valuable (Primal Fury, Open Wounds synergies)
--    Conservative: +10% value
turtleFeralDamage.CRIT = vanillaFeralDamage.CRIT * 1.1  -- 5.015 → 5.517

print("")
print("Turtle WoW - Druid - Feral Damage:")
print("  TOHIT: " .. string.format("%.2f", vanillaFeralDamage.TOHIT) .. " → " .. string.format("%.2f", turtleFeralDamage.TOHIT) .. " (+12.5%)")
print("  AP: " .. string.format("%.2f", vanillaFeralDamage.ATTACKPOWER) .. " → " .. string.format("%.3f", turtleFeralDamage.ATTACKPOWER) .. " (+20% Ferocious Bite)")
print("  AGI: " .. string.format("%.2f", vanillaFeralDamage.AGI) .. " → " .. string.format("%.2f", turtleFeralDamage.AGI) .. " (+10% MCP removed)")
print("  STR: " .. string.format("%.2f", vanillaFeralDamage.STR) .. " → " .. string.format("%.3f", turtleFeralDamage.STR) .. " (+10%)")
print("  CRIT: " .. string.format("%.2f", vanillaFeralDamage.CRIT) .. " → " .. string.format("%.3f", turtleFeralDamage.CRIT) .. " (+10%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleFeralDamage

  local set = ItemsOfPower.SetTypes.StatSet:new("Turtle WoW - Druid - Feral Damage", stats)



  if not ItemsOfPower.SetByName["Turtle WoW - Druid - Feral Damage"] then
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Turtle WoW - Druid - Feral Damage")
  else
    print("Updated StatSet: Turtle WoW - Druid - Feral Damage")
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
  CRIT = 1.275,
  HASTE = 2.4893,
  ARMORIGNORE = 0.75,
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
turtleFeralTank.TOHIT = AdjustHitCap(vanillaFeralTank.TOHIT)  -- 1.50 → 1.69

-- 2. Haste Baseline Check
turtleFeralTank.HASTE = EnsureMinimumHaste(vanillaFeralTank.HASTE, vanillaFeralTank.CRIT, "tank")

-- 3. Armor HIGHLY valuable (cap removed! Continues beyond 75% with diminishing returns - CRITICAL)
--    Conservative: +30% value (massive change from vanilla hard cap)
turtleFeralTank.ARMOR = vanillaFeralTank.ARMOR * 1.3  -- 0.1 → 0.13

-- 4. Stamina more valuable (Frenzied Regeneration: 6/7/8% of stamina per rage point)
--    Conservative: +15% value
turtleFeralTank.STA = vanillaFeralTank.STA * 1.15  -- 1.0 → 1.15

-- 5. Dodge more valuable (Ancient Brutality: generates rage on dodge, Feral Swiftness bonus)
--    Conservative: +15% value
turtleFeralTank.DODGE = vanillaFeralTank.DODGE * 1.15  -- 3.5872 → 4.125

-- 6. Attack Power more valuable (Threat generation: Swipe/Maul/Savage Bite)
--    Note: Swipe nerfed 8% → 4% AP, but still scales
--    Conservative: +10% value
turtleFeralTank.ATTACKPOWER = vanillaFeralTank.ATTACKPOWER * 1.1  -- 0.34 → 0.374
turtleFeralTank.ATTACKPOWERFERAL = vanillaFeralTank.ATTACKPOWERFERAL * 1.1

-- 7. Agility more valuable (Dodge scaling + AP)
--    Conservative: +10% value
turtleFeralTank.AGI = vanillaFeralTank.AGI * 1.1  -- 0.48 → 0.528

print("")
print("Turtle WoW - Druid - Feral Tank:")
print("  TOHIT: " .. string.format("%.2f", vanillaFeralTank.TOHIT) .. " → " .. string.format("%.2f", turtleFeralTank.TOHIT) .. " (+12.5%)")
print("  ARMOR: " .. string.format("%.2f", vanillaFeralTank.ARMOR) .. " → " .. string.format("%.2f", turtleFeralTank.ARMOR) .. " (+30% CAP REMOVED!)")
print("  STA: " .. string.format("%.2f", vanillaFeralTank.STA) .. " → " .. string.format("%.2f", turtleFeralTank.STA) .. " (+15% Frenzied Regen)")
print("  DODGE: " .. string.format("%.2f", vanillaFeralTank.DODGE) .. " → " .. string.format("%.3f", turtleFeralTank.DODGE) .. " (+15% Ancient Brutality)")
print("  AP: " .. string.format("%.2f", vanillaFeralTank.ATTACKPOWER) .. " → " .. string.format("%.3f", turtleFeralTank.ATTACKPOWER) .. " (+10%)")
print("  AGI: " .. string.format("%.2f", vanillaFeralTank.AGI) .. " → " .. string.format("%.3f", turtleFeralTank.AGI) .. " (+10%)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleFeralTank

  local set = ItemsOfPower.SetTypes.StatSet:new("Turtle WoW - Druid - Feral Tank", stats)



  if not ItemsOfPower.SetByName["Turtle WoW - Druid - Feral Tank"] then
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Turtle WoW - Druid - Feral Tank")
  else
    print("Updated StatSet: Turtle WoW - Druid - Feral Tank")
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
turtleRestoration.SPELLHASTE = EnsureMinimumHaste(vanillaRestoration.SPELLHASTE, vanillaRestoration.SPELLCRIT, "healer")

-- 2. Healing Power HIGHLY valuable (Tree of Life Aura + Gift of Nature - DOUBLE MULTIPLICATIVE)
--    - Tree of Life Aura (1.17.0): Changed from flat heal to healing power % multiplier
--    - Gift of Nature (1.18.0): Now increases total healing (multiplicative with healing power)
--    Conservative: +50% value (massive double-scaling change)
turtleRestoration.HEAL = vanillaRestoration.HEAL * 1.5  -- 1.21 → 1.815

-- 3. Spirit more valuable (Emerald Blessing: 5% combat mana regen for raid in 1.17.0)
--    Conservative: +20% value
turtleRestoration.SPI = vanillaRestoration.SPI * 1.2  -- 0.87 → 1.044

-- 4. Armor more valuable (Tree of Life: +180% armor from items in 1.18.0)
--    Conservative: +10% value (situational, only in Tree of Life form)
turtleRestoration.ARMOR = vanillaRestoration.ARMOR * 1.1  -- 0.005 → 0.0055

print("")
print("Turtle WoW - Druid - Restoration:")
print("  HEAL: " .. string.format("%.2f", vanillaRestoration.HEAL) .. " → " .. string.format("%.3f", turtleRestoration.HEAL) .. " (+50% ToL + Gift of Nature!)")
print("  SPI: " .. string.format("%.2f", vanillaRestoration.SPI) .. " → " .. string.format("%.3f", turtleRestoration.SPI) .. " (+20% Emerald Blessing)")
print("  ARMOR: " .. string.format("%.3f", vanillaRestoration.ARMOR) .. " → " .. string.format("%.4f", turtleRestoration.ARMOR) .. " (+10% ToL form)")

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleRestoration

  local set = ItemsOfPower.SetTypes.StatSet:new("Turtle WoW - Druid - Restoration", stats)



  if not ItemsOfPower.SetByName["Turtle WoW - Druid - Restoration"] then
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Turtle WoW - Druid - Restoration")
  else
    print("Updated StatSet: Turtle WoW - Druid - Restoration")
  end
end)

print("")
print("All Turtle WoW Druid StatSets created!")
print("Total: 4 specs")
