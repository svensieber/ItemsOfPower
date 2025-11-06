# Warlock Implementation - Turtle WoW StatSets

**Phase:** 5 (Warlock)
**Status:** ✅ Completed
**Datei:** `statsets/turtlewow_warlock.lua`
**Datum:** 2025-11-06

---

## Zusammenfassung

Diese Implementation konvertiert die Vanilla Baseline Warlock StatSets zu Turtle WoW angepassten Weights. Alle 3 Warlock Specs wurden implementiert:

- **Affliction** - Moderate Änderungen (Spell Power +15%, Haste +10%)
- **Demonology** - MASSIVE Änderungen (Spell Power +40%, INT +30%, STA +50%)
- **Destruction** - Größere Änderungen (Crit +20%, Shadow Damage +20%)

**Quellen:**
- `statsets/vanilla_baseline_all.lua` - Vanilla Baseline Weights
- `docs/turtle-wow-warlock-scaling-changes.md` - Turtle WoW Änderungen (602 Zeilen!)
- `tools/turtle_wow_adjustments.lua` - Adjustment Functions

---

## 1. Affliction

### Vanilla Baseline

```lua
SPELLTOHIT = 9.6     -- Spell Hit Cap 9%
SPELLHASTE = 6.26    -- Haste
SPELLCRIT = 3.12     -- Crit (lowest of 3 specs)
DMG = 1.0            -- Generic spell damage
SHADOWDMG = 0.91     -- Shadow damage priority
FIREDMG = 0.35       -- Fire damage (lower)
INT = 0.4
MANAREG = 1.0
```

### Turtle WoW Adjustments

| Stat | Vanilla | Turtle WoW | Änderung | Grund |
|------|---------|------------|----------|-------|
| SPELLTOHIT | 9.6 | **10.8** | +12.5% | Spell Hit Cap 9% → 8% |
| DMG | 1.0 | **1.15** | +15% | Siphon Life 100%, Drain Soul, Dark Harvest |
| SPELLHASTE | 6.26 | **6.89** | +10% | Rapid Deterioration DoT tick speed |

**Alle anderen Stats:** Unverändert

### Begründung

**1. Spell Power (+15%)**

Turtle WoW buffed mehrere Affliction Spells mit **signifikanten Spell Power Coefficients**:

**Siphon Life (April 2025 Major Buff):**
- **Coefficient:** 50% → **100%**
- **Impact:** Doubles spell power scaling
- **Referenz:** turtle-wow-warlock-scaling-changes.md:354-356

**Drain Soul (November 2024 Buff):**
- **Coefficient:** 16.67% → **20%**
- **Mana Cost:** -20%
- **Damage Pattern:** Even damage per tick (no more buildup)
- **Impact:** Viable DPS ability
- **Referenz:** turtle-wow-warlock-scaling-changes.md:280-281

**Dark Harvest (NEW Capstone - 1.17.2):**
- **Type:** Channeled Shadow damage
- **Coefficient:** **25%** spell power
- **Damage:** 700-1150 Shadow damage over 8 seconds (R1-R3)
- **Effect:** Reduces Affliction DoT tick time by **20%** (buffed to 30% in April 2025)
- **Cooldown:** 30 seconds
- **Impact:** CRITICAL - new rotational finisher, accelerates DoT damage
- **Referenz:** turtle-wow-warlock-scaling-changes.md:132-138, 357-359

**Soul Siphon (Tier 5 Talent):**
- **Effect:** Drain Soul/Dark Harvest/Death Coil +2/4/6% damage per Affliction effect on target
- **Max:** 4 effects = **24% bonus** at max rank
- **Impact:** Scales with DoT coverage
- **Referenz:** turtle-wow-warlock-scaling-changes.md:126-131, 305-306

**Calculation:**
- Vanilla DMG Weight: 1.0
- Combined Spell Power Scaling: +15% (conservative)
- **Turtle WoW DMG Weight:** 1.0 × 1.15 = **1.15**

