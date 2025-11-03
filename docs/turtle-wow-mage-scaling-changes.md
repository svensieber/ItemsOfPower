# Turtle WoW Mage Scaling Changes

This document tracks all Mage-specific changes from Turtle WoW that affect stat scaling and item valuation for the Pawn addon.

**Base Reference:** Vanilla 1.12.1 Mage stat scaling is implemented in `ClassicHawsJon_small.lua`.

---

## Version 1.16.1 - First Class Changes

**Developer Context:** Fire and Frost are well-designed in vanilla, but Arcane falls far behind and lacks a clear niche.

### Baseline Changes

#### Arcane Missiles Scaling Buff
- **Spell Power Coefficient:** 0.24 → 0.286 per missile
- **Impact:** +19% spell damage scaling for Arcane Missiles

### Arcane Changes

#### Arcane Impact (formerly Improved Arcane Explosion)
- **Effect:** +2/4/6% crit chance for Arcane Explosion and Arcane Missiles
- **Impact:** Critical strike more valuable for Arcane

#### New Talent: Arcane Potency (Row 4)
- **Effect:** +18/36/50% critical strike damage bonus for Arcane spells
- **Prerequisite:** Arcane Mind
- **Impact:** CRITICAL - Crit damage much more valuable for Arcane

#### New Talent: Brilliance Aura (Row 5)
- **Effect:** Party members gain mana regen equal to 15% of Mage's mana regen within 30y
- **Duration:** 30 minutes
- **Prerequisite:** Arcane Potency
- **Note:** Can be cast while mounted
- **Impact:** Spirit and Mp5 provide raid-wide benefit

---

## Version 1.17.0 - Hyjal

### Quality of Life Changes

#### Brilliance Aura Toggle
- **Previous:** Had mana cost and 30min duration
- **New:** Aura/state spell (toggle on/off)
- **Cost:** None
- **Duration:** Permanent until toggled off
- **Impact:** Can be active alongside other effects

#### New Teleports/Portals
- **Theramore (Alliance):** Teleport quest at level 45, portal from Lower Karazhan Halls tome drops
- **Stonard (Horde):** Teleport quest at level 45, portal from Lower Karazhan Halls tome drops

#### Cone of Cold
- **Change:** Now lists area of effect in spell description (QoL)

---

## Version 1.17.2 - Tower of Karazhan

**Developer Context:** Fire and Frost have bland rotations. Arcane lacks viability and identity, being locked to single-target and one AoE ability. Goal: Add rotation depth for Fire/Frost, complete Arcane rework as wild/uncontrollable spec.

### Baseline Changes

#### New Spell: Arcane Surge
- **Trigger:** Usable after spell is fully/partially resisted
- **Effect:** Cannot be resisted
- **Spell Power:** 65% coefficient
- **Cooldown:** 8 seconds
- **Instant cast**
- **Ranks:**
  - Rank 1 (32): 85 mana, 202-244 Arcane damage
  - Rank 2 (40): 110 mana, 290-349 Arcane damage
  - Rank 3 (48): 140 mana, 398-474 Arcane damage
  - Rank 4 (56): 170 mana, 517-612 Arcane damage
- **Impact:** Adds damage when fighting resistant mobs

#### Arcane Missiles Scaling Buff
- **Coefficient:** 28.6% → 32.8% per missile (for ranks above level 20)
- **Impact:** +21% total spell power scaling for full channel
- **Note:** Scales multiplicatively with Arcane Rupture's damage increase

#### Dampen/Amplify Magic Simplification
- **Ranks:** Reduced to 1 rank
- **Cost:** 6% base mana
- **Dampen Magic:** 2% reduced magic damage, 1% reduced healing
- **Amplify Magic:** 2% increased healing, 1% increased magic damage

#### Arcane Intellect Mana Cost Reduction
- **Ranks:** 60/185/520/945/1510 → 50/100/240/340/445

#### Arcane Brilliance Mana Cost Reduction
- **Rank 1 (56):** 3400 → 1200

---

### Arcane Changes (1.17.2) - Complete Rework

**Theme:** Wild, uncontrollable Arcane magic

#### Wand Specialization
- **New:** +5/10% wand hit chance
- **New:** Wand hits grant mana = 150% of level (chance increases per point)

