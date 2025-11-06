# Vanilla Baseline Stat Weights (ClassicHawsJon)

Dieser Dokument enthält alle Stat Weights aus ClassicHawsJon_small.lua als Referenz für die ItemsOfPower Konvertierung.

**Quelle:** ClassicHawsJon_small.lua (Pawn scales for Classic Era)
**Version:** PawnClassicLastUpdatedVersion = 2.1100
**Status:** Vanilla Baseline (OHNE Turtle WoW Anpassungen)

---

## Rating Conversion Multipliers (Classic Era)

ClassicHawsJon verwendet "Pre-Multiplied" Werte für Classic Era, da Vanilla % statt Ratings anzeigt:

```lua
HitRatingPer = 9.37931         -- 1% Hit = ~9.38 Rating
SpellHitRatingPer = 8          -- 1% Spell Hit = 8 Rating
CritRatingPer = 8.5            -- 1% Crit = 8.5 Rating
SpellCritRatingPer = 8         -- 1% Spell Crit = 8 Rating
HasteRatingPer = 8.03          -- 1% Haste = 8.03 Rating
SpellHasteRatingPer = 8.03     -- 1% Spell Haste = 8.03 Rating
ExpertiseRating = 2.34483      -- 1 Expertise = ~2.34 Rating
ArmorPenetrationPer = 3.75     -- Armor Pen conversion
DefenseRatingPer = 1.5         -- 1 Defense = 1.5 Rating
DodgeRatingPer = 9.44          -- 1% Dodge = 9.44 Rating
ParryRatingPer = 9.44          -- 1% Parry = 9.44 Rating
BlockRatingPer = 6.9           -- 1% Block = 6.9 Rating
```

**Wichtig:** Die Weights unten sind bereits mit diesen Multipliern berechnet!

---

## Druid (11)

### Balance (Spec 1)
**Role:** Ranged Caster DPS (Moonkin)

**Top Stats:**
- SpellHitRating = 9.68 (8 * 1.21)
- SpellDamage = 1.0 (generic spell damage)
- SpellHasteRating = 6.42 (8.03 * 0.8)
- ArcaneSpellDamage = 0.64
- Mp5 = 0.58

**Full Weights:**
```
Agility=0.05, Intellect=0.38, Mana=0.032, Spirit=0.34, Mp5=0.58,
SpellDamage=1, ArcaneSpellDamage=0.64, NatureSpellDamage=0.43,
SpellHitRating=9.68, SpellCritRating=4.96, SpellHasteRating=6.42, SpellPenetration=0.21,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=0.472, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

### Feral (Damage) (Spec 2)
**Role:** Melee DPS (Cat Form)

**Top Stats:**
- Strength = 1.48 (highest stat)
- Agility = 1.0 (baseline)
- FeralAp = 0.59 (Attack Power in Feral Forms)
- HitRating = 5.72 (9.37931 * 0.61)
- ExpertiseRating = 1.43

**Full Weights:**
```
Strength=1.48, Agility=1, Ap=0.59, FeralAp=0.59,
HitRating=5.72, ExpertiseRating=1.43, CritRating=5.02, HasteRating=3.45, ArmorPenetration=1.5,
Intellect=0.1, Mana=0.009, Spirit=0.05, Mp5=0.3, Healing=0.025,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.02,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=0.472, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

### Feral (Tank) (Spec 3)
**Role:** Tank (Bear Form)

**Top Stats:**
- Stamina = 1.0 (highest stat for tanking)
- Agility = 0.48
- DodgeRating = 3.59 (9.44 * 0.38)
- Armor = 0.1 (sehr wertvoll!)
- Ap = 0.34

**Full Weights:**
```
Strength=0.2, Agility=0.48, Ap=0.34, FeralAp=0.34,
HitRating=1.50, ExpertiseRating=0.42, CritRating=1.28, HasteRating=2.49, ArmorPenetration=0.75,
Intellect=0.1, Mana=0.009, Spirit=0.05, Mp5=0.3, Healing=0.025, NatureSpellDamage=0.025,
Stamina=1, Health=0.08, Hp5=2, Armor=0.1,
DefenseRating=0.39, DodgeRating=3.59, ResilienceRating=0.2,
AllResist=1, FireResist=0.2, FrostResist=0.2, ArcaneResist=0.2, ShadowResist=0.2, NatureResist=0.2
```

