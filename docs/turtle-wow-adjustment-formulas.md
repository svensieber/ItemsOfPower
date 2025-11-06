# Turtle WoW Adjustment Formulas

Dieses Dokument beschreibt die mathematischen Formeln und Begründungen für die Anpassung von Vanilla Stat Weights an Turtle WoW spezifische Balance-Änderungen.

**Ziel:** Vanilla ClassicHawsJon Weights korrekt für Turtle WoW anpassen

**Implementierung:** `tools/turtle_wow_adjustments.lua`

---

## Übersicht der Änderungen

| Änderung | Patch | Impact | Adjustment |
|----------|-------|--------|------------|
| Hit Cap 9% → 8% | 1.17.2 | Hit +12.5% wertvoller | Multiplier 1.125 |
| Armor Cap Removal | 1.18.0 | Armor +25-50% wertvoller | Multiplier 1.25-2.0 |
| Weapon Skill Linear | 1.17.2 | Konsistent wertvoll | ~5.0 per point |
| Meditation (Casting Regen) | 1.16.0 | Neu, sehr wertvoll | 1.5-2.5x Mp5 |
| Vampirism | Custom | Neu, niche | 0.1-0.2 (Warlock) |

---

## 1. Hit Cap Reduction (9% → 8%)

### Begründung

**Vanilla WoW:**
- Hit Cap vs +3 Level Boss: **9%**
- ~84.4 Hit Rating benötigt (9.37931 per %)

**Turtle WoW (Patch 1.17.2):**
- Hit Cap vs +3 Level Boss: **8%**
- ~75.0 Hit Rating benötigt (9.37931 per %)

**Impact:** Du brauchst **weniger** Hit Rating um zu cappen, also ist **jeder Punkt Hit wertvoller**.

### Formel

```
Turtle Hit Weight = Vanilla Hit Weight × (9/8)
Turtle Hit Weight = Vanilla Hit Weight × 1.125
```

**Erklärung:**
- Du brauchst 1/9 weniger Hit Rating für Cap
- Aber dein "Budget" für Stats bleibt gleich
- Daher: Jeder Hit Punkt ist ~12.5% wertvoller

### Beispiele

#### Hunter Marksmanship
```
Vanilla: TOHIT = 9.38
Turtle:  TOHIT = 9.38 × 1.125 = 10.55 (+12.5%)
```

#### Warrior Arms
```
Vanilla: TOHIT = 9.38
Turtle:  TOHIT = 9.38 × 1.125 = 10.55 (+12.5%)
```

#### Shadow Priest
```
Vanilla: SPELLTOHIT = 8.96
Turtle:  SPELLTOHIT = 8.96 × 1.125 = 10.08 (+12.5%)
```

### Lua Implementation

```lua
function AdjustHitCap(vanillaHitWeight)
  local HIT_CAP_MULTIPLIER = 9 / 8  -- 1.125
  return vanillaHitWeight * HIT_CAP_MULTIPLIER
end

function AdjustSpellHitCap(vanillaSpellHitWeight)
  local SPELL_HIT_CAP_MULTIPLIER = 9 / 8  -- 1.125
  return vanillaSpellHitWeight * SPELL_HIT_CAP_MULTIPLIER
end
```

### Verification

**Test in-game:**
1. Create StatSet with Vanilla Hit weight
2. Compare item values vs Turtle WoW BiS lists
3. Adjust if Hit is under/over-valued

**Expected:** Hit should be top 1-3 stat for most DPS specs (before cap)

---

## 2. Armor Cap Removal (75% → Diminishing Returns)

### Begründung

**Vanilla WoW:**
- **Hard Cap:** 75% physical damage reduction
- Armor beyond cap = **worthless**
- Tanks hit cap easily → Armor stacking stops

**Turtle WoW (Patch 1.18.0):**
- **Soft Cap:** 75% mit diminishing returns
- Armor beyond 75% = **still valuable** (aber weniger)
- Tanks können immer noch Armor stacken

**Impact:** Armor ist **viel wertvoller** für Tanks, da es nie nutzlos wird.

### Formel

#### Conservative Approach (Default)