---

**2. Spell Haste (+10%)**

**Rapid Deterioration (NEW - 1.17.2 Tier 5):**
- **Points:** 2
- **Effect:**
  - +6% casting speed for Affliction spells
  - **Haste affects DoT/channel tick speed at 50/100% efficiency** (reduces duration)
- **Impact:** Haste scaling for Affliction
- **Referenz:** turtle-wow-warlock-scaling-changes.md:115-120

**Mechanism:**
- **Normal Haste:** Reduces cast time only
- **Rapid Deterioration:** Haste also reduces tick time for DoTs
  - 50% efficiency at Rank 1
  - **100% efficiency at Rank 2**
- **Example:** 10% haste → 10% faster ticks → 10% more DoT damage in same time
- **Combined with Dark Harvest:** DoT damage accelerated by 30% during channel

**Calculation:**
- Vanilla Haste Weight: 6.26
- Rapid Deterioration Impact: +10% (conservative, DoT focus spec)
- **Turtle WoW Haste Weight:** 6.26 × 1.10 = **6.89**

---

**3. Spell Hit Cap (+12.5%)**
- Identisch mit anderen Caster Specs
- Spell Hit Cap 9% → 8% (Patch 1.17.2)
- Formula: 9.6 × 1.125 = **10.8**

---

## 2. Demonology

### Vanilla Baseline

```lua
SPELLTOHIT = 9.6
SPELLHASTE = 5.62
SPELLCRIT = 5.28     -- Higher than Affliction
DMG = 1.0
SHADOWDMG = 0.8      -- Equal Fire/Shadow
FIREDMG = 0.8
INT = 0.4
STA = 0.1
SPI = 0.5            -- Higher than other specs
```

### Turtle WoW Adjustments

| Stat | Vanilla | Turtle WoW | Änderung | Grund |
|------|---------|------------|----------|-------|
| SPELLTOHIT | 9.6 | **10.8** | +12.5% | Spell Hit Cap Reduction |
| DMG | 1.0 | **1.4** | +40% | Demon AP Scaling (MASSIVE!) |
| INT | 0.4 | **0.52** | +30% | Fel Intellect 30% transfer |
| STA | 0.1 | **0.15** | +50% | Fel Stamina 50% transfer |
| SPELLCRIT | 5.28 | **6.34** | +20% | Demonic Precision + Unleashed Potential |

### Begründung

**1. Spell Power (+40%) - GAME-CHANGER!**

Demonology hat in Turtle WoW **MASSIVE Spell Power → Demon Damage Scaling**:

**Demon Attack Power Scaling (August 2025):**
- **Voidwalker:** 20% of warlock spell damage as AP
- **Succubus:** 40%
- **Felhunter:** 30%
- **Infernal:** 60%
- **Felguard:** 60%
- **Doomguard:** 30%
- **Impact:** CRITICAL - demons scale with spell damage as AP
- **Referenz:** turtle-wow-warlock-scaling-changes.md:500-508

**Unleashed Potential (Tier 5 - Reworked December 2024):**
- **Trigger:** Crit strikes grant stack
- **Stack Duration:** 20s (funnel spells refresh)
- **Benefit:** 5/10/15% of spell damage per stack
- **Max Stacks:** 3 (45% spell damage transfer!)
- **Impact:** Crit-based stacking system
- **Referenz:** turtle-wow-warlock-scaling-changes.md:193-201, 316-322

**Imp Firebolt (April 2025 Scaling):**
- **Spell Power Coefficient by Rank:** 10/15/20/25/30/35/40%
- **Impact:** Imp damage scales with gear
- **Referenz:** turtle-wow-warlock-scaling-changes.md:371-372

**Combined Example:** 500 Spell Damage Warlock mit Felguard
- Demon AP from base: 500 × 0.60 = **300 AP**
- Demon spell damage from Unleashed Potential (3 stacks): 500 × 0.45 = **225 spell damage**
- Total demon buff: 300 AP + 225 spell damage
- **Impact:** Massive demon DPS increase