---

### Restoration (Spec 4)
**Role:** Healer

**Top Stats:**
- Mp5 = 1.7 (höchster Wert!)
- Healing = 1.21
- Intellect = 1.0
- Spirit = 0.87
- SpellCritRating = 2.8

**Full Weights:**
```
Agility=0.05, Intellect=1, Mana=0.09, Spirit=0.87, Mp5=1.7, Healing=1.21,
SpellCritRating=2.8, SpellHasteRating=3.93,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=0.472, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

## Hunter (3)

### Beast Mastery (Spec 1)
**Role:** Ranged Physical DPS

**Top Stats:**
- HitRating = 9.38 (9.37931 * 1)
- CritRating = 6.8 (8.5 * 0.8)
- HasteRating = 4.02 (8.03 * 0.5)
- Mp5 = 2.4
- Agility = 1.0

**Full Weights:**
```
Strength=0.05, Agility=1, MeleeDps=0.75, RangedDps=2.4,
Ap=0.43, Rap=0.43, HitRating=9.38, ExpertiseRating=0.12, CritRating=6.8, HasteRating=4.02, ArmorPenetration=0.64,
Intellect=0.8, Mana=0.075, Spirit=0.05, Mp5=2.4,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=0.472, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

### Marksmanship (Spec 2)
**Role:** Ranged Physical DPS

**Top Stats:**
- HitRating = 9.38
- CritRating = 5.1 (8.5 * 0.6)
- HasteRating = 3.21 (8.03 * 0.4)
- Mp5 = 2.4
- Agility = 1.0

**Full Weights:**
```
Strength=0.05, Agility=1, MeleeDps=0.75, RangedDps=2.6,
Ap=0.55, Rap=0.55, HitRating=9.38, ExpertiseRating=0.12, CritRating=5.1, HasteRating=3.21, ArmorPenetration=1.39,
Intellect=0.9, Mana=0.085, Spirit=0.05, Mp5=2.4,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=0.472, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

### Survival (Spec 3)
**Role:** Ranged Physical DPS

**Top Stats:**
- HitRating = 9.38
- CritRating = 5.53 (8.5 * 0.65)
- HasteRating = 3.21 (8.03 * 0.4)
- Mp5 = 2.4
- Agility = 1.0

**Full Weights:**
```
Strength=0.05, Agility=1, MeleeDps=1, RangedDps=2.4,
Ap=0.55, Rap=0.55, HitRating=9.38, ExpertiseRating=0.12, CritRating=5.53, HasteRating=3.21, ArmorPenetration=1.05,
Intellect=0.8, Mana=0.075, Spirit=0.05, Mp5=2.4,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=0.472, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

## Mage (8)

### Arcane (Spec 1)
**Role:** Ranged Caster DPS

**Top Stats:**
- ArcaneSpellDamage = 0.88
- SpellHitRating = 6.96 (8 * 0.87)
- Mp5 = 1.13
- Spirit = 0.59
- SpellCritRating = 4.8

**Full Weights:**
```
Agility=0.05, Intellect=0.46, Mana=0.038, Spirit=0.59, Mp5=1.13,
SpellDamage=1, FireSpellDamage=0.064, FrostSpellDamage=0.52, ArcaneSpellDamage=0.88,
SpellHitRating=6.96, SpellCritRating=4.8, SpellHasteRating=4.74, SpellPenetration=0.09,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=0.472, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

### Fire (Spec 2)
**Role:** Ranged Caster DPS

**Top Stats:**
- FireSpellDamage = 0.94
- SpellHitRating = 7.44 (8 * 0.93)
- SpellHasteRating = 6.58 (8.03 * 0.82)
- SpellCritRating = 6.16 (8 * 0.77)
- SpellDamage = 1.0

**Full Weights:**
```
Agility=0.05, Intellect=0.44, Mana=0.036, Spirit=0.066, Mp5=0.9,
SpellDamage=1, FireSpellDamage=0.94, FrostSpellDamage=0.32, ArcaneSpellDamage=0.168,
SpellHitRating=7.44, SpellCritRating=6.16, SpellHasteRating=6.58, SpellPenetration=0.09,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=0.472, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

### Frost (Spec 3)
**Role:** Ranged Caster DPS

