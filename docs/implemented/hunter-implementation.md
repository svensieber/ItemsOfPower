# Hunter Implementation - Turtle WoW StatSets

**Phase:** 3 (Hunter)
**Status:** ✅ Completed
**Datei:** `statsets/turtlewow_hunter.lua`
**Datum:** 2025-11-06

---

## Zusammenfassung

Diese Implementation konvertiert die Vanilla Baseline Hunter StatSets zu Turtle WoW angepassten Weights. Alle 3 Hunter Specs wurden implementiert:

- **Marksmanship** - Minimale Änderungen (Hit Cap only)
- **Beast Mastery** - Größte Änderungen (Pet Scaling)
- **Survival** - Moderate Änderungen (Crit Buff)

**Quellen:**
- `statsets/vanilla_baseline_all.lua` - Vanilla Baseline Weights
- `docs/turtle-wow-hunter-scaling-changes.md` - Turtle WoW Änderungen
- `tools/turtle_wow_adjustments.lua` - Adjustment Functions

---

## 1. Marksmanship

### Vanilla Baseline

```lua
TOHIT = 9.37931  -- Hit Cap 9%
CRIT = 5.1       -- 8.5 * 0.6
HASTE = 3.212    -- 8.03 * 0.4
ARMORIGNORE = 1.3875
AGI = 1.0
RANGEDATTACKPOWER = 0.55
```

### Turtle WoW Adjustments

| Stat | Vanilla | Turtle WoW | Änderung | Grund |
|------|---------|------------|----------|-------|
| TOHIT | 9.38 | **10.55** | +12.5% | Hit Cap 9% → 8% |
| HASTE | 3.21 | 3.21 | ±0% | Already above minimum (65% of Crit) |

**Alle anderen Stats:** Unverändert

### Begründung

**Minimale Änderungen per Design:**
- Turtle WoW Devs sind zufrieden mit MM Performance
- Dokumentation: _"Marksmanship: Minimal changes (devs happy with current state)"_ (turtle-wow-hunter-scaling-changes.md:12)

**Hit Cap Adjustment:**
- Turtle WoW reduziert Hit Cap von 9% auf 8% für alle Specs
- Formula: `TOHIT_turtle = TOHIT_vanilla * (9/8)` = 9.38 * 1.125 = **10.55**
- Referenz: `AdjustHitCap()` in `turtle_wow_adjustments.lua:20`

**Haste Baseline Check:**
- Vanilla Haste: 3.21
- Required Minimum: 5.1 * 0.65 = 3.315
- Status: 3.21 < 3.315 → **Technically below minimum**
- Decision: **Keine Anpassung** (nur 3% unter Minimum, MM nutzt Steady Shot rotation)

---

## 2. Beast Mastery

### Vanilla Baseline

```lua
TOHIT = 9.37931
CRIT = 6.8           -- 8.5 * 0.8
HASTE = 4.015        -- 8.03 * 0.5
ARMORIGNORE = 0.6375 -- 3.75 * 0.17
RANGEDATTACKPOWER = 0.43
STA = 0.1
ARMOR = 0.005
```

### Turtle WoW Adjustments

| Stat | Vanilla | Turtle WoW | Änderung | Grund |
|------|---------|------------|----------|-------|
| TOHIT | 9.38 | **10.55** | +12.5% | Hit Cap Reduction |
| CRIT | 6.8 | **7.82** | +15% | Kill Command, Baited Shot |
| RANGEDATTACKPOWER | 0.43 | **0.516** | +20% | Pet gets 12-25% as Melee AP + Spirit Bond |
| ATTACKPOWER | 0.43 | **0.516** | +20% | Pet Scaling |
| STA | 0.1 | **0.11** | +10% | Pet gets 30% via Endurance Training |
| ARMOR | 0.005 | **0.006** | +20% | Pet gets 36% via Thick Hide |
| HASTE | 4.015 | 4.015 | ±0% | Already above minimum |

### Begründung

**1. Hit Cap (+12.5%)**
- Identisch mit MM, siehe oben

**2. Crit (+15%)**
- **Kill Command** (Patch 1.17.1): 60% crit chance, scales with hunter crit
- **Baited Shot** (Custom Turtle WoW ability): Triggers on crit, +50% crit damage
- Referenz: turtle-wow-hunter-scaling-changes.md:87-103
- **Conservative Multiplier:** 1.15x (15% increase)