#### Magic Absorption
- **Points:** 5 → 3
- **Mana Return:** 1/2/3/4/5% → 1/2/3% of total mana
- **Cooldown:** 1s → 2s
- **Trigger:** Changed from "spell fully resisted on you" to "your spell partially/fully resisted"
- **Impact:** More consistent mana return, works with Arcane Surge

#### Arcane Concentration
- **Cooldown:** Added 8 second cooldown
- **Impact:** Clearcasting less frequent but still valuable

#### Arcane Impact
- **Change:** Now affects ALL Arcane spells (was only Arcane Explosion/Missiles)
- **Impact:** Crit valuable for entire Arcane rotation

#### Magic Attunement
- **Points:** 2 → 1
- **Effect:** 25/50% → 100%
- **New:** Can cast Amplify/Dampen Magic on targets below level 63

#### New Keystone: Arcane Rupture (Row 3)
- **Effect:** Deals damage + increases Arcane Missiles damage and mana cost by 25% for 8s
- **Cast Time:** 2.5 seconds
- **Cooldown:** 15 seconds
- **Spell Power:** 100% coefficient
- **Ranks:**
  - Rank 1 (20/Talent): 80 mana, 111-125 damage
  - Rank 2 (28): 145 mana, 189-209 damage
  - Rank 3 (36): 210 mana, 334-366 damage
  - Rank 4 (44): 270 mana, 416-475 damage
  - Rank 5 (52): 320 mana, 556-605 damage
  - Rank 6 (60): 390 mana, 703-766 damage
- **Impact:** CRITICAL - Main rotation ability, makes Arcane Missiles 25% stronger

#### Improved Mana Shield
- **Change:** 10/20% → 13/25% mana reduction per damage point

#### New Talent: Temporal Convergence (Row 4, 3 Points)
- **Effect:** Arcane Missiles 5/10/15% chance to reset Arcane Rupture cooldown + refund its mana
- **Cooldown:** Once every 15 seconds
- **Buff Duration:** 12 seconds
- **Impact:** Adds proc-based gameplay, reduces mana cost

#### Arcane Meditation
- **Mana Regen:** 5/10/15% → 7/14/20% while casting
- **New:** Tripled below 35% mana
- **Impact:** MAJOR - Spirit very valuable when low on mana

#### Arcane Instability (Moved Row 6 → Row 5)
- **Previous:** Generic crit/damage increase
- **New:** Damaging Arcane spells 8/16/25% chance to erupt for +25% damage (costs 2% base mana)
- **Impact:** Proc-based damage increase

#### New Keystone: Accelerated Arcana (Row 5)
- **Effect:** +6% Arcane spell casting speed
- **Effect:** Casting speed increases cooldown recovery of Arcane spells and Arcane Missiles tick speed
- **Affected Spells:** Presence of Mind, Evocation, Arcane Power, Arcane Surge, Arcane Rupture
- **Impact:** Haste scales cooldowns, unique mechanic

#### Arcane Potency (Moved Row 6 → Row 5)
- **Points:** 3 → 2
- **Crit Damage:** 17/33/50% → 50/100%
- **Impact:** MASSIVE crit damage scaling

#### New Talent: Resonance Cascade (Row 6, 5 Points)
- **Effect:** Damaging Arcane spells 4/8/12/16/20% chance to duplicate for 50% damage
- **Self-Trigger:** Can chain up to 4 times
- **Arcane Missiles:** Duplicates channel in tandem
- **Note:** Doesn't trigger on-hit spell effects
- **Impact:** MAJOR - Adds multiplicative damage scaling

#### Arcane Power (Complete Rework)
- **Previous:** +30% damage, +30% mana cost
- **New:** +35% casting speed, drains 2% max mana/sec, -75% mana gain
- **Death Mechanic:** Falling below 10% mana = instant death
- **Duration:** 20 seconds, cannot be cancelled
- **Impact:** CRITICAL - High-risk/high-reward cooldown, requires mana management

#### Brilliance Aura
- **Status:** Removed from talent tree (baseline in 1.17.0)

---

### Fire Changes (1.17.2)