**Top Stats:**
- SpellHitRating = 9.76 (8 * 1.22)
- FrostSpellDamage = 0.95
- SpellDamage = 1.0
- SpellHasteRating = 5.06 (8.03 * 0.63)
- SpellCritRating = 4.64

**Full Weights:**
```
Agility=0.05, Intellect=0.37, Mana=0.032, Spirit=0.06, Mp5=0.8,
SpellDamage=1, FireSpellDamage=0.05, FrostSpellDamage=0.95, ArcaneSpellDamage=0.13,
SpellHitRating=9.76, SpellCritRating=4.64, SpellHasteRating=5.06, SpellPenetration=0.07,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=0.472, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

## Paladin (2)

### Holy (Spec 1)
**Role:** Healer

**Top Stats:**
- Mp5 = 1.24
- Intellect = 1.0
- Healing = 0.54
- Intellect = 1.0
- SpellCritRating = 3.68

**Full Weights:**
```
Agility=0.05, Intellect=1, Mana=0.009, Spirit=0.28, Mp5=1.24, Healing=0.54,
SpellCritRating=3.68, SpellHasteRating=3.13,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=0.472, BlockRating=0.07, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

### Protection (Spec 2)
**Role:** Tank

**Top Stats:**
- Stamina = 1.0
- SpellHitRating = 6.24 (8 * 0.78) [für Holy Shield Threat!]
- DefenseRating = 1.05 (1.5 * 0.7)
- DodgeRating = 6.61 (9.44 * 0.7)
- SpellCritRating = 4.8

**Full Weights:**
```
Strength=0.2, Agility=0.6, MeleeDps=1.77, Ap=0.06,
HitRating=1.50, ExpertiseRating=0.63, CritRating=1.28, HasteRating=4.02, ArmorPenetration=0.34,
Intellect=0.5, Mana=0.045, Spirit=0.05, Mp5=1, SpellDamage=0.44, HolySpellDamage=0.44,
SpellHitRating=6.24, SpellCritRating=4.8, SpellHasteRating=0.96, SpellPenetration=0.03,
Stamina=1, Health=0.09, Hp5=2, Armor=0.02,
DefenseRating=1.05, DodgeRating=6.61, ParryRating=5.66, BlockRating=4.14, BlockValue=0.15, ResilienceRating=0.2,
AllResist=1, FireResist=0.2, FrostResist=0.2, ArcaneResist=0.2, ShadowResist=0.2, NatureResist=0.2
```

**Besonderheit:** `IsOffHand=PawnIgnoreStatValue` - filtert Shields raus (Tank benötigt Shields!)

---

### Retribution (Spec 3)
**Role:** Melee DPS

**Top Stats:**
- MeleeDps = 5.4 (Weapon DPS!)
- Strength = 1.0
- ExpertiseRating = 2.04 (2.34483 * 0.87)
- HitRating = 7.88 (9.37931 * 0.84)
- CritRating = 5.61

**Full Weights:**
```
Strength=1, Agility=0.64, MeleeDps=5.4, Ap=0.41,
HitRating=7.88, ExpertiseRating=2.04, CritRating=5.61, HasteRating=2.01, ArmorPenetration=0.34,
Intellect=0.34, Mana=0.032, Spirit=0.05, Mp5=1, SpellDamage=0.33, HolySpellDamage=0.33,
SpellHitRating=1.68, SpellCritRating=0.96, SpellHasteRating=0.32, SpellPenetration=0.015,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=0.472, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

## Priest (5)

### Discipline (Spec 1)
**Role:** Healer (in Vanilla - wird in Turtle WoW zu Holy DPS!)

**Top Stats:**
- Mp5 = 1.19
- Intellect = 1.0
- Healing = 0.72
- SpellHasteRating = 4.58 (8.03 * 0.57)
- Spirit = 0.48

**Full Weights:**
```
Agility=0.05, Intellect=1, Mana=0.09, Spirit=0.48, Mp5=1.19, Healing=0.72,
SpellCritRating=2.56, SpellHasteRating=4.58,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=0.472, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

### Holy (Spec 2)
**Role:** Healer

**Top Stats:**
- Mp5 = 1.35
- Intellect = 1.0
- Healing = 0.81
- Spirit = 0.73
- SpellHasteRating = 4.82

