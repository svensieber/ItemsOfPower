--[[
  Turtle WoW Mage StatSets

  Based on Vanilla ClassicHawsJon weights with Turtle WoW adjustments.

  Changes from Vanilla:
  - Spell Hit Cap: 9% → 8% (all specs: +12.5% Spell Hit value)
  - Spell Haste: Baseline adjustments

  Arcane:
  - Arcane Power (1.17.2): +30% haste, drains 1% mana/sec, death <10% mana
  - Arcane Potency: +50/100% crit damage (1.16.1→1.17.2)
  - Arcane Meditation: TRIPLED below 35% mana (20%→60% regen while casting)
  - Accelerated Arcana: Haste scales cooldown recovery + AM tick speed
  - Resonance Cascade: 4-20% chance to duplicate for 50% damage, chains 4x
  - Arcane Missiles: 32.8% coefficient, Arcane Rupture: 90% coefficient

  Fire:
  - Hot Streak (1.17.2): Fireball/Fire Blast crits reduce Pyroblast by 1s/stack (5 max)
  - Master of Elements: 15/30/45% mana refund on crit
  - Ignite (1.18.0): Duration 4s, threat split among mages

  Frost:
  - Icicles (1.17.2): New rotational ability, 40% SP per icicle, roots caster
  - Ice Barrier: +15% Frost damage while active (1.17.2)
  - Shatter nerfed: 50% → 35% vs frozen, but Flash Freeze synergies

  References:
  - docs/turtle-wow-mage-scaling-changes.md
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
-- ARCANE
-- ============================================================================

-- Vanilla Baseline
local vanillaArcane = ApplyMultiplier({
  INT = 0.46,
  SPI = 0.59,
  STA = 0.1,
  AGI = 0.05,
  DMG = 1.0,              -- Generic spell damage
  ARCANEDMG = 0.88,       -- Arcane damage
  FROSTDMG = 0.52,        -- Frost damage (hybrid)
  FIREDMG = 0.064,        -- Fire damage (low)
  SPELLTOHIT = 6.96,      -- Pre-multiplied
  SPELLCRIT = 4.8,        -- Spell crit
  SPELLHASTE = 4.7377,    -- Spell haste
  SPELLPEN = 0.09,
  MANA = 0.038,
  MANAREG = 1.13,
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

-- Turtle WoW Adjustments for Arcane
local turtleArcane = {}
for k, v in pairs(vanillaArcane) do
  turtleArcane[k] = v
end

-- 1. Spell Hit Cap Adjustment: 9% → 8% (+12.5%)
turtleArcane.SPELLTOHIT = vanillaArcane.SPELLTOHIT * 1.125  -- 6.96 → 7.83

-- 2. Spell Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 3. Spell Crit HIGHLY valuable (Arcane Potency: +50/100% crit damage - CRITICAL)
--    +75% value for doubled crit damage
turtleArcane.SPELLCRIT = vanillaArcane.SPELLCRIT * 1.75  -- 4.8 → 8.4

-- 4. Spell Power HIGHLY valuable (Arcane Missiles 32.8%, Arcane Rupture 90%, Resonance Cascade)
--    +35% value for multiplicative cascade stacking
turtleArcane.DMG = vanillaArcane.DMG * 1.35  -- 1.0 → 1.35

-- 5. Arcane Damage more valuable (Arcane Missiles scaling, Arcane Rupture buff)
--    Conservative: +30% value
turtleArcane.ARCANEDMG = vanillaArcane.ARCANEDMG * 1.3  -- 0.88 → 1.144

-- 6. Spirit HIGHLY valuable (Arcane Meditation TRIPLED below 35% mana: 20% → 60%)
--    +150% value (averaged over fight, execute phase is massive)
turtleArcane.SPI = vanillaArcane.SPI * 2.5  -- 0.59 → 1.475

-- 7. Intellect more valuable (Arcane Power: instant death <10% mana, need large pool)
--    +50% value for survival requirement
turtleArcane.INT = vanillaArcane.INT * 1.5  -- 0.46 → 0.69

-- 8. Haste more valuable (Accelerated Arcana: cooldown recovery + Arcane Missiles tick speed)
--    +40% value for dual scaling (CD recovery + tick speed)
turtleArcane.SPELLHASTE = turtleArcane.SPELLHASTE * 1.4  -- 4.74 → 6.63

-- 9. Add CASTINGREG support (Meditation items in 1.16.0, medium-high value for Arcane)
--    Arcane Meditation synergy, mana-hungry spec
turtleArcane.CASTINGREG = 8.0  -- Medium-high value for Arcane mana efficiency

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleArcane

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Mage_Arcane", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Mage_Arcane"] then
    ItemsOfPower:RegisterSet(set)
  end
end)

-- ============================================================================
-- FIRE
-- ============================================================================

-- Vanilla Baseline
local vanillaFire = ApplyMultiplier({
  INT = 0.44,
  SPI = 0.066,
  STA = 0.1,
  AGI = 0.05,
  DMG = 1.0,              -- Generic spell damage
  FIREDMG = 0.94,         -- Fire damage
  ARCANEDMG = 0.168,      -- Arcane damage (low)
  FROSTDMG = 0.32,        -- Frost damage (low)
  SPELLTOHIT = 7.44,      -- Pre-multiplied
  SPELLCRIT = 6.16,       -- Spell crit (HIGH in vanilla)
  SPELLHASTE = 6.5846,    -- Spell haste
  SPELLPEN = 0.09,
  MANA = 0.036,
  MANAREG = 0.9,
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

-- Turtle WoW Adjustments for Fire
local turtleFire = {}
for k, v in pairs(vanillaFire) do
  turtleFire[k] = v
end

-- 1. Spell Hit Cap Adjustment: 9% → 8% (+12.5%)
turtleFire.SPELLTOHIT = vanillaFire.SPELLTOHIT * 1.125  -- 7.44 → 8.37

-- 2. Spell Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 3. Spell Crit HIGHLY valuable (Hot Streak procs, Master of Elements 45% mana refund, Ignite)
--    +50% value for Hot Streak stack reduction + mana refund
turtleFire.SPELLCRIT = vanillaFire.SPELLCRIT * 1.5  -- 6.16 → 9.24

-- 4. Spell Power more valuable (Fireball/Pyroblast/Fire Blast scaling improved)
--    Conservative: +15% value
turtleFire.DMG = vanillaFire.DMG * 1.15  -- 1.0 → 1.15

-- 5. Fire Damage more valuable (Hot Streak Pyroblast, Ignite scaling)
--    Conservative: +20% value
turtleFire.FIREDMG = vanillaFire.FIREDMG * 1.2  -- 0.94 → 1.128

-- 6. Haste more valuable (More casts, more Hot Streak procs, faster Pyroblast at 5 stacks)
--    Conservative: +10% value
turtleFire.SPELLHASTE = turtleFire.SPELLHASTE * 1.1  -- 6.58 → 7.24

-- 7. Add CASTINGREG support (Meditation items in 1.16.0, medium value for Fire)
turtleFire.CASTINGREG = 5.0  -- Medium value for Fire mana efficiency

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleFire

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Mage_Fire", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Mage_Fire"] then
    ItemsOfPower:RegisterSet(set)
  end
end)

-- ============================================================================
-- FROST
-- ============================================================================

-- Vanilla Baseline
local vanillaFrost = ApplyMultiplier({
  INT = 0.37,
  SPI = 0.06,
  STA = 0.1,
  AGI = 0.05,
  DMG = 1.0,              -- Generic spell damage
  FROSTDMG = 0.95,        -- Frost damage
  ARCANEDMG = 0.13,       -- Arcane damage (low)
  FIREDMG = 0.05,         -- Fire damage (very low)
  SPELLTOHIT = 9.76,      -- Pre-multiplied (HIGHEST of all Mage specs)
  SPELLCRIT = 4.64,       -- Spell crit
  SPELLHASTE = 5.0589,    -- Spell haste
  SPELLPEN = 0.07,
  MANA = 0.032,
  MANAREG = 0.8,
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

-- Turtle WoW Adjustments for Frost
local turtleFrost = {}
for k, v in pairs(vanillaFrost) do
  turtleFrost[k] = v
end

-- 1. Spell Hit Cap Adjustment: 9% → 8% (+12.5%)
turtleFrost.SPELLTOHIT = vanillaFrost.SPELLTOHIT * 1.125  -- 9.76 → 10.98

-- 2. Spell Haste Baseline Check
-- Haste baseline check removed (vanilla values are correct)

-- 3. Spell Power more valuable (Frostbolt, Icicles 40% per icicle, Ice Barrier +15% Frost damage)
--    +35% value for Icicles + Ice Barrier damage bonus
turtleFrost.DMG = vanillaFrost.DMG * 1.35  -- 1.0 → 1.35

-- 4. Frost Damage more valuable (Icicles, Ice Barrier +15% Frost damage while active)
--    +40% value for Ice Barrier uptime damage bonus
turtleFrost.FROSTDMG = vanillaFrost.FROSTDMG * 1.4  -- 0.95 → 1.33

-- 5. Crit slightly less valuable (Shatter nerfed: 50% → 35% vs frozen, but Flash Freeze synergies)
--    Conservative: Net -5% value (nerf offset by new synergies)
turtleFrost.SPELLCRIT = vanillaFrost.SPELLCRIT * 0.95  -- 4.64 → 4.408

-- 6. Haste more valuable (More Frostbolts, more Icicles procs via crits)
--    Conservative: +10% value
turtleFrost.SPELLHASTE = turtleFrost.SPELLHASTE * 1.1  -- 5.06 → 5.56

-- 7. Add CASTINGREG support (Meditation items in 1.16.0, medium value for Frost)
turtleFrost.CASTINGREG = 5.0  -- Medium value for Frost mana efficiency

-- Queue StatSet creation (delayed until OnEnable)
table.insert(ItemsOfPower_PendingStatSets, function()
  local stats = turtleFrost

  local set = ItemsOfPower.SetTypes.StatSet:new("TurtleWoW_Mage_Frost", stats)



  if not ItemsOfPower.SetByName["TurtleWoW_Mage_Frost"] then
    ItemsOfPower:RegisterSet(set)
  end
end)
