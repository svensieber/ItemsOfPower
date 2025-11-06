--[[
  Test Output: Hunter Marksmanship Conversion

  This shows the expected output from converting ClassicHawsJon
  Hunter Marksmanship scale to ItemsOfPower StatSet.

  Source: ClassicHawsJon_small.lua lines 104-111
]]

-- ORIGINAL PAWN SCALE (Pre-multiplied for Classic Era)
--[[
PawnAddPluginScaleFromTemplate(
  ScaleProviderName,
  3, -- Hunter
  2, -- Marksmanship
  {
    Strength=0.05, Agility=1, Dps=0, MeleeDps=0.75, RangedDps=2.6,
    Ap=0.55, Rap=0.55, FeralAp=0, HitRating=9.37931*1, ExpertiseRating=2.34483*0.05,
    CritRating=8.5*0.6, HasteRating=8.03*0.4, ArmorPenetration=3.75*0.37,
    Intellect=0.9, Mana=0.085, Spirit=0.05, Mp5=2.4,
    Healing=0, SpellDamage=0, ... (all spell stats 0)
    Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
    DefenseRating=1.5*0.05, DodgeRating=9.44*0.05, ParryRating=9.44*0.05,
    BlockRating=0, BlockValue=0, ResilienceRating=0.2,
    AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
    ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36
  }
)
]]

-- EXPECTED CONVERSION WARNINGS
--[[
WARNINGS:
  - Weapon DPS stats ignored: MeleeDps=0.75
  - Weapon DPS stats ignored: RangedDps=2.6
  - AllResist=0.2 distributed to all resistances
]]

-- EXPECTED IOP STATSET
-- Generated Code:
--[===[
-- Vanilla - Hunter - Marksmanship
do
  local stats = {
    -- Base Stats
    STR = 0.05000,
    AGI = 1.00000,
    STA = 0.10000,
    INT = 0.90000,
    SPI = 0.05000,

    -- Physical DPS Stats
    ATTACKPOWER = 0.55000,
    RANGEDATTACKPOWER = 0.55000,
    TOHIT = 9.37931,      -- Pre-multiplied (was HitRating)
    CRIT = 5.10000,       -- Pre-multiplied (was 8.5 * 0.6)
    HASTE = 3.21200,      -- Pre-multiplied (was 8.03 * 0.4)
    ARMORIGNORE = 1.38750, -- Pre-multiplied (was 3.75 * 0.37)

    -- Resources
    MANA = 0.08500,
    MANAREG = 2.40000,    -- (was Mp5)
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,  -- (was Hp5)

    -- Defense/Resistances
    ARMOR = 0.00500,
    DEFENSE = 0.07500,    -- Pre-multiplied (was 1.5 * 0.05)
    DODGE = 0.47200,      -- Pre-multiplied (was 9.44 * 0.05)
    PARRY = 0.47200,      -- Pre-multiplied (was 9.44 * 0.05)
    RESILIENCE = 0.20000,

    -- Resistances (including distributed AllResist)
    FIRERES = 0.24000,    -- 0.04 + 0.20 (AllResist)
    FROSTRES = 0.24000,   -- 0.04 + 0.20 (AllResist)
    ARCANERES = 0.24000,  -- 0.04 + 0.20 (AllResist)
    SHADOWRES = 0.24000,  -- 0.04 + 0.20 (AllResist)
    NATURERES = 0.24000,  -- 0.04 + 0.20 (AllResist)
  }

  if not ItemsOfPower.SetByName["Vanilla - Hunter - Marksmanship"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Hunter - Marksmanship", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Hunter - Marksmanship")
  else
    print("StatSet already exists: Vanilla - Hunter - Marksmanship")
  end
end
]===]

-- VERIFICATION NOTES:
--[[
1. Base Stats (STR, AGI, STA, INT, SPI): ✓ Direct 1:1 mapping
2. Physical DPS: ✓ All mapped correctly, pre-multiplied values preserved
3. Weapon DPS (MeleeDps, RangedDps): ✗ Ignored as expected (not in ItemBonusLib)
4. Expertise: ✗ Ignored (not in Vanilla, was 0.11724 from pre-mult)
5. Resources: ✓ Mp5 → MANAREG, Hp5 → HEALTHREG
6. Defense: ✓ All ratings pre-multiplied correctly
7. AllResist: ✓ Distributed to all 5 resistances (+0.2 each)
8. MetaSocketEffect: ✗ Ignored (TBC feature)
9. Spell Stats: Not shown (all were 0 for Hunter)

STAT PRIORITIES (Top 5 for Hunter MM):
1. TOHIT = 9.37931      (Hit Rating - most valuable)
2. CRIT = 5.10000       (Crit Rating)
3. HASTE = 3.21200      (Haste Rating)
4. MANAREG = 2.40000    (Mp5 - mana sustain)
5. ARMORIGNORE = 1.38750 (Armor Penetration)
]]

-- NEXT STEPS:
--[[
1. Load convert_pawn_to_iop.lua in WoW
2. Copy Hunter MM scale from ClassicHawsJon_small.lua
3. Run: ConvertPawnScale(scale, "Hunter", "Marksmanship", true)
4. Verify output matches this expected output
5. Execute generated code in-game
6. Test with known items (e.g. compare with Pawn addon if available)
]]

print("Test conversion output loaded. This shows expected conversion result.")
print("See comments for verification notes and next steps.")