**Full Weights:**
```
Agility=0.05, Intellect=1, Mana=0.09, Spirit=0.73, Mp5=1.35, Healing=0.81,
SpellCritRating=1.92, SpellHasteRating=4.82,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=0.472, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

### Shadow (Spec 3)
**Role:** Ranged Caster DPS

**Top Stats:**
- ShadowSpellDamage = 1.0 (gleich wie generic SpellDamage!)
- SpellHitRating = 8.96 (8 * 1.12)
- SpellCritRating = 6.08 (8 * 0.76)
- SpellHasteRating = 5.22 (8.03 * 0.65)
- Mp5 = 1.0

**Full Weights:**
```
Agility=0.05, Intellect=0.19, Mana=0.017, Spirit=0.21, Mp5=1,
SpellDamage=1, ShadowSpellDamage=1,
SpellHitRating=8.96, SpellCritRating=6.08, SpellHasteRating=5.22, SpellPenetration=0.08,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=0.472, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

## Rogue (4)

### Assassination (Spec 1)
**Role:** Melee DPS

**Top Stats:**
- MeleeDps = 3.0
- ExpertiseRating = 2.58 (2.34483 * 1.1)
- HitRating = 9.38 (9.37931 * 1)
- HasteRating = 7.23 (8.03 * 0.9)
- CritRating = 6.89

**Full Weights:**
```
Strength=0.5, Agility=1, MeleeDps=3, Ap=0.45,
HitRating=9.38, ExpertiseRating=2.58, CritRating=6.89, HasteRating=7.23, ArmorPenetration=0.9,
MeleeMinDamage=1.25, MeleeMaxDamage=1.25,
Intellect=0, Mana=0, Spirit=0.05, Mp5=0,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=1.13, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

**Besonderheit:** `IsOffHand=PawnIgnoreStatValue, IsFrill=PawnIgnoreStatValue, IsShield=PawnIgnoreStatValue`

---

### Combat (Spec 2)
**Role:** Melee DPS

**Top Stats:**
- MeleeDps = 3.0
- ExpertiseRating = 2.58
- HitRating = 9.38
- HasteRating = 7.23
- CritRating = 6.89

**Full Weights:** (identisch mit Assassination, außer MeleeMin/MaxDamage)
```
Strength=0.5, Agility=1, MeleeDps=3, Ap=0.45,
HitRating=9.38, ExpertiseRating=2.58, CritRating=6.89, HasteRating=7.23, ArmorPenetration=0.9,
MeleeMinDamage=0.875, MeleeMaxDamage=0.875,
Intellect=0, Mana=0, Spirit=0.05, Mp5=0,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=1.13, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

### Subtlety (Spec 3)
**Role:** Melee DPS

**Full Weights:** (identisch mit Assassination)
```
Strength=0.5, Agility=1, MeleeDps=3, Ap=0.45,
HitRating=9.38, ExpertiseRating=2.58, CritRating=6.89, HasteRating=7.23, ArmorPenetration=0.9,
MeleeMinDamage=1.25, MeleeMaxDamage=1.25,
Intellect=0, Mana=0, Spirit=0.05, Mp5=0,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=1.13, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

### Off-hand (Spec nil)
**Role:** Off-hand Weapon Valuation

**Top Stats:**
- MeleeDps = 2.0 (niedriger als Main Hand!)
- HitRating = 9.38
- ExpertiseRating = 2.58
- HasteRating = 7.23
- CritRating = 6.89

**Full Weights:**
```
Strength=0.5, Agility=1, MeleeDps=2, Ap=0.45,
HitRating=9.38, ExpertiseRating=2.58, CritRating=6.89, HasteRating=7.23, ArmorPenetration=0.9,
MeleeSpeed=-80, SpeedBaseline=2.9,
Intellect=0, Mana=0, Spirit=0.05, Mp5=0,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=1.13, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

**Besonderheit:**
- `IsCloth/IsLeather/IsMail/IsPlate/IsShield/IsRanged/MainHandDps=PawnIgnoreStatValue` - Filtert alles außer Off-hand Waffen!
- `LocalizedName` = "Rogue: Off Hand"

---

## Shaman (7)

### Elemental (Spec 1)
**Role:** Ranged Caster DPS

