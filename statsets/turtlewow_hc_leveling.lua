--[[
  Turtle WoW Hardcore Leveling StatSets

  One set per class, for the most effective HC leveling spec.
  Based on TurtleWoW 1.18.1 raid weights with HC survival adjustments.

  HC Leveling Philosophy:
  - Survival is #1 priority (one death = permanent)
  - Stamina greatly increased (×4-6 from raid baseline)
  - Spirit increased (health/mana regen between fights = less downtime)
  - Intellect increased for mana classes (larger pool = more safety margin)
  - Defensive stats (Armor, Dodge, Parry, Health) greatly increased
  - Hit Rating reduced (only ~5% needed vs +2 mobs, not 9% raid bosses)
  - Crit/Haste reduced (less rotation optimization, more sustain)
  - ArmorPen minimal (irrelevant while leveling)
  - Resistances doubled (unexpected elemental damage can kill)
  - Primary damage stats (STR/AGI/AP/DMG/WeaponDPS) mostly preserved
    (fast kills = fewer dangerous situations)

  Spec choices per class:
  - Warrior: Arms (Mortal Strike, Sweeping Strikes for multi-mob)
  - Hunter: Beast Mastery (pet tanks, safest leveling class)
  - Mage: Frost (kiting, Ice Barrier, Frost Nova)
  - Paladin: Retribution (melee DPS + self-healing)
  - Priest: Shadow (Shadow Form, VE sustain, damage + self-heal)
  - Rogue: Combat (sustained damage, Blade Flurry for emergencies)
  - Warlock: Affliction (DoTs + Drain Life + pet, very safe)
  - Shaman: Enhancement (Windfury, self-heal, Ghost Wolf mobility)
  - Druid: Feral (cat DPS, bear form for emergencies, self-heal)
]]

-- Initialize pending StatSets queue
if not ItemsOfPower_PendingStatSets then
  ItemsOfPower_PendingStatSets = {}
end

-- Helper: Register new set OR update existing set's stats
local function RegisterOrUpdateStatSet(name, stats)
  local existingSet = ItemsOfPower.SetByName[name]
  if existingSet then
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

local DISPLAY_MULTIPLIER = 10

local function ApplyMultiplier(statTable)
  local result = {}
  for k, v in pairs(statTable) do
    result[k] = v * DISPLAY_MULTIPLIER
  end
  return result
end

-- ============================================================================
-- WARRIOR ARMS HC
-- Mortal Strike + Sweeping Strikes, good single target + cleave
-- Key HC stats: Weapon DPS (main damage), STR, STA (survival)
-- Spirit is valuable for health regen between pulls (no self-heal)
-- ============================================================================

local hcWarriorArms = ApplyMultiplier({
  STR = 1.0,              -- Main damage stat
  AGI = 0.65,             -- Crit + dodge + armor
  STA = 0.55,             -- HC: ×5.5 from raid 0.1 (survival priority)
  SPI = 0.20,             -- HC: ×4 from raid 0.05 (health regen between pulls)
  ATTACKPOWER = 0.50,     -- Reduced from TW raid 0.608
  TOHIT = 5.0,            -- HC: reduced from raid ~10.5 (only ~5% needed)
  EXPERTISE = 1.5,        -- Reduced from raid 2.34
  CRIT = 5.5,             -- HC: reduced from TW raid ~10.1 (less burst-focused)
  HASTE = 3.5,            -- HC: reduced from TW raid ~5.3
  ARMORPEN = 1.5,         -- HC: reduced from TW raid ~3.7 (minimal value leveling)
  WEAPONDPS = 5.0,        -- Keep high: main damage source for warriors
  HEALTH = 0.05,          -- HC: ×5 from raid 0.01
  HEALTHREG = 2.5,        -- HC: ×2.5 from raid 1.0 (sustain)
  ARMOR = 0.025,          -- HC: ×5 from raid 0.005
  DEFENSE = 0.15,         -- HC: ×2 from raid 0.075
  DODGE = 1.4,            -- HC: ×3 from raid 0.472
  PARRY = 1.4,            -- HC: ×3 from raid 0.472
  RESILIENCE = 0.3,
  FIRERES = 0.48,         -- HC: ×2 from raid 0.24
  FROSTRES = 0.48,
  ARCANERES = 0.48,
  SHADOWRES = 0.48,
  NATURERES = 0.48,
})

