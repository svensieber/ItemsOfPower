--[[
  Turtle WoW Stat Adjustment Utilities

  Provides functions to adjust Vanilla stat weights for Turtle WoW specific changes:
  - Hit Cap Reduction: 9% → 8% (Patch 1.17.2)
  - Armor Cap Removal: 75% hard cap → diminishing returns (Patch 1.18.0)
  - Weapon Skill Rework: Linear scaling (Patch 1.17.2)
  - New Stats: Meditation (CASTINGREG), Vampirism (VAMPIR)

  Usage:
    1. Load this file: /script LoadFile("tools/turtle_wow_adjustments.lua")
    2. Use adjustment functions on Vanilla weights
    3. Generate adjusted StatSets

  References:
    - docs/turtle-wow-general-scaling-changes.md
    - docs/ScalingTurtleWoWClaude-Implementation.md
]]

-- ============================================================================
-- HIT CAP ADJUSTMENTS (Patch 1.17.2)
-- ============================================================================

--[[
  Hit Cap Reduction: 9% → 8%

  Impact: Hit is MORE valuable per point (need less to cap)
  Formula: turtleWeight = vanillaWeight * (9/8) = vanillaWeight * 1.125

  Explanation:
  - Vanilla: Need 9% hit = ~84.4 Hit Rating (9.37931 per %)
  - Turtle: Need 8% hit = ~75.0 Hit Rating (9.37931 per %)
  - You reach cap FASTER, so each point of Hit is +12.5% more valuable

  Example:
  - Vanilla Hunter MM: HitRating = 9.38
  - Turtle Hunter MM: HitRating = 9.38 * 1.125 = 10.55
]]
function AdjustHitCap(vanillaHitWeight)
  if not vanillaHitWeight or vanillaHitWeight == 0 then
    return 0
  end

  local HIT_CAP_MULTIPLIER = 9 / 8  -- 1.125
  local adjustedWeight = vanillaHitWeight * HIT_CAP_MULTIPLIER

  return adjustedWeight
end

--[[
  Spell Hit Cap Reduction: 9% → 8%

  Same logic as physical hit, but for spell casters.

  Example:
  - Vanilla Shadow Priest: SpellHitRating = 8.96
  - Turtle Shadow Priest: SpellHitRating = 8.96 * 1.125 = 10.08
]]
function AdjustSpellHitCap(vanillaSpellHitWeight)
  if not vanillaSpellHitWeight or vanillaSpellHitWeight == 0 then
    return 0
  end

  local SPELL_HIT_CAP_MULTIPLIER = 9 / 8  -- 1.125
  local adjustedWeight = vanillaSpellHitWeight * SPELL_HIT_CAP_MULTIPLIER

  return adjustedWeight
end

-- ============================================================================
-- ARMOR CAP ADJUSTMENTS (Patch 1.18.0)
-- ============================================================================

--[[
  Armor Cap Removal: 75% hard cap → diminishing returns

  Impact: Armor is MORE valuable for tanks (no longer worthless at cap)
  Formula: Depends on tank role and existing armor levels

  Conservative approach:
  - Protection Warriors/Paladins: +50% armor value
  - Feral Druids: +40% armor value (already had high armor)

  Aggressive approach (if tank is NOT near cap):
  - Protection Warriors/Paladins: +100% armor value
  - Feral Druids: +75% armor value

  Example:
  - Vanilla Warrior Prot: Armor = 0.02
  - Turtle Warrior Prot (conservative): Armor = 0.02 * 1.5 = 0.03
  - Turtle Warrior Prot (aggressive): Armor = 0.02 * 2.0 = 0.04
]]

-- Tank Role Constants
local TANK_ROLE_MULTIPLIERS = {
  -- Conservative (default)
  ["warrior_prot_conservative"] = 1.5,
  ["paladin_prot_conservative"] = 1.5,
  ["druid_feral_tank_conservative"] = 1.4,

  -- Aggressive (pre-raid / low armor)
  ["warrior_prot_aggressive"] = 2.0,
  ["paladin_prot_aggressive"] = 2.0,
  ["druid_feral_tank_aggressive"] = 1.75,
}

