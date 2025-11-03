# Turtle WoW Warlock Scaling Changes

This document tracks all Warlock-specific changes from Turtle WoW that affect stat scaling and item valuation for the Pawn addon.

**Base Reference:** Vanilla 1.12.1 stat scaling is implemented in `ClassicHawsJon_small.lua`.

**Related Documentation:** See `turtle-wow-general-scaling-changes.md` for non-class-specific changes.

---

## Version 1.16.1 - First Class Changes

### New Abilities
- **Mana Funnel:** Transfers mana to pet (Rank 1: 18/sec, Rank 2: 36/sec)
- **Demon Portal (later Demon Gate):** Summons Felguard for 5 minutes
- **Avoidance:** Pet passive, reduces AoE damage by 50%

### Talent Changes
- **Soul Siphon:** Merged Improved Drain Life + Drain Mana
- **Master Conjurer:** Merged Healthstone/Firestone/Spellstone improvements (+10/20% Healthstone, +15/30% stone effects)
- **Inferno:** Cooldown 1 hour → 20 minutes
- **Intensity:** 70% pushback resistance for Destruction Fire spells
- **Pyroclasm:** 25% chance to stun with Rain of Fire/Hellfire/Conflagrate/Soul Fire

---

## Version 1.17.2 - Mysteries of Azeroth (MAJOR REWORK)

### Baseline Changes

#### Drain Soul (Complete Rework)
- **Damage Pattern:** Builds up over 6 seconds
- **Spell Power Coefficient:** 16.67% per tick
- **Ranks:** 5 ranks (new Rank 5 at 60: 950 damage)
- **Soul Shard:** Granted on kill
- **Impact:** CRITICAL - now viable DPS ability

#### Soul Fire (Major Buffs)
- **Spell Power Coefficient:** 100% → 125%
- **Cooldown:** 1 minute → 30 seconds
- **New Ranks:** 4 ranks starting at level 30
- **Impact:** CRITICAL - significant spell power scaling, usable on cooldown

#### Searing Pain
- **Threat:** Removed increased threat generation
- **Impact:** Viable for DPS without threat issues

#### Curse of Weakness (Reworked)
- **Effect:** Flat damage reduction → 15% attack speed reduction
- **Ranks:** Multiple → 1 rank
- **Impact:** Attack speed debuff

#### Corruption
- **Cast Time:** 2 seconds → 1.5 seconds
- **Impact:** Faster DoT application

#### Demons
- **Change:** Can no longer benefit from player buffs/consumables
- **Reason:** Discouraged demon swapping, made Greater demons weaker
- **Compensation:** Demonology tree buffs

#### Greater Demons (Complete Rework)
- **Control:** No longer require Enslave, immediate control
- **Duration:** Set duration
- **After Duration:** Turn on master (no party chaos)
- **Changes:**
  - Demon Gate (Demon Portal renamed): 30min CD, 4s cast, 6s spawn, 1min duration
  - Inferno: 20min → 10min CD, 2s → 1.5s cast, 30s duration
  - Ritual of Doom: 4 → 2 players, no random death, 1min duration

#### Avoidance
- **AoE Reduction:** 50% → 80%
- **Applies To:** Regular, Greater, and Enslaved demons

#### Conjured Stones (NEW System)
- **Type:** Personal 30-minute buffs (mutually exclusive)
- **Restriction:** Not usable in combat (changed Oct 21)
- **Stones:**
  - **Firestone (22):** +2% Fire crit, main-hand/wand 40% chance for 15-20 + level Fire damage
  - **Felstone (32):** 3% damage as healing (also heals demon)
  - **Wrathstone (42):** +40% Fire spell threat, -30% Hellfire self-damage
  - **Spellstone (52):** -10% spell threat
- **Impact:** CRITICAL - new buff system replacing off-hand stones

---

### Affliction Specialization

#### Improved Corruption (Adjusted)
- **Cast Time Reduction:** 0.4/0.8/1.2/1.6/2s → 0.3/0.6/0.9/1.2/1.5s
- **Reason:** Accommodate baseline 2s → 1.5s reduction
- **Result:** Still instant at max rank

#### Resilient Shadows (NEW - Tier 2)
- **Points:** 3
- **Effect:** Reduces Interrupt duration on Shadow spells by 10/20/30%