```
Warrior/Paladin Tank: Armor × 1.5  (+50%)
Druid Feral Tank:     Armor × 1.4  (+40%)
```

**Begründung:** Vorsichtiger Schätzwert, geht davon aus dass Tanks schon hohe Armor haben.

#### Aggressive Approach (Pre-Raid / Low Armor)

```
Warrior/Paladin Tank: Armor × 2.0  (+100%)
Druid Feral Tank:     Armor × 1.75 (+75%)
```

**Begründung:** Für Tanks mit niedriger Armor (Pre-Raid Gear) ist Armor EXTREM wertvoll.

### Warum unterschiedliche Multipliers?

**Druid vs Warrior/Paladin:**
- Druids haben **von Natur aus** mehr Armor (Dire Bear Form)
- Druids waren schon in Vanilla **näher am Cap**
- Daher: Druid Armor profit weniger von Cap Removal

**Warrior/Paladin:**
- Mussten jeden Armor-Punkt farmen
- Harten Cap früher erreicht
- Viele Armor-Items waren "wasted stats"
- Jetzt: Alles ist wertvoll!

### Beispiele

#### Warrior Protection (Conservative)
```
Vanilla: ARMOR = 0.02
Turtle:  ARMOR = 0.02 × 1.5 = 0.03 (+50%)
```

#### Warrior Protection (Aggressive, Pre-Raid)
```
Vanilla: ARMOR = 0.02
Turtle:  ARMOR = 0.02 × 2.0 = 0.04 (+100%)
```

#### Druid Feral Tank (Conservative)
```
Vanilla: ARMOR = 0.1
Turtle:  ARMOR = 0.1 × 1.4 = 0.14 (+40%)
```

### Lua Implementation

```lua
local TANK_ROLE_MULTIPLIERS = {
  ["warrior_prot_conservative"] = 1.5,
  ["paladin_prot_conservative"] = 1.5,
  ["druid_feral_tank_conservative"] = 1.4,
  ["warrior_prot_aggressive"] = 2.0,
  ["paladin_prot_aggressive"] = 2.0,
  ["druid_feral_tank_aggressive"] = 1.75,
}

function AdjustArmorForTanks(vanillaArmorWeight, tankRole, aggressive)
  local suffix = aggressive and "_aggressive" or "_conservative"
  local roleKey = tankRole .. suffix
  local multiplier = TANK_ROLE_MULTIPLIERS[roleKey]
  return vanillaArmorWeight * multiplier
end
```

### Verification

**Test in-game:**
1. Equip high-armor items on tank
2. Compare tooltip values
3. Verify Armor is **competitive** with Stamina/Defense

**Expected:** Armor should be top 3-5 stat for tanks (after Stamina)

---

## 3. Haste Baseline Adjustments

### Begründung

**Vanilla WoW:**
- Haste Rating existiert, aber **sehr rare**
- ClassicHawsJon hat konservative Haste Weights

**Turtle WoW:**
- Haste Rating **häufiger** auf Items
- Haste ist **wettbewerbsfähig** mit Crit

**Impact:** Haste sollte **mindestens** 40-80% des Crit-Werts haben.

### Formel

```
Minimum Haste = Crit Weight × Role Multiplier

Role Multipliers:
- Melee DPS:   0.7  (70% of Crit)
- Ranged DPS:  0.65 (65% of Crit)
- Spell DPS:   0.8  (80% of Spell Crit)
- Healer:      0.6  (60% of Spell Crit)
- Tank:        0.5  (50% of Crit)
```

**Anwendung:** Wenn Vanilla Haste < Minimum → Auf Minimum erhöhen

### Beispiele

#### Hunter Marksmanship
```
Vanilla: CRIT = 5.1, HASTE = 3.21
Minimum Haste = 5.1 × 0.65 = 3.32
Adjustment: 3.21 → 3.32 (leicht erhöht)
```

#### Shadow Priest
```
Vanilla: SPELLCRIT = 6.08, SPELLHASTE = 5.22
Minimum Haste = 6.08 × 0.8 = 4.86
No adjustment needed (5.22 > 4.86)
```