**Calculation:**
- Vanilla DMG Weight: 1.0
- Combined Demon Scaling: +40% (conservative, high demon uptime assumed)
- **Turtle WoW DMG Weight:** 1.0 × 1.40 = **1.4**

---

**2. Intellect (+30%)**

**Fel Intellect (MAJOR REWORK - 1.17.2, Adjusted December 2024):**
- **Previous:** Static mana bonus
- **New Effect:**
  - **10/20/30% of warlock's total Intellect transferred to demon**
  - 5/10/15% demon mana regen continues while casting
- **Points:** 5 → 3
- **Impact:** CRITICAL - Intellect now scales demon mana and regen
- **Referenz:** turtle-wow-warlock-scaling-changes.md:160-164, 308-311

**Example:** 300 Intellect Warlock mit Rank 3 Fel Intellect
- Demon gains: 300 × 0.30 = **90 Intellect**
- Effect: +1350 mana (15 mana per INT)
- Plus: 15% mana regen while warlock casting

**Calculation:**
- Vanilla INT Weight: 0.4
- Fel Intellect Impact: +30% (matches max transfer %)
- **Turtle WoW INT Weight:** 0.4 × 1.30 = **0.52**

---

**3. Stamina (+50%)**

**Fel Stamina (MAJOR REWORK - 1.17.2, Adjusted December 2024):**
- **Previous:** Static health bonus
- **New Effect:**
  - **10/20/30/40/50% of warlock's total Stamina transferred to demon**
  - -1/2/3/4/5% chance for demon to be crit
- **Points:** 5 (unchanged)
- **Impact:** CRITICAL - Stamina now scales demon health
- **Referenz:** turtle-wow-warlock-scaling-changes.md:166-170, 313-314

**Example:** 300 Stamina Warlock mit Rank 5 Fel Stamina
- Demon gains: 300 × 0.50 = **150 Stamina**
- Effect: +1500 HP (10 HP per STA)
- Plus: -5% chance to be crit

**Calculation:**
- Vanilla STA Weight: 0.1
- Fel Stamina Impact: +50% (matches max transfer %)
- **Turtle WoW STA Weight:** 0.1 × 1.50 = **0.15**

---

**4. Spell Crit (+20%)**

**Demonic Precision (Tier 6 - Reworked December 2024):**
- **Effect:** Demons gain +1/2/3% melee/spell hit
- **Transfer:** 30/60/90% of warlock **spell hit and spell crit** to demons
- **Impact:** CRITICAL - both hit and crit transfer
- **Referenz:** turtle-wow-warlock-scaling-changes.md:209-211, 323-325, 456-458

**Unleashed Potential (Trigger):**
- **Previous:** Direct damage 60% chance
- **New:** **Crit strikes grant stack**
- **Impact:** More crit = more demon damage stacks
- **Referenz:** turtle-wow-warlock-scaling-changes.md:316-322

**Calculation:**
- Vanilla Crit Weight: 5.28
- Combined Crit Impact: +20% (Demonic Precision transfer + Unleashed Potential trigger)
- **Turtle WoW Crit Weight:** 5.28 × 1.20 = **6.34**

---

**5. Spell Hit Cap (+12.5%)**
- Identisch mit Affliction

---

## 3. Destruction

### Vanilla Baseline

```lua
SPELLTOHIT = 12.8    -- HIGHEST of all caster specs!
SPELLHASTE = 9.23    -- Haste King
SPELLCRIT = 6.96     -- High crit
DMG = 1.0
SHADOWDMG = 0.95     -- Shadow damage priority
FIREDMG = 0.23       -- Fire damage (lower)
INT = 0.34
MANAREG = 0.65       -- Lower than other specs
```

### Turtle WoW Adjustments