#### Improved Drains (Changed)
- **Effect:** Drain Mana +5/10% effectiveness (was damage conversion)

#### Improved Curse of Agony (Buffed)
- **Damage Bonus:** 2/4/6% → 3/6/10%

#### Fel Concentration (Buffed)
- **New:** Also affects Dark Harvest

#### Curse of Exhaustion (Moved and Buffed)
- **Location:** Tier 5 → Tier 3
- **Slow:** 10% → 30%

#### Nightfall (Reworked)
- **Trigger Spells:** Corruption + Drain Life → Corruption + Dark Harvest + all drains
- **Proc Chance:** Fixed → 1/3/5% (3 ranks)

#### Rapid Deterioration (NEW - Tier 5)
- **Points:** 2
- **Effect:**
  - +6% casting speed for Affliction spells
  - Haste affects DoT/channel tick speed at 50/100% efficiency (reduces duration)
- **Impact:** Haste scaling for Affliction

#### Malediction (NEW Keystone - Tier 5)
- **Effect:** Curse of Agony usable alongside other curses (except Curse of Doom)
- **Impact:** CRITICAL - removes curse slot limitation

#### Soul Siphon (NEW - Tier 5)
- **Points:** 3
- **Effect:** Drain Soul/Dark Harvest/Death Coil +2/3/4% damage per Affliction effect on target
- **Max:** 4 effects (16% bonus at max rank)
- **Impact:** Scales with DoT coverage

#### Dark Harvest (NEW Capstone - Tier 7)
- **Type:** Channeled Shadow damage
- **Effect:** 700 Shadow damage over 8 seconds, reduces Affliction DoT tick time by 20% while channeling
- **Cooldown:** 30 seconds
- **Ranks:** Level 40 (talent), 50 (900), 60 (1150)
- **Impact:** CRITICAL - new rotational finisher, accelerates DoT damage

---

### Demonology Specialization (COMPLETE REWORK)

#### Soul Entrapment (Buffed)
- **Effect:** +1/2/3% damage while no demon active

#### Demonic Sacrifice (Moved and Prerequisite)
- **Location:** Deep tree → higher (Tier 3)
- **Prerequisite:** Soul Entrapment
- **Benefits:**
  - Imp: +6% Fire damage
  - Voidwalker: 3% max HP regen every 4 sec
  - Succubus: +6% Shadow damage
  - Felhunter: 2% max mana regen every 4 sec
- **Impact:** More accessible for non-Demonology specs

#### Soul Funnel (Buffed)
- **Effect:** Scales with demon's missing HP/mana
- **Impact:** Clutch demon healing improved

#### Fel Intellect (MAJOR REWORK)
- **Previous:** Static mana bonus
- **New:** 7/14/21/28/35% of warlock's total Intellect transferred to demon
- **Additional:** 15/30/45/60/75% demon mana regen continues while casting
- **Impact:** CRITICAL - Intellect now scales demon mana and regen

#### Fel Stamina (MAJOR REWORK)
- **Previous:** Static health bonus
- **New:** 7/14/21/28/35% of warlock's total Stamina transferred to demon
- **Additional:** -1/2/3/4/5% chance for demon to be crit
- **Impact:** CRITICAL - Stamina now scales demon health

#### Fel Domination (Buffed)
- **Cooldown:** 15min → 5min
- **Cast Time Reduction:** 5.5s → 4s
- **Additional:** Reduces Inferno CD by 2.5/5min, Demon Gate CD by 7.5/15min

#### Master Summoner (Buffed)
- **Mana Reduction:** Increased to 40/60%
- **Additional:** Reduces Greater demon CDs by 25/50%

#### Improved Stones (NEW - Tier 4)
- **Points:** 2
- **Effect:** +25/50% Wrathstone/Spellstone, +1/2% Felstone healing, +1/2% Firestone crit

#### Nether Studies (NEW - Replaces 3 demon talents)
- **Effect:** +15/30/45% to Succubus Seduction, Voidwalker Torment, Imp Blood Pact, Felhunter Tainted Blood

#### Unholy Power (Changed)
- **Points:** 5 → 3
- **Damage:** Changed to 5/10/15%
- **Demons:** Now affects all demons