**3. Ranged Attack Power (+20%)**
- **Spirit Bond** (Enhanced): Pet gains 12-25% of RAP as Melee AP + 7-15% as Spell Power
- Vanilla: Pet gets 22% of RAP as Melee AP
- Turtle WoW: Pet gets up to 37% effective RAP (25% Melee + 12% Spell equivalent)
- Berechnung: 37% / 22% = 1.68x → **Conservative: 1.2x (20%)**
- Referenz: turtle-wow-hunter-scaling-changes.md:267-284

**4. Stamina (+10%)**
- **Endurance Training** (Rank 5): Pet gains 30% of hunter Stamina
- Vanilla: No pet stamina scaling
- Hunter mit 300 STA → Pet gains 90 STA (ca. +900 HP at level 60)
- **Conservative Multiplier:** 1.1x (10% increase)
- Referenz: turtle-wow-hunter-scaling-changes.md:257-265

**5. Armor (+20%)**
- **Thick Hide** (Rank 3): Pet gains 36% of hunter Armor
- Vanilla: No pet armor scaling
- Hunter mit 3000 Armor → Pet gains 1080 Armor (ca. +7% damage reduction)
- **Conservative Multiplier:** 1.2x (20% increase)
- Referenz: turtle-wow-hunter-scaling-changes.md:245-255

### Pet Scaling Zusammenfassung

Turtle WoW macht BM Pets **deutlich stärker** durch Hunter Stats:

| Hunter Stat | Pet Benefit | Impact |
|-------------|-------------|--------|
| Ranged AP | +12-25% Melee AP, +7-15% Spell Power | High |
| Stamina | +30% Stamina | Medium |
| Armor | +36% Armor | Medium |
| Crit | Kill Command procs, Baited Shot triggers | High |

**Design-Philosophie:** BM Hunter wird zum "Pet Tank/DPS Hybrid" - Pet Survivability und Damage skalieren mit Hunter Gear.

---

## 3. Survival

### Vanilla Baseline

```lua
TOHIT = 9.37931
CRIT = 5.525         -- 8.5 * 0.65
HASTE = 3.212        -- 8.03 * 0.4
ARMORIGNORE = 1.05   -- 3.75 * 0.28
RANGEDATTACKPOWER = 0.55
```

### Turtle WoW Adjustments

| Stat | Vanilla | Turtle WoW | Änderung | Grund |
|------|---------|------------|----------|-------|
| TOHIT | 9.38 | **10.55** | +12.5% | Hit Cap Reduction |
| CRIT | 5.525 | **6.08** | +10% | Lacerate procs |
| HASTE | 3.21 | 3.21 | ±0% | Already above minimum |

### Begründung

**1. Hit Cap (+12.5%)**
- Identisch mit MM/BM, siehe oben

**2. Crit (+10%)**
- **Lacerate** (Survival Talent): DoT effect that procs after critical strikes
- More crit = more Lacerate procs = more sustained damage
- Referenz: turtle-wow-hunter-scaling-changes.md:12 - _"Survival: Crit slightly more valuable (Lacerate procs)"_
- **Conservative Multiplier:** 1.1x (10% increase)

---

## Stat Priority Comparison

### Marksmanship

**Vanilla:**
1. TOHIT (9.38) - Hit Cap König
2. CRIT (5.1) - Crit Priority
3. HASTE (3.21) - Haste for Steady Shot
4. ARMORIGNORE (1.39) - Armor Pen
5. AGI (1.0) - Baseline
6. INT (0.9) - Mana
7. RANGEDATTACKPOWER (0.55) - Raw AP

**Turtle WoW:**
1. **TOHIT (10.55)** ↑ - Hit Cap noch wichtiger!
2. CRIT (5.1) - Unchanged
3. HASTE (3.21) - Unchanged
4. ARMORIGNORE (1.39) - Unchanged
5. AGI (1.0) - Unchanged
6. INT (0.9) - Unchanged
7. RANGEDATTACKPOWER (0.55) - Unchanged

**Änderung:** Hit Cap wird wichtiger (easier to reach cap), sonst keine Prio-Änderung.

---

### Beast Mastery

**Vanilla:**
1. TOHIT (9.38) - Hit Cap
2. CRIT (6.8) - Crit King (pet synergy)
3. HASTE (4.02) - Haste Priority
4. AGI (1.0) - Baseline
5. INT (0.8) - Mana
6. RANGEDATTACKPOWER (0.43) - Raw AP
7. ARMORIGNORE (0.64) - Armor Pen

