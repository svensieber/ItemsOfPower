# Rogue Implementation - Turtle WoW StatSets

**Phase:** 4 (Rogue)
**Status:** ✅ Completed
**Datei:** `statsets/turtlewow_rogue.lua`
**Datum:** 2025-11-06

---

## Zusammenfassung

Diese Implementation konvertiert die Vanilla Baseline Rogue StatSets zu Turtle WoW angepassten Weights. Alle 3 Rogue Specs wurden implementiert:

- **Assassination** - Größte Änderungen (Poison AP Scaling +35%)
- **Combat** - Agility Buff (Blade Rush Energy Regen +25%)
- **Subtlety** - Support Spec (AP +20%, Health +50%)

**Hinweis:** In Vanilla waren alle 3 Rogue Specs identisch (ClassicHawsJon unterscheidet nur durch Talents). Turtle WoW fügt signifikante mechanische Unterschiede hinzu.

**Quellen:**
- `statsets/vanilla_baseline_all.lua` - Vanilla Baseline Weights
- `docs/turtle-wow-rogue-scaling-changes.md` - Turtle WoW Änderungen (925 Zeilen!)
- `tools/turtle_wow_adjustments.lua` - Adjustment Functions

---

## 1. Assassination

### Vanilla Baseline

```lua
TOHIT = 9.37931  -- Hit Cap 9%
HASTE = 7.227    -- Haste King
CRIT = 6.885     -- Crit
PARRY = 1.1328
ARMORIGNORE = 0.9
AGI = 1.0
ATTACKPOWER = 0.45  -- Relatively low!
STR = 0.5
```

### Turtle WoW Adjustments

| Stat | Vanilla | Turtle WoW | Änderung | Grund |
|------|---------|------------|----------|-------|
| TOHIT | 9.38 | **10.55** | +12.5% | Hit Cap 9% → 8% |
| ATTACKPOWER | 0.45 | **0.608** | +35% | Poison AP Scaling |
| CRIT | 6.885 | **7.57** | +10% | Relentless Strikes |
| HASTE | 7.227 | 7.227 | ±0% | Already above minimum |

**Alle anderen Stats:** Unverändert

### Begründung

**1. Attack Power (+35%) - KRITISCH!**

Turtle WoW fügt **massive Attack Power Scaling** für Poisons hinzu (Patch 1.17.2 Dezember 2024):

**Poison AP Scaling:**
- **Instant Poison:** +5% AP per proc
- **Deadly Poison:** +2% AP per tick × 4 ticks = **+8% AP per stack**
  - 5 stacks = **+40% AP total**
- **Corrosive Poison:** +8% AP per stack (leicht nerfed in 1.18.0)
- **Dissolvent Poison:** +4.75% AP per proc (1.18.0)

**Envenom Multiplier:**
- **Base:** +30% poison effectiveness (April 2025)
- **Combined with AP:**
  - Instant: 5% × 1.30 = **6.5% AP per proc**
  - Deadly: 8% × 1.30 = **10.4% AP per stack** (52% for 5 stacks!)
- **Duration:** 12-28 seconds (1-5 CP)

**Noxious Assault (1.18.0 Capstone):**
- **Type:** Combo point generator
- **Damage:** 35% of Attack Power + flat damage
- **Effect:** Dual wield strike, applies poisons from **both weapons**
- **Energy Cost:** 45
- **Impact:** Constant poison application, scales with AP

**Calculation:**
- Vanilla AP Weight: 0.45
- Poison Scaling Impact: +35% (conservative estimate)
- **Turtle WoW AP Weight:** 0.45 × 1.35 = **0.608**

**Referenz:** turtle-wow-rogue-scaling-changes.md:425-431, 576-584

---

**2. Crit (+10%)**

**Relentless Strikes (Dezember 2024 Major Buff):**
- **Energy Return:** 25 → 20 (nerf)
- **NEW Effect:** Increases finisher damage by **+5% per stack**
- **Max Stacks:** 5 (25% finisher damage increase)
- **Duration:** 30 seconds
- **Impact:** Permanent 20-25% finisher damage amp with proper rotation

**Finisher List:**
- Eviscerate
- Envenom (poison finisher)
- Deadly Throw (pre-April 2025 rework)
- Rupture
- Slice and Dice
- Expose Armor
- Kidney Shot
- Flourish

**Lethality (Tier 5 Talent):**
- **Effect:** +6/12/18/24/30% crit damage for combo point generators
- **Includes:** All combo generators (Sinister Strike, Noxious Assault, etc.)
- **Impact:** Crit scales damage significantly