#### Unleashed Potential (NEW - Tier 5)
- **Points:** 3
- **Effect:**
  - Direct damage spells: 60% chance to grant demon Unleashed Potential for 3 sec
  - Funnel spells: 100% chance
- **Unleashed Potential:**
  - Demon AP: +20/40/60% of warlock spell damage
  - Demon spell damage: +5/10/15% of warlock spell damage
- **Impact:** CRITICAL - spell damage scales demon damage

#### Power Overwhelming (NEW Keystone - Tier 5)
- **Cooldown:** 14 seconds
- **Cost:** 7% base mana
- **Effect:** +20% demon damage for 10 seconds, demon takes 40% max HP as damage over duration
- **Impact:** Demon burst cooldown

#### Demonic Precision (NEW - Tier 6)
- **Effect:** Demons gain +1/2/3% melee/spell hit, plus 33/66/100% of warlock spell hit for both melee and spell
- **Impact:** CRITICAL - hit rating transfers to demons

#### Master Demonologist (Complete Rework - Tier 7)
- **Demon-Specific Bonuses:**
  - Imp: -3/6/9/12/15% spell costs, +1/2/3/4/5% casting speed
  - Voidwalker: -2/4/6/8/10% physical damage, +8/16/24/32/40% pushback resistance
  - Succubus: +2/4/6/8/10% all damage, +5% threat
  - Felhunter: +0.2/0.4/0.6/0.8/1 all resistances per level, 10% chance to apply Tainted Blood to attackers
  - Infernal: +3/6/9/12/15% casting/attack speed, -50% healing taken
  - Felguard: +4/8/12/16/20% all damage, +20% mana costs
- **Impact:** CRITICAL - major demon-specific bonuses

#### Soul Link (Reworked)
- **Type:** Passive (auto-applies)
- **Damage Transfer:** 30% → 20% to demon
- **Damage Bonus:** 3% → 5% to warlock
- **Applies To:** Any demon (regular, Greater, enslaved)
- **Impact:** Permanent passive damage bonus

---

### Destruction Specialization

#### Improved Shadow Bolt (Complete Rework)
- **Previous:** Crit-based charges
- **New:** Flat 5/10/15/20/25% proc chance per cast
- **Debuff:** +15% Shadow damage, 10 second duration, no charges (permanent until expires)
- **Impact:** CRITICAL - consistent Shadow damage amplification

#### Cataclysm (Buffed)
- **Mana Reduction:** 1/2/3/4/5% → 2/4/6/8/10%

#### Demonic Swiftness (NEW - Merged talent)
- **Points:** 2
- **Effect:** Imp Firebolt -0.25/0.5s cast, Succubus Lash -3/6s CD

#### Aftermath (Buffed and Clarified)
- **Points:** 5 → 3 (same proc chance)
- **Additional:** +2/4/6% Immolate periodic damage
- **Clarification:** Description corrected (slows, not dazes)

#### Improved Soul Fire (NEW - Tier 5)
- **Points:** 2
- **Effect:** Soul Fire 50/100% chance to refund Soul Shard and grant +8% Fire damage for 25 sec

#### Improved Immolate (Changed)
- **Effect:** Now increases all Immolate damage (was just initial)
- **Damage:** 5/10/15/20/25% → 4/8/12/16/20%

#### Conflagrate (Major Rework)
- **Previous:** Consumed Immolate DoT
- **New:** Consumes 3 seconds of Immolate to deal that damage instantly
- **GCD:** 1.5s → 1s
- **Impact:** No longer removes Immolate, more usable

---

## Version 1.17.2 - Hotfixes

### October 21, 2024
- **Stones:** No longer share 30min CD (usable in combat instead)
- **Fel Domination:** 5min CD confirmed, no demon summon lock

### November 1, 2024
- **Improved Shadow Bolt:** +15% → +20% Shadow damage
- **Power Overwhelming:** Mana cost reduced to 80

### November 20, 2024
- **Searing Pain:** +10% base damage all ranks
- **Drain Soul:** 16.67% → 20% coefficient, -20% mana cost, even damage per tick (no buildup)
- **Dark Harvest:** 20% → 25% spell power coefficient
- **Nightfall:** Changed from 3 points (1/3/5% proc) to 2 points (2/4% proc)

### December 20, 2024 (MAJOR TUNING)