**Developer Context:** Fire performs well but rotation is dull outside Scorch upkeep. Ignite has threat issues.

#### Ignite
- **Duration:** 4s → 6s
- **Threat:** Now split among all Mages contributing to Ignite
- **Impact:** CRITICAL - Reduces threat issues, increases uptime window, reduces overall DPS but allows continuous casting

#### Improved Fire Blast
- **New:** Also reduces Fire Blast GCD by 0.17/0.34/0.5 seconds
- **Impact:** Fire Blast more responsive

#### New Talent: Hot Streak (Row 5, 3 Points)
- **Effect:** Fireball/Fire Blast crits 33/66/100% chance to grant Hot Streak
- **Hot Streak:** Reduces next Pyroblast cast time by 0.5s per stack
- **Duration:** 30 seconds
- **Max Stacks:** 3/6/9
- **Impact:** MAJOR - Adds proc-based rotation, crit very valuable

---

### Frost Changes (1.17.2)

**Developer Context:** Frost performs well but rotation is entirely Frostbolt spam, too simple even for Vanilla.

#### Piercing Ice
- **Position:** Moved to Row 2 (smoother talent progression)

#### Improved Blizzard
- **Slow:** 30/50/65% → 20/30/40%
- **Impact:** Nerf to AoE slow

#### Shatter
- **Crit Chance:** 10/20/30/40/50% → 7/14/21/28/35% vs frozen targets
- **Impact:** Crit less valuable vs frozen, still strong

#### New Keystone: Icicles (Row 5)
- **Effect:** Root self, launch icicles for 5 seconds
- **Damage:** Per second
- **Spell Power:** 40% per icicle
- **Cooldown:** 30 seconds
- **Downside:** Taking damage has high chance to shatter (30% base HP as Frost damage)
- **Note:** Root can be broken with Blink
- **Ranks:**
  - Rank 1 (30): 200 mana, 101 damage/icicle
  - Rank 2 (40): 265 mana, 147 damage/icicle
  - Rank 3 (50): 330 mana, 213 damage/icicle
  - Rank 4 (60): 400 mana, 272 damage/icicle
- **Impact:** New rotational ability, high risk in PvP

#### New Talent: Flash Freeze (Row 6, 2 Points)
- **Trigger:** When target immune to freeze effects
- **Effect:** 50/100% chance to reset Icicles cooldown + next Icicles 400% faster channel
- **Duration:** 10 seconds
- **Synergy:** Frostbite talent, Frost Nova
- **Impact:** Makes Icicles much better vs raid bosses

#### Ice Barrier
- **New:** +15% Frost damage while active
- **Impact:** Barrier now DPS increase if maintained, rewards timing

---

## Version 1.17.2 - Hotfixes

### November 20, 2024

#### Hot Streak
- **Duration:** 30 seconds → 3 minutes
- **Impact:** Much longer buff window, easier to use for Fire Mages

---

### December 20, 2024

#### Arcane Rupture
- **Spell Power:** 100% → 90% coefficient
- **Impact:** Minor nerf to Arcane damage

#### Hot Streak
- **Cast Time Reduction:** 0.5s → 1s per stack
- **Max Stacks:** 9 → 5
- **Impact:** Easier to stack, more impactful per stack

#### Icicles
- **GCD:** 1.5s → 1s
- **Impact:** Smoother to use in rotation

---

### April 1, 2025

#### Arcane Rupture
- **Base Damage:** Reduced for lower ranks
  - Ranks 1-4: -10% damage
  - Rank 5: -5% damage
  - Rank 6: Unchanged
- **Impact:** Leveling nerf, endgame unchanged

#### Pyroblast
- **GCD:** 1.5s → 1s
- **Impact:** No longer clips GCD at max Hot Streak stacks, smoother Fire rotation

#### Flash Freeze
- **Change:** No longer activates on temporary immunities (Free Action Potion, Blessing of Freedom)
- **Impact:** PvP improvement, removes punishment for using immunities against Frost Mages

#### Dampen Magic
- **Spell Damage Reduction:** 2% → 3%
- **Healing Reduction:** 1% → 2%

#### Amplify Magic
- **Healing Bonus:** 2% → 3%
- **Spell Damage Taken:** 1% → 2%
- **Impact:** Both spells now more useful after 1.17.2 rework