**Top Stats:**
- SpellCritRating = 8.4 (8 * 1.05)
- SpellDamage = 1.0
- NatureSpellDamage = 1.0 (gleicher Wert!)
- SpellHitRating = 7.2 (8 * 0.9)
- SpellHasteRating = 7.23 (8.03 * 0.9)

**Full Weights:**
```
Agility=0.05, Intellect=0.31, Mana=0.024, Spirit=0.09, Mp5=1.14,
SpellDamage=1, NatureSpellDamage=1,
SpellHitRating=7.2, SpellCritRating=8.4, SpellHasteRating=7.23, SpellPenetration=0.38,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=1.13, BlockRating=0.07, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

### Enhancement (Spec 2)
**Role:** Melee DPS (Hybrid Physical + Spell)

**Top Stats:**
- ExpertiseRating = 3.52 (2.34483 * 1.5) [!!!]
- Strength = 1.0
- CritRating = 8.33 (8.5 * 0.98)
- Agility = 0.87
- HitRating = 6.28

**Hybrid Stats:** SpellDamage=0.3, NatureSpellDamage=0.3, SpellCritRating=2.61

**Full Weights:**
```
Strength=1, Agility=0.87, MeleeDps=3, Ap=0.5,
HitRating=6.28, ExpertiseRating=3.52, CritRating=8.33, HasteRating=5.14, ArmorPenetration=0.45,
Intellect=0.34, Mana=0.032, Spirit=0.05, Mp5=1,
SpellDamage=0.3, NatureSpellDamage=0.3, SpellHitRating=1.78, SpellCritRating=2.61, SpellHasteRating=0.64, SpellPenetration=0.11,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=0.472, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

### Restoration (Spec 3)
**Role:** Healer

**Top Stats:**
- Mp5 = 1.33
- Intellect = 1.0
- Healing = 0.9
- SpellHasteRating = 5.94 (8.03 * 0.74)
- Spirit = 0.61

**Full Weights:**
```
Agility=0.05, Intellect=1, Mana=0.009, Spirit=0.61, Mp5=1.33, Healing=0.9,
SpellCritRating=3.84, SpellHasteRating=5.94,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=0.472, BlockRating=0.07, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

## Warlock (9)

### Affliction (Spec 1)
**Role:** Ranged Caster DPS (DoTs)

**Top Stats:**
- SpellHitRating = 9.6 (8 * 1.2)
- SpellDamage = 1.0
- ShadowSpellDamage = 0.91
- SpellHasteRating = 6.26 (8.03 * 0.78)
- Mp5 = 1.0

**Full Weights:**
```
Agility=0.05, Intellect=0.4, Mana=0.03, Spirit=0.1, Mp5=1,
SpellDamage=1, FireSpellDamage=0.35, ShadowSpellDamage=0.91,
SpellHitRating=9.6, SpellCritRating=3.12, SpellHasteRating=6.26, SpellPenetration=0.08,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=0.472, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

### Demonology (Spec 2)
**Role:** Ranged Caster DPS (Pet focus)

**Top Stats:**
- SpellHitRating = 9.6
- SpellDamage = 1.0
- FireSpellDamage = 0.80
- ShadowSpellDamage = 0.80
- SpellHasteRating = 5.62

**Full Weights:**
```
Agility=0.05, Intellect=0.4, Mana=0.03, Spirit=0.5, Mp5=1,
SpellDamage=1, FireSpellDamage=0.80, ShadowSpellDamage=0.80,
SpellHitRating=9.6, SpellCritRating=5.28, SpellHasteRating=5.62, SpellPenetration=0.08,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=0.472, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

### Destruction (Spec 3)
**Role:** Ranged Caster DPS (Direct damage)

**Top Stats:**
- SpellHitRating = 12.8 (8 * 1.6) [HÖCHSTER HIT WEIGHT!]
- SpellHasteRating = 9.23 (8.03 * 1.15)
- SpellDamage = 1.0
- ShadowSpellDamage = 0.95
- SpellCritRating = 6.96

**Full Weights:**
```
Agility=0.05, Intellect=0.34, Mana=0.028, Spirit=0.25, Mp5=0.65,
SpellDamage=1, FireSpellDamage=0.23, ShadowSpellDamage=0.95,
SpellHitRating=12.8, SpellCritRating=6.96, SpellHasteRating=9.23, SpellPenetration=0.08,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=0.472, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

## Warrior (1)

### Arms (Spec 1)
**Role:** Melee DPS