#### Improved Shadow Bolt (Reworked)
- **On Hit:** 5/10/15/20/25% → 2/4/6/8/10% chance
- **On Crit:** 0% → 20/40/60/80/100% chance
- **Shadow Damage:** +15% → +20%
- **Impact:** More consistent via crits

#### Improved Soul Fire (Buffed)
- **Buff Application:** On hit → on cast (guaranteed)
- **Duration:** 25 → 30 seconds

#### Resilient Shadows (Reworked)
- **Effect:** Interrupt reduction → +3/6/9% dispel resistance for Affliction spells

#### Improved Drains (Buffed)
- **Effect:** Also increases Drain Soul damage by 5/10%

#### Nightfall (Buffed)
- **Effect:** Shadow Bolts from Nightfall proc guaranteed to hit

#### Soul Siphon (Buffed)
- **Damage:** 2/3/4% → 2/4/6% per Affliction effect

#### Fel Intellect (Adjusted)
- **Points:** 5 → 3
- **Intellect Transfer:** 7-35% → 10/20/30%
- **Mana Regen:** 15-75% → 5/10/15%

#### Fel Stamina (Adjusted)
- **Stamina Transfer:** 7-35% → 10/20/30/40/50%

#### Unleashed Potential (Complete Rework)
- **Trigger:** Direct damage 60% → crit strikes grant stack
- **Stack Duration:** 3s → 20s (funnel spells refresh)
- **Benefit:** 5/10/15% of spell damage
- **Max Stacks:** 3
- **Impact:** Crit-based stacking system

#### Demonic Precision (Reworked)
- **Transfer:** Hit only → hit + crit
- **Amount:** 33/66/100% of spell hit and spell crit to demons

#### Master Demonologist (Changes)
- **Voidwalker:** Pushback → +4/8/12/16/20% healing taken
- **Infernal:** -50% → -75% healing taken
- **Felguard:** +20% → +30% mana costs
- **Greater Demons:** Duration 30s/1min → 3 minutes

#### Soul Link (Buffed)
- **Damage Transfer:** 20% → 25%
- **Additional:** Prevents Enslaved demons from breaking free early

#### Succubus Soothing Kiss (Reworked)
- **Effect:** Soothes target, -15/20/25/30% threat for Succubus and Warlock
- **Cooldown:** 3 minutes

#### Voidwalker Sacrifice (NEW Scaling)
- **Change:** Added spellpower scaling to Voidwalker's Sacrifice ability
- **Impact:** Voidwalker sacrifice shield now scales with spell damage

### April 1, 2025 (MAJOR CHANGES)

#### Resilient Shadows (Buffed)
- **Dispel Resistance:** 3/6/9% → 5/10/15%

#### Malediction (Buffed)
- **Effect:** Curse of Recklessness/Elements/Shadows auto-apply Curse of Agony if not present
- **Impact:** Faster trash setup

#### Siphon Life (Major Buff)
- **Spell Power Coefficient:** 50% → 100%

#### Dark Harvest (Buffed)
- **Haste:** 20% → 30%
- **Additional:** Resets CD if target dies during channel

#### Soul Funnel (Nerf)
- **Cost:** Warlock pays 30% of transferred health/mana

#### Demonic Sacrifice (Changed)
- **Effect:** Removed when enslaving demon

#### Master Demonologist (Nerfs)
- **Infernal:** -75% → -50% healing reduction
- **Felguard:** +20% → +10% damage

#### Imp Firebolt (NEW Scaling)
- **Spell Power Coefficient by Rank:** 10/15/20/25/30/35/40%

#### Felguard Legion Strike (Reworked)
- **Damage:** 130% weapon → 50% weapon
- **Cooldown:** 6s → 4s
- **Additional:** Felguard can now crit with all attacks

---

## Version 1.18.0 - Scars of the Past

### Baseline Changes

#### Pet Command: Take Position (NEW)
- **Effect:** Select location to send pet (respects LoS)
- **Impact:** Better pet positioning

#### Drain Soul (Mana Change)
- **Previous:** Flat mana cost
- **New:** Initial + per second cost
- **Example R5:** 524 flat → 135 initial + 65/sec (525 total)
- **Impact:** Less punishing for short channels

#### Health/Mana Funnel
- **Range:** 20 → 30 yards

#### Stones
- **Change:** Usable in combat

