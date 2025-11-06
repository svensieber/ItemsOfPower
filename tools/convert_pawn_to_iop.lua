--[[
  Pawn to ItemsOfPower Converter

  Converts Pawn scale definitions (from ClassicHawsJon) to ItemsOfPower StatSet creation code.

  Usage:
    1. Load this file: /script LoadFile("tools/convert_pawn_to_iop.lua")
    2. Call: ConvertPawnScale(pawnScaleTable, className, specName)
    3. Copy generated code and execute in-game

  Example:
    ConvertPawnScale({
      Agility=1, HitRating=9.37931, CritRating=5.1,
      Ap=0.55, Stamina=0.1
    }, "Hunter", "Marksmanship")
]]

-- Stat Mapping Table: Pawn → ItemBonusLib
local STAT_MAPPING = {
  -- Base Stats
  Strength = "STR",
  Agility = "AGI",
  Stamina = "STA",
  Intellect = "INT",
  Spirit = "SPI",

  -- Physical DPS
  Ap = "ATTACKPOWER",
  Rap = "RANGEDATTACKPOWER",
  FeralAp = "ATTACKPOWERFERAL",
  HitRating = "TOHIT",
  CritRating = "CRIT",
  HasteRating = "HASTE",
  ArmorPenetration = "ARMORIGNORE",

  -- Spell/Caster Stats
  SpellDamage = "DMG",
  FireSpellDamage = "FIREDMG",
  FrostSpellDamage = "FROSTDMG",
  ArcaneSpellDamage = "ARCANEDMG",
  ShadowSpellDamage = "SHADOWDMG",
  NatureSpellDamage = "NATUREDMG",
  HolySpellDamage = "HOLYDMG",
  SpellHitRating = "SPELLTOHIT",
  SpellCritRating = "SPELLCRIT",
  SpellHasteRating = "SPELLHASTE",
  SpellPenetration = "SPELLPEN",

  -- Healing
  Healing = "HEAL",
  Mp5 = "MANAREG",
  Mana = "MANA",

  -- Tank/Survival
  Armor = "ARMOR",
  DefenseRating = "DEFENSE",
  DodgeRating = "DODGE",
  ParryRating = "PARRY",
  BlockRating = "BLOCK",
  BlockValue = "BLOCKVALUE",
  ResilienceRating = "RESILIENCE",
  Health = "HEALTH",
  Hp5 = "HEALTHREG",

  -- Resistances
  FireResist = "FIRERES",
  FrostResist = "FROSTRES",
  ArcaneResist = "ARCANERES",
  ShadowResist = "SHADOWRES",
  NatureResist = "NATURERES",
}

-- Stats to ignore (not available or not relevant in Vanilla)
local IGNORE_STATS = {
  Dps = true,
  MeleeDps = true,
  RangedDps = true,
  ExpertiseRating = true,
  MetaSocketEffect = true,
  IsOffHand = true,  -- Filter, not a stat
  SpellPower = false, -- Will be mapped to DMG
}

-- Convert single Pawn stat to IoP stat
local function ConvertStat(pawnStatName, pawnValue)
  -- Check if should be ignored
  if IGNORE_STATS[pawnStatName] then
    if IGNORE_STATS[pawnStatName] == true then
      return nil, nil  -- Completely ignore
    end
  end

  -- Special case: SpellPower → DMG
  if pawnStatName == "SpellPower" then
    return "DMG", pawnValue
  end

  -- Standard mapping
  local iopStatName = STAT_MAPPING[pawnStatName]
  if not iopStatName then
    return nil, nil  -- Unknown stat
  end

  return iopStatName, pawnValue
end

-- Convert full Pawn scale to IoP stats table
function ParsePawnScale(pawnScale)
  local iopStats = {}
  local warnings = {}
  local allResistValue = 0

  -- First pass: Convert all mappable stats
  for pawnStat, value in pairs(pawnScale) do
    if type(value) == "number" and value ~= 0 then
      -- Handle AllResist specially
      if pawnStat == "AllResist" then
        allResistValue = value
      else
        local iopStat, iopValue = ConvertStat(pawnStat, value)

        if iopStat then
          iopStats[iopStat] = (iopStats[iopStat] or 0) + iopValue
        elseif not IGNORE_STATS[pawnStat] then
          table.insert(warnings, "Unknown stat: " .. pawnStat)
        elseif pawnStat == "Dps" or pawnStat == "MeleeDps" or pawnStat == "RangedDps" then
          table.insert(warnings, "Weapon DPS stats ignored: " .. pawnStat .. "=" .. value)
        end
      end
    end
  end

  -- Second pass: Distribute AllResist
  if allResistValue > 0 then
    iopStats.FIRERES = (iopStats.FIRERES or 0) + allResistValue
    iopStats.FROSTRES = (iopStats.FROSTRES or 0) + allResistValue
    iopStats.ARCANERES = (iopStats.ARCANERES or 0) + allResistValue
    iopStats.SHADOWRES = (iopStats.SHADOWRES or 0) + allResistValue
    iopStats.NATURERES = (iopStats.NATURERES or 0) + allResistValue
    table.insert(warnings, "AllResist=" .. allResistValue .. " distributed to all resistances")
  end

  return iopStats, warnings