**Calculation:**
- Vanilla Crit Weight: 6.885
- Relentless Strikes Impact: +10% (conservative)
- **Turtle WoW Crit Weight:** 6.885 × 1.10 = **7.57**

**Referenz:** turtle-wow-rogue-scaling-changes.md:413-418, 540-542

---

**3. Hit Cap (+12.5%)**
- Identisch mit Hunter/anderen Classes
- Hit Cap 9% → 8% (Patch 1.17.2)
- Formula: 9.38 × 1.125 = **10.55**

---

## 2. Combat

### Vanilla Baseline

```lua
-- Identisch mit Assassination in Vanilla!
TOHIT = 9.37931
HASTE = 7.227
CRIT = 6.885
AGI = 1.0
ATTACKPOWER = 0.45
```

### Turtle WoW Adjustments

| Stat | Vanilla | Turtle WoW | Änderung | Grund |
|------|---------|------------|----------|-------|
| TOHIT | 9.38 | **10.55** | +12.5% | Hit Cap Reduction |
| AGI | 1.0 | **1.25** | +25% | Blade Rush Energy Regen |
| CRIT | 6.885 | **7.57** | +10% | Close Quarters Combat |
| HASTE | 7.227 | **7.59** | +5% | Blade Rush Attack Speed |

### Begründung

**1. Agility (+25%) - KRITISCH!**

**Blade Rush (Complete Rework - 1.18.0):**
- **Location:** Tier 6 (moved from Tier 5)
- **New Effect:**
  - +2/5% melee attack speed
  - **Reduces time between Energy regeneration ticks by amount equal to Agility**
- **Impact:** CRITICAL - Agility now directly affects energy generation via tick speed

**Energy Mechanic:**
- **Base:** 2 seconds per tick = 10 energy per tick = 5 energy/sec
- **With Blade Rush (Rank 2) + 300 Agility:**
  - Energy tick time reduced by agility amount
  - Result: Faster energy generation → more abilities per second
  - Exact formula: TBD (unclear from docs)

**Why +25%?**
- Conservative estimate for energy generation value
- Combat is energy-starved (Blade Flurry -30% energy regen)
- More agility = more energy = more DPS
- **Vanilla AGI Weight:** 1.0
- **Turtle WoW AGI Weight:** 1.0 × 1.25 = **1.25**

**Referenz:** turtle-wow-rogue-scaling-changes.md:599-605, 804-812

---

**2. Crit (+10%)**

**Close Quarters Combat (Buffed - October 2024):**
- **Points:** 5 → 2
- **Weapon Types:** Daggers, Fist Weapons, **Maces** (NEW)
- **Effect:** +2/5% crit chance
- **Impact:** Crit highly valuable for these weapon types

**Improved Backstab (Buffed):**
- **New Effect:** Backstab has 15/30/45% chance to award additional combo point
- **Impact:** Crit = more combo points for dagger builds

**Calculation:** Same as Assassination (+10%)
- **Turtle WoW Crit Weight:** 6.885 × 1.10 = **7.57**

**Referenz:** turtle-wow-rogue-scaling-changes.md:230-234, 210-212

---

**3. Haste (+5%)**

**Blade Rush Attack Speed:**
- **Effect:** +2/5% melee attack speed (in addition to energy regen)
- **Impact:** Minor DPS increase

**Why only +5%?**
- Vanilla Haste already sehr hoch (7.227)
- Blade Rush buff is relatively minor (+5% attack speed max)
- **Vanilla Haste Weight:** 7.227
- **Turtle WoW Haste Weight:** 7.227 × 1.05 = **7.59**

**Referenz:** turtle-wow-rogue-scaling-changes.md:599-605

---

**4. Hit Cap (+12.5%)**
- Identisch mit Assassination

---

## 3. Subtlety

### Vanilla Baseline

```lua
-- Identisch mit Assassination/Combat in Vanilla!
TOHIT = 9.37931
HASTE = 7.227
CRIT = 6.885
ATTACKPOWER = 0.45
HEALTH = 0.01  -- Very low!
```

### Turtle WoW Adjustments

| Stat | Vanilla | Turtle WoW | Änderung | Grund |
|------|---------|------------|----------|-------|
| TOHIT | 9.38 | **10.55** | +12.5% | Hit Cap Reduction |
| ATTACKPOWER | 0.45 | **0.54** | +20% | Mark for Death, Shadow of Death |
| HEALTH | 0.01 | **0.015** | +50% | Cloaked in Shadows |