#### Arcane Power
- **Haste:** 35% → 30%
- **Mana Drain:** 2% → 1% max mana/sec
- **Mana Regen Penalty:** 75% → 50%
- **Impact:** CRITICAL - Much less punishing to use, reduces mandatory reliance on Tier 3 6-set

#### Arcane Mage Tier 3 (6 Set Bonus)
- **Change:** No longer removes mana regeneration penalty from Arcane Power
- **Impact:** Set bonus less mandatory, opens up gear choices for Tier 3.5+

#### Fireball
- **Mana Cost Reductions:** All ranks reduced
  - Rank 3: 65 → 60
  - Rank 4: 95 → 85
  - Rank 5: 140 → 120
  - Rank 6: 185 → 160
  - Rank 7: 220 → 190
  - Rank 8: 260 → 220
  - Rank 9: 305 → 245
  - Rank 10: 350 → 265
  - Rank 11: 395 → 275
  - Rank 12: 410 → 295
- **Impact:** MAJOR - Fire Mages less mana starved, Mp5 slightly less valuable

#### Flamestrike
- **Mana Cost Reductions:** Ranks 2-6 reduced
  - Rank 2: 330 → 250
  - Rank 3: 490 → 360
  - Rank 4: 650 → 470
  - Rank 5: 815 → 580
  - Rank 6: 990 → 680
- **Impact:** AoE rotation more sustainable

---

## Version 1.18.0 - Scars of the Past

### Baseline Changes

#### Flamestrike
- **Cast Time:** 3s → 2.5s
- **Impact:** AoE rotation improvement

### Arcane Changes (1.18.0)

#### Arcane Rupture
- **Arcane Missiles Buff:** 25% → 20% damage/mana increase
- **Note:** Also affects Arcane Tier 1 8pc set bonus

#### Arcane Focus
- **Position:** Swapped with Magic Absorption
- **Impact:** Fire/Frost can access Row 2 without useless talent

### Fire Changes (1.18.0)

#### Flame Throwing
- **New:** Also increases Blast Wave radius by 10/20%
- **Impact:** QoL for AoE

#### Ignite
- **Duration:** 6s → 4s (reverted)
- **Reason:** Longer duration didn't work as intended, solo Fire Mage forced to spam Scorch
- **Impact:** Back to vanilla duration, promotes Fire Mage cooperation

#### Hot Streak
- **Ranks:** 3 → 2
- **Proc Chance:** 33/66/100% → 50/100%
- **Impact:** More talent point efficient

#### Master of Elements
- **Mana Refund:** 10/20/30% → 15/30/45% of base mana cost on crit
- **Impact:** Better mana sustain for Fire

#### Blast Wave
- **Cooldown:** 45s → 30s
- **Impact:** More frequent AoE ability

#### Improved Scorch (August 2025 Revision)
- **Renamed:** Fire Vulnerability
- **New:** Also applied by Fire Blast with same chances
- **Impact:** Easier to apply/maintain debuff

---

## Stat Priority Impact Summary

### Arcane Mage

#### Extremely High Priority
1. **Spell Power** - Arcane Missiles scaling buffed twice (28.6% → 32.8%), Arcane Rupture 90%, multiplicative with Resonance Cascade
2. **Spell Crit** - Arcane Potency +50/100% crit damage, Temporal Convergence procs
3. **Intellect** - Large mana pool critical for Arcane Power (instant death <10% mana)

#### High Priority
4. **Spell Hit** - To 16% cap (3% from talents)
5. **Spell Haste** - Accelerated Arcana scales cooldown recovery + Arcane Missiles tick speed
6. **Spirit** - Arcane Meditation TRIPLED below 35% mana (7/14/20% → 21/42/60%)

#### Medium Priority
7. **Mp5** - Mana sustain for longer fights
8. **Stamina** - Survivability

### Fire Mage

#### Extremely High Priority
1. **Spell Power** - Fireball, Pyroblast, Fire Blast all scale
2. **Spell Crit** - Hot Streak procs, Master of Elements mana return (15/30/45%), Ignite