table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_HC_Warrior_Arms", hcWarriorArms)
end)

-- ============================================================================
-- HUNTER BEAST MASTERY HC
-- Pet tanks everything, safest leveling class
-- Key HC stats: AGI (primary), Ranged Weapon DPS, STA (pet + hunter)
-- INT valuable (larger mana pool for more shots before drinking)
-- ============================================================================

local hcHunterBM = ApplyMultiplier({
  AGI = 1.0,              -- Primary stat: AP, crit, dodge, armor
  STR = 0.05,             -- Irrelevant for ranged
  STA = 0.60,             -- HC: ×6 from raid 0.1 (pet + hunter survival)
  INT = 0.45,             -- HC: ×1.8 from raid 0.25 (mana pool for safety)
  SPI = 0.15,             -- HC: ×3 from raid 0.05 (mana regen between fights)
  ATTACKPOWER = 0.55,     -- Reduced from TW raid ~0.71 (pet benefits via Spirit Bond)
  RANGEDATTACKPOWER = 0.55,
  TOHIT = 5.0,            -- HC: reduced from TW raid ~11.3 (only ~5% needed)
  CRIT = 5.0,             -- HC: reduced from TW raid ~9.2 (Kill Command procs)
  HASTE = 3.0,            -- HC: reduced from TW raid ~4.4
  RANGEDWEAPONDPS = 2.5,  -- Keep high: main damage source
  ARMORPEN = 0.35,        -- HC: reduced from TW raid ~0.64
  MANA = 0.12,            -- HC: ×1.6 from raid 0.075
  MANAREG = 2.8,          -- HC: increased from TW raid 2.04 (sustain)
  HEALTH = 0.05,          -- HC: ×5 from raid 0.01
  HEALTHREG = 2.5,        -- HC: ×2.5 from raid 1.0
  ARMOR = 0.02,           -- HC: ×4 from raid 0.005
  DEFENSE = 0.15,         -- HC: ×2 from raid 0.075
  DODGE = 1.4,            -- HC: ×3 from raid 0.472
  PARRY = 1.4,            -- HC: ×3
  RESILIENCE = 0.3,
  FIRERES = 0.48,         -- HC: ×2
  FROSTRES = 0.48,
  ARCANERES = 0.48,
  SHADOWRES = 0.48,
  NATURERES = 0.48,
})

table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_HC_Hunter_BM", hcHunterBM)
end)

-- ============================================================================
-- MAGE FROST HC
-- Ice Barrier, Frost Nova kiting, high control and safety
-- Key HC stats: INT (mana pool), STA (survive burst), Spell Power
-- Spirit valuable (mana regen between pulls, Evocation)
-- ============================================================================