end

-- Generate ItemsOfPower StatSet creation code
function GenerateStatSetCode(className, specName, iopStats, vanillaBaseline)
  local prefix = vanillaBaseline and "Vanilla - " or "Turtle WoW - "
  local setName = prefix .. className .. " - " .. specName

  -- Sort stats for consistent output
  local statNames = {}
  for stat in pairs(iopStats) do
    table.insert(statNames, stat)
  end
  table.sort(statNames)

  -- Generate code
  local lines = {}
  table.insert(lines, "-- " .. setName)
  table.insert(lines, "do")
  table.insert(lines, "  local stats = {")

  for _, stat in ipairs(statNames) do
    local value = iopStats[stat]
    if value ~= 0 then
      table.insert(lines, string.format("    %s = %.5f,", stat, value))
    end
  end

  table.insert(lines, "  }")
  table.insert(lines, "  ")
  table.insert(lines, "  if not ItemsOfPower.SetByName[\"" .. setName .. "\"] then")
  table.insert(lines, "    local set = ItemsOfPower.SetTypes.StatSet:new(\"" .. setName .. "\", stats)")
  table.insert(lines, "    ItemsOfPower:RegisterSet(set)")
  table.insert(lines, "    print(\"Created StatSet: " .. setName .. "\")")
  table.insert(lines, "  else")
  table.insert(lines, "    print(\"StatSet already exists: " .. setName .. "\")")
  table.insert(lines, "  end")
  table.insert(lines, "end")
  table.insert(lines, "")

  return table.concat(lines, "\n")
end

-- Main conversion function
function ConvertPawnScale(pawnScale, className, specName, vanillaBaseline)
  if not pawnScale or type(pawnScale) ~= "table" then
    print("ERROR: Invalid pawnScale - must be a table")
    return nil
  end

  if not className or not specName then
    print("ERROR: className and specName are required")
    return nil
  end

  -- Parse scale
  local iopStats, warnings = ParsePawnScale(pawnScale)

  -- Print warnings
  if table.getn(warnings) > 0 then
    print("WARNINGS:")
    for i, warning in ipairs(warnings) do
      print("  - " .. warning)
    end
    print("")
  end

  -- Generate code
  local code = GenerateStatSetCode(className, specName, iopStats, vanillaBaseline)

  -- Print code
  print("=== Generated Code ===")
  print(code)
  print("======================")
  print("")
  print("Copy the code above and execute it in-game to create the StatSet.")
  print("")

  return iopStats, code
end

-- Helper: Convert all scales from ClassicHawsJon format
function ConvertAllClassicHawsJonScales(classicHawsJonData, vanillaBaseline)
  local allCode = {}

  table.insert(allCode, "-- Generated StatSets from ClassicHawsJon")
  table.insert(allCode, "-- Generated: " .. date())
  table.insert(allCode, "")

  for _, scaleData in ipairs(classicHawsJonData) do
    local className = scaleData.class
    local specName = scaleData.spec
    local pawnScale = scaleData.stats

    local iopStats = ParsePawnScale(pawnScale)
    local code = GenerateStatSetCode(className, specName, iopStats, vanillaBaseline)

    table.insert(allCode, code)
  end

  return table.concat(allCode, "\n")
end

-- Test function
function TestConversion()
  print("=== Testing Pawn to IoP Conversion ===\n")

  -- Test Case: Hunter Marksmanship (from ClassicHawsJon line 108)
  local testScale = {
    Strength = 0.05,
    Agility = 1,
    Dps = 0,
    MeleeDps = 0.75,
    RangedDps = 2.6,
    Ap = 0.55,
    Rap = 0.55,
    FeralAp = 0,
    HitRating = 9.37931,  -- Pre-multiplied: HitRatingPer * 1.0
    ExpertiseRating = 0.46894,
    CritRating = 5.1,  -- Pre-multiplied: CritRatingPer * 0.6
    HasteRating = 3.212,  -- Pre-multiplied: HasteRatingPer * 0.4
    ArmorPenetration = 1.3875,
    Intellect = 0.9,
    Mana = 0.085,
    Spirit = 0.05,
    Mp5 = 2.4,
    Stamina = 0.1,
    Health = 0.01,
    Hp5 = 1,
    Armor = 0.005,
    DefenseRating = 0.075,
    DodgeRating = 0.472,
    ParryRating = 0.472,
    BlockRating = 0,
    BlockValue = 0,
    ResilienceRating = 0.2,
    AllResist = 0.2,
    FireResist = 0.04,
    FrostResist = 0.04,
    ArcaneResist = 0.04,
    ShadowResist = 0.04,
    NatureResist = 0.04,
    MetaSocketEffect = 36,
  }

  ConvertPawnScale(testScale, "Hunter", "Marksmanship", true)
end

print("Pawn to IoP Converter loaded!")
print("Usage:")
print("  TestConversion()                                    - Run test conversion")
print("  ConvertPawnScale(scale, class, spec, vanilla)      - Convert single scale")
print("")
