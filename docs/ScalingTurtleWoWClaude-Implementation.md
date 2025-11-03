# Turtle WoW Scaling Implementation Guide

This document provides a comprehensive guide for implementing Pawn stat weights for Turtle WoW based on the changes documented in `turtle-wow-general-scaling-changes.md`.

## File Overview

**File:** `ScalingTurtleWoWClaude.lua`
**Based On:** `ClassicHawsJon_small.lua`
**Target API:** Vanilla WoW 1.12.1 (Lua 5.0)
**Status:** Phase 1 - General Framework Complete

---

## Key Differences from Vanilla/ClassicHawsJon

### 1. Hit Cap Reduction (Patch 1.17.2)

**Change:** Hit cap vs +3 level bosses reduced from 9% to 8%

**Implementation:**
```lua
-- OLD (Vanilla/Classic):
HitRatingPer = 9.37931

-- NEW (Turtle WoW):
HitRatingPer = 10.42  -- Adjusted multiplier for 8% cap
```

**Impact:**
- Hit rating more valuable per point (need 8% instead of 9%)
- All melee DPS scales should reflect this increased value
- Spell hit also affected (8% cap)

**Class Implications:**
- Warriors, Rogues, Hunters: Hit weights increase ~12%
- Casters: Spell hit weights increase similarly
- Consider Emerald Blessing (+1% raid spell hit) for casters

---

### 2. Weapon Skill Rework (Patch 1.17.2)

**Change:** Linear scaling replaces breakpoint system

**Old System:**
- Awkward breakpoints at 305, 308
- Soft cap at 305 weapon skill
- Racial bonuses: +5

**New System:**
- Linear scaling: Each point = +0.2% hit chance
- Each point reduces glancing damage by 2%
- No soft cap
- Racial bonuses reduced to +3

**Implementation:**
```lua
WeaponSkillPer = 5  -- New variable for weapon skill value
```

**Impact:**
- Weapon skill items more consistently valuable
- No "magic number" at 305 anymore
- Racial weapon skill bonuses still useful but less powerful

---

### 3. Armor Cap Removal (Patch 1.18.0)

**Change:** 75% hard cap removed, replaced with diminishing returns

**Old System:**
- Hard cap at 75% damage reduction
- Armor stacking worthless beyond cap

**New System:**
- Soft cap at 75% with diminishing returns
- Extra armor still provides some benefit

**Implementation:**
```lua
-- Tank armor multiplier increased
local ArmorMultiplier = 1.2  -- Was effectively 1.0 at cap

-- Example tank scale:
Armor=0.02 * ArmorMultiplier  -- = 0.024 (was 0.02)
```

**Impact:**
- **CRITICAL for tank scaling**
- Armor significantly more valuable for warriors/paladins/druids
- All tank specs should increase armor weight by ~20-50%

---

### 4. New Stat: Meditation (Patch 1.16.0)

**Effect:** 5% of mana regeneration continues during combat per item with Meditation

**Implementation:**
```lua
MeditationPer = 10  -- Value per Meditation item
Meditation=MeditationPer*X  -- Where X is importance for spec
```

**Stacking:**
- Each item with Meditation adds another 5%
- 2 items = 10% mana regen during combat
- 3 items = 15% mana regen during combat
- Etc.

**Class Implications:**
- **Very High Value:** Holy Priests, Resto Druids, Resto Shamans
- **High Value:** Balance Druids, Shadow Priests, Elemental Shamans
- **Medium Value:** Paladins (all specs), Mages, Warlocks
- **Low/Zero Value:** Pure physical classes (Warriors, Rogues, Hunters)

**Synergy with Spirit:**
- Meditation makes Spirit more valuable
- Spirit provides the base regen that Meditation allows during combat
- Specs with high Meditation should also value Spirit more

---

### 5. New Stat: Haste (Patch 1.16.0)

**Effect:** Increases attack/cast speed by 1-5% with diminishing returns

**Implementation:**
```lua
HasteRatingPer = 8.03
SpellHasteRatingPer = 8.03

-- Example usage:
HasteRating=HasteRatingPer*X  -- Where X is importance for spec
```

**Characteristics:**
- First Haste stat in Classic WoW
- Found on raid items and set bonuses
- Diminishing returns (exact formula TBD)
- Benefits both physical and casters

