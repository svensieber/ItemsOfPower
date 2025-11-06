# Pawn (ClassicHawsJon) zu ItemBonusLib Stat Mapping

Dieses Dokument definiert die Übersetzung zwischen Pawn Stats (verwendet in ClassicHawsJon_small.lua) und ItemBonusLib Stats (verwendet in ItemsOfPower).

## Status: ✓ = Direkt mappbar, ⚠ = Spezialfall, ✗ = Nicht verfügbar

---

## Base Stats

| Pawn Stat | ItemBonusLib Stat | Status | Notizen |
|-----------|-------------------|--------|---------|
| `Strength` | `STR` | ✓ | 1:1 Mapping |
| `Agility` | `AGI` | ✓ | 1:1 Mapping |
| `Stamina` | `STA` | ✓ | 1:1 Mapping |
| `Intellect` | `INT` | ✓ | 1:1 Mapping |
| `Spirit` | `SPI` | ✓ | 1:1 Mapping |

---

## Physical DPS Stats

| Pawn Stat | ItemBonusLib Stat | Status | Notizen |
|-----------|-------------------|--------|---------|
| `Ap` | `ATTACKPOWER` | ✓ | Attack Power |
| `Rap` | `RANGEDATTACKPOWER` | ✓ | Ranged Attack Power |
| `FeralAp` | `ATTACKPOWERFERAL` | ✓ | Druid Feral Form AP |
| `HitRating` | `TOHIT` | ✓ | Hit Rating (pre-multiplied in Pawn) |
| `CritRating` | `CRIT` | ✓ | Melee Crit Rating (pre-multiplied in Pawn) |
| `HasteRating` | `HASTE` | ✓ | Melee Haste Rating (pre-multiplied in Pawn) |
| `ExpertiseRating` | - | ⚠ | **Keine Expertise in Vanilla** - Kann ignoriert werden für Classic Era, TBC nutzt 1:1 mit TOHIT |
| `ArmorPenetration` | `ARMORIGNORE` | ✓ | Armor Penetration (pre-multiplied in Pawn) |
| `Dps` | - | ✗ | **Weapon DPS** - Nicht in ItemBonusLib, muss über andere Stats approximiert werden |
| `MeleeDps` | - | ✗ | **Weapon DPS** - Nicht in ItemBonusLib, muss über andere Stats approximiert werden |
| `RangedDps` | - | ✗ | **Weapon DPS** - Nicht in ItemBonusLib, muss über andere Stats approximiert werden |

**Weapon DPS Handling:**
- ItemBonusLib scannt keine Weapon DPS direkt
- Alternative: Ignorieren (da Weapons ohnehin separat bewertet werden sollten)
- Oder: Weight auf AP/Crit/Hit verteilen im Verhältnis der ursprünglichen Weights

---

## Spell/Caster Stats

| Pawn Stat | ItemBonusLib Stat | Status | Notizen |
|-----------|-------------------|--------|---------|
| `SpellDamage` | `DMG` | ✓ | Generic Spell Damage |
| `FireSpellDamage` | `FIREDMG` | ✓ | Fire Spell Damage |
| `FrostSpellDamage` | `FROSTDMG` | ✓ | Frost Spell Damage |
| `ArcaneSpellDamage` | `ARCANEDMG` | ✓ | Arcane Spell Damage |
| `ShadowSpellDamage` | `SHADOWDMG` | ✓ | Shadow Spell Damage |
| `NatureSpellDamage` | `NATUREDMG` | ✓ | Nature Spell Damage |
| `HolySpellDamage` | `HOLYDMG` | ✓ | Holy Spell Damage |
| `SpellPower` | - | ⚠ | **TBC Stat** - In Vanilla wird dies durch SpellDamage repräsentiert, verwende `DMG` |
| `SpellHitRating` | `SPELLTOHIT` | ✓ | Spell Hit Rating (pre-multiplied in Pawn) |
| `SpellCritRating` | `SPELLCRIT` | ✓ | Spell Crit Rating (pre-multiplied in Pawn) |
| `SpellHasteRating` | `SPELLHASTE` | ✓ | Spell Haste Rating (pre-multiplied in Pawn) |
| `SpellPenetration` | `SPELLPEN` | ✓ | Spell Penetration |

---

## Healing Stats