function AdjustArmorForTanks(vanillaArmorWeight, tankRole, aggressive)
  if not vanillaArmorWeight or vanillaArmorWeight == 0 then
    return 0
  end

  -- Default to conservative
  local suffix = aggressive and "_aggressive" or "_conservative"
  local roleKey = tankRole .. suffix

  local multiplier = TANK_ROLE_MULTIPLIERS[roleKey]

  if not multiplier then
    -- Unknown role, return unchanged
    print("WARNING: Unknown tank role: " .. tostring(tankRole))
    return vanillaArmorWeight
  end

  local adjustedWeight = vanillaArmorWeight * multiplier

  return adjustedWeight
end

-- Convenience wrappers
function AdjustArmorForWarriorTank(vanillaArmorWeight, aggressive)
  return AdjustArmorForTanks(vanillaArmorWeight, "warrior_prot", aggressive)
end

function AdjustArmorForPaladinTank(vanillaArmorWeight, aggressive)
  return AdjustArmorForTanks(vanillaArmorWeight, "paladin_prot", aggressive)
end

function AdjustArmorForDruidTank(vanillaArmorWeight, aggressive)
  return AdjustArmorForTanks(vanillaArmorWeight, "druid_feral_tank", aggressive)
end

-- ============================================================================
-- HASTE BASELINE VALUES
-- ============================================================================

--[[
  Haste Rating Baseline Values

  Turtle WoW adds Haste Rating as a more prominent stat.
  Vanilla ClassicHawsJon already has Haste values, but they're conservative.

  Turtle WoW:
  - Physical DPS: Haste is ~0.4-0.9x relative to Crit (depending on spec)
  - Casters: Spell Haste is ~0.6-1.0x relative to Spell Crit

  This function returns a baseline multiplier for Haste relative to Crit.
]]
function GetHasteBaselineMultiplier(role)
  local HASTE_MULTIPLIERS = {
    -- Physical DPS
    ["melee_dps"] = 0.7,        -- Haste = 0.7x Crit value
    ["ranged_dps"] = 0.65,      -- Slightly lower for ranged

    -- Casters
    ["spell_dps"] = 0.8,        -- Spell Haste = 0.8x Spell Crit
    ["healer"] = 0.6,           -- Healers value Haste but Crit less

    -- Tanks
    ["tank"] = 0.5,             -- Tanks value Haste moderately
  }

  return HASTE_MULTIPLIERS[role] or 0.7
end

-- Helper: Adjust existing Haste weight if too low
function EnsureMinimumHaste(currentHasteWeight, critWeight, role)
  local minimumMultiplier = GetHasteBaselineMultiplier(role)
  local minimumHaste = critWeight * minimumMultiplier

  if currentHasteWeight < minimumHaste then
    return minimumHaste
  else
    return currentHasteWeight
  end
end

-- ============================================================================
-- WEAPON SKILL ADJUSTMENTS (Patch 1.17.2)
-- ============================================================================

--[[
  Weapon Skill Rework: Linear scaling instead of breakpoints

  Old System (Vanilla):
  - Breakpoint at 305 weapon skill (soft cap)
  - Racial bonuses: +5
  - Awkward scaling

  New System (Turtle WoW):
  - Linear: Each point = +0.2% hit chance
  - Each point reduces glancing damage by 2%
  - Racial bonuses: +3 (reduced from +5)
  - No soft cap

  Impact:
  - Weapon skill items consistently valuable
  - No magic 305 number
  - Weapon skill weight: ~5 per point (rough estimate)

  Note: Weapon skill is NOT a stat in ItemBonusLib, so this is mostly
  informational. Can be used if we want to add manual notes.
]]
function GetWeaponSkillValue()
  -- Weapon skill in Turtle WoW
  -- Each point = +0.2% hit + glancing reduction
  -- Roughly equivalent to 0.2% hit = ~1.88 hit rating value
  -- Conservative estimate: 5.0 per weapon skill point

  return 5.0
