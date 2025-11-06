# Vanilla StatSets Imported

Dieses Dokument listet alle Vanilla Baseline StatSets auf, die aus ClassicHawsJon konvertiert und in ItemsOfPower importiert wurden.

**Datei:** `statsets/vanilla_baseline_all.lua`
**Generiert:** 2025-11-06
**Quelle:** ClassicHawsJon_small.lua (Pawn scales für Classic Era)
**Total:** 28 Specs

---

## Zweck der Vanilla Baselines

Diese StatSets dienen als:
1. **Referenz-Baseline** - Vergleich mit Turtle WoW Anpassungen
2. **A/B Testing** - User können Vanilla vs Turtle WoW Weights vergleichen
3. **Debugging** - Ist ein Problem in der Konvertierung oder den Turtle Anpassungen?
4. **Fallback** - Falls Turtle WoW Anpassungen nicht gefallen

**Wichtig:** Diese Weights sind für **Vanilla WoW**, NICHT für Turtle WoW optimiert!

---

## Liste aller importierten StatSets

### Druid (4 Specs)

| Spec Name | Role | Top 3 Stats | Notes |
|-----------|------|-------------|-------|
| Vanilla - Druid - Balance | Caster DPS | SpellHit (9.68), DMG (1.0), SpellHaste (6.42) | Moonkin |
| Vanilla - Druid - Feral Damage | Melee DPS | STR (1.48), AGI (1.0), HitRating (5.72) | Cat Form |
| Vanilla - Druid - Feral Tank | Tank | STA (1.0), ARMOR (0.1), DODGE (3.59) | Bear Form |
| Vanilla - Druid - Restoration | Healer | Mp5 (1.7), HEAL (1.21), INT (1.0) | Tree Form |

---

### Hunter (3 Specs)

| Spec Name | Role | Top 3 Stats | Notes |
|-----------|------|-------------|-------|
| Vanilla - Hunter - Beast Mastery | Ranged DPS | HitRating (9.38), CritRating (6.8), HasteRating (4.02) | Pet focus |
| Vanilla - Hunter - Marksmanship | Ranged DPS | HitRating (9.38), CritRating (5.1), HasteRating (3.21) | Pure ranged |
| Vanilla - Hunter - Survival | Ranged DPS | HitRating (9.38), CritRating (5.53), HasteRating (3.21) | Melee/Ranged hybrid |

---

### Mage (3 Specs)

| Spec Name | Role | Top 3 Stats | Notes |
|-----------|------|-------------|-------|
| Vanilla - Mage - Arcane | Caster DPS | SpellHit (6.96), ArcaneSpellDmg (0.88), SpellCrit (4.8) | Mana management |
| Vanilla - Mage - Fire | Caster DPS | SpellHit (7.44), FireSpellDmg (0.94), SpellHaste (6.58) | Crit focus |
| Vanilla - Mage - Frost | Caster DPS | SpellHit (9.76), FrostSpellDmg (0.95), SpellHaste (5.06) | Control + DPS |

---

### Paladin (3 Specs)

| Spec Name | Role | Top 3 Stats | Notes |
|-----------|------|-------------|-------|
| Vanilla - Paladin - Holy | Healer | Mp5 (1.24), INT (1.0), HEAL (0.54) | Flash of Light spam |
| Vanilla - Paladin - Protection | Tank | STA (1.0), SpellHit (6.24), Defense (1.05) | Spell threat |
| Vanilla - Paladin - Retribution | Melee DPS | STR (1.0), HitRating (7.88), CritRating (5.61) | Hybrid physical/spell |

**Besonderheit Prot Paladin:** SpellHit sehr wertvoll für Holy Shield threat!

---

### Priest (3 Specs)

| Spec Name | Role | Top 3 Stats | Notes |
|-----------|------|-------------|-------|
| Vanilla - Priest - Discipline | Healer | Mp5 (1.19), INT (1.0), HEAL (0.72) | Shield spam |
| Vanilla - Priest - Holy | Healer | Mp5 (1.35), INT (1.0), HEAL (0.81) | Renew + Flash Heal |
| Vanilla - Priest - Shadow | Caster DPS | SpellHit (8.96), ShadowSpellDmg (1.0), SpellCrit (6.08) | DoT focus |

**Hinweis:** Discipline wird in Turtle WoW zu Holy DPS umgebaut!

---

### Rogue (3 Specs)