| Pawn Stat | ItemBonusLib Stat | Status | Notizen |
|-----------|-------------------|--------|---------|
| `Healing` | `HEAL` | ✓ | Bonus Healing |
| `Mp5` | `MANAREG` | ✓ | Mana per 5 seconds |
| `Mana` | `MANA` | ✓ | Base Mana pool |

---

## Tank/Survival Stats

| Pawn Stat | ItemBonusLib Stat | Status | Notizen |
|-----------|-------------------|--------|---------|
| `Armor` | `ARMOR` | ✓ | Base Armor |
| `DefenseRating` | `DEFENSE` | ✓ | Defense Rating (pre-multiplied in Pawn) |
| `DodgeRating` | `DODGE` | ✓ | Dodge Rating (pre-multiplied in Pawn) |
| `ParryRating` | `PARRY` | ✓ | Parry Rating (pre-multiplied in Pawn) |
| `BlockRating` | `BLOCK` | ✓ | Block Rating (pre-multiplied in Pawn) |
| `BlockValue` | `BLOCKVALUE` | ✓ | Block Value |
| `ResilienceRating` | `RESILIENCE` | ✓ | Resilience Rating (Turtle WoW custom stat) |
| `Health` | `HEALTH` | ✓ | Base Health |
| `Hp5` | `HEALTHREG` | ✓ | Health per 5 seconds |

---

## Resistance Stats

| Pawn Stat | ItemBonusLib Stat | Status | Notizen |
|-----------|-------------------|--------|---------|
| `AllResist` | - | ⚠ | **Berechnet** - Summe von allen Resist-Werten, nicht direkt verfügbar. Lösung: Weight auf alle einzelnen Resists verteilen |
| `FireResist` | `FIRERES` | ✓ | Fire Resistance |
| `FrostResist` | `FROSTRES` | ✓ | Frost Resistance |
| `ArcaneResist` | `ARCANERES` | ✓ | Arcane Resistance |
| `ShadowResist` | `SHADOWRES` | ✓ | Shadow Resistance |
| `NatureResist` | `NATURERES` | ✓ | Nature Resistance |

---

## Special Pawn Stats

| Pawn Stat | ItemBonusLib Stat | Status | Notizen |
|-----------|-------------------|--------|---------|
| `MetaSocketEffect` | - | ⚠ | **TBC/WotLK Feature** - Meta Gems existieren nicht in Vanilla, ignorieren |
| `IsOffHand` | - | ⚠ | **Pawn Filter** - Nutzt `PawnIgnoreStatValue`, keine direkte Stat. Kann in IoP als separater StatSet für Off-hand Waffen implementiert werden |

---

## Turtle WoW Custom Stats (nicht in ClassicHawsJon)

Diese Stats existieren in ItemBonusLib (Turtle WoW) aber NICHT in ClassicHawsJon:

| ItemBonusLib Stat | Vanilla Equivalent | Notizen |
|-------------------|-------------------|---------|
| `VAMPIR` | - | Vampirism Rating (neuer Turtle WoW Stat) - Weight muss manuell hinzugefügt werden |
| `CASTINGREG` | `Mp5` (approximation) | Meditation/Regen while casting (Turtle WoW 1.16.0) - Sehr wertvoll für Healer, Weight muss manuell hinzugefügt werden |

---

## Konvertierungs-Algorithmus

### Schritt 1: Basis-Konvertierung

```lua
function ConvertPawnStatToIoP(pawnStatName, pawnValue)
  local mapping = {
    Strength = "STR",
    Agility = "AGI",
    Stamina = "STA",
    Intellect = "INT",
    Spirit = "SPI",
    Ap = "ATTACKPOWER",
    Rap = "RANGEDATTACKPOWER",
    FeralAp = "ATTACKPOWERFERAL",
    HitRating = "TOHIT",
    CritRating = "CRIT",
    HasteRating = "HASTE",
    ArmorPenetration = "ARMORIGNORE",
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
    Healing = "HEAL",
    Mp5 = "MANAREG",
    Mana = "MANA",
    Armor = "ARMOR",
    DefenseRating = "DEFENSE",
    DodgeRating = "DODGE",
    ParryRating = "PARRY",
    BlockRating = "BLOCK",
    BlockValue = "BLOCKVALUE",
    ResilienceRating = "RESILIENCE",
    Health = "HEALTH",
    Hp5 = "HEALTHREG",
    FireResist = "FIRERES",
    FrostResist = "FROSTRES",
    ArcaneResist = "ARCANERES",
    ShadowResist = "SHADOWRES",
    NatureResist = "NATURERES",
  }

  return mapping[pawnStatName], pawnValue
end
```