end

-- ============================================================================
-- NEW TURTLE WOW STATS
-- ============================================================================

--[[
  Meditation (CASTINGREG) - Patch 1.16.0

  Effect: 5% of mana regen continues during combat PER ITEM with Meditation

  Impact:
  - EXTREMELY valuable for healers (mana sustain)
  - Each piece with Meditation = 5% more regen
  - Full set with Meditation = huge mana sustain

  Baseline weights:
  - Healers: CASTINGREG = 1.5-2.5x Mp5 value
  - Casters (DPS): CASTINGREG = 0.3-0.5x Mp5 value (if OOM issues)
]]
function GetCastingRegenWeight(role, mp5Weight)
  if not mp5Weight or mp5Weight == 0 then
    mp5Weight = 1.0  -- Default fallback
  end

  local CASTING_REGEN_MULTIPLIERS = {
    ["healer_disc"] = 2.5,      -- Discipline Priest - VERY valuable
    ["healer_holy"] = 2.0,      -- Holy Priest/Paladin
    ["healer_resto"] = 2.0,     -- Resto Druid/Shaman
    ["caster_dps"] = 0.4,       -- Casters - moderate value
    ["caster_oom"] = 0.8,       -- Casters with OOM issues (Arcane Mage)
  }

  local multiplier = CASTING_REGEN_MULTIPLIERS[role]
  if not multiplier then
    return 0  -- Not applicable
  end

  return mp5Weight * multiplier
end

--[[
  Vampirism (VAMPIR)

  Effect: Vampirism Rating - life drain effects

  Impact:
  - Useful for Warlocks (Drain Life builds)
  - Minimal value for other classes

  Baseline weights:
  - Warlock (Affliction): VAMPIR = 0.1-0.2
  - Others: VAMPIR = 0 (not useful)
]]
function GetVampirismWeight(className, specName)
  if className == "Warlock" then
    if specName == "Affliction" then
      return 0.15  -- Moderate value for Drain Life
    else
      return 0.05  -- Minimal value for other specs
    end
  end

  return 0  -- Not useful for other classes
end

-- ============================================================================
-- COMPREHENSIVE ADJUSTMENT FUNCTION
-- ============================================================================