**Class Implications:**
- **Physical DPS:** Scales with attack power and crit
- **Casters:** Reduces cast times, increases DPS
- **Healers:** Faster heals, more important for spike healing

**Relative Value:**
- Generally less valuable than hit (until hit capped)
- Often comparable to or slightly better than crit
- More valuable in longer fights

---

### 6. Racial Stat Bonuses (Patch 1.17.2)

These are **passive bonuses** that affect effective stat weights for different races.

**Note:** `ClassicHawsJon_small.lua` and this implementation do NOT create race-specific scales. However, these bonuses mean certain stats are effectively more valuable for certain races.

#### Human
- **Perception:** +2% physical & spell crit
- **The Human Spirit:** +5% mana regen while casting

**Stat Weight Effects:**
- Crit rating: Effectively 2% more efficient
- Spirit: 5% more valuable for casters (similar to Meditation)

#### High Elf
- **Swiftness of the Rangers:** +2% Agility

**Stat Weight Effects:**
- Agility: 2% more valuable
- Scales with crit, dodge, and physical DPS

#### Night Elf
- **Quickness:** +1% attack/cast/movement speed

**Stat Weight Effects:**
- Effectively +1% haste
- Small but consistent DPS increase

#### Orc
- **Blood Fury:** +2x level AP/spell damage (15 sec, off-GCD)

**Stat Weight Effects:**
- Strong burst cooldown
- Slightly increases value of AP/spell damage scaling

#### Troll
- **Berserking:** 10-15% attack/cast speed (reduced from 10-30%)
- **Regeneration:** 20% health regen, 25% continues in combat

**Stat Weight Effects:**
- Strong but nerfed from Vanilla
- Haste slightly less valuable (already have burst haste)

#### Goblin
- **Aggressive Negotiations:** +3 Dagger & Mace skill
- **Prospecting:** +10 Mining & Jewelcrafting skill

**Stat Weight Effects:**
- Weapon skill: +3 = +0.6% hit, +6% glancing reduction
- Valuable for dagger/mace users (Rogues, Shamans)

---

### 7. Debuff Limit Increase (Patch 1.16.1)

**Change:** 16 debuffs → 24 debuffs on targets

**Impact:**
- DoT-based builds more viable
- Shadow Priests, Warlocks benefit
- More raid debuff slots = more flexibility

**Implementation:**
- No direct stat weight changes
- Indirectly buffs DoT damage scaling
- Consider increasing spell damage value slightly for DoT specs

---

### 8. Additional Changes

#### Emerald Blessing (Patch 1.17.0)
- Druid raid buff: +1% spell hit, +5% in-combat mana regen
- Reduces spell hit cap requirement by 1%
- Increases value of Spirit (more regen)

#### Anti-Crit Gear (Patch 1.17.0)
- New +1% anti-crit sources available
- Easier to reach 5.6% crit immunity cap for tanks
- Slightly reduces Defense value (more options to cap)

---

## Rating Conversion Table

Stat values for Turtle WoW (Vanilla 1.12.1 API with modifications):

| Stat | Multiplier | Notes |
|------|------------|-------|
| Hit Rating | 10.42 | Increased for 8% cap |
| Spell Hit Rating | 8.89 | Increased for 8% cap |
| Crit Rating | 8.5 | Unchanged |
| Spell Crit Rating | 8.0 | Unchanged |
| Haste Rating | 8.03 | **NEW** in 1.16.0 |
| Spell Haste Rating | 8.03 | **NEW** in 1.16.0 |
| Expertise Rating | 2.34483 | Unchanged |
| Armor Penetration | 3.75 | Unchanged |
| Spell Penetration | 1.0 | Unchanged |
| Defense Rating | 1.5 | Unchanged |
| Dodge Rating | 9.44 | Unchanged |
| Parry Rating | 9.44 | Unchanged |
| Block Rating | 6.9 | Unchanged |
| **Meditation** | 10.0 | **NEW** in 1.16.0 |
| **Weapon Skill** | 5.0 | **CHANGED** in 1.17.2 |

---

## Implementation Checklist