| Spec Name | Role | Top 3 Stats | Notes |
|-----------|------|-------------|-------|
| Vanilla - Rogue - Assassination | Melee DPS | HitRating (9.38), HasteRating (7.23), CritRating (6.89) | Poison focus |
| Vanilla - Rogue - Combat | Melee DPS | HitRating (9.38), HasteRating (7.23), CritRating (6.89) | Sword spec |
| Vanilla - Rogue - Subtlety | Melee DPS | HitRating (9.38), HasteRating (7.23), CritRating (6.89) | Stealth focus |

**Hinweis:** Alle 3 Specs haben identische Weights (unterscheiden sich nur in Talents)

---

### Shaman (3 Specs)

| Spec Name | Role | Top 3 Stats | Notes |
|-----------|------|-------------|-------|
| Vanilla - Shaman - Elemental | Caster DPS | SpellCrit (8.4), SpellHaste (7.23), SpellHit (7.2) | Lightning Bolt spam |
| Vanilla - Shaman - Enhancement | Melee DPS | Expertise (3.52), STR (1.0), CritRating (8.33) | Hybrid melee/spell |
| Vanilla - Shaman - Restoration | Healer | Mp5 (1.33), INT (1.0), HEAL (0.9) | Chain Heal focus |

**Besonderheit Enhancement:** ExpertiseRating = 3.52 (höchster Wert aller Specs!)

---

### Warlock (3 Specs)

| Spec Name | Role | Top 3 Stats | Notes |
|-----------|------|-------------|-------|
| Vanilla - Warlock - Affliction | Caster DPS | SpellHit (9.6), ShadowSpellDmg (0.91), SpellHaste (6.26) | DoT focus |
| Vanilla - Warlock - Demonology | Caster DPS | SpellHit (9.6), FireSpellDmg (0.8), ShadowSpellDmg (0.8) | Pet buffs |
| Vanilla - Warlock - Destruction | Caster DPS | SpellHit (12.8), SpellHaste (9.23), DMG (1.0) | Direct damage |

**Besonderheit Destruction:** SpellHit = 12.8 (HÖCHSTER aller Caster Specs!)

---

### Warrior (3 Specs)

| Spec Name | Role | Top 3 Stats | Notes |
|-----------|------|-------------|-------|
| Vanilla - Warrior - Arms | Melee DPS | HitRating (9.38), ArmorPen (4.13), CritRating (7.23) | Mortal Strike |
| Vanilla - Warrior - Fury | Melee DPS | CritRating (5.95), HitRating (5.35), Ap (0.54) | Dual wield |
| Vanilla - Warrior - Protection | Tank | STA (1.0), Defense (1.22), Dodge (6.61) | Shield Block |

**Besonderheit Arms:** ArmorPen = 4.13 (höchster ArmorPen Wert aller Specs!)

---

## Verwendung In-Game

### Methode 1: LoadFile (empfohlen)

```lua
/script LoadFile("Interface\\AddOns\\ItemsOfPower\\statsets\\vanilla_baseline_all.lua")
```

**Voraussetzung:** Datei muss in AddOns-Ordner liegen

### Methode 2: Copy/Paste

1. Öffne `statsets/vanilla_baseline_all.lua`
2. Kopiere alles ODER nur einzelne Specs
3. Füge in-game ein (max ~255 Zeichen pro Nachricht)
4. Verwende `/run` statt `/script` für längere Blöcke

**Tipp:** Specs sind durch Kommentare getrennt:
```lua
-- Vanilla - Hunter - Marksmanship
do
  local stats = { ... }
  ...
end
```

### Methode 3: Einzelne Specs

Kopiere nur die Specs die du brauchst:

```lua
-- Kopiere von "-- Vanilla - Hunter - Marksmanship"
-- bis zum nächsten "-- Vanilla - ..."
/run -- Vanilla - Hunter - Marksmanship
/run do
/run   local stats = {
/run     AGI = 1.0, TOHIT = 9.38, ...
/run   }
/run   if not ItemsOfPower.SetByName["Vanilla - Hunter - Marksmanship"] then
/run     local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Hunter - Marksmanship", stats)
/run     ItemsOfPower:RegisterSet(set)
/run   end
/run end
```

---

## Verifizierung

### Nach dem Import:

1. **Öffne ItemsOfPower:** `/ipw`
2. **Navigiere zu Sets:** Sollte alle 28 "Vanilla - ..." StatSets zeigen
3. **Prüfe einen Spec:**
   - Wähle z.B. "Vanilla - Hunter - Marksmanship"
   - Prüfe Stat Weights:
     - AGI = 1.0 ✓
     - TOHIT = ~9.38 ✓
     - CRIT = ~5.1 ✓