| Stat | Vanilla | Turtle WoW | Änderung | Grund |
|------|---------|------------|----------|-------|
| SPELLTOHIT | 12.8 | **14.4** | +12.5% | Spell Hit Cap Reduction |
| DMG | 1.0 | **1.15** | +15% | Soul Fire 114% |
| SPELLCRIT | 6.96 | **8.35** | +20% | Improved Shadow Bolt proc on crit |
| SHADOWDMG | 0.95 | **1.14** | +20% | Improved Shadow Bolt +20% debuff |
| FIREDMG | 0.23 | **0.253** | +10% | Improved Soul Fire +10% |

### Begründung

**1. Spell Crit (+20%) - KRITISCH!**

**Shadow Vulnerability (Improved Shadow Bolt - Reworked):**

**December 2024 Rework:**
- **On Hit:** 5-10% chance (was 5-25%)
- **On Crit:** **20/40/60/80/100% chance**
- **Shadow Damage:** +15% → **+20%**
- **Duration:** 10 seconds, no charges (permanent until expires)
- **Impact:** CRITICAL - crit-dependent proc, massive Shadow damage amp
- **Referenz:** turtle-wow-warlock-scaling-changes.md:234-239, 286-290

**Mechanism:**
- **Rank 5:** 100% chance to apply on crit
- **Debuff:** +20% Shadow damage for 10 seconds
- **Example:** 1000 Shadow Bolt damage becomes 1200 with debuff
- **Uptime:** Very high with proper crit rate (30%+ crit = near-permanent)

**Improved Soul Fire (Tier 5 - 1.17.2):**
- **Effect:** Soul Fire 50/100% chance to refund Soul Shard and grant **+8% Fire damage** for 25 sec
- **December 2024 Buff:** On hit → **on cast** (guaranteed)
- **Duration:** 25s → **30s**
- **1.18.0 Buff:** Fire Damage Bonus: 8% → **10%**
- **Impact:** Near-permanent Fire damage buff with 30s cooldown
- **Referenz:** turtle-wow-warlock-scaling-changes.md:252-254, 292-294, 478-479

**Calculation:**
- Vanilla Crit Weight: 6.96
- Shadow Vulnerability Crit Scaling: +20% (conservative, high crit synergy)
- **Turtle WoW Crit Weight:** 6.96 × 1.20 = **8.35**

---

**2. Shadow Damage (+20%)**

**Shadow Vulnerability (Improved Shadow Bolt):**
- **Effect:** +20% Shadow damage debuff (was +15%)
- **Duration:** 10 seconds
- **Uptime:** Very high with Rank 5 (100% on crit)
- **Impact:** Permanent Shadow damage multiplier
- **Referenz:** turtle-wow-warlock-scaling-changes.md:286-290

**Calculation:**
- Vanilla Shadow Damage Weight: 0.95
- Shadow Vulnerability Multiplier: +20% (matches debuff strength)
- **Turtle WoW Shadow Damage Weight:** 0.95 × 1.20 = **1.14**

---

**3. Spell Power (+15%)**

**Soul Fire (Major Buffs - 1.17.2, Nerfed 1.18.0):**
- **Coefficient:** 100% → 125% (1.17.2) → **114%** (1.18.0)
- **Cooldown:** 1 minute → **30 seconds**
- **Ranks:** 4 ranks starting at level 30
- **Impact:** Usable on cooldown, strong spell power scaling
- **Referenz:** turtle-wow-warlock-scaling-changes.md:38-42, 415-417

**Improved Shadow Bolt Amplification:**
- **+20% Shadow damage debuff** applies to all Shadow spells
- **Shadow Bolt** is primary filler
- **Impact:** More spell power value when debuff active

**Calculation:**
- Vanilla DMG Weight: 1.0
- Combined Spell Power Scaling: +15% (conservative, Soul Fire + debuff)
- **Turtle WoW DMG Weight:** 1.0 × 1.15 = **1.15**

---

**4. Fire Damage (+10%)**