### Begründung

**1. Attack Power (+20%)**

Subtlety ist in Turtle WoW ein **Support/Utility Spec** mit AP Scaling:

**Mark for Death (Capstone - 1.18.0 Rework):**
- **Previous Name:** Exploit Vulnerability
- **Cooldown:** 3 minutes
- **Duration:** 8 seconds (was 6)
- **Effect:**
  - Party Attack Power: **+30% of rogue's melee AP**
  - Party Spell Power: **+18% of rogue's melee AP**
- **Cannot be dodged/blocked/parried**
- **Impact:** CRITICAL - rogue's AP converts to party buffs

**Example:** 2000 AP Rogue
- Party gains: **600 AP** or **360 Spell Power**
- Duration: 8 seconds every 3 minutes (or 2 min with Preparation)

**Shadow of Death (NEW Keystone - 1.18.0):**
- **Type:** Finishing move
- **Cooldown:** 1 minute
- **Energy Cost:** 30
- **Duration:** 6 seconds
- **Mechanic:** Sigil accumulates damage
  - Stores percentage of ALL damage taken by target
  - Max capacity: percentage of rogue's **Attack Power**
  - Both scale per combo point
  - Deals stored damage when full or expires
- **Values by Combo Points:**
  - 1 CP: 50% AP cap, 10% damage accumulated
  - 5 CP: **250% AP cap**, 50% damage accumulated
- **Impact:** Converts party damage buffs into personal burst, scales with AP

**Calculation:**
- Vanilla AP Weight: 0.45
- Support Scaling Impact: +20% (conservative)
- **Turtle WoW AP Weight:** 0.45 × 1.20 = **0.54**

**Referenz:** turtle-wow-rogue-scaling-changes.md:688-697, 665-682

---

**2. Health (+50%)**

**Cloaked in Shadows (NEW - 1.18.0):**
- **Location:** Tier 4
- **Points:** 2
- **Effect:** Vanish grants party members within 20 yards a shield for 20 seconds
- **Shield Amount:** **6/12% of rogue's maximum health**
- **Impact:** Party survivability utility, Health scaling

**Example:** 4000 HP Rogue mit Rank 2
- Shield: 4000 × 0.12 = **480 HP** per party member
- 5-man party: 2400 HP total shields
- 20 second duration

**Calculation:**
- Vanilla Health Weight: 0.01 (very low, nur für survivability)
- Cloaked in Shadows Impact: +50% (conservative)
- **Turtle WoW Health Weight:** 0.01 × 1.50 = **0.015**

**Referenz:** turtle-wow-rogue-scaling-changes.md:647-651

---

**3. Hit Cap (+12.5%)**
- Identisch mit Assassination/Combat

---

## Stat Priority Comparison

### Assassination

**Vanilla:**
1. TOHIT (9.38) - Hit Cap König
2. HASTE (7.23) - Haste King
3. CRIT (6.89) - Crit Priority
4. PARRY (1.13) - Avoidance
5. ARMORIGNORE (0.9)
6. AGI (1.0)
7. STR (0.5)
8. **ATTACKPOWER (0.45)** - Relatively low!

**Turtle WoW:**
1. **TOHIT (10.55)** ↑ - Hit Cap noch wichtiger
2. **HASTE (7.23)** - Unchanged (still king)
3. **CRIT (7.57)** ↑ - Relentless Strikes buff!
4. PARRY (1.13) - Unchanged
5. ARMORIGNORE (0.9) - Unchanged
6. AGI (1.0) - Unchanged
7. **ATTACKPOWER (0.608)** ↑ - MASSIVE JUMP! (Poison Scaling)
8. STR (0.5) - Unchanged

**Wichtige Änderung:** Attack Power springt von Position 8 auf Position 7 und wird **35% wertvoller**! Poison Scaling ist GAME-CHANGER.

---

### Combat

**Vanilla:**
1. TOHIT (9.38)
2. HASTE (7.23)
3. CRIT (6.89)
4. PARRY (1.13)
5. **AGI (1.0)**
6. ARMORIGNORE (0.9)
7. STR (0.5)
8. ATTACKPOWER (0.45)

**Turtle WoW:**
1. **TOHIT (10.55)** ↑
2. **HASTE (7.59)** ↑
3. **CRIT (7.57)** ↑
4. **AGI (1.25)** ↑ - MASSIVE BUFF! (Energy Regen)
5. PARRY (1.13)
6. ARMORIGNORE (0.9)
7. ATTACKPOWER (0.45) - Unchanged
8. STR (0.5)