4. **Tooltip Test:**
   - Hovere über ein Item (z.B. Devilsaur Gauntlets)
   - Sollte "Vanilla - Hunter - Marksmanship: XXX" im Tooltip zeigen
   - Falls nicht: Settings → Tooltip → Display In Tooltip aktivieren

### Bekannte Unterschiede zu Pawn:

ItemsOfPower vs Pawn:
- ✗ **Weapon DPS** - Nicht verfügbar in ItemsOfPower (MeleeDps, RangedDps ignoriert)
- ✗ **Expertise** - Ignoriert (existiert nicht in Vanilla)
- ✗ **Meta Gems** - Ignoriert (TBC Feature)
- ✓ **AllResist** - Auf einzelne Resistances verteilt
- ✓ **Pre-Multiplied Ratings** - Korrekt übernommen

---

## Bekannte Einschränkungen

### 1. Keine Weapon DPS Bewertung

**Problem:** ItemBonusLib scannt keine Weapon DPS

**Workaround:** Weapons separat bewerten (z.B. mit Formel-Sets)

**Beispiel:**
```lua
-- Erstelle ItemFormula Set für Weapon DPS
local formula = "MeleeDps * 5.31 + ATTACKPOWER * 0.45"
```

### 2. Keine Off-hand Spec für Rogue

**ClassicHawsJon hat:** "Rogue: Off Hand" als 4. Spec

**ItemsOfPower:** Nicht inkludiert (noch)

**Workaround:** Nutze Main Hand Spec mit reduziertem Weight

### 3. Keine IsOffHand / IsShield Filters

**Pawn nutzt:** `IsOffHand=PawnIgnoreStatValue` um Items zu filtern

**ItemsOfPower:** Keine Item-Type Filters verfügbar

**Impact:** Tank Specs bewerten auch Off-hand Waffen (was falsch ist)

---

## Statistiken

**Total StatSets:** 28
**Total Zeilen Code:** ~1089
**Durchschnitt pro Spec:** ~39 Zeilen

**Stat Distribution:**
- Physical DPS Specs: 10
- Caster DPS Specs: 9
- Healer Specs: 6
- Tank Specs: 3

**Top Stats (Frequency):**
- TOHIT / SPELLTOHIT: 22 specs (hit is king!)
- CRIT / SPELLCRIT: 25 specs (crit everywhere)
- Stamina: 28 specs (everyone needs HP)
- Mp5: 15 specs (mana users)
- Armor: 28 specs (but very low weight for non-tanks)

---

## Nächste Schritte

**Phase 3+: Turtle WoW Anpassungen** (Klassenweise)

Für jeden Spec:
1. Starte mit Vanilla Baseline
2. Wende allgemeine Adjustments an (`turtle_wow_adjustments.lua`)
3. Wende klassenspezifische Anpassungen an (aus `docs/turtle-wow-*-scaling-changes.md`)
4. Generiere "Turtle WoW - Class - Spec" StatSet
5. Test in-game, compare mit Vanilla Baseline

**Reihenfolge:**
- Phase 3: Hunter (einfach)
- Phase 4: Rogue
- Phase 5: Warlock
- Phase 6-8: Shaman, Paladin, Druid
- Phase 9-11: Mage, Priest, Warrior (komplex)

---

## Troubleshooting

### "StatSet already exists"
```lua
-- Entferne existierenden Set:
ItemsOfPower:UnregisterSet(ItemsOfPower.SetByName["Vanilla - Hunter - Marksmanship"])
-- Dann neu erstellen
```

### "ItemsOfPower.SetTypes.StatSet not found"
- ItemsOfPower nicht geladen
- Führe `/reload` aus

### Weights scheinen falsch
1. Prüfe ob Pre-Multiplication korrekt (HitRating should be ~9.38 for 1.0 weight)
2. Prüfe ob AllResist korrekt verteilt wurde (+0.2 auf jede Resistance)
3. Vergleiche mit `docs/vanilla-baseline-weights.md`

### Tooltip zeigt nichts
1. `/ipw` → Settings → Tooltip → Enable
2. Wähle StatSet → Display In Tooltip aktivieren
3. `/reload` falls nötig

---

## Referenzen

- **Quelle:** `docs/ClassicHawsJon_small.lua`
- **Mapping:** `docs/pawn-to-iop-mapping.md`
- **Baseline Docs:** `docs/vanilla-baseline-weights.md`
- **Generator:** `tools/generate_all_vanilla_baselines.lua`
- **Konverter:** `tools/convert_pawn_to_iop.lua`