local hcMageFrost = ApplyMultiplier({
  INT = 0.55,             -- HC: ×1.49 from raid 0.37 (mana pool = more spells = safer)
  SPI = 0.20,             -- HC: ×3.3 from raid 0.06 (mana regen between fights)
  STA = 0.45,             -- HC: ×4.5 from raid 0.1 (survive burst damage)
  AGI = 0.05,             -- Unchanged
  DMG = 1.2,              -- Reduced from TW raid 1.40 (kill speed still matters)
  FROSTDMG = 1.15,        -- Reduced from TW raid 1.38 (main school)
  ARCANEDMG = 0.10,       -- Minor (Arcane Explosion emergency AoE)
  FIREDMG = 0.04,         -- Minimal
  SPELLTOHIT = 5.5,       -- HC: reduced from TW raid ~11.0 (less needed leveling)
  SPELLCRIT = 3.5,        -- HC: reduced from raid 4.64 (Shatter still works on frozen)
  SPELLHASTE = 3.5,       -- HC: reduced from TW raid ~5.6
  SPELLPEN = 0.05,        -- Minimal
  MANA = 0.06,            -- HC: ×1.875 from raid 0.032
  MANAREG = 1.5,          -- HC: ×1.875 from raid 0.8 (sustain)
  CASTINGREG = 4.0,       -- Slightly reduced from raid 5.0
  HEALTH = 0.05,          -- HC: ×5 from raid 0.01
  HEALTHREG = 2.5,        -- HC: ×2.5 from raid 1.0
  ARMOR = 0.025,          -- HC: ×5 from raid 0.005 (cloth = squishy)
  DEFENSE = 0.15,         -- HC: ×2
  DODGE = 1.4,            -- HC: ×3
  PARRY = 1.4,            -- HC: ×3
  RESILIENCE = 0.3,
  FIRERES = 0.48,         -- HC: ×2
  FROSTRES = 0.48,
  ARCANERES = 0.48,
  SHADOWRES = 0.48,
  NATURERES = 0.48,
})

table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_HC_Mage_Frost", hcMageFrost)
end)

-- ============================================================================
-- PALADIN RETRIBUTION HC
-- Melee DPS with self-healing (Int > Stam for effective HP!)
-- Key insight: 7 Int = 105 mana ~ 1 Flash of Light (170 HP heal) > 70 HP from 7 Stam
-- Int is the strongest "survival" stat for Paladin due to mana-to-heal conversion
-- ============================================================================

local hcPaladinRet = ApplyMultiplier({
  STR = 1.0,              -- Main melee stat
  AGI = 0.55,             -- Reduced from raid 0.64 (crit + dodge)
  STA = 0.55,             -- HC: ×5.5 from raid 0.1 (high but below INT)
  INT = 0.65,             -- HC: ×1.9 from raid 0.34 (mana = heals = effective HP)
  SPI = 0.15,             -- HC: ×3 from raid 0.05 (mana + health regen)
  ATTACKPOWER = 0.40,     -- Reduced from TW raid 0.47
  TOHIT = 4.5,            -- HC: reduced from TW raid ~8.9
  EXPERTISE = 0.55,       -- Reduced from raid 0.87
  CRIT = 4.0,             -- HC: reduced from TW raid ~6.5
  HASTE = 1.8,            -- HC: reduced from TW raid ~2.4
  ARMORPEN = 0.05,        -- HC: minimal
  WEAPONDPS = 5.0,        -- Keep high: main damage + Seal procs
  DMG = 0.35,             -- Spell damage (Seals, Judgements)
  HOLYDMG = 0.35,         -- Holy damage
  SPELLTOHIT = 1.2,       -- Reduced from raid 1.89
  SPELLCRIT = 0.7,        -- Reduced
  HEAL = 0.30,            -- HC: self-healing value (not in raid set)
  MANA = 0.05,            -- HC: increased (mana = heals)
  MANAREG = 2.0,          -- HC: ×2 from raid 1.0 (heal sustain)
  CASTINGREG = 5.0,       -- HC: increased from raid 4.0 (combat mana for heals)
  HEALTH = 0.05,          -- HC: ×5 from raid 0.01
  HEALTHREG = 2.0,        -- HC: ×2 from raid 1.0
  ARMOR = 0.025,          -- HC: ×5 from raid 0.005
  DEFENSE = 0.15,         -- HC: ×2
  DODGE = 1.4,            -- HC: ×3
  PARRY = 1.4,            -- HC: ×3
  RESILIENCE = 0.3,
  FIRERES = 0.48,         -- HC: ×2
  FROSTRES = 0.48,
  ARCANERES = 0.48,
  SHADOWRES = 0.48,
  NATURERES = 0.48,
})

table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_HC_Paladin_Retribution", hcPaladinRet)
end)

-- ============================================================================
-- PRIEST SHADOW HC
-- Shadow Form + Vampiric Embrace sustain, good damage + self-healing
-- Key HC stats: STA (cloth = squishy), INT (mana pool), SPI (Shadowform regen)
-- Shadow Mend (50% HEAL + 20% shadow SP) provides emergency healing
-- ============================================================================