**Wichtige Änderung:** Agility wird **25% wertvoller** wegen Blade Rush Energy Regen! AGI bleibt an Position 5, aber der Gap zu anderen Stats wird kleiner.

---

### Subtlety

**Vanilla:**
1. TOHIT (9.38)
2. HASTE (7.23)
3. CRIT (6.89)
4. PARRY (1.13)
5. AGI (1.0)
6. ARMORIGNORE (0.9)
7. STR (0.5)
8. ATTACKPOWER (0.45)
9. **HEALTH (0.01)** - Sehr niedrig!

**Turtle WoW:**
1. **TOHIT (10.55)** ↑
2. HASTE (7.23)
3. CRIT (6.89)
4. PARRY (1.13)
5. AGI (1.0)
6. ARMORIGNORE (0.9)
7. **ATTACKPOWER (0.54)** ↑ - Support Scaling!
8. STR (0.5)
9. **HEALTH (0.015)** ↑ - Jetzt wertvoll! (Cloaked in Shadows)

**Wichtige Änderung:** Health wird **50% wertvoller** (immer noch niedrig, aber signifikant für Support-Build). AP wird **20% wertvoller** für Party Buffs.

---

## Testing Procedures

### In-Game Testing

**1. StatSet Import**

```lua
-- Methode 1: LoadFile (empfohlen)
/script LoadFile("Interface\\AddOns\\ItemsOfPower\\statsets\\turtlewow_rogue.lua")

-- Oder: Copy/Paste einzelne Specs
```

**Erwartete Output:**
```
Turtle WoW - Rogue - Assassination:
  TOHIT: 9.38 → 10.55 (+12.5%)
  AP: 0.45 → 0.608 (+35%)
  CRIT: 6.89 → 7.57 (+10%)

Turtle WoW - Rogue - Combat:
  TOHIT: 9.38 → 10.55 (+12.5%)
  AGI: 1.00 → 1.25 (+25%)
  CRIT: 6.89 → 7.57 (+10%)
  HASTE: 7.23 → 7.59 (+5%)

Turtle WoW - Rogue - Subtlety:
  TOHIT: 9.38 → 10.55 (+12.5%)
  AP: 0.45 → 0.54 (+20%)
  HEALTH: 0.010 → 0.015 (+50%)

Created StatSet: Turtle WoW - Rogue - Assassination
Created StatSet: Turtle WoW - Rogue - Combat
Created StatSet: Turtle WoW - Rogue - Subtlety

All Turtle WoW Rogue StatSets created!
Total: 3 specs
```

**2. Tooltip Verification**

```lua
/ipw
-- Settings → Tooltip → Enable
-- Wähle "Turtle WoW - Rogue - Assassination"
-- Aktiviere "Display In Tooltip"
```

**Test Items:**
- **Assassination:** Dal'Rend's Sacred Charge (AP, CRIT) - Sollte höher bewertet werden als Vanilla
- **Combat:** Mugger's Belt (AGI, CRIT) - AGI sollte sehr wertvoll sein
- **Subtlety:** Wristguards of Stability (HEALTH, STA) - Health sollte höher bewertet werden

**3. A/B Testing: Turtle WoW vs Vanilla**

Vergleiche Scores mit beiden Specs aktiv:

**Assassination Test:**
- Item: Aged Core Leather Gloves (AP +28, CRIT +1%)
- Vanilla Score: AP (0.45 × 28) + CRIT ≈ 12.6 + 6.89 = ~19.5
- Turtle Score: AP (0.608 × 28) + CRIT ≈ 17.0 + 7.57 = ~24.6
- **Difference:** +26% higher score!

**Combat Test:**
- Item: Blackhand's Breadth (AGI +25, CRIT +2%)
- Vanilla Score: AGI (1.0 × 25) + CRIT ≈ 25 + 13.8 = ~38.8
- Turtle Score: AGI (1.25 × 25) + CRIT ≈ 31.25 + 15.1 = ~46.4
- **Difference:** +20% higher score!

---

## Known Issues & Limitations

### 1. No Off-Hand Spec

**Issue:** ClassicHawsJon hat "Rogue: Off Hand" als 4. Spec (line 226-249 in ClassicHawsJon_small.lua)

**Impact:** Kein separates StatSet für Off-Hand Weapons

**Workaround:**
- Nutze Main Hand Spec mit manueller Adjustment
- Off-hand hat typischerweise niedrigere Damage-Weights (50% Schaden in Vanilla)

**Future:** Könnte als separates Set hinzugefügt werden