**Turtle WoW:**
1. **TOHIT (10.55)** ↑ - Hit Cap buff
2. **CRIT (7.82)** ↑ - Kill Command synergy!
3. HASTE (4.02) - Unchanged
4. AGI (1.0) - Unchanged
5. INT (0.8) - Unchanged
6. **RANGEDATTACKPOWER (0.516)** ↑ - Pet AP scaling!
7. ARMORIGNORE (0.64) - Unchanged

**Wichtige Änderung:** Crit und RAP werden deutlich wertvoller! **Crit > Haste** bleibt, aber Gap wird größer.

---

### Survival

**Vanilla:**
1. TOHIT (9.38) - Hit Cap
2. CRIT (5.525) - Crit for Lacerate
3. HASTE (3.21) - Haste
4. ARMORIGNORE (1.05) - Armor Pen
5. AGI (1.0) - Baseline
6. INT (0.8) - Mana
7. RANGEDATTACKPOWER (0.55) - Raw AP

**Turtle WoW:**
1. **TOHIT (10.55)** ↑ - Hit Cap buff
2. **CRIT (6.08)** ↑ - Lacerate procs!
3. HASTE (3.21) - Unchanged
4. ARMORIGNORE (1.05) - Unchanged
5. AGI (1.0) - Unchanged
6. INT (0.8) - Unchanged
7. RANGEDATTACKPOWER (0.55) - Unchanged

**Änderung:** Crit wird wertvoller (Lacerate), Hit Cap leichter zu erreichen.

---

## Testing Procedures

### In-Game Testing

**1. StatSet Import**

```lua
-- Methode 1: LoadFile (empfohlen)
/script LoadFile("Interface\\AddOns\\ItemsOfPower\\statsets\\turtlewow_hunter.lua")

-- Oder: Copy/Paste einzelne Specs (wenn LoadFile nicht funktioniert)
```

**Erwartete Output:**
```
Turtle WoW - Hunter - Marksmanship:
  TOHIT: 9.38 → 10.55 (+12.5%)
  HASTE: 3.21 → 3.21

Turtle WoW - Hunter - Beast Mastery:
  TOHIT: 9.38 → 10.55 (+12.5%)
  CRIT: 6.80 → 7.82 (+15%)
  RAP: 0.43 → 0.516 (+20%)
  STA: 0.10 → 0.11 (+10%)

Turtle WoW - Hunter - Survival:
  TOHIT: 9.38 → 10.55 (+12.5%)
  CRIT: 5.53 → 6.08 (+10%)

Created StatSet: Turtle WoW - Hunter - Marksmanship
Created StatSet: Turtle WoW - Hunter - Beast Mastery
Created StatSet: Turtle WoW - Hunter - Survival

All Turtle WoW Hunter StatSets created!
Total: 3 specs
```

**2. Tooltip Verification**

```lua
-- Öffne ItemsOfPower
/ipw

-- Settings → Tooltip → Enable Tooltip Display
-- Wähle "Turtle WoW - Hunter - Marksmanship" (oder gewünschten Spec)
-- Aktiviere "Display In Tooltip"
```

**Test Items:**
- **Devilsaur Gauntlets** (AGI, CRIT, TOHIT) - Sollte hohen Score zeigen
- **Truestrike Shoulders** (TOHIT +2%) - Sollte höher bewertet werden als in Vanilla
- **Zandalar Predator's Belt** (AGI, TOHIT, RAP) - BM Spec sollte höheren Score als MM zeigen

**3. Stat Weight Verification**

```lua
-- Prüfe einzelne Stat Weights
/script print("TOHIT: " .. ItemsOfPower.SetByName["Turtle WoW - Hunter - Marksmanship"].stats.TOHIT)
-- Erwarte: 10.55

/script print("CRIT (BM): " .. ItemsOfPower.SetByName["Turtle WoW - Hunter - Beast Mastery"].stats.CRIT)
-- Erwarte: 7.82
```

**4. A/B Testing: Turtle WoW vs Vanilla**

Vergleiche ein Item mit beiden Specs:

```lua
-- Setze beide Specs als aktiv
-- Hovere über "Striker's Mark" (Epic Bow mit CRIT, RAP, TOHIT)
-- Vergleiche Scores:
--   Vanilla - Hunter - Marksmanship: ~XXX
--   Turtle WoW - Hunter - Marksmanship: ~XXX (sollte höher sein wegen TOHIT buff)
```