#### Doomguard
- **Ability:** Rend removed
- **New:** Infernal Blade (12s duration, +30% Fire damage on attacks, applies 250 Fire DoT over 5s, stacks 3x)

#### Spellstone (Complete Rework)
- **Previous:** Passive threat reduction buff
- **New:** Active dispel + magic shield
- **Effect:** Removes all Magic effects, grants shield (level × 12 damage absorbed) for 30s
- **Cooldown:** Shares with Healthstones
- **Impact:** Strategic dispel tool

#### Rain of Fire
- **Tick Speed:** 2 seconds → 1 second (same total damage)

#### Soul Fire (Nerf)
- **Spell Power Coefficient:** 125% → 114%
- **Reason:** Normalize with Improved Soul Fire buffs

---

### Affliction

#### Fel Concentration (Improved)
- **Points:** 5 → 2
- **Spells:** Now affects all Affliction spells (includes Fear, Howl of Terror)

#### Sinister Pursuit (NEW - Row 1, moved from Row 3 in August 2025)
- **Points:** 3
- **Effect:** Demon +5/10/15% movement speed for 3s after attacking Affliction-affected target
- **Note:** Originally Row 3 in main 1.18.0, moved to Row 1 in August 2025 revision

#### Curse of Exhaustion (Nerf)
- **Slow:** 30% → 10% baseline

#### Improved Curse of Exhaustion (NEW - Tier 5)
- **Points:** 2
- **Effect:** +15/30% slow (restores to 40% total)
- **Reason:** Too accessible for other specs

---

### Demonology

#### Soul Entrapment (Buffed)
- **Damage:** 1/2/3% → 2/4/6%

#### Demonic Sacrifice (Changed Benefits)
- **Imp:** 6% Fire → 4% Spell Damage
- **Succubus:** 6% Shadow → -10% Threat
- **Felhunter:** 2% → 3% mana regen

#### Power Overwhelming (Buffed)
- **Effect:** Removes all CC from demon on activation
- **Cost:** 40% max HP → 40% base HP

#### Demonic Precision (Adjusted)
- **Transfer:** 33/66/100% → 30/60/90%
- **Baseline:** +1/2/3% hit/crit for both melee and spell

#### Master Demonologist (Simplified)
- **Imp:** -3-15% spell costs (casting speed removed)
- **Voidwalker:** -2-10% physical damage (healing taken removed)
- **Succubus:** +2-10% damage (threat removed)
- **Felhunter:** +0.2-1 all resistances per level
- **Greater Demons:** +2-10% spell crit, -8-40% healing taken (unified bonuses)

---

### Destruction

#### Shadow Vulnerability (Renamed)
- **Previous Name:** Improved Shadow Bolt
- **Additional:** Drain Soul ticks can now apply

#### Destructive Reach (Buffed)
- **Effect:** Also increases Hellfire radius

#### Improved Soul Fire (Buffed)
- **Fire Damage Bonus:** 8% → 10%

---

### August 2025 Revision

#### Voidstone (NEW)
- **Level:** 52
- **Effect:** -10% spell threat for 30 minutes
- **Cost:** 20% base mana, 3s cast, 1 Soul Shard

#### Spellstone
- **Level:** 52 → 36

#### Ritual of Doom (Faster)
- **Cast + Channel:** 10+10s → 5+5s

#### Talent Tree Restructure
- **Change:** Removed talent link dependency between Master Demonologist and Unleashed Potential
- **Impact:** More flexible talent pathing in Demonology tree

#### Demon Attack Power Scaling (NEW)
- **Voidwalker:** 20% of warlock spell damage as AP
- **Succubus:** 40%
- **Felhunter:** 30%
- **Infernal:** 60%
- **Felguard:** 60%
- **Doomguard:** 30%
- **Impact:** CRITICAL - demons scale with spell damage as AP

---

## Stat Priority Impact Summary

### Affliction
1. **Spell Power:** Siphon Life 50%→100%, Drain Soul 20%, Dark Harvest 25%, Soul Siphon +2-6% per DoT
2. **Haste:** Rapid Deterioration (50/100% efficiency for DoT tick speed), Dark Harvest +30% haste
3. **Critical Strike:** Nightfall proc chance