local hcPriestShadow = ApplyMultiplier({
  INT = 0.45,             -- HC: ×2.4 from raid 0.19 (mana pool)
  SPI = 0.50,             -- HC: increased from TW raid 0.42 (Shadowform 15% regen)
  STA = 0.50,             -- HC: ×5 from raid 0.1 (cloth = very squishy)
  AGI = 0.05,             -- Unchanged
  DMG = 1.1,              -- Reduced from TW raid 1.42 (kill speed still matters)
  SHADOWDMG = 1.15,       -- Reduced from TW raid 1.47 (main school)
  SPELLTOHIT = 5.0,       -- HC: reduced from TW raid ~10.1
  SPELLCRIT = 4.0,        -- HC: reduced from raid 6.08
  SPELLHASTE = 3.5,       -- HC: reduced from raid 5.22
  SPELLPEN = 0.05,        -- Minimal
  HEAL = 0.25,            -- HC: Shadow Mend self-healing (50% HEAL coefficient)
  MANA = 0.035,           -- HC: ×2 from raid 0.017
  MANAREG = 1.5,          -- HC: ×1.5 from raid 1.0
  CASTINGREG = 5.0,       -- Same as raid (Shadowform regen already handles this)
  HEALTH = 0.05,          -- HC: ×5 from raid 0.01
  HEALTHREG = 2.5,        -- HC: ×2.5 from raid 1.0
  ARMOR = 0.025,          -- HC: ×5 from raid 0.005 (cloth = squishy)
  DEFENSE = 0.15,         -- HC: ×2
  DODGE = 1.4,            -- HC: ×3
  PARRY = 1.4,            -- HC: ×3
  RESILIENCE = 0.3,
  FIRERES = 0.48,         -- HC: ×2
  FROSTRES = 0.48,
  ARCANERES = 0.48,
  SHADOWRES = 0.48,
  NATURERES = 0.48,
})

table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_HC_Priest_Shadow", hcPriestShadow)
end)

-- ============================================================================
-- ROGUE COMBAT HC
-- Sustained damage, Blade Flurry for multi-mob, Evasion for emergencies
-- Most dangerous class for HC (melee, no self-heal, leather armor)
-- Key HC stats: AGI (dodge = survival), STA (very squishy), WEAPONDPS
-- ============================================================================

local hcRogueCombat = ApplyMultiplier({
  AGI = 1.2,              -- Primary stat: AP + crit + dodge (dodge = survival)
  STR = 0.45,             -- Reduced from raid 0.5
  STA = 0.65,             -- HC: ×6.5 from raid 0.1 (squishiest melee class)
  SPI = 0.15,             -- HC: ×3 from raid 0.05 (health regen between fights)
  ATTACKPOWER = 0.45,     -- Reduced from TW raid 0.56
  TOHIT = 5.0,            -- HC: reduced from TW raid ~10.6
  EXPERTISE = 0.70,       -- Reduced from raid 1.1
  CRIT = 5.0,             -- HC: reduced from TW raid ~7.6
  HASTE = 5.0,            -- HC: reduced from raid 7.23 (energy regen still important)
  ARMORPEN = 0.45,        -- HC: reduced from TW raid ~0.9
  WEAPONDPS = 3.0,        -- Keep relatively high: main damage source
  HEALTH = 0.05,          -- HC: ×5 from raid 0.01
  HEALTHREG = 2.5,        -- HC: ×2.5 from raid 1.0
  ARMOR = 0.03,           -- HC: ×6 from raid 0.005 (leather = very squishy)
  DEFENSE = 0.15,         -- HC: ×2
  DODGE = 2.0,            -- HC: ×4.2 from raid 0.472 (critical for leather melee)
  PARRY = 2.0,            -- HC: ×1.8 from raid 1.13
  RESILIENCE = 0.3,
  FIRERES = 0.60,         -- HC: ×2.5 (squishy class needs more resists)
  FROSTRES = 0.60,
  ARCANERES = 0.60,
  SHADOWRES = 0.60,
  NATURERES = 0.60,
})