### Phase 1: General Framework ✅
- [x] Create base file structure
- [x] Adjust rating conversions for 8% hit cap
- [x] Add Meditation stat support
- [x] Add Haste stat support
- [x] Document armor cap changes
- [x] Document racial bonuses
- [x] Set up auto-enable logic

### Phase 2: Class/Spec Scales ✅
- [x] Druid (Balance, Feral DPS, Feral Tank, Restoration)
- [x] Hunter (Beast Mastery, Marksmanship, Survival)
- [x] Mage (Arcane, Fire, Frost)
- [x] Paladin (Holy, Protection, Retribution)
- [x] Priest (Discipline, Holy, Shadow)
- [x] Rogue (Assassination, Combat, Subtlety)
- [x] Shaman (Elemental, Enhancement, Restoration)
- [x] Warlock (Affliction, Demonology, Destruction)
- [x] Warrior (Arms, Fury, Protection)

### Phase 3: Testing & Refinement (TODO)
- [ ] In-game validation
- [ ] Community feedback
- [ ] Sim/theorycrafting validation
- [ ] Adjust weights based on actual performance

---

## Implementation Guidelines

### For Melee DPS Specs:
1. Increase Hit rating weight by ~12% (8% cap vs 9%)
2. Add Haste support (typically 0.4-0.9x modifier)
3. Increase Weapon Skill value (linear scaling)
4. Keep other physical stats similar to ClassicHawsJon

### For Caster DPS Specs:
1. Increase Spell Hit weight by ~11% (8% cap vs 9%)
2. Add Meditation support (typically 0.5-1.5x modifier)
3. Add Spell Haste support (typically 0.6-1.0x modifier)
4. Increase Spirit value for Human race consideration
5. Consider Emerald Blessing (-1% hit needed)

### For Tank Specs:
1. **CRITICAL:** Increase Armor weight by 20-50%
2. Keep defensive stats similar
3. Consider new anti-crit sources
4. Add Meditation for Druid/Paladin (moderate value)

### For Healer Specs:
1. Add Meditation support (**HIGH VALUE**, 1.5-2.5x modifier)
2. Increase Spirit value (synergy with Meditation)
3. Add Spell Haste support (moderate value, 0.4-0.7x)
4. Keep other healing stats similar

---

## Testing Recommendations

### In-Game Testing:
1. Test with actual Turtle WoW items
2. Validate hit cap at 8% (not 9%)
3. Confirm Meditation stacking (multiple items)
4. Verify Haste diminishing returns
5. Test armor beyond old 75% cap

### Validation Sources:
- Turtle WoW Discord theorycrafting channels
- Combat log analysis
- Raid testing with actual gear
- Community feedback from experienced players

---

## Lua 5.0 Compatibility Notes

Turtle WoW uses Lua 5.0 (Vanilla 1.12.1 API). Ensure compatibility:

### Safe to Use:
- Basic table operations
- String manipulation (string.*)
- Math functions (math.*)
- Basic control flow (if, for, while)

### Avoid:
- Lua 5.1+ features (goto, # operator on tables, etc.)
- Modern API functions added in TBC+
- Table functions added after 5.0

### Best Practices:
- Use `table.getn()` instead of `#table`
- Use `string.len()` instead of `#string`
- Test all code on actual Turtle WoW client
- Reference original Vanilla addon code for patterns

---

## Next Steps

1. **Review class-specific docs:**
   - `turtle-wow-druid-scaling-changes.md`
   - `turtle-wow-hunter-scaling-changes.md`
   - `turtle-wow-mage-scaling-changes.md`
   - `turtle-wow-paladin-scaling-changes.md`
   - `turtle-wow-priest-scaling-changes.md`
   - `turtle-wow-rogue-scaling-changes.md`
   - `turtle-wow-shaman-scaling-changes.md`
   - `turtle-wow-warlock-scaling-changes.md`
   - `turtle-wow-warrior-scaling-changes.md`

2. **Implement class scales one at a time**

3. **Test each scale in-game before moving to next**

4. **Iterate based on feedback**

---

## References

- Base implementation: `ClassicHawsJon_small.lua`
- Turtle WoW changes: `docs/turtle-wow-general-scaling-changes.md`
- Official changelogs: `/turtle-wow-changelogs/*.html`
- Pawn documentation: `Readme.htm`, `CLAUDE.md`