--[[
  Apply all Turtle WoW adjustments to Vanilla stats

  Takes a Vanilla IoP stats table and adjusts it for Turtle WoW.

  Adjustments made:
  1. Hit Cap: +12.5% for TOHIT
  2. Spell Hit Cap: +12.5% for SPELLTOHIT
  3. Armor (if tank): +25-50%
  4. Haste: Ensure minimum baseline
  5. New Stats: Add CASTINGREG, VAMPIR

  Parameters:
  - vanillaStats: IoP stats table (from Vanilla conversion)
  - className: Class name (e.g., "Warrior", "Priest")
  - specName: Spec name (e.g., "Arms", "Shadow")
  - role: Role type (e.g., "melee_dps", "tank", "healer")
  - aggressive: Use aggressive armor multiplier for tanks

  Returns:
  - Adjusted stats table (Turtle WoW)
]]
function ApplyTurtleWoWAdjustments(vanillaStats, className, specName, role, aggressive)
  -- Make a copy to avoid modifying original
  local turtleStats = {}
  for k, v in pairs(vanillaStats) do
    turtleStats[k] = v
  end

  -- 1. Hit Cap Adjustment
  if turtleStats.TOHIT and turtleStats.TOHIT > 0 then
    turtleStats.TOHIT = AdjustHitCap(turtleStats.TOHIT)
  end

  -- 2. Spell Hit Cap Adjustment
  if turtleStats.SPELLTOHIT and turtleStats.SPELLTOHIT > 0 then
    turtleStats.SPELLTOHIT = AdjustSpellHitCap(turtleStats.SPELLTOHIT)
  end

  -- 3. Armor Adjustment (for tanks)
  if role == "tank" and turtleStats.ARMOR and turtleStats.ARMOR > 0 then
    if className == "Warrior" then
      turtleStats.ARMOR = AdjustArmorForWarriorTank(turtleStats.ARMOR, aggressive)
    elseif className == "Paladin" then
      turtleStats.ARMOR = AdjustArmorForPaladinTank(turtleStats.ARMOR, aggressive)
    elseif className == "Druid" then
      turtleStats.ARMOR = AdjustArmorForDruidTank(turtleStats.ARMOR, aggressive)
    end
  end

  -- 4. Haste Baseline Check
  if turtleStats.HASTE and turtleStats.CRIT then
    turtleStats.HASTE = EnsureMinimumHaste(turtleStats.HASTE, turtleStats.CRIT, role)
  end

  if turtleStats.SPELLHASTE and turtleStats.SPELLCRIT then
    local spellRole = (role == "healer") and "healer" or "spell_dps"
    turtleStats.SPELLHASTE = EnsureMinimumHaste(turtleStats.SPELLHASTE, turtleStats.SPELLCRIT, spellRole)
  end

  -- 5. New Stats: CASTINGREG (Meditation)
  if role == "healer" or role == "caster_dps" or role == "caster_oom" then
    local mp5Weight = turtleStats.MANAREG or 1.0
    turtleStats.CASTINGREG = GetCastingRegenWeight(role .. (role == "healer" and "_resto" or ""), mp5Weight)
  end

  -- 6. New Stats: VAMPIR (Vampirism)
  local vampirWeight = GetVampirismWeight(className, specName)
  if vampirWeight > 0 then
    turtleStats.VAMPIR = vampirWeight
  end

  return turtleStats
end

-- ============================================================================
-- HELPER: DETECT ROLE FROM SPEC
-- ============================================================================

--[[
  Automatically detect role from class + spec name

  Returns: "melee_dps", "ranged_dps", "spell_dps", "healer", "tank"
]]
function DetectRole(className, specName)
  local ROLE_MAP = {
    -- Druid
    ["Druid"] = {
      ["Balance"] = "spell_dps",
      ["Feral (Damage)"] = "melee_dps",
      ["Feral Damage"] = "melee_dps",
      ["Feral (Tank)"] = "tank",
      ["Feral Tank"] = "tank",
      ["Restoration"] = "healer",
    },

    -- Hunter
    ["Hunter"] = {
      ["Beast Mastery"] = "ranged_dps",
      ["Marksmanship"] = "ranged_dps",
      ["Survival"] = "ranged_dps",
    },

    -- Mage
    ["Mage"] = {
      ["Arcane"] = "spell_dps",
      ["Fire"] = "spell_dps",
      ["Frost"] = "spell_dps",
    },

    -- Paladin
    ["Paladin"] = {
      ["Holy"] = "healer",
      ["Protection"] = "tank",
      ["Retribution"] = "melee_dps",
    },

    -- Priest
    ["Priest"] = {
      ["Discipline"] = "healer",  -- Vanilla (becomes DPS in Turtle WoW!)
      ["Holy"] = "healer",
      ["Shadow"] = "spell_dps",
    },

    -- Rogue
    ["Rogue"] = {
      ["Assassination"] = "melee_dps",
      ["Combat"] = "melee_dps",
      ["Subtlety"] = "melee_dps",
    },

    -- Shaman
    ["Shaman"] = {
      ["Elemental"] = "spell_dps",
      ["Enhancement"] = "melee_dps",
      ["Restoration"] = "healer",
    },

    -- Warlock
    ["Warlock"] = {
      ["Affliction"] = "spell_dps",
      ["Demonology"] = "spell_dps",
      ["Destruction"] = "spell_dps",
    },

    -- Warrior
    ["Warrior"] = {
      ["Arms"] = "melee_dps",
      ["Fury"] = "melee_dps",
      ["Protection"] = "tank",
    },
  }

  if ROLE_MAP[className] and ROLE_MAP[className][specName] then
    return ROLE_MAP[className][specName]
  end

  -- Fallback: guess from spec name
  if string.find(specName, "Tank") or string.find(specName, "Protection") then
    return "tank"
  elseif string.find(specName, "Heal") or string.find(specName, "Restoration") or string.find(specName, "Holy") then
    return "healer"
  else
    return "melee_dps"  -- Default
  end
