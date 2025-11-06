--[[
  Generate All Vanilla Baseline StatSets

  This script extracts ALL specs from ClassicHawsJon_small.lua and generates
  ItemsOfPower StatSet creation code for each one.

  Output: statsets/vanilla_baseline_all.lua

  Usage:
    lua tools/generate_all_vanilla_baselines.lua
]]

-- Load conversion utilities (simulate if running standalone)
dofile("tools/convert_pawn_to_iop.lua")

-- ============================================================================
-- ALL CLASSICHAWSJON SPECS DATA
-- ============================================================================

-- Pre-multiplied rating values for Classic Era
local HitRatingPer = 9.37931
local SpellHitRatingPer = 8
local CritRatingPer = 8.5
local SpellCritRatingPer = 8
local HasteRatingPer = 8.03
local SpellHasteRatingPer = 8.03
local ExpertiseRatingPer = 2.34483
local ArmorPenetrationPer = 3.75
local DefenseRatingPer = 1.5
local DodgeRatingPer = 9.44
local ParryRatingPer = 9.44
local BlockRatingPer = 6.9

local allSpecs = {
  -- DRUID (11)
  {
    class = "Druid",
    spec = "Balance",
    stats = {
      Agility=0.05, Intellect=0.38, Mana=0.032, Spirit=0.34, Mp5=0.58,
      SpellDamage=1, ArcaneSpellDamage=0.64, NatureSpellDamage=0.43,
      SpellHitRating=SpellHitRatingPer*1.21, SpellCritRating=SpellCritRatingPer*0.62,
      SpellHasteRating=SpellHasteRatingPer*0.8, SpellPenetration=0.21,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.05, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },
  {
    class = "Druid",
    spec = "Feral Damage",
    stats = {
      Strength=1.48, Agility=1, Ap=0.59, FeralAp=0.59,
      HitRating=HitRatingPer*0.61, ExpertiseRating=ExpertiseRatingPer*0.61,
      CritRating=CritRatingPer*0.59, HasteRating=HasteRatingPer*0.43,
      ArmorPenetration=ArmorPenetrationPer*0.4,
      Intellect=0.1, Mana=0.009, Spirit=0.05, Mp5=0.3, Healing=0.025,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.02,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.05, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },
  {
    class = "Druid",
    spec = "Feral Tank",
    stats = {
      Strength=0.2, Agility=0.48, Ap=0.34, FeralAp=0.34,
      HitRating=HitRatingPer*0.16, ExpertiseRating=ExpertiseRatingPer*0.18,
      CritRating=CritRatingPer*0.15, HasteRating=HasteRatingPer*0.31,
      ArmorPenetration=ArmorPenetrationPer*0.2,
      Intellect=0.1, Mana=0.009, Spirit=0.05, Mp5=0.3, Healing=0.025,
      NatureSpellDamage=0.025,
      Stamina=1, Health=0.08, Hp5=2, Armor=0.1,
      DefenseRating=DefenseRatingPer*0.26, DodgeRating=DodgeRatingPer*0.38,
      ResilienceRating=0.2,
      AllResist=1, FireResist=0.2, FrostResist=0.2, ArcaneResist=0.2,
      ShadowResist=0.2, NatureResist=0.2,
    }
  },
  {
    class = "Druid",
    spec = "Restoration",
    stats = {
      Agility=0.05, Intellect=1, Mana=0.09, Spirit=0.87, Mp5=1.7, Healing=1.21,
      SpellCritRating=SpellCritRatingPer*0.35, SpellHasteRating=SpellHasteRatingPer*0.49,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.05, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },

  -- HUNTER (3)
  {
    class = "Hunter",
    spec = "Beast Mastery",
    stats = {
      Strength=0.05, Agility=1, Ap=0.43, Rap=0.43,
      HitRating=HitRatingPer*1, ExpertiseRating=ExpertiseRatingPer*0.05,
      CritRating=CritRatingPer*0.8, HasteRating=HasteRatingPer*0.5,
      ArmorPenetration=ArmorPenetrationPer*0.17,
      Intellect=0.8, Mana=0.075, Spirit=0.05, Mp5=2.4,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.05, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },
  {
    class = "Hunter",
    spec = "Marksmanship",
    stats = {
      Strength=0.05, Agility=1, Ap=0.55, Rap=0.55,
      HitRating=HitRatingPer*1, ExpertiseRating=ExpertiseRatingPer*0.05,
      CritRating=CritRatingPer*0.6, HasteRating=HasteRatingPer*0.4,
      ArmorPenetration=ArmorPenetrationPer*0.37,
      Intellect=0.9, Mana=0.085, Spirit=0.05, Mp5=2.4,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.05, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },
  {
    class = "Hunter",
    spec = "Survival",
    stats = {
      Strength=0.05, Agility=1, Ap=0.55, Rap=0.55,
      HitRating=HitRatingPer*1, ExpertiseRating=ExpertiseRatingPer*0.05,
      CritRating=CritRatingPer*0.65, HasteRating=HasteRatingPer*0.4,
      ArmorPenetration=ArmorPenetrationPer*0.28,
      Intellect=0.8, Mana=0.075, Spirit=0.05, Mp5=2.4,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.05, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },

  -- MAGE (8)
  {
    class = "Mage",
    spec = "Arcane",
    stats = {
      Agility=0.05, Intellect=0.46, Mana=0.038, Spirit=0.59, Mp5=1.13,
      SpellDamage=1, FireSpellDamage=0.064, FrostSpellDamage=0.52, ArcaneSpellDamage=0.88,
      SpellHitRating=SpellHitRatingPer*0.87, SpellCritRating=SpellCritRatingPer*0.6,
      SpellHasteRating=SpellHasteRatingPer*0.59, SpellPenetration=0.09,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.05, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },
  {
    class = "Mage",
    spec = "Fire",
    stats = {
      Agility=0.05, Intellect=0.44, Mana=0.036, Spirit=0.066, Mp5=0.9,
      SpellDamage=1, FireSpellDamage=0.94, FrostSpellDamage=0.32, ArcaneSpellDamage=0.168,
      SpellHitRating=SpellHitRatingPer*0.93, SpellCritRating=SpellCritRatingPer*0.77,
      SpellHasteRating=SpellHasteRatingPer*0.82, SpellPenetration=0.09,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.05, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },
  {
    class = "Mage",
    spec = "Frost",
    stats = {
      Agility=0.05, Intellect=0.37, Mana=0.032, Spirit=0.06, Mp5=0.8,
      SpellDamage=1, FireSpellDamage=0.05, FrostSpellDamage=0.95, ArcaneSpellDamage=0.13,
      SpellHitRating=SpellHitRatingPer*1.22, SpellCritRating=SpellCritRatingPer*0.58,
      SpellHasteRating=SpellHasteRatingPer*0.63, SpellPenetration=0.07,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.05, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },

  -- PALADIN (2)
  {
    class = "Paladin",
    spec = "Holy",
    stats = {
      Agility=0.05, Intellect=1, Mana=0.009, Spirit=0.28, Mp5=1.24, Healing=0.54,
      SpellCritRating=SpellCritRatingPer*0.46, SpellHasteRating=SpellHasteRatingPer*0.39,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0.01, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },
  {
    class = "Paladin",
    spec = "Protection",
    stats = {
      Strength=0.2, Agility=0.6, Ap=0.06,
      HitRating=HitRatingPer*0.16, ExpertiseRating=ExpertiseRatingPer*0.27,
      CritRating=CritRatingPer*0.15, HasteRating=HasteRatingPer*0.5,
      ArmorPenetration=ArmorPenetrationPer*0.09,
      Intellect=0.5, Mana=0.045, Spirit=0.05, Mp5=1,
      SpellDamage=0.44, HolySpellDamage=0.44,
      SpellHitRating=SpellHitRatingPer*0.78, SpellCritRating=SpellCritRatingPer*0.6,
      SpellHasteRating=SpellHasteRatingPer*0.12, SpellPenetration=0.03,
      Stamina=1, Health=0.09, Hp5=2, Armor=0.02,
      DefenseRating=DefenseRatingPer*0.7, DodgeRating=DodgeRatingPer*0.7,
      ParryRating=ParryRatingPer*0.6, BlockRating=BlockRatingPer*0.6, BlockValue=0.15,
      ResilienceRating=0.2,
      AllResist=1, FireResist=0.2, FrostResist=0.2, ArcaneResist=0.2,
      ShadowResist=0.2, NatureResist=0.2,
    }
  },
  {
    class = "Paladin",
    spec = "Retribution",
    stats = {
      Strength=1, Agility=0.64, Ap=0.41,
      HitRating=HitRatingPer*0.84, ExpertiseRating=ExpertiseRatingPer*0.87,
      CritRating=CritRatingPer*0.66, HasteRating=HasteRatingPer*0.25,
      ArmorPenetration=ArmorPenetrationPer*0.09,
      Intellect=0.34, Mana=0.032, Spirit=0.05, Mp5=1,
      SpellDamage=0.33, HolySpellDamage=0.33,
      SpellHitRating=SpellHitRatingPer*0.21, SpellCritRating=SpellCritRatingPer*0.12,
      SpellHasteRating=SpellHasteRatingPer*0.04, SpellPenetration=0.015,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.05, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },

  -- PRIEST (5)
  {
    class = "Priest",
    spec = "Discipline",
    stats = {
      Agility=0.05, Intellect=1, Mana=0.09, Spirit=0.48, Mp5=1.19, Healing=0.72,
      SpellCritRating=SpellCritRatingPer*0.32, SpellHasteRating=SpellHasteRatingPer*0.57,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.05, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },
  {
    class = "Priest",
    spec = "Holy",
    stats = {
      Agility=0.05, Intellect=1, Mana=0.09, Spirit=0.73, Mp5=1.35, Healing=0.81,
      SpellCritRating=SpellCritRatingPer*0.24, SpellHasteRating=SpellHasteRatingPer*0.60,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.05, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },
  {
    class = "Priest",
    spec = "Shadow",
    stats = {
      Agility=0.05, Intellect=0.19, Mana=0.017, Spirit=0.21, Mp5=1,
      SpellDamage=1, ShadowSpellDamage=1,
      SpellHitRating=SpellHitRatingPer*1.12, SpellCritRating=SpellCritRatingPer*0.76,
      SpellHasteRating=SpellHasteRatingPer*0.65, SpellPenetration=0.08,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.05, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },

  -- ROGUE (4)
  {
    class = "Rogue",
    spec = "Assassination",
    stats = {
      Strength=0.5, Agility=1, Ap=0.45,
      HitRating=HitRatingPer*1, ExpertiseRating=ExpertiseRatingPer*1.1,
      CritRating=CritRatingPer*0.81, HasteRating=HasteRatingPer*0.9,
      ArmorPenetration=ArmorPenetrationPer*0.24,
      Spirit=0.05,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.12, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },
  {
    class = "Rogue",
    spec = "Combat",
    stats = {
      Strength=0.5, Agility=1, Ap=0.45,
      HitRating=HitRatingPer*1, ExpertiseRating=ExpertiseRatingPer*1.1,
      CritRating=CritRatingPer*0.81, HasteRating=HasteRatingPer*0.9,
      ArmorPenetration=ArmorPenetrationPer*0.24,
      Spirit=0.05,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.12, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },
  {
    class = "Rogue",
    spec = "Subtlety",
    stats = {
      Strength=0.5, Agility=1, Ap=0.45,
      HitRating=HitRatingPer*1, ExpertiseRating=ExpertiseRatingPer*1.1,
      CritRating=CritRatingPer*0.81, HasteRating=HasteRatingPer*0.9,
      ArmorPenetration=ArmorPenetrationPer*0.24,
      Spirit=0.05,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.12, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },

  -- SHAMAN (7)
  {
    class = "Shaman",
    spec = "Elemental",
    stats = {
      Agility=0.05, Intellect=0.31, Mana=0.024, Spirit=0.09, Mp5=1.14,
      SpellDamage=1, NatureSpellDamage=1,
      SpellHitRating=SpellHitRatingPer*0.9, SpellCritRating=SpellCritRatingPer*1.05,
      SpellHasteRating=SpellHasteRatingPer*0.9, SpellPenetration=0.38,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.12, BlockRating=BlockRatingPer*0.01, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },
  {
    class = "Shaman",
    spec = "Enhancement",
    stats = {
      Strength=1, Agility=0.87, Ap=0.5,
      HitRating=HitRatingPer*0.67, ExpertiseRating=ExpertiseRatingPer*1.5,
      CritRating=CritRatingPer*0.98, HasteRating=HasteRatingPer*0.64,
      ArmorPenetration=ArmorPenetrationPer*0.12,
      Intellect=0.34, Mana=0.032, Spirit=0.05, Mp5=1,
      SpellDamage=0.3, NatureSpellDamage=0.3,
      SpellHitRating=SpellHitRatingPer*0.223, SpellCritRating=SpellCritRatingPer*0.326,
      SpellHasteRating=SpellHasteRatingPer*0.08, SpellPenetration=0.11,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.05, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },
  {
    class = "Shaman",
    spec = "Restoration",
    stats = {
      Agility=0.05, Intellect=1, Mana=0.009, Spirit=0.61, Mp5=1.33, Healing=0.9,
      SpellCritRating=SpellCritRatingPer*0.48, SpellHasteRating=SpellHasteRatingPer*0.74,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0.01, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },

  -- WARLOCK (9)
  {
    class = "Warlock",
    spec = "Affliction",
    stats = {
      Agility=0.05, Intellect=0.4, Mana=0.03, Spirit=0.1, Mp5=1,
      SpellDamage=1, FireSpellDamage=0.35, ShadowSpellDamage=0.91,
      SpellHitRating=SpellHitRatingPer*1.2, SpellCritRating=SpellCritRatingPer*0.39,
      SpellHasteRating=SpellHasteRatingPer*0.78, SpellPenetration=0.08,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.05, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },
  {
    class = "Warlock",
    spec = "Demonology",
    stats = {
      Agility=0.05, Intellect=0.4, Mana=0.03, Spirit=0.5, Mp5=1,
      SpellDamage=1, FireSpellDamage=0.80, ShadowSpellDamage=0.80,
      SpellHitRating=SpellHitRatingPer*1.2, SpellCritRating=SpellCritRatingPer*0.66,
      SpellHasteRating=SpellHasteRatingPer*0.7, SpellPenetration=0.08,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.05, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },
  {
    class = "Warlock",
    spec = "Destruction",
    stats = {
      Agility=0.05, Intellect=0.34, Mana=0.028, Spirit=0.25, Mp5=0.65,
      SpellDamage=1, FireSpellDamage=0.23, ShadowSpellDamage=0.95,
      SpellHitRating=SpellHitRatingPer*1.6, SpellCritRating=SpellCritRatingPer*0.87,
      SpellHasteRating=SpellHasteRatingPer*1.15, SpellPenetration=0.08,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.05, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },

  -- WARRIOR (1)
  {
    class = "Warrior",
    spec = "Arms",
    stats = {
      Strength=1, Agility=0.69, Ap=0.45,
      HitRating=HitRatingPer*1, ExpertiseRating=ExpertiseRatingPer*1,
      CritRating=CritRatingPer*0.85, HasteRating=HasteRatingPer*0.57,
      ArmorPenetration=ArmorPenetrationPer*1.1,
      Spirit=0.05,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.05, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },
  {
    class = "Warrior",
    spec = "Fury",
    stats = {
      Strength=1, Agility=0.57, Ap=0.54,
      HitRating=HitRatingPer*0.57, ExpertiseRating=ExpertiseRatingPer*0.57,
      CritRating=CritRatingPer*0.7, HasteRating=HasteRatingPer*0.41,
      ArmorPenetration=ArmorPenetrationPer*0.47,
      Spirit=0.05,
      Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
      DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05,
      ParryRating=ParryRatingPer*0.12, ResilienceRating=0.2,
      AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
      ShadowResist=0.04, NatureResist=0.04,
    }
  },
  {
    class = "Warrior",
    spec = "Protection",
    stats = {
      Strength=0.33, Agility=0.59, Ap=0.06,
      HitRating=HitRatingPer*0.67, ExpertiseRating=ExpertiseRatingPer*0.67,
      CritRating=CritRatingPer*0.28, HasteRating=HasteRatingPer*0.21,
      ArmorPenetration=ArmorPenetrationPer*0.19,
      Spirit=0.05,
      Stamina=1, Health=0.09, Hp5=2, Armor=0.02,
      DefenseRating=DefenseRatingPer*0.81, DodgeRating=DodgeRatingPer*0.7,
      ParryRating=ParryRatingPer*0.58, BlockRating=BlockRatingPer*0.59, BlockValue=0.35,
      ResilienceRating=0.2,
      AllResist=1, FireResist=0.2, FrostResist=0.2, ArcaneResist=0.2,
      ShadowResist=0.2, NatureResist=0.2,
    }
  },
}

-- ============================================================================
-- GENERATE ALL STATSETS
-- ============================================================================

function GenerateAllVanillaBaselines()
  local output = {}

  table.insert(output, "--[[")
  table.insert(output, "  Vanilla Baseline StatSets")
  table.insert(output, "  Generated from ClassicHawsJon_small.lua")
  table.insert(output, "  ")
  table.insert(output, "  Total: " .. #allSpecs .. " specs")
  table.insert(output, "  ")
  table.insert(output, "  Usage:")
  table.insert(output, "    1. Copy this entire file")
  table.insert(output, "    2. Execute in-game (in chunks if needed)")
  table.insert(output, "    3. All StatSets will be created")
  table.insert(output, "]]")
  table.insert(output, "")
  table.insert(output, "-- Generated: " .. os.date("%Y-%m-%d %H:%M:%S"))
  table.insert(output, "")

  -- Generate each spec
  for i, specData in ipairs(allSpecs) do
    print("Converting: " .. specData.class .. " - " .. specData.spec)

    local iopStats, warnings = ParsePawnScale(specData.stats)
    local code = GenerateStatSetCode(specData.class, specData.spec, iopStats, true)

    table.insert(output, code)
  end

  table.insert(output, "")
  table.insert(output, "print(\"All Vanilla Baseline StatSets loaded!\")")
  table.insert(output, "print(\"Total: " .. #allSpecs .. " specs created\")")

  return table.concat(output, "\n")
end

-- ============================================================================
-- MAIN EXECUTION
-- ============================================================================

print("=== Generating All Vanilla Baseline StatSets ===")
print("")

local generatedCode = GenerateAllVanillaBaselines()

-- Write to file
local outputFile = io.open("statsets/vanilla_baseline_all.lua", "w")
if outputFile then
  outputFile:write(generatedCode)
  outputFile:close()
  print("")
  print("✓ Generated: statsets/vanilla_baseline_all.lua")
  print("✓ Total specs: " .. #allSpecs)
  print("")
  print("Next steps:")
  print("  1. Load in WoW: /script LoadFile(\"Interface\\\\AddOns\\\\ItemsOfPower\\\\statsets\\\\vanilla_baseline_all.lua\")")
  print("  2. Or copy/paste sections into game")
  print("  3. Verify StatSets created: /ipw → Sets")
else
  print("ERROR: Could not write output file")
end