#### High Priority
3. **Spell Hit** - To 16% cap (3% from talents)
4. **Intellect** - Mana pool, 1% crit per 60 Int
5. **Spell Haste** - More casts, more Hot Streak procs

#### Medium Priority
6. **Mp5** - Sustained casting
7. **Spirit** - Out of combat regen
8. **Stamina** - Survivability

### Frost Mage

#### Extremely High Priority
1. **Spell Power** - Frostbolt, Icicles (40% per icicle), Ice Barrier gives +15% Frost damage
2. **Spell Crit** - Shatter +7/14/21/28/35% vs frozen (nerfed but still strong), Flash Freeze synergy

#### High Priority
3. **Spell Hit** - To 16% cap (3% from talents)
4. **Intellect** - Mana pool, 1% crit per 60 Int
5. **Spell Haste** - More Frostbolts, more Icicles procs

#### Medium Priority
6. **Mp5** - Mana sustain
7. **Spirit** - Out of combat regen
8. **Stamina** - Survivability (Icicles self-damage risk)

---

## Critical Scaling Breakpoints

### Arcane Power Death Mechanic (1.17.2)
- **Duration:** 20 seconds
- **Mana Drain:** 2% max mana/sec = 40% total
- **Death Threshold:** 10% mana
- **Safe Minimum:** Start with at least 50% mana to avoid death
- **Cannot Cancel:** Must ride out full 20 seconds

### Arcane Meditation Low Mana (1.17.2)
- **Above 35% Mana:** 7/14/20% regen while casting
- **Below 35% Mana:** 21/42/60% regen while casting (TRIPLED)
- **Impact:** Spirit value triples in execute phase

### Hot Streak Stacking (1.18.0)
- **Per Stack:** 1 second cast time reduction
- **Max Stacks:** 5
- **Pyroblast Base Cast:** 6 seconds
- **At Max Stacks:** 1 second cast time (5s reduction)
- **Impact:** Instant-cast Pyroblast at 5 stacks

### Ice Barrier Damage Bonus (1.17.2)
- **Bonus:** +15% Frost damage while active
- **Duration:** 1 minute
- **Impact:** Must maintain for DPS increase

---

## Sources

All information compiled from official Turtle WoW changelogs:
- 1.16.1.html (Arcane Missiles buff, Arcane Potency, Brilliance Aura)
- 1.17.0.html (Brilliance Aura toggle, new teleports)
- 1.17.2-mage-changes.html
- 1.17.2-2024.11.20-changes.html (Hot Streak duration buff)
- 1.17.2-2024.12.20-changes.html (Arcane Rupture nerf, Hot Streak buff, Icicles GCD)
- 1.17.2-2025.04.01-changes.html (Arcane Power rework, Fireball/Flamestrike mana costs, Pyroblast GCD)
- 1.18.0-mage-changes.html

**Last Updated:** Based on changelogs through August 14, 2025 revision

---

## Implementation Notes for ClassicHawsJon_small.lua

### Critical Changes Requiring Stat Weight Updates

#### Arcane
1. **Arcane Missiles (1.16.1 + 1.17.2):** Coefficient 24% → 28.6% → 32.8% per missile
2. **Arcane Potency (1.16.1):** +50/100% crit damage - crit MUCH more valuable
3. **Arcane Meditation (1.17.2):** TRIPLED below 35% mana - Spirit scaling changes dynamically
4. **Resonance Cascade (1.17.2):** 4/8/12/16/20% to duplicate - multiplicative scaling
5. **Arcane Power (1.17.2):** Requires 50%+ mana to avoid death mechanic

#### Fire
1. **Ignite (1.17.2 → 1.18.0):** 4s → 6s → 4s duration, threat split
2. **Hot Streak (1.17.2):** Crit procs reduce Pyroblast cast by 1s per stack (max 5)
3. **Master of Elements (1.18.0):** 15/30/45% mana refund on crit

#### Frost
1. **Shatter (1.17.2):** 10/20/30/40/50% → 7/14/21/28/35% crit vs frozen
2. **Ice Barrier (1.17.2):** +15% Frost damage while active
3. **Icicles (1.17.2):** New rotational ability, 40% spell power per icicle
4. **Flash Freeze (1.17.2):** Resets Icicles vs freeze-immune targets (raid bosses)