end

-- ============================================================================
-- TEST FUNCTIONS
-- ============================================================================

function TestAdjustments()
  print("=== Testing Turtle WoW Adjustments ===\n")

  -- Test 1: Hit Cap Adjustment
  print("Test 1: Hit Cap Adjustment")
  local vanillaHit = 9.38
  local turtleHit = AdjustHitCap(vanillaHit)
  print(string.format("  Vanilla Hit: %.2f", vanillaHit))
  print(string.format("  Turtle Hit: %.2f (+%.1f%%)", turtleHit, ((turtleHit / vanillaHit) - 1) * 100))
  print("")

  -- Test 2: Armor Adjustment for Tank
  print("Test 2: Armor Adjustment (Warrior Tank)")
  local vanillaArmor = 0.02
  local turtleArmorConservative = AdjustArmorForWarriorTank(vanillaArmor, false)
  local turtleArmorAggressive = AdjustArmorForWarriorTank(vanillaArmor, true)
  print(string.format("  Vanilla Armor: %.3f", vanillaArmor))
  print(string.format("  Turtle Armor (Conservative): %.3f (+50%%)", turtleArmorConservative))
  print(string.format("  Turtle Armor (Aggressive): %.3f (+100%%)", turtleArmorAggressive))
  print("")

  -- Test 3: CASTINGREG for Healer
  print("Test 3: CASTINGREG Weight (Resto Druid)")
  local mp5Weight = 1.7
  local castingRegenWeight = GetCastingRegenWeight("healer_resto", mp5Weight)
  print(string.format("  Mp5 Weight: %.2f", mp5Weight))
  print(string.format("  CASTINGREG Weight: %.2f (2x Mp5)", castingRegenWeight))
  print("")

  -- Test 4: Comprehensive Adjustment
  print("Test 4: Comprehensive Adjustment (Hunter MM)")
  local vanillaStats = {
    AGI = 1.0,
    TOHIT = 9.38,
    CRIT = 5.1,
    HASTE = 3.21,
    ATTACKPOWER = 0.55,
  }

  local turtleStats = ApplyTurtleWoWAdjustments(vanillaStats, "Hunter", "Marksmanship", "ranged_dps", false)

  print("  Vanilla → Turtle:")
  print(string.format("    TOHIT: %.2f → %.2f", vanillaStats.TOHIT, turtleStats.TOHIT))
  print(string.format("    HASTE: %.2f → %.2f", vanillaStats.HASTE, turtleStats.HASTE))
  print("")

  print("=== Tests Complete ===")
end

-- ============================================================================
-- LOAD MESSAGE
-- ============================================================================

print("Turtle WoW Adjustment Utilities loaded!")
print("Functions:")
print("  AdjustHitCap(weight) - Adjust Hit Rating for 8% cap")
print("  AdjustSpellHitCap(weight) - Adjust Spell Hit for 8% cap")
print("  AdjustArmorForTanks(weight, role, aggressive) - Adjust Armor for tanks")
print("  ApplyTurtleWoWAdjustments(stats, class, spec, role, aggressive) - Apply all adjustments")
print("  TestAdjustments() - Run test suite")
print("")
print("Usage:")
print("  TestAdjustments()  - Run tests")
print("")