**Improved Soul Fire (1.18.0 Buff):**
- **Effect:** +10% Fire damage for 30 seconds (was +8%)
- **Trigger:** On cast (guaranteed)
- **Duration:** 30 seconds
- **Soul Fire Cooldown:** 30 seconds
- **Impact:** **Near-permanent +10% Fire damage buff**
- **Referenz:** turtle-wow-warlock-scaling-changes.md:478-479

**Calculation:**
- Vanilla Fire Damage Weight: 0.23
- Improved Soul Fire Buff: +10% (matches buff strength)
- **Turtle WoW Fire Damage Weight:** 0.23 × 1.10 = **0.253**

---

**5. Spell Hit Cap (+12.5%)**
- Identisch mit Affliction/Demonology
- **Wichtig:** Destruction hat **höchsten SPELLTOHIT** in Vanilla (12.8)
- **Turtle WoW:** 12.8 × 1.125 = **14.4**

---

## Stat Priority Comparison

### Affliction

**Vanilla:**
1. SPELLTOHIT (9.6) - Hit Cap
2. SPELLHASTE (6.26) - Haste
3. SPELLCRIT (3.12) - Crit (lowest)
4. DMG (1.0) - Generic spell damage
5. MANAREG (1.0) - Mp5
6. SHADOWDMG (0.91) - Shadow damage
7. INT (0.4)
8. FIREDMG (0.35) - Fire damage

**Turtle WoW:**
1. **SPELLTOHIT (10.8)** ↑ - Hit Cap wichtiger
2. **SPELLHASTE (6.89)** ↑ - DoT tick speed!
3. SPELLCRIT (3.12) - Unchanged (still low)
4. **DMG (1.15)** ↑ - Siphon Life, Dark Harvest
5. MANAREG (1.0) - Unchanged
6. SHADOWDMG (0.91) - Unchanged
7. INT (0.4) - Unchanged
8. FIREDMG (0.35) - Unchanged

**Wichtige Änderung:** Haste wird **deutlich wertvoller** wegen Rapid Deterioration! DoT Spec profitiert stark von Haste.

---

### Demonology

**Vanilla:**
1. SPELLTOHIT (9.6) - Hit Cap
2. SPELLHASTE (5.62) - Haste
3. SPELLCRIT (5.28) - Crit
4. **DMG (1.0)** - Generic spell damage
5. MANAREG (1.0) - Mp5
6. SHADOWDMG (0.8) - Shadow
7. FIREDMG (0.8) - Fire
8. SPI (0.5) - Spirit
9. **INT (0.4)** - Intellect
10. **STA (0.1)** - Stamina

**Turtle WoW:**
1. **SPELLTOHIT (10.8)** ↑
2. **DMG (1.4)** ↑↑ - MASSIVE JUMP! (Demon AP Scaling)
3. SPELLHASTE (5.62) - Unchanged
4. **SPELLCRIT (6.34)** ↑
5. MANAREG (1.0) - Unchanged
6. SHADOWDMG (0.8) - Unchanged
7. FIREDMG (0.8) - Unchanged
8. **INT (0.52)** ↑ - Fel Intellect transfer
9. SPI (0.5) - Unchanged
10. **STA (0.15)** ↑ - Fel Stamina transfer

**KRITISCHE Änderung:** Spell Damage springt von Position 4 auf **Position 2** und wird **40% wertvoller**! Demonology wird **Spell Damage Spec** wegen Demon Scaling.

INT und STA werden ebenfalls **deutlich wertvoller** (Pet Scaling).

---

### Destruction

**Vanilla:**
1. **SPELLTOHIT (12.8)** - HIGHEST of all casters!
2. SPELLHASTE (9.23) - Haste King
3. SPELLCRIT (6.96) - High crit
4. DMG (1.0) - Spell damage
5. SHADOWDMG (0.95) - Shadow priority
6. MANAREG (0.65) - Mp5
7. INT (0.34)
8. SPI (0.25)
9. FIREDMG (0.23) - Fire damage (low)