**Top Stats:**
- MeleeDps = 5.31 (SEHR hoch!)
- ArmorPenetration = 4.13 (3.75 * 1.1)
- Strength = 1.0
- HitRating = 9.38 (9.37931 * 1)
- ExpertiseRating = 2.34 (2.34483 * 1)

**Full Weights:**
```
Strength=1, Agility=0.69, MeleeDps=5.31, Ap=0.45,
HitRating=9.38, ExpertiseRating=2.34, CritRating=7.23, HasteRating=4.58, ArmorPenetration=4.13,
Intellect=0, Mana=0, Spirit=0.05, Mp5=0,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=0.472, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

### Fury (Spec 2)
**Role:** Melee DPS

**Top Stats:**
- MeleeDps = 5.22
- Strength = 1.0
- HitRating = 5.35 (9.37931 * 0.57)
- CritRating = 5.95 (8.5 * 0.7)
- Ap = 0.54

**Full Weights:**
```
Strength=1, Agility=0.57, MeleeDps=5.22, Ap=0.54,
HitRating=5.35, ExpertiseRating=1.34, CritRating=5.95, HasteRating=3.29, ArmorPenetration=1.76,
Intellect=0, Mana=0, Spirit=0.05, Mp5=0,
Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
DefenseRating=0.075, DodgeRating=0.472, ParryRating=1.13, ResilienceRating=0.2,
AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04
```

---

### Protection (Spec 3)
**Role:** Tank

**Top Stats:**
- Stamina = 1.0
- DefenseRating = 1.22 (1.5 * 0.81)
- DodgeRating = 6.61 (9.44 * 0.7)
- HitRating = 6.28 (9.37931 * 0.67)
- ParryRating = 5.48

**Full Weights:**
```
Strength=0.33, Agility=0.59, MeleeDps=3.13, Ap=0.06,
HitRating=6.28, ExpertiseRating=1.57, CritRating=2.38, HasteRating=1.69, ArmorPenetration=0.71,
Intellect=0, Mana=0, Spirit=0.05, Mp5=0,
Stamina=1, Health=0.09, Hp5=2, Armor=0.02,
DefenseRating=1.22, DodgeRating=6.61, ParryRating=5.48, BlockRating=4.07, BlockValue=0.35, ResilienceRating=0.2,
AllResist=1, FireResist=0.2, FrostResist=0.2, ArcaneResist=0.2, ShadowResist=0.2, NatureResist=0.2
```

**Besonderheit:** `IsOffHand=PawnIgnoreStatValue`

---

## Zusammenfassung

**Total Specs:** 29 (inkl. Rogue Off-hand)

**Klassen-Verteilung:**
- Druid: 4 specs
- Hunter: 3 specs
- Mage: 3 specs
- Paladin: 3 specs
- Priest: 3 specs
- Rogue: 4 specs (inkl. Off-hand)
- Shaman: 3 specs
- Warlock: 3 specs
- Warrior: 3 specs

**Häufigste Top Stats:**
1. **Hit Rating** - Wichtig für fast alle DPS Specs
2. **Crit Rating** - Sehr wertvoll für Crit-abhängige Specs
3. **Spell Hit Rating** - Critical für Caster
4. **Mp5** - Essential für Healer
5. **Stamina** - Nummer 1 für alle Tanks

**Besonderheiten:**
- **Weapon DPS** (MeleeDps/RangedDps/Dps) - Nicht in ItemBonusLib, muss ignoriert oder approximiert werden
- **AllResist** - Wird auf alle 5 Resistances verteilt
- **ExpertiseRating** - Wird in Vanilla ignoriert (existiert nicht)
- **Pre-Multiplication** - Alle Rating Weights sind bereits mit Rating-Konvertierern multipliziert

---

## Nächste Schritte

1. ✅ **Phase 0.1:** Mapping-Dokumentation erstellt
2. ✅ **Phase 0.2:** Konvertierungsskript entwickelt
3. ✅ **Phase 0.3:** Test mit Hunter MM (Dokumentation)
4. ✅ **Phase 0.4:** Vanilla Baseline dokumentiert

**Phase 1:** Allgemeine Turtle WoW Anpassungen
**Phase 2:** Alle Vanilla StatSets importieren
**Phasen 3-11:** Klassenweise Turtle WoW Anpassungen