table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_HC_Rogue_Combat", hcRogueCombat)
end)

-- ============================================================================
-- WARLOCK AFFLICTION HC
-- DoTs + Drain Life + Voidwalker pet = extremely safe leveling
-- Key HC stats: STA (Life Tap costs HP!), INT (mana pool), Spell Power
-- Drain Life provides constant self-healing, making SP partially a survival stat
-- ============================================================================

local hcWarlockAffliction = ApplyMultiplier({
  INT = 0.65,             -- HC: ×1.625 from raid 0.4 (mana pool)
  SPI = 0.25,             -- HC: ×2.5 from raid 0.1 (mana regen, Life Tap less needed)
  STA = 0.55,             -- HC: ×5.5 from raid 0.1 (Life Tap costs HP, STA is critical)
  AGI = 0.05,             -- Unchanged
  DMG = 1.2,              -- Reduced from TW raid 1.5 (DoTs still efficient)
  SHADOWDMG = 0.80,       -- Kept similar to raid (main school)
  FIREDMG = 0.30,         -- Kept similar to raid
  SPELLTOHIT = 5.0,       -- HC: reduced from TW raid ~10.8
  SPELLCRIT = 2.5,        -- HC: reduced from raid 3.12 (DoTs don't crit in vanilla)
  SPELLHASTE = 5.0,       -- HC: reduced from TW raid ~8.1 (DoT haste still good)
  SPELLPEN = 0.05,        -- Minimal
  HEAL = 0.15,            -- HC: Drain Life sustain value
  MANA = 0.05,            -- HC: ×1.67 from raid 0.03
  MANAREG = 1.0,          -- Same as raid (Life Tap is primary mana source)
  CASTINGREG = 4.0,       -- Reduced from raid 5.0 (less relevant with Life Tap)
  HEALTH = 0.06,          -- HC: ×6 from raid 0.01 (Life Tap costs HP)
  HEALTHREG = 2.5,        -- HC: ×2.5 from raid 1.0
  ARMOR = 0.025,          -- HC: ×5 from raid 0.005 (cloth)
  DEFENSE = 0.15,         -- HC: ×2
  DODGE = 1.4,            -- HC: ×3
  PARRY = 1.4,            -- HC: ×3
  RESILIENCE = 0.3,
  FIRERES = 0.48,         -- HC: ×2
  FROSTRES = 0.48,
  ARCANERES = 0.48,
  SHADOWRES = 0.48,
  NATURERES = 0.48,
})

table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_HC_Warlock_Affliction", hcWarlockAffliction)
end)

-- ============================================================================
-- SHAMAN ENHANCEMENT HC
-- Windfury procs + self-healing + Ghost Wolf mobility
-- Key HC stats: STR (main damage), INT (mana for heals!), STA (melee danger)
-- INT is very valuable: mana = healing spells between pulls and in emergencies
-- ============================================================================