**Turtle WoW:**
1. **SPELLTOHIT (14.4)** ↑ - Still highest!
2. SPELLHASTE (9.23) - Unchanged (still king)
3. **SPELLCRIT (8.35)** ↑ - Shadow Vulnerability proc!
4. **DMG (1.15)** ↑ - Soul Fire
5. **SHADOWDMG (1.14)** ↑ - Shadow Vulnerability debuff!
6. MANAREG (0.65) - Unchanged
7. INT (0.34) - Unchanged
8. SPI (0.25) - Unchanged
9. **FIREDMG (0.253)** ↑ - Improved Soul Fire

**Wichtige Änderung:** Crit wird **20% wertvoller** wegen Shadow Vulnerability on-crit proc! Shadow Damage wird **20% wertvoller** wegen permanenten +20% Debuff.

---

## Testing Procedures

### In-Game Testing

**1. StatSet Import**

```lua
/script LoadFile("Interface\\AddOns\\ItemsOfPower\\statsets\\turtlewow_warlock.lua")
```

**Erwartete Output:**
```
Turtle WoW - Warlock - Affliction:
  SPELLTOHIT: 9.60 → 10.80 (+12.5%)
  DMG: 1.00 → 1.15 (+15%)
  SPELLHASTE: 6.26 → 6.89 (+10%)

Turtle WoW - Warlock - Demonology:
  SPELLTOHIT: 9.60 → 10.80 (+12.5%)
  DMG: 1.00 → 1.40 (+40%)
  INT: 0.40 → 0.52 (+30%)
  STA: 0.10 → 0.15 (+50%)
  SPELLCRIT: 5.28 → 6.34 (+20%)

Turtle WoW - Warlock - Destruction:
  SPELLTOHIT: 12.80 → 14.40 (+12.5%)
  DMG: 1.00 → 1.15 (+15%)
  SPELLCRIT: 6.96 → 8.35 (+20%)
  SHADOWDMG: 0.95 → 1.14 (+20%)
  FIREDMG: 0.23 → 0.253 (+10%)

Created StatSet: Turtle WoW - Warlock - Affliction
Created StatSet: Turtle WoW - Warlock - Demonology
Created StatSet: Turtle WoW - Warlock - Destruction

All Turtle WoW Warlock StatSets created!
Total: 3 specs
```

**2. Tooltip Verification**

```lua
/ipw
-- Settings → Tooltip → Enable
-- Wähle gewünschten Spec
```

**Test Items:**
- **Affliction:** Deathmist Wraps (Shadow DMG, SPELLHASTE) - Haste sollte sehr wertvoll sein
- **Demonology:** Nemesis Robes (DMG, INT, STA) - Alle Stats sollten höher bewertet werden
- **Destruction:** Mantle of the Blackwing Cabal (DMG, SPELLCRIT) - Crit sollte sehr wertvoll sein

---

## Known Issues & Limitations

### 1. Demon Scaling Variability

**Issue:** Demon uptime und choice variiert stark:

**Solo Play:**
- Voidwalker: Tank (20% spell damage → AP)
- Felhunter: PvP (30% spell damage → AP)
- **Impact:** Lower spell damage value

**Raid/Group Play:**
- Felguard: DPS (60% spell damage → AP)
- Succubus: DPS (40% spell damage → AP)
- **Impact:** Higher spell damage value

**Current Approach:** Conservative +40% (assumes mixed demon usage)

**Alternative:** Create TWO Demonology specs:
- "Turtle WoW - Warlock - Demonology (Solo)" - DMG +30%
- "Turtle WoW - Warlock - Demonology (Raid)" - DMG +50%

---

### 2. Unleashed Potential Stack Uptime

**Issue:** Unleashed Potential stacks on crits, 20s duration

**Uptime depends on:**
- Crit rate (higher = more stacks)
- Fight length (short fights = lower average stacks)
- Funnel usage (refreshes duration)