**Referenz:** docs/vanilla-statsets-imported.md:219-226

---

### 2. Blade Rush Energy Regen Math Unclear

**Issue:** Exact formula für Agility → Energy Tick Time reduction ist unclear

**Current Approach:** Conservative +25% AGI multiplier

**Alternative Scenarios:**
- **Aggressive:** +35% if formula is very strong
- **Conservative:** +15% if formula is weak

**Testing Needed:** In-game testing mit verschiedenen Agility levels

**Example Math (hypothetical):**
```lua
-- Base: 2.0 second energy tick
-- With 300 AGI + Blade Rush Rank 2:
--   Reduction = 300 / X (unknown divisor)
--   If X = 100: New tick = 2.0 - 3.0 = -1.0 (impossible, capped)
--   If X = 300: New tick = 2.0 - 1.0 = 1.0 (2x energy regen!)
--   If X = 600: New tick = 2.0 - 0.5 = 1.5 (33% more energy)
```

**Status:** ⚠️ Needs in-game testing to verify optimal multiplier

**Referenz:** turtle-wow-rogue-scaling-changes.md:804-812

---

### 3. Poison AP Scaling Komplexität

**Issue:** Poison Scaling ist **sehr komplex**:
- Different scaling per poison type (5%, 8%, 4.75%)
- Envenom multiplier (30%)
- Stack-based scaling (Deadly/Corrosive 5 stacks)
- Uptime variance

**Current Approach:** Conservative +35% AP multiplier für Assassination

**Scenarios:**
- **Low Envenom Uptime:** +25% might be more accurate
- **High Envenom Uptime:** +45% might be better
- **Depends on:** Rotation, energy management, fight length

**Testing Needed:** DPS logs mit verschiedenen AP levels

---

### 4. Subtlety Support Scaling

**Issue:** Subtlety AP value hängt von **Party Composition** ab:

**Solo Play:**
- Mark for Death: No value (no party to buff)
- Shadow of Death: Only personal burst
- **AP Multiplier:** Könnte sogar niedriger sein als Vanilla!

**Party Play (4 physical DPS):**
- Mark for Death: MASSIVE value (600 AP to party)
- Shadow of Death: Accumulates more damage
- **AP Multiplier:** Könnte +40% oder höher sein!

**Current Approach:** Conservative +20% (assumes occasional party play)

**Alternative:** Create TWO Subtlety specs:
- "Turtle WoW - Rogue - Subtlety (Solo)"
- "Turtle WoW - Rogue - Subtlety (Party)"

---

## Verification Checklist

Vor Phase 5 (Warlock) weitergehen:

- [ ] **Test Import:** Script lädt ohne Errors
- [ ] **Test Tooltip:** Scores werden angezeigt
- [ ] **Assassination AP Test:** Items mit hohem AP werden deutlich höher bewertet
- [ ] **Combat AGI Test:** Agility-heavy Items werden höher bewertet
- [ ] **Subtlety Health Test:** Items mit Health werden höher bewertet (aber immer noch niedrig)
- [ ] **Compare Vanilla vs Turtle:** Alle Specs zeigen höhere Scores für relevante Stats

---

## Nächste Schritte

**Phase 5: Warlock** (nach Verification)

Warlock hat **3 Specs** mit unterschiedlichen Priorities:
- **Affliction:** DoT focus, spell hit
- **Demonology:** Pet scaling (ähnlich wie Hunter BM?)
- **Destruction:** Direct damage, spell crit

**Komplexität:** Medium-High
- Caster (SpellHit, SpellCrit, SpellHaste)
- Pet Scaling für Demonology
- Shadow/Fire Spell Damage Split

**Referenz:** `docs/turtle-wow-warlock-scaling-changes.md` (erstellen!)

---

## Referenzen

**Code:**
- `statsets/turtlewow_rogue.lua` - Implementation (267 lines)
- `statsets/vanilla_baseline_all.lua` - Vanilla Baselines
- `tools/turtle_wow_adjustments.lua` - Adjustment Functions

**Dokumentation:**
- `docs/turtle-wow-rogue-scaling-changes.md` - Turtle WoW Changes (925 lines!)
- `docs/vanilla-baseline-weights.md` - ClassicHawsJon Weights
- `docs/turtle-wow-adjustment-formulas.md` - Mathematical Formulas

**External:**
- [Turtle WoW Wiki - Rogue Changes](https://turtle-wow.fandom.com/wiki/Rogue)
- [Turtle WoW Changelogs](https://forum.turtle-wow.org/viewforum.php?f=19)