local hcShamanEnhancement = ApplyMultiplier({
  STR = 1.0,              -- Main melee stat
  AGI = 0.75,             -- Reduced from TW raid ~0.91 (crit + dodge)
  STA = 0.55,             -- HC: ×5.5 from raid 0.1 (melee range = dangerous)
  INT = 0.55,             -- HC: ×1.6 from raid 0.34 (mana for emergency heals)
  SPI = 0.15,             -- HC: ×3 from raid 0.05 (mana regen between fights)
  ATTACKPOWER = 0.60,     -- Reduced from TW raid ~0.85
  TOHIT = 4.5,            -- HC: reduced from TW raid ~7.5
  EXPERTISE = 1.0,        -- Reduced from raid 1.5
  CRIT = 5.5,             -- HC: reduced from TW raid ~10.0
  HASTE = 4.0,            -- HC: reduced from TW raid ~6.9 (Flurry still matters)
  ARMORPEN = 0.25,        -- HC: reduced from TW raid ~0.45
  WEAPONDPS = 3.5,        -- Keep high: Windfury scales with weapon damage
  DMG = 0.25,             -- Spell damage for shocks
  NATUREDMG = 0.25,       -- Nature damage for Lightning Strike
  FIREDMG = 0.15,         -- Fire damage (Flametongue)
  SPELLTOHIT = 1.2,       -- Reduced from TW raid ~2.0
  SPELLCRIT = 1.8,        -- Reduced from TW raid ~3.1
  HEAL = 0.25,            -- HC: self-healing value (not in raid set)
  MANA = 0.05,            -- HC: ×1.56 from raid 0.032
  MANAREG = 2.0,          -- HC: ×2 from raid 1.0 (mana for heals)
  HEALTH = 0.05,          -- HC: ×5 from raid 0.01
  HEALTHREG = 2.5,        -- HC: ×2.5 from raid 1.0
  ARMOR = 0.025,          -- HC: ×5 from raid 0.005
  DEFENSE = 0.15,         -- HC: ×2
  DODGE = 1.4,            -- HC: ×3
  PARRY = 1.4,            -- HC: ×3
  RESILIENCE = 0.3,
  FIRERES = 0.48,         -- HC: ×2
  FROSTRES = 0.48,
  ARCANERES = 0.48,
  SHADOWRES = 0.48,
  NATURERES = 0.48,
})

table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_HC_Shaman_Enhancement", hcShamanEnhancement)
end)

-- ============================================================================
-- DRUID FERAL HC
-- Cat form for DPS, Bear form for emergencies, self-heal in caster form
-- Most versatile HC class: can tank, DPS, and heal as needed
-- Key HC stats: AGI (dodge in both forms), STR (cat AP), STA (bear HP pool)
-- INT/SPI valuable for emergency healing between pulls
-- ============================================================================

local hcDruidFeral = ApplyMultiplier({
  STR = 1.35,             -- Reduced from TW raid ~1.63 (cat form AP)
  AGI = 1.0,              -- Primary: dodge + crit + armor (both forms)
  STA = 0.55,             -- HC: ×5.5 from raid 0.1 (bear form HP scaling)
  INT = 0.20,             -- HC: ×2 from raid 0.1 (mana for emergency heals)
  SPI = 0.20,             -- HC: ×4 from raid 0.05 (mana/health regen, innervate self)
  ATTACKPOWER = 0.60,     -- Reduced from TW raid ~0.80
  ATTACKPOWERFERAL = 0.60,
  TOHIT = 4.0,            -- HC: reduced from TW raid ~6.4
  EXPERTISE = 0.40,       -- Reduced from raid 0.61
  CRIT = 4.0,             -- HC: reduced from TW raid ~5.5 (Primal Fury energy)
  HASTE = 2.5,            -- HC: reduced from raid ~3.5
  ARMORPEN = 0.7,         -- HC: reduced from TW raid ~1.5
  WEAPONDPS = 0.85,       -- Slightly reduced from TW raid ~0.94
  HEAL = 0.15,            -- HC: emergency healing in caster form
  MANA = 0.015,           -- HC: ×1.67 from raid 0.009
  MANAREG = 0.5,          -- HC: ×1.67 from raid 0.3 (emergency healing mana)
  HEALTH = 0.05,          -- HC: ×5 from raid 0.01
  HEALTHREG = 2.5,        -- HC: ×2.5 from raid 1.0
  ARMOR = 0.06,           -- HC: ×3 from raid 0.02 (bear already has lots)
  DEFENSE = 0.15,         -- HC: ×2
  DODGE = 1.4,            -- HC: ×3 from raid 0.472
  RESILIENCE = 0.3,
  FIRERES = 0.48,         -- HC: ×2
  FROSTRES = 0.48,
  ARCANERES = 0.48,
  SHADOWRES = 0.48,
  NATURERES = 0.48,
})

table.insert(ItemsOfPower_PendingStatSets, function()
  RegisterOrUpdateStatSet("TurtleWoW_HC_Druid_Feral", hcDruidFeral)
end)