**Current Approach:** Assumes 2-3 stacks average (30-45% spell damage transfer)

**Scenarios:**
- **Low Crit (15%):** ~1.5 stacks average → DMG +35% might be better
- **High Crit (30%):** ~2.5 stacks average → DMG +45% might be better

---

### 3. Affliction Haste Complexity

**Issue:** Rapid Deterioration DoT tick speed is **COMPLEX**:

**Mechanism:**
- Haste reduces tick time (and duration)
- **50% efficiency at Rank 1**, 100% at Rank 2
- Only affects DoTs, not direct damage

**Example:** 10% haste mit Rank 2
- Corruption: 18 seconds → 16.36 seconds (same total damage, faster)
- More ticks in same time = more damage per second

**Current Approach:** +10% Haste value (conservative)

**Alternative Scenarios:**
- **Pure DoT Build:** +15% Haste value (if only casting DoTs)
- **Hybrid Build:** +5% Haste value (if casting many direct damage spells)

---

### 4. Shadow Vulnerability Uptime (Destruction)

**Issue:** Shadow Vulnerability (Improved Shadow Bolt) proc chance varies:

**Rank 5:**
- On hit: 10% chance
- **On crit: 100% chance**

**Uptime depends on:**
- Crit rate (20% crit = ~20% uptime, 30% crit = ~30% uptime)
- Cast frequency (more casts = more chances)

**Current Approach:** Assumes 25-30% crit rate → near-permanent uptime

**Scenarios:**
- **Low Crit (15%):** Lower uptime → Shadow Damage +10% might be more accurate
- **High Crit (35%+):** Permanent uptime → Shadow Damage +20% correct

---

## Verification Checklist

Vor Phase 6 (Shaman) weitergehen:

- [ ] **Test Import:** Script lädt ohne Errors
- [ ] **Affliction Haste Test:** Items mit Haste werden höher bewertet
- [ ] **Demonology DMG Test:** Items mit Spell Damage werden **DEUTLICH** höher bewertet (+40%)
- [ ] **Demonology INT/STA Test:** Intellect und Stamina werden höher bewertet
- [ ] **Destruction Crit Test:** Items mit Crit werden deutlich höher bewertet
- [ ] **Destruction Shadow DMG Test:** Shadow Damage Items werden höher bewertet
- [ ] **Compare Vanilla vs Turtle:** Alle Specs zeigen höhere Scores

---

## Nächste Schritte

**Phase 6: Shaman** (nach Verification)

Shaman hat **3 Specs** mit sehr unterschiedlichen Priorities:
- **Elemental:** Caster DPS (SpellCrit, SpellHaste focus)
- **Enhancement:** Hybrid Melee/Spell (Physical + Spell scaling)
- **Restoration:** Healer (Mp5, INT, Heal focus)

**Komplexität:** Medium-High
- Elemental: Pure Caster (ähnlich wie Warlock)
- Enhancement: Hybrid (komplexester Spec, physical + spell)
- Restoration: Healer (neues Terrain, bisher nur DPS/Tank)

**Referenz:** `docs/turtle-wow-shaman-scaling-changes.md` (erstellen!)

---

## Referenzen

**Code:**
- `statsets/turtlewow_warlock.lua` - Implementation (315 lines)
- `statsets/vanilla_baseline_all.lua` - Vanilla Baselines
- `tools/turtle_wow_adjustments.lua` - Adjustment Functions

**Dokumentation:**
- `docs/turtle-wow-warlock-scaling-changes.md` - Turtle WoW Changes (602 lines!)
- `docs/vanilla-baseline-weights.md` - ClassicHawsJon Weights
- `docs/turtle-wow-adjustment-formulas.md` - Mathematical Formulas

**External:**
- [Turtle WoW Wiki - Warlock Changes](https://turtle-wow.fandom.com/wiki/Warlock)
- [Turtle WoW Changelogs](https://forum.turtle-wow.org/viewforum.php?f=19)