### Schritt 2: Spezialfälle behandeln

```lua
-- AllResist verteilen
if pawnStats.AllResist and pawnStats.AllResist > 0 then
  iopStats.FIRERES = (iopStats.FIRERES or 0) + pawnStats.AllResist
  iopStats.FROSTRES = (iopStats.FROSTRES or 0) + pawnStats.AllResist
  iopStats.ARCANERES = (iopStats.ARCANERES or 0) + pawnStats.AllResist
  iopStats.SHADOWRES = (iopStats.SHADOWRES or 0) + pawnStats.AllResist
  iopStats.NATURERES = (iopStats.NATURERES or 0) + pawnStats.AllResist
end

-- Weapon DPS ignorieren (mit Warnung)
if pawnStats.Dps or pawnStats.MeleeDps or pawnStats.RangedDps then
  print("WARNING: Weapon DPS stats werden ignoriert (nicht in ItemBonusLib verfügbar)")
end

-- Expertise ignorieren für Vanilla
if pawnStats.ExpertiseRating and pawnStats.ExpertiseRating > 0 then
  print("INFO: Expertise wird ignoriert (Vanilla hat keine Expertise)")
end

-- MetaSocketEffect ignorieren
if pawnStats.MetaSocketEffect then
  print("INFO: MetaSocketEffect wird ignoriert (Vanilla hat keine Meta Gems)")
end

-- SpellPower → DMG
if pawnStats.SpellPower and pawnStats.SpellPower > 0 then
  iopStats.DMG = (iopStats.DMG or 0) + pawnStats.SpellPower
end
```

### Schritt 3: Turtle WoW Anpassungen

```lua
-- Turtle WoW spezifische Stats hinzufügen (manuell nach Spec)
-- VAMPIR - nur für Life Drain / Vampiric Specs relevant
-- CASTINGREG - sehr wichtig für Healer

function AddTurtleWoWStats(iopStats, className, specName)
  -- Healer Specs
  if specName == "Restoration" or specName == "Holy" or specName == "Discipline" then
    -- Meditation/CASTINGREG sehr wertvoll
    iopStats.CASTINGREG = iopStats.MANAREG * 2.5  -- 2.5x so wertvoll wie Mp5
  end

  -- Warlock Shadow specs
  if className == "Warlock" then
    iopStats.VAMPIR = 0.1  -- Vampirism für Drain Life Builds
  end

  return iopStats
end
```

---

## Hinweise zur Pre-Multiplication

ClassicHawsJon verwendet "Pre-Multiplied" Werte für Classic Era:

```lua
HitRatingPer = 9.37931  -- 1% Hit = ~9.38 Hit Rating in Vanilla
```

Diese Werte werden in ClassicHawsJon mit den Stat Weights multipliziert:

```lua
HitRating=HitRatingPer*1  -- bedeutet: 1% Hit hat Weight 1.0
```

**Für ItemsOfPower:**
- ItemBonusLib gibt bereits die **Rating-Werte** zurück (nicht die %-Werte)
- Daher: Die Pawn Weights **DIREKT übernehmen** (die Multiplikation ist bereits in Pawn gemacht)

**Beispiel:**
```
Pawn: HitRating=HitRatingPer*1.0 = 9.37931*1.0 = 9.37931
IoP:  TOHIT=9.37931  ← Direkt übernehmen!
```

---

## Zusammenfassung

**Konvertierbare Stats:** 34 von 37 Pawn Stats (92%)

**Nicht konvertierbar:**
1. `Dps` / `MeleeDps` / `RangedDps` - Weapon DPS nicht verfügbar in ItemBonusLib
2. `ExpertiseRating` - Nicht relevant für Vanilla Classic
3. `MetaSocketEffect` - TBC/WotLK Feature, nicht in Vanilla

**Spezialfälle:**
1. `AllResist` - Auf einzelne Resists verteilen
2. `IsOffHand` - Als Filter verwenden, separate StatSets erstellen
3. `SpellPower` - Auf `DMG` mappen

**Turtle WoW Ergänzungen:**
1. `VAMPIR` - Manuell hinzufügen für relevante Specs
2. `CASTINGREG` - Manuell hinzufügen für Healer Specs