#### Resto Druid
```
Vanilla: SPELLCRIT = 2.8, SPELLHASTE = 3.93
Minimum Haste = 2.8 × 0.6 = 1.68
No adjustment needed (3.93 > 1.68)
```

### Lua Implementation

```lua
function GetHasteBaselineMultiplier(role)
  local HASTE_MULTIPLIERS = {
    ["melee_dps"] = 0.7,
    ["ranged_dps"] = 0.65,
    ["spell_dps"] = 0.8,
    ["healer"] = 0.6,
    ["tank"] = 0.5,
  }
  return HASTE_MULTIPLIERS[role] or 0.7
end

function EnsureMinimumHaste(currentHasteWeight, critWeight, role)
  local minimumMultiplier = GetHasteBaselineMultiplier(role)
  local minimumHaste = critWeight * minimumMultiplier

  if currentHasteWeight < minimumHaste then
    return minimumHaste
  else
    return currentHasteWeight
  end
end
```

---

## 4. Weapon Skill Rework

### Begründung

**Vanilla WoW:**
- **Breakpoint System:** 305 Weapon Skill = magic number
- Awkward scaling
- Racial bonuses: +5

**Turtle WoW (Patch 1.17.2):**
- **Linear Scaling:** Each point = +0.2% hit + glancing reduction
- No breakpoints
- Racial bonuses: +3 (reduced)

**Impact:** Weapon Skill konsistent wertvoll, kein "magic 305".

### Formel

```
Weapon Skill Value ≈ 5.0 per point

Breakdown:
- +0.2% hit = ~1.88 Hit Rating value
- Glancing reduction = ~3.0 DPS increase
- Total ≈ 5.0 per point
```

**Hinweis:** Weapon Skill ist **NICHT** in ItemBonusLib verfügbar. Diese Formel ist informational für manuelle Adjustments.

### Beispiel

```
Edgemaster's Handguards: +7 Sword Skill
Value ≈ 7 × 5.0 = 35 points
```

Vergleich: ~3.5 Crit Rating wert (für Warrior mit Crit=10)

---

## 5. Neue Stats: Meditation (CASTINGREG)

### Begründung

**Patch 1.16.0:** Meditation hinzugefügt

**Effect:** 5% von Mana Regen funktioniert **während Casting**

**Impact:**
- **EXTREM wertvoll** für Healer (ständig am casten)
- Moderate Wert für Caster DPS (nur wenn OOM issues)

### Formel

```
CASTINGREG = Mp5 Weight × Role Multiplier

Role Multipliers:
- Discipline Priest:  2.5x Mp5  (most valuable)
- Holy Healer:        2.0x Mp5
- Resto Healer:       2.0x Mp5
- Caster DPS:         0.4x Mp5  (low priority)
- Caster w/ OOM:      0.8x Mp5  (Arcane Mage)
```

### Beispiele

#### Resto Druid
```
Mp5 Weight = 1.7
CASTINGREG = 1.7 × 2.0 = 3.4

Priority: CASTINGREG > Mp5 > Healing
```

#### Shadow Priest
```
Mp5 Weight = 1.0
CASTINGREG = 1.0 × 0.4 = 0.4

Priority: Spell Damage > Spell Hit > CASTINGREG
```

#### Arcane Mage (OOM build)
```
Mp5 Weight = 1.13
CASTINGREG = 1.13 × 0.8 = 0.9

Priority: Spell Damage > Spell Crit > CASTINGREG
```

### Lua Implementation

```lua
function GetCastingRegenWeight(role, mp5Weight)
  local CASTING_REGEN_MULTIPLIERS = {
    ["healer_disc"] = 2.5,
    ["healer_holy"] = 2.0,
    ["healer_resto"] = 2.0,
    ["caster_dps"] = 0.4,
    ["caster_oom"] = 0.8,
  }

  local multiplier = CASTING_REGEN_MULTIPLIERS[role]
  if not multiplier then return 0 end

  return mp5Weight * multiplier
end
```

---

## 6. Neue Stats: Vampirism (VAMPIR)

### Begründung

**Turtle WoW Custom Stat**

**Effect:** Vampirism Rating - boosts life drain effects