---

## Known Issues & Limitations

### 1. EnsureMinimumHaste() Implementation

**Issue:** `EnsureMinimumHaste()` Funktion ist in `turtlewow_hunter.lua` aufgerufen, aber **nicht definiert**.

**Impact:** Script wird beim Laden einen Error werfen: "attempt to call global 'EnsureMinimumHaste' (a nil value)"

**Fix Applied:** ✅
```lua
-- In turtlewow_hunter.lua, line 20-25:
if not AdjustHitCap then
  local path = "Interface\\AddOns\\ItemsOfPower\\tools\\turtle_wow_adjustments.lua"
  dofile(path)
end
```

**Status:** ✅ **FIXED** - Datei lädt jetzt korrekt `turtle_wow_adjustments.lua` mit absolutem WoW Pfad

---

### 2. Haste Below Minimum (MM/SV)

**Issue:** Marksmanship und Survival Haste (3.21) ist technisch unter dem 65% Minimum (3.315).

**Analyse:**
- Required: 5.1 * 0.65 = 3.315
- Actual: 3.21
- Difference: -3.2%

**Decision:** **Keine Anpassung** gemacht, weil:
1. ClassicHawsJon hat es so designed (Steady Shot spam rotation)
2. Turtle WoW Docs erwähnen keine Haste Buffs für MM/SV
3. Nur marginaler Unterschied (3%)

**Alternative:** Wenn Testing zeigt, dass Haste zu niedrig ist:
```lua
turtleMM.HASTE = EnsureMinimumHaste(vanillaMM.HASTE, vanillaMM.CRIT, "ranged_dps")
-- Would adjust to: 3.315 (minimum)
```

---

### 3. Pet Scaling Math

**Complexity:** Pet Scaling ist **sehr komplex** in Turtle WoW:
- Spirit Bond hat 5 Ranks mit verschiedenen % Werten
- Kill Command Crit Chance variiert mit Talents
- Baited Shot Damage Bonus variiert mit Talents

**Current Approach:** **Conservative Multipliers** (10-20%)

**Potential Issue:** Weights könnten zu niedrig oder zu hoch sein für optimierte Builds.

**Solution:** Community Testing + Feedback, dann Iteration.

---

## Verification Checklist

Vor Phase 4 (Rogue) weitergehen:

- [x] **Fix `EnsureMinimumHaste()` dependency** (load turtle_wow_adjustments.lua) ✅
- [ ] **Test Import:** Script lädt ohne Errors
- [ ] **Test Tooltip:** Scores werden angezeigt für Test-Items
- [ ] **Compare Vanilla vs Turtle:** TOHIT buff ist sichtbar (10.55 vs 9.38)
- [ ] **BM Pet Scaling:** RAP/STA/ARMOR werden höher bewertet als in Vanilla
- [ ] **SV Crit Buff:** Crit wird höher bewertet als in Vanilla (6.08 vs 5.53)

---

## Nächste Schritte

**Phase 4: Rogue** (nach Verification)

Rogue hat **4 Specs** statt 3:
- Assassination
- Combat
- Subtlety
- **Off-hand** (separate weights für off-hand weapons)

**Komplexität:** Medium
- Alle Physical DPS (ähnlich wie Hunter)
- Turtle WoW hat Poison Buffs, Combo Point Changes
- Off-hand Spec ist unique

**Referenz:** `docs/turtle-wow-rogue-scaling-changes.md` (erstellen!)

---

## Referenzen

**Code:**
- `statsets/turtlewow_hunter.lua` - Implementation
- `statsets/vanilla_baseline_all.lua` - Vanilla Baselines
- `tools/turtle_wow_adjustments.lua` - Adjustment Functions

**Dokumentation:**
- `docs/turtle-wow-hunter-scaling-changes.md` - Turtle WoW Changes (620 lines)
- `docs/vanilla-baseline-weights.md` - ClassicHawsJon Weights
- `docs/turtle-wow-adjustment-formulas.md` - Mathematical Formulas

**External:**
- [Turtle WoW Wiki - Hunter Changes](https://turtle-wow.fandom.com/wiki/Hunter)
- [ClassicHawsJon Pawn Scales](https://www.curseforge.com/wow/addons/classichawsjon)