### Demonology
1. **Spell Power:**
   - Unleashed Potential: 5-15% transfers to demons (3 stacks)
   - Demon AP scaling: 20-60% spell damage as demon AP (August 2025)
   - Imp Firebolt: 10-40% spell power coefficient
2. **Intellect:** Fel Intellect: 10-30% transfers to demons
3. **Stamina:** Fel Stamina: 10-50% transfers to demons
4. **Hit Rating:** Demonic Precision: 30-90% transfers to demons
5. **Critical Strike:** Demonic Precision: 30-90% transfers, Unleashed Potential stacks on crits

### Destruction
1. **Spell Power:** Soul Fire 114%, Improved Shadow Bolt +20% Shadow damage amplification
2. **Critical Strike:** Improved Shadow Bolt 20-100% proc on crit, Improved Soul Fire buff proc
3. **Fire Damage:** Firestone +2%, Improved Soul Fire +10%

---

## Critical Scaling Breakpoints

### Fel Intellect/Stamina Scaling (December 2024)
- **Intellect:** 10/20/30% total → demons (was 7-35% at 5 points)
- **Stamina:** 10/20/30/40/50% total → demons (was 7-35% at 5 points)
- **Impact:** Stats from gear now transfer to demons

### Demon Spell Damage Scaling
- **Unleashed Potential:** 5-15% spell damage (3 stacks, 20s duration)
- **Demon AP:** 20-60% spell damage as AP (August 2025)
- **Impact:** Spell damage becomes demon damage

### Soul Fire Rotation (Destruction)
- **Coefficient:** 114% spell power (1.18.0)
- **Improved Soul Fire:** 100% chance for +10% Fire damage (30s duration)
- **Cooldown:** 30 seconds
- **Impact:** Near-permanent 10% Fire damage with proper rotation

### Affliction DoT Acceleration
- **Dark Harvest:** -20% DoT tick time while channeling
- **Rapid Deterioration:** Haste affects tick speed at 50/100% efficiency
- **Impact:** Haste significantly increases DoT damage throughput

---

## Implementation Notes for ClassicHawsJon_small.lua

### High Priority
1. **Soul Fire:** 100% → 125% (1.17.2) → 114% (1.18.0) coefficient
2. **Drain Soul:** 16.67% → 20% coefficient
3. **Dark Harvest:** 25% coefficient
4. **Siphon Life:** 50% → 100% coefficient
5. **Fel Intellect:** 10-30% total Intellect → demons
6. **Fel Stamina:** 10-50% total Stamina → demons
7. **Unleashed Potential:** 5-15% spell damage → demons
8. **Demon AP Scaling:** 20-60% spell damage as demon AP
9. **Imp Firebolt:** 10-40% spell power coefficient
10. **Demonic Precision:** 30-90% hit/crit transfer

### Medium Priority
1. **Improved Shadow Bolt:** +20% Shadow damage debuff
2. **Improved Soul Fire:** +10% Fire damage for 30s
3. **Haste (Affliction):** Rapid Deterioration 50/100% efficiency for DoT ticks
4. **Soul Siphon:** +2-6% per Affliction effect (max 4 = 24%)
5. **Malediction:** Removes curse slot limitation

### Low Priority
1. **Stone buffs:** Firestone +2% Fire crit, etc.
2. **Master Demonologist:** Various demon-specific bonuses
3. **Conflagrate rework:** Usability improvement

---

## Sources

All information from official Turtle WoW changelogs:
- `turtle-wow-changelogs/1.16.1.html` (lines 723-776)
- `turtle-wow-changelogs/1.17.0.html` (Troll Warlock mention)
- `turtle-wow-changelogs/1.17.2-warlock-changes.html` (complete)
- `turtle-wow-changelogs/1.17.2-2024.10.21-changes.html`
- `turtle-wow-changelogs/1.17.2-2024.11.01-changes.html`
- `turtle-wow-changelogs/1.17.2-2024.11.20-changes.html` (lines 103-112)
- `turtle-wow-changelogs/1.17.2-2024.12.20-changes.html` (lines 293-372)
- `turtle-wow-changelogs/1.17.2-2025.04.01-changes.html` (lines 282-341)
- `turtle-wow-changelogs/1.18.0-warlock-changes.html` (complete)

**Last Updated:** Based on changelogs through Patch 1.18.0 (August 14, 2025 revision)