**Impact:**
- **Useful** für Warlock (Drain Life builds)
- **Nutzlos** für alle anderen Klassen

### Formel

```
Warlock Affliction: VAMPIR = 0.15
Warlock Other:      VAMPIR = 0.05
Other Classes:      VAMPIR = 0
```

### Beispiel

#### Warlock Affliction
```
VAMPIR = 0.15

Priority: Spell Damage > Spell Hit > VAMPIR > Spirit
```

### Lua Implementation

```lua
function GetVampirismWeight(className, specName)
  if className == "Warlock" then
    if specName == "Affliction" then
      return 0.15
    else
      return 0.05
    end
  end
  return 0
end
```

---

## Comprehensive Adjustment Function

### Usage

```lua
local vanillaStats = {
  AGI = 1.0,
  TOHIT = 9.38,
  CRIT = 5.1,
  HASTE = 3.21,
  ATTACKPOWER = 0.55,
  RANGEDATTACKPOWER = 0.55,
}

local turtleStats = ApplyTurtleWoWAdjustments(
  vanillaStats,
  "Hunter",          -- className
  "Marksmanship",    -- specName
  "ranged_dps",      -- role
  false              -- aggressive (armor multiplier)
)

-- Result:
-- {
--   AGI = 1.0,
--   TOHIT = 10.55,           -- Adjusted: +12.5%
--   CRIT = 5.1,
--   HASTE = 3.32,            -- Adjusted: Minimum baseline
--   ATTACKPOWER = 0.55,
--   RANGEDATTACKPOWER = 0.55,
-- }
```

### Adjustment Pipeline

1. **Hit Cap:** TOHIT × 1.125
2. **Spell Hit Cap:** SPELLTOHIT × 1.125
3. **Armor (if tank):** ARMOR × 1.25-2.0
4. **Haste Baseline:** Ensure HASTE ≥ CRIT × 0.6-0.8
5. **Add CASTINGREG:** If healer/caster
6. **Add VAMPIR:** If Warlock

---

## Testing & Verification

### In-Game Testing

**Step 1: Create Test StatSet**
```lua
-- Load adjustment utilities
/script LoadFile("tools/turtle_wow_adjustments.lua")

-- Test with known spec
TestAdjustments()
```

**Step 2: Compare with BiS Lists**
- Turtle WoW Class Discord BiS lists
- Compare top items with adjusted weights
- Verify stat priorities match community consensus

**Step 3: Iterate**
- If Hit is over/under-valued → Adjust multiplier
- If Armor seems wrong → Switch conservative/aggressive
- If Haste too low/high → Adjust role multiplier

### Expected Stat Priorities

**Physical DPS (Melee/Ranged):**
1. Hit (until cap)
2. Crit / Haste
3. Attack Power
4. Agility / Strength

**Spell DPS:**
1. Spell Hit (until cap)
2. Spell Damage
3. Spell Crit / Spell Haste
4. Intellect

**Healer:**
1. Healing Power
2. Mp5 / CASTINGREG
3. Intellect
4. Spirit
5. Spell Crit / Spell Haste

**Tank:**
1. Stamina
2. Defense / Dodge
3. Armor (NOW COMPETITIVE!)
4. Block Value (Prot Pally/Warrior)

---

## Summary Table

| Adjustment | Vanilla → Turtle | Function |
|------------|------------------|----------|
| Hit Cap | ×1.125 | `AdjustHitCap()` |
| Spell Hit Cap | ×1.125 | `AdjustSpellHitCap()` |
| Armor (Tank Conservative) | ×1.4-1.5 | `AdjustArmorForTanks(false)` |
| Armor (Tank Aggressive) | ×1.75-2.0 | `AdjustArmorForTanks(true)` |
| Haste Minimum | ≥ Crit × 0.6-0.8 | `EnsureMinimumHaste()` |
| CASTINGREG | Mp5 × 1.5-2.5 | `GetCastingRegenWeight()` |
| VAMPIR | 0.05-0.15 | `GetVampirismWeight()` |

---

## Next Steps

**Phase 2:** Alle Vanilla Baselines konvertieren
**Phasen 3-11:** Klassenspezifische Turtle WoW Anpassungen anwenden
