# Turtle WoW Warrior Scaling Changes

This document tracks all Warrior-specific changes from Turtle WoW that affect stat scaling and item valuation for the Pawn addon.

**Base Reference:** Vanilla 1.12.1 stat scaling is implemented in `ClassicHawsJon_small.lua`.

**Related Documentation:** See `turtle-wow-general-scaling-changes.md` for non-class-specific changes (weapon skill rework, hit cap changes, armor cap removal, etc.).

---

## Version 1.16.1 - First Class Changes

### Baseline Changes

#### Thunderclap
- **Change:** Now usable in Defensive Stance (was Battle Stance only)
- **Impact:** Quality of life for Protection, improved AoE threat generation

#### Intervene (NEW)
- **Type:** New baseline ability
- **Cost:** 10 rage
- **Cooldown:** 30 seconds
- **Effect:** Intercept friendly target, taking damage for them
- **Impact:** New defensive utility for all Warriors

#### Decisive Strike (NEW)
- **Type:** New baseline ability
- **Cost:** 15 rage
- **Cast Time:** 2 seconds (castable while moving)
- **Effect:** Guaranteed critical strike with increased damage
- **Impact:** New burst damage option, competes with rage management

---

### Arms Specialization

#### Die by the Sword (NEW Passive)
- **Type:** Passive learned from Tome
- **Effect:** Grants +20% parry chance while Retaliation is active
- **Impact:** Adds defensive burst windows and increases parry value during retaliation uptime

#### Improved Thunder Clap
- **Rage Reduction:** Reduces Thunder Clap cost by 1/2/4 rage at ranks 1/2/3
- **Damage Increase:** Increases Thunder Clap damage by 20/40/60% at ranks 1/2/3
- **Impact:** Improves AoE threat and ability to convert Attack Power into cleave damage

#### Poleaxe Specialization (MERGED)
- **Location:** Tier 5, 5 points (Arms)
- **Effect:** +1/2/3/4/5% critical strike chance with axes and polearms (combines former Axe + Polearm talents)
- **Impact:** Frees a talent row while keeping crit weighting for two-handed weapon users

#### Improved Disciplines (NEW)
- **Location:** Tier 6, 3 points (Arms)
- **Effect:** Reduces the cooldown of Retaliation, Recklessness, and Shield Wall by 2/4/6 minutes
- **Impact:** More frequent access to major cooldowns, raises value of rage pooling and defensive stats during burst windows

---

### Protection Specialization

#### Improved Shield Block
- **Change:** 3 ranks reduced to 1 rank
- **Effect:** Increases Shield Block duration by 1 second
- **Impact:** Talent point efficiency, consistent Shield Block uptime improvement

---

## Version 1.17.2 - Mysteries of Azeroth

### Baseline Changes (MAJOR REWORKS)

#### Rage Generation Formula (CRITICAL CHANGE)
- **Previous:** Heavily weapon speed-dependent
- **New Formula:** 90% gear-dependent (damage dealt), 10% predetermined based on weapon speed
- **Impact:**
  - Weapon damage/DPS now most important (not speed)
  - Faster weapons generate more rage per time
  - Gear quality (Attack Power, crit, hit) directly affects rage generation
  - Reduces slow weapon advantage
  - Passive rage retention improved (Anger Management’s out-of-combat effect is baseline and rage decay is fixed at 2 per 2 seconds)

#### Execute (MAJOR REBALANCE)
- **Damage Changes:**
  - Base damage reduced
  - Rage-to-damage conversion increased
  - Better scaling with extra rage consumption
- **Cooldown:** 5.5 seconds added
- **Impact:**
  - Execute spam reduced by cooldown
  - Higher rage pooling value during execute phase
  - Increases value of rage generation mechanics

#### Heroic Strike Queue (Mechanic Adjustment)
- **Change:** Off-hand weapon attacks are no longer guaranteed to hit while Heroic Strike is queued
- **Compensation:** Dual Wield Specialization now supplies off-hand hit chance (see Fury section)
- **Impact:** Hit rating regained value for dual-wield builds; weapon skill and hit become critical for smoothing rage generation

#### Rend
- **Attack Power Scaling:** Now scales with Attack Power
- **Impact:** Attack Power significantly more valuable for Warriors using Rend

#### Slam
- **Availability:** Now learned at level 14 (was talent-gated)
- **Mechanic Change:** Pauses swing timer (does not reset it)
- **Impact:** More accessible rotational tool, swing timer management less punishing

#### Sunder Armor
- **Rage Cost:** 15 → 10 rage
- **Impact:** More efficient threat/armor reduction, improves rage economy

#### Hamstring
- **Cooldown:** 6 seconds added
- **Impact:** Limits Hamstring spam, slight nerf to rage dump capability

---

### Arms Specialization

#### Talent Layout Updates
- **Tactical Mastery:** Moved from row 2 → row 1, making rage retention accessible to every Arms build
- **Deflection:** Shifted from row 1 → row 2 to balance early tree access
- **Impact:** Early-level and hybrid builds gain rage consistency without sacrificing key points elsewhere

#### Improved Charge (BUFF)
- **Rage Gain:** Increased from 3/6 → 5/10 rage
- **Impact:** Stronger openers and smoother rage curves, raising the value of weapon damage and AP for first globals

#### Improved Rend (Adjusted)
- **Ranks:** Reduced from 3 ranks (15/25/35%) to 2 ranks (10/20%)
- **Impact:** Keeps total throughput while freeing a talent point; synergizes with the new Attack Power scaling on Rend

#### Deep Wounds (MAJOR REWORK)
- **Tick Rate:** 3 seconds → 1.5 seconds
- **Duration:** 12 seconds → 6 seconds (same total damage delivered twice as fast)
- **Armor Interaction:** Boss armor now mitigates Deep Wounds (previously bypassed)
- **Impact:**
  - Huge non-raid DPS boost and PvP pressure
  - Critical strike chance gains more value (faster bleed application)
  - Execute windows benefit from front-loaded bleed damage

#### Counterattack (NEW)
- **Location:** Row 3 keystone (1 point)
- **Trigger:** Activates for 5 seconds after you parry
- **Effect:** Instant strike that immobilizes the target for 3 seconds and deals base damage + 10% AP (5-second cooldown)
- **Impact:** Rewards parry stacking and provides additional crowd control for Arms builds

#### Improved Slam (Relocated)
- **Change:** Now sits in the Arms tree, reduced from 5 → 2 points, and also lowers Slam’s global cooldown
- **Impact:** Enables slam-centric Arms builds with fewer talent points and better rotational flow

#### Two-Handed Weapon Specialization (Streamlined)
- **Points:** Reduced from 5 → 3 points
- **Effect:** Grants +2/4/6% two-handed weapon damage and +1/2/3 weapon skill across all 2H weapon types
- **Impact:** Higher baseline hit/crit reliability and improved scaling for slow 2H weapons

#### Sweeping Strikes (QoL)
- **Rage Cost:** 30 → 20 rage
- **Charges:** No longer consumed by off-hand hits
- **Impact:** Cleave damage becomes cheaper and more consistent for multi-target Arms builds

#### Master of Arms (NEW)
- **Location:** Row 5, 5 points
- **Effect:** Grants weapon-type bonuses per skill point:
  - **Axe:** +1/2/3/4/5% critical strike chance
  - **Mace:** Ignores 2/4/6/8/10 armor per character level (up to 600 at level 60)
  - **Sword:** 1/2/3/4/5% chance to gain an extra attack
  - **Polearm:** +0.4/0.8/1.2/1.6/2.0 yards melee range
- **Impact:** Weapon selection meaningfully changes stat priorities (crit, armor penetration, extra attacks, positioning)

#### Precision Cut (NEW)
- **Location:** Row 5, 3 points
- **Effect:** Adds 20/40/60% more damage to Execute’s extra rage consumption
- **Impact:** Increases the value of rage generation and execute-phase crits prior to later reworks

#### Boundless Anger (NEW)
- **Location:** Row 6, 3 points
- **Effect:** Raises maximum rage by 10/20/30 (100 → 130 at max rank)
- **Impact:** Allows larger rage pools for Execute chains and high-cost abilities

#### Improved Disciplines (Cooldown Buff)
- **Location:** Row 6, 3 points
- **Effect:** Reduces Retaliation, Recklessness, and Shield Wall cooldowns by 4/8/12 minutes (up from 2/4/6)
- **Impact:** Major cooldowns become available far more often, increasing the value of burst stats and defensive uptime

---

### Fury Specialization

#### Booming Voice (BUFF)
- **Effect:** Increases shout radius and bonuses by 12/24/36/48/60% (formerly 10/20/30/40/50%) and now affects Intimidating Shout, Piercing Howl, and Challenging Shout
- **Impact:** Larger buff coverage and threat radius, especially valuable for AP-granting Battle Shout builds

#### Dual Wield Specialization (REWORK)
- **Location:** Moved from row 4 → row 2
- **Effect:** Still grants off-hand damage, now also adds +2/4/6/8/10% chance to hit with the off-hand
- **Impact:** Compensates for the Heroic Strike queue change; hit rating remains premium for dual wielders

#### Improved Shouts (MERGED)
- **Change:** Combines Improved Battle Shout and Improved Demoralizing Shout into a single row-3 talent
- **Impact:** Consolidates buff+tank utility while freeing a point in the tree

#### Blood Craze (BUFF)
- **Healing:** Increased from 1/2/3% to 2/4/6% of total health over the effect duration
- **Impact:** Greater sustain for crit-based Fury builds; increases stamina valuation

#### Unbridled Wrath (MAJOR BUFF)
- **Proc Chance:** 8/16/24/32/40% → 15/30/45/60/75%
- **Two-Handed Bonus:** Proc chance doubled when using 2H weapons
- **Impact:**
  - Massive rage gains for 2H builds (up to 150% proc chance)
  - Attack speed/haste scaling significantly improved

#### Enrage (REWORK)
- **Duration:** 12 → 8 seconds
- **Swing Cap:** Removed (no maximum number of swings)
- **Impact:** Reliable uptime; crit chance and attack speed become key enablers

#### Bloodthirst (COMPLETE REWORK)
- **New Behavior:** Deals self-damage equal to half base + half scaling (can critically hit the warrior) and guarantees Enrage activation
- **Damage:** Flat damage increased per rank; still scales with 30% AP
- **Impact:**
  - On-demand Enrage trigger with 10% physical damage buff
  - Stamina/armor mitigate self-harm; crit chance fuels uptime via Enrage procs

#### Reckless Execute (Talent Swap)
- **Change:** Replaces Improved Execute; reduces Execute cooldown by 2/4 seconds (second point removes cooldown)
- **Impact:** Encourages Execute weaving even before later hotfixes; reinforces rage generation importance

#### Improved Pummel (NEW)
- **Location:** Row 4, 2 points
- **Effect:** Grants Pummel a 25/50% chance to daze for 4 seconds and extends spell-school lockout by 1/2 seconds
- **Impact:** Adds utility to interrupt builds without sacrificing DPS-oriented stats

#### Improved Whirlwind (NEW)
- **Location:** Row 5, 3 points
- **Effect:** Reduces Whirlwind cooldown by 1/1.5/2 seconds
- **Impact:** Speeds up Fury rotational throughput; haste/crit become more valuable for AoE windows

#### Battlefield Mobility (Renamed)
- **Change:** Former Improved Intercept; now also reduces Intervene cooldown
- **Impact:** Enhances mobility for both PvE positioning and PvP gap closing

#### Improved Berserker Rage (REMOVED)
- **Impact:** Fury loses a passive emergency rage/freedom tool until its later reintroduction in 1.18.0

#### Blood Drinker (NEW)
- **Location:** Row 6, 3 points
- **Effect:** While under Enrage, Death Wish, or Recklessness, critical strikes cause your next 5 melee attacks to heal you for 1/1.5/2% of maximum health
- **Impact:** Adds burst sustain tied to crit rate and attack speed; stamina directly scales healing pool

---

### Protection Specialization

#### Improved Bloodrage (BUFF)
- **Change:** Moved to row 1 and now grants an additional 5/10 instant rage
- **Impact:** Tanks start pulls with more rage, increasing early threat and smoothing gear checks

#### Shield Specialization (BUFF)
- **Effect:** Now generates 1/2/3/4/5 rage whenever you block in addition to block chance
- **Impact:** Block value and avoidance directly translate into rage generation

#### Anticipation (Streamlined)
- **Ranks:** Reduced to 3 ranks granting 7/14/20 Defense
- **Impact:** Frees talent points for threat-focused options while maintaining mitigation

#### Improved Shield Block (REMOVED)
- **Impact:** Power reallocated to new Shield Slam talents; players must rely on other tools for extended block uptime

#### Toughness (BUFF)
- **Effect:** Now also increases shield damage absorption by 3/6/9/12/15%
- **Impact:** Elevates the value of armor and block value for mitigation-focused builds

#### Improved Intervene (NEW)
- **Effect:** Grants a 50/100% chance to become immune to movement-impairing effects for 3 seconds after using Intervene
- **Impact:** Adds mobility utility for tank repositioning and PvP support

#### Improved Taunt / Defiance (Repositioned)
- **Improved Taunt:** Moved row 4 → row 3
- **Defiance:** Moved row 3 → row 4 to reflect expanded threat options deeper in tree

#### Improved Revenge (BUFF)
- **Effect:** Now also reduces Revenge cooldown by 0.5/1/1.5 seconds
- **Impact:** Increases Rage-to-threat efficiency; synergizes with new Reprisal talent

#### Improved Sunder Armor (REMOVED)
- **Impact:** Baseline Sunder cost reduction covers its benefit, freeing points for new talents

#### Gag Order (Renamed)
- **Change:** Improved Shield Bash renamed to Gag Order, moved to row 4, adds a 25/50% chance for Shield Slam to dispel a magic effect
- **Impact:** Provides utility while you chase threat stats

#### Improved Disarm (Reworked)
- **Effect:** Now 2 points, reducing Disarm cooldown by 10/20 seconds
- **Impact:** Adds PvP/utility leverage without heavy point investment

#### One-Handed Weapon Specialization (Shifted)
- **Location:** Moved from row 6 → row 5
- **Impact:** Easier access to +damage modifier for hybrid builds

#### Shield Slam (MAJOR BUFF)
- **Location:** Now row 5
- **Scaling:** Damage now scales with both Attack Power and Shield Block Value
- **Impact:**
  - Attack Power and Block Value become premier threat stats
  - Early access enables shield builds at level 30+

#### Improved Shield Slam (NEW)
- **Effect:** Reduces Shield Slam cooldown by 0.5/1 second and grants 35/70% extra block chance for 5 seconds after use
- **Impact:** Encourages Shield Slam-centric rotations and adds mitigation windows

#### Reprisal (NEW)
- **Effect:** Increases Revenge damage by 25/50% and gives a 50/100% chance to refund its rage cost on success
- **Impact:** Elevates Revenge as a threat tool and rewards crit/dodge-heavy encounters

#### Improved Shield Wall (Repositioned)
- **Location:** Row 5 → row 6; now reduces Shield Wall cooldown by 5/10 minutes and extends duration by 1/2 seconds
- **Impact:** Grants defensive cooldown parity without dipping into Arms for Improved Disciplines

#### Defensive Tactics (NEW)
- **Effect:** While wearing a shield, you retain 50/100/150% of Defensive Stance threat when using other stances
- **Impact:** Enables mixed-stance DPS/threat play without forfeiting threat scaling

#### Concussion Blow (MAJOR BUFF)
- **Location:** Moved to row 7
- **Effect:** Deals damage, generates high threat, and penetrates 50% armor (later 100%—see December 20 update)
- **Impact:** Snap-threat opener that scales with AP and weapon damage; increases value of armor penetration

---

## Version 1.17.2 - Hotfixes

### November 1, 2024

#### Fury Baseline
- **Enrage:** Damage bonus reduced from 25% → 15%
- **Impact:** Still strong but less dominant, slightly reduces crit value

#### Fury Talent
- **Bloodrage:** Now activates Enrage when used
- **Impact:** Additional on-demand Enrage source, synergizes with Bloodthirst

#### Arms/Fury Baseline
- **Rend:** Now scales with 5% of Attack Power per tick
- **Impact:** Attack Power scaling formalized, makes Rend viable rotational DoT

#### Arms Talent
- **Mortal Strike:** Now uses normalized weapon damage
- **Impact:** Weapon speed less critical, raw weapon DPS more important

---

### October 21, 2024

#### Protection Talent
- **Improved Shield Slam:** Effect duration and cooldown reduced from 5 seconds to 4.5 seconds, cooldown reduction increased from 0.5/1 seconds to 0.75/1.5 seconds
- **Impact:** More frequent Shield Slam usage increases value of Block Value and Attack Power through higher ability uptime

---

### December 20, 2024 (MAJOR UPDATE)

#### Fury Baseline Changes

##### Bloodthirst (MAJOR REWORK)
- **Previous:** Self-damage ability that proc'd Enrage
- **New Effects:**
  - No longer damages you (cannot proc Enrage)
  - Increases movement speed by 5% for 6 seconds (stacks with other movement speed)
  - Base damage increased:
    - Rank 1: 80 → 100
    - Rank 2: 100 → 130
    - Rank 3: 120 → 160
    - Rank 4: 150 → 200
  - Attack Power scaling increased from 30% → 35%
- **Impact:** CRITICAL change
  - Reverts Enrage proc mechanic (back to crit-based + Bloodrage)
  - Higher damage scaling increases Attack Power value
  - Movement speed quality of life improvement

##### Enrage
- **Damage Bonus:** Increased from 3/6/9/12/15% → 4/8/12/16/20%
- **Impact:** Compensates for loss of Bloodthirst Enrage proc, increases critical strike value further

#### Arms/Protection Shared Changes

##### Concussion Blow (MAJOR BUFF)
- **Cooldown:** 45 seconds → 20 seconds
- **Armor Penetration:** 50% → 100%
- **Stun Duration:** 5 seconds → 2 seconds
- **Impact:**
  - More frequent usage increases armor penetration value
  - Better threat opener for Protection
  - 100% armor penetration makes it ignore armor completely

#### Baseline Ability Changes

##### Decisive Strike Removal + Slam Rework
- **Decisive Strike:** Removed completely
- **Slam Changes:**
  - Now has 2.5 second cast time (continues swing timer, castable while moving)
  - Multiple ranks added:
    - Rank 1 (Level 14): 50% Weapon Damage
    - Rank 2 (Level 24): 60% Weapon Damage
    - Rank 3 (Level 34): 70% Weapon Damage
    - Rank 4 (Level 44): 80% Weapon Damage
    - Rank 5 (Level 54): 90% Weapon Damage
- **Impact:** Slam now the primary castable rage dump, continues swing timer (no pause)

##### Execute (REVERT)
- **Values:** Reverted to original Vanilla values:
  - Rank 1 (Level 24): 125 + 3 per rage
  - Rank 2 (Level 32): 200 + 6 per rage
  - Rank 3 (Level 40): 325 + 9 per rage
  - Rank 4 (Level 48): 450 + 12 per rage
  - Rank 5 (Level 56): 600 + 15 per rage
- **Cooldown:** 5.5 seconds → 4.5 seconds
- **Impact:** Lower base damage, higher rage scaling, rage pooling more important

#### Arms Talents

##### Master of Arms (Mace - NERF)
- **Armor Penetration:** Reduced from 2/4/6/8/10 per level → 1.2/2.4/3.6/4.8/6 per level
- **Result:** 600 armor pen at level 60 → 360 armor pen
- **Impact:** Significant nerf to Mace specialization, reduces armor penetration stat priority for Mace users

##### Precision Cut (COMPLETE REWORK - December 20)
- **Previous:** Increased Execute extra rage damage by 20/40/60%
- **New Effect:** Execute refunds 10/20/30% of rage spent upon hit
- **Impact:** CRITICAL change
  - Enables Execute spam through rage refund
  - Less benefit from rage pooling
  - Changes Execute phase from "pool and burst" to "sustain spam"

##### Reckless Execute
- **Rank 1:** Cooldown reduction reduced from 2 seconds → 1.5 seconds
- **Rank 2:** Removes Execute cooldown (unchanged)
- **Impact:** Slightly slower Execute spam without Rank 2

#### Protection Talents

##### Defensive Tactics
- **Threat Modifier:** Increased from 55/110/165% → 60/120/180%
- **Impact:** Better threat generation when NOT in Defensive Stance, improves DPS stance threat for tanks

##### Improved Shield Slam
- **Cooldown Reduction:** Increased from 0.5/1 seconds → 0.75/1.5 seconds
- **Block Buff Duration:** Reduced from 5 seconds → 4.5 seconds
- **Impact:** More frequent Shield Slam, increases Block Value and Attack Power value

##### Revenge
- **Cooldown:** Increased from 5 seconds → 6 seconds
- **Impact:** Slightly less frequent usage, minor nerf to Protection threat generation

---

### April 1, 2025

#### Concussion Blow (Buff)
- **Stun Duration:** 2 seconds → 3 seconds
- **Impact:** Longer crowd control window improves tactical flexibility for Protection and Arms

#### Improved Pummel (Complete Rework)
- **Previous Effect:** 25/50% chance to daze for 4 seconds, extends spell-school lockout by 1/2 seconds
- **New Effect:** 50/100% chance to apply 50% movement speed slow for 4 seconds, extends spell-school lockout by 1/2 seconds
- **Impact:** More reliable slow application, guaranteed control utility at rank 2 (100% proc)

---

## Version 1.18.0 - Scars of the Past

### August 2025 Revision

#### Slam (Dual Wield Interaction)
- **Change:** Slam now resets the swing timer of your off-hand weapon
- **Impact:** CRITICAL for Dual Wield Warriors
  - Off-hand swing timer reset means Slam is less punishing for DW builds
  - Increases viability of Slam in Dual Wield Fury rotations
  - Attack speed value increases for DW Slam builds

#### Blood Craze / Enrage Dependency
- **Change:** Removed talent link dependency between Blood Craze and Enrage
- **Impact:** Quality of life change, allows taking Blood Craze without Enrage requirement

---

### Baseline Changes

#### Execute
- **Cooldown:** Removed (was 5.5 seconds)
- **Impact:** Execute spam restored, rage becomes primary limiting factor

---

### Arms Specialization

#### Master Strike (NEW - Replaces Counterattack)
- **Location:** Row 3 keystone, 1 point
- **Cost / Cooldown:** 20 rage, 30-second cooldown; deals 35% weapon damage plus weapon-specific rider
- **Weapon Effects:**
  - **Mace:** 3-second disorient (breaks on damage)
  - **Sword:** 3-second disarm
  - **Axe:** 4-second root
  - **Polearm:** Deals +100% weapon damage to mounted targets and dismounts them
  - **Fist:** 2-second knockdown
  - **Staff:** +25% parry chance for 10 seconds
  - **Dagger:** 3-second silence
- **Impact:** Massive utility upgrade; weapon swaps directly map to PvP control or PvE mitigation needs

#### Mortal Strike
- **Damage:** 105-120% weapon damage → 115-130% weapon damage
- **Impact:** Increased burst damage, weapon damage scaling improved

#### Slam
- **Damage:** 60-90% weapon damage → 65-100% weapon damage
- **Impact:** Improved rotational filler damage

#### Precision Cut (REWORK)
- **Previous:** +20/40/60% Execute extra rage damage
- **New Effect:** Increases Execute base damage by 15/30/45%
- **Impact:** Less reliant on rage pooling, more consistent Execute damage

---

### Fury Specialization

#### Flurry (REWORK)
- **Previous:** Attack speed increase after crit
- **New Additional Effect:** Also reduces Slam cast time
- **Impact:**
  - Critical strike enables faster Slam rotation
  - Slam becomes viable in Fury builds
  - Critical strike value increased further

#### Improved Execute (Renamed from Reckless Execute)
- **Previous Name:** Reckless Execute
- **New Effect:** Reduces Execute rage cost by 2/5 (reverted to Vanilla version)
- **Previous (December 20):** Rank 1 reduced CD by 1.5s, Rank 2 removed CD
- **Impact:** REVERT to Vanilla behavior
  - Cheaper Execute spam through rage cost reduction
  - Simpler talent design
  - Works with Execute cooldown removal (baseline 1.18.0)

#### Improved Berserker Rage (NEW)
- **Location:** Row 6, 2 points
- **Effect:** Berserker Rage generates 5/10 rage and has a 50/100% chance to break movement-impairing effects upon activation
- **Impact:** Restores the on-demand rage/freedom tool removed in 1.17.2 and supports sustained Enrage uptime

#### Battlefield Mobility (BUFF)
- **Change:** Still reduces Intercept cooldown and now also lowers Charge cooldown by 2/4 seconds
- **Impact:** Improves gap-closing cadence for Fury in both PvE and PvP

#### Blood Drinker (COMPLETE REWORK)
- **Previous:** Healed only on critical strikes after triggering during cooldowns
- **New Effect:** ALL attacks heal for 1/1.5/2% of maximum health while Enrage, Death Wish, or Recklessness is active
- **Impact:** MASSIVE sustain buff
  - No crit requirement; scales with attack speed and uptime
  - Stamina dramatically improves self-healing pool
  - Works with the new Improved Berserker Rage for frequent activation windows

#### Bloodthirst
- **Movement Speed:** +5% → +10% movement speed during Bloodthirst buff
- **Impact:** Quality of life, improved mobility

---

### Protection Specialization

#### Concussive Blow (MAJOR BUFF)
- **Rage Cost:** Removed (previously cost rage)
- **New Effect:** Generates 10 rage instantly when cast
- **Impact:** CRITICAL change for Protection
  - Excellent rage generation opener
  - Free stun + rage generation
  - Increases value of rage-generating stats less critical at pull
  - Better threat generation in early fight

---

## Stat Priority Impact Summary

### All Specializations (Baseline Changes)
1. **Attack Power:**
   - Rend scaling (5% AP per tick)
   - Shield Slam scaling (Protection)
   - Rage generation (90% gear-dependent)
2. **Weapon Damage/DPS:**
   - Rage generation formula heavily weighted toward damage dealt
   - Weapon speed less critical (normalization)
   - Raw DPS > speed in most cases
3. **Critical Strike:**
   - Deep Wounds proc trigger (Arms)
   - Enrage activation (Fury)
   - Rage generation through damage
4. **Hit Rating:**
   - 9% → 8% cap (see general scaling changes)
   - Heroic Strike queue change means off-hand swings now obey the hit table, amplifying hit rating value for dual wield
5. **Armor:**
   - 75% cap removed (see general changes)
   - Remains invaluable for Protection and smoothing incoming damage during high-Enrage windows

### Arms Priority Changes
1. **Critical Strike:**
   - Deep Wounds trigger (2x output speed outside raids)
   - Master of Arms (Axe): +5% crit
   - Rage generation for Execute spam
2. **Weapon Type Selection (Master of Arms):**
   - **Axe:** Critical strike builds (stacks with spec bonus)
   - **Mace:** High armor targets (ignores up to 360 armor at level 60 after December 20 nerf)
   - **Sword:** On-hit proc builds (extra attack)
   - **Polearm:** Utility/positioning (+1 yard range)
3. **Rage Generation Stats:**
   - Attack Power, Crit, Hit all feed rage pool
   - Boundless Anger: +30 max rage for Execute pooling
4. **Attack Power:**
   - Rend scaling, Execute scaling
   - Mortal Strike weapon damage scaling

### Fury Priority Changes
1. **Attack Speed/Haste:**
   - Unbridled Wrath procs (up to 75%, doubled for 2H)
   - Blood Drinker healing (1.18.0 - ALL attacks)
   - No Enrage swing cap (attack speed fully effective)
2. **Critical Strike:**
   - Enrage activation (15% damage buff, 8s duration)
   - Flurry trigger (enables fast Slam)
   - Rage generation
3. **Stamina:**
   - Blood Drinker healing pool (1–2% max HP per attack once reworked)
   - Improved Berserker Rage uptime rewards bigger health pools
   - Sustained soloing/raid survivability
4. **2-Handed vs Dual Wield:**
   - 2H: Doubled Unbridled Wrath (150% proc chance)
   - DW: More frequent attacks for Blood Drinker
5. **Attack Power:**
   - Rage generation (90% gear-dependent formula)
   - Direct damage scaling

### Protection Priority Changes
1. **Block Value:**
   - Shield Slam damage scaling (dual: AP + Block Value)
   - Primary threat generation stat
2. **Attack Power:**
   - Shield Slam damage scaling
   - Rend scaling for threat
   - Rage generation
3. **Armor:**
   - 75% cap removed (see general changes)
   - Unlimited scaling value for mitigation
4. **Hit Rating:**
   - Critical for threat consistency
   - Rage generation reliability
5. **Critical Strike:**
   - Rage generation
   - Threat spikes

---

## Critical Scaling Breakpoints

### Rage Generation Formula (Post-1.17.2)
- **90% Gear-Dependent:** Damage dealt = Attack Power, Crit, Hit, Weapon Damage
- **10% Predetermined:** Based on weapon speed (faster = higher rage per second)
- **Breakpoint Impact:**
  - Weapon DPS > Weapon Speed in most scenarios
  - Crit/Hit caps have major rage generation implications
  - AP scaling exponential (more damage = more rage = more abilities)

### Execute Phase Mechanics
- **Base Cooldown:** Removed in 1.18.0 (was 5.5s in 1.17.2)
- **Rage Limit:** Only constraint on Execute spam
- **Boundless Anger:** +30 max rage (100 → 130 cap)
- **Precision Cut:** +45% base Execute damage at max rank
- **Optimal Play:** Pool rage before execute phase, spam Execute without cooldown limit

### Enrage Uptime (Fury)
- **Duration:** 8 seconds (post-1.17.2 nerf)
- **Triggers:**
  - Critical strike (natural procs)
  - Bloodthirst cast (on-demand, cooldown-based)
  - Bloodrage use (on-demand, 1-minute cooldown)
- **Damage Bonus:** 15% physical damage (post-nerf)
- **Uptime Goal:** Near-permanent with proper cooldown rotation + critical strike rate

### Blood Drinker Healing (Fury 1.18.0)
- **Heal Amount:** 1-2% max HP per attack (during Enrage/Death Wish/Recklessness)
- **No Crit Requirement:** ALL attacks heal (not just crits)
- **Scaling:**
  - Attack Speed: More attacks = more healing
  - Stamina: Larger HP pool = larger absolute heals
  - Enrage Uptime: More time healing
- **Example:**
  - 5000 HP, 2% per attack, 2.0 attack speed = 100 HP per attack = 50 HP/s during Enrage
  - 8000 HP, 2% per attack, 1.5 attack speed = 160 HP per attack = 106.7 HP/s during Enrage

### Deep Wounds Output (Arms)
- **Tick Rate:** 1.5 seconds (post-1.17.2)
- **Duration:** 6 seconds = 4 ticks total
- **Damage Delivery:** 2x faster than vanilla (was 3s ticks)
- **Boss Armor:** Now reduces Deep Wounds (was unmitigated in vanilla)
- **Non-Boss Impact:** Effectively doubled damage output (armor typically lower)

### Weapon Type Selection (Arms Master of Arms)
- **Critical Decision Point:** Weapon type determines secondary scaling
  - **Axe Build:** Stack critical strike (inherent +5% crit)
  - **Mace Build:** Flat armor ignore (2/4/6/8/10 per level → 360 armor at 60 after nerf)
  - **Sword Build:** Stack on-hit procs/attack speed (5% extra attack chance)
  - **Polearm Build:** Utility focus (+0.4–2.0 yard range increase)

---

## Implementation Notes for ClassicHawsJon_small.lua

### High Priority Changes

1. **Rage Generation Formula (ALL Warriors):**
   - Weapon speed less important (10% vs 90% split)
   - Attack Power, Crit, Hit now 90% of rage generation
   - Weapon DPS primary weapon stat (not speed)
   - Impact: Increases value of AP, Crit, Hit for all Warriors

2. **Attack Power Scaling:**
   - **Rend:** 5% AP scaling per tick (baseline for all)
   - **Shield Slam:** AP + Block Value scaling (Protection)
   - **Execute:** Scales with AP through weapon damage
   - **Rage Generation:** 90% gear-dependent = AP value

3. **Critical Strike (Arms):**
   - Deep Wounds: 2x output speed outside raids, Boss armor applies
   - Master of Arms (Axe): +5% crit chance; Mace path ignores up to 360 armor at 60 (post-nerf)
   - Enrage trigger (if Fury talents taken)
   - Implement: +50-100% crit value for Arms depending on content

4. **Critical Strike (Fury):**
   - Enrage activation (15% damage buff, 8s duration)
   - Flurry trigger (enables fast Slam casting)
   - Rage generation
   - Implement: High crit priority for Enrage uptime

5. **Block Value (Protection):**
   - Shield Slam scales with Block Value + AP
   - Primary threat stat for Protection
   - Implement: Significantly increase Block Value weight

### Medium Priority Changes

1. **Attack Speed/Haste (Fury):**
   - Unbridled Wrath: 75% proc chance, doubled for 2H (150%)
   - Blood Drinker: Heal on ALL attacks (1-2% max HP)
   - No Enrage swing limit
   - Implement: High haste/attack speed value for Fury

2. **Stamina (Fury):**
   - Blood Drinker: 1–2% max HP healing per attack after 1.18.0
   - Improved Berserker Rage uptime benefits larger health pools
   - Implement: Moderate stamina value (sustain scaling)

3. **Armor Penetration (Arms - Mace Build):**
   - Master of Arms (Mace): Flat armor ignore (up to 360 at level 60 after nerf)
   - Concussion Blow: +50% armor penetration (100% post-Dec 20)
   - Implement: Conditional armor penetration value if using maces or deep Protection burst

4. **Weapon Type (Arms):**
   - Master of Arms bonuses are weapon-type dependent
   - Implement: Can't directly weight this, but documentation important
   - Note: Poleaxe Specialization (Fury) gives +5% crit with Axes/Polearms

### Low Priority Changes

1. **Execute Mechanics:**
   - Cooldown removed (1.18.0)
   - Rage pooling primary constraint
   - Boundless Anger: +30 max rage
   - Precision Cut: +45% base damage
   - Implement: Rage generation has increased value for execute phase

2. **Slam Integration:**
   - Baseline at level 14
   - Flurry reduces cast time (Fury)
   - Pauses (not resets) swing timer
   - Implement: Attack speed has slight value for Slam-focused builds

3. **Master Strike Utility (Arms):**
   - Weapon-dependent CC after parry with 20 rage cost
   - 30-second cooldown (post-1.18.0)
   - Implement: No direct stat scaling, utility-focused

4. **Improved Disciplines (Arms):**
   - Reduces Retaliation, Recklessness, and Shield Wall cooldowns by 4/8/12 minutes
   - Allows deep Arms builds to access frequent burst/defensive windows without talent swaps
   - Implement: Track for burst simulations but no direct stat weight change

---

## Sources

All information compiled from official Turtle WoW changelogs:
- `turtle-wow-changelogs/1.16.1.html` (lines 777-814)
- `turtle-wow-changelogs/1.17.2-warrior-changes.html` (complete file)
- `turtle-wow-changelogs/1.17.2-2024.10.21-changes.html` (Warrior hotfix - Improved Shield Slam)
- `turtle-wow-changelogs/1.17.2-2024.11.01-changes.html` (Warrior hotfixes)
- `turtle-wow-changelogs/1.17.2-2024.11.20-changes.html` (no Warrior changes)
- `turtle-wow-changelogs/1.17.2-2024.12.20-changes.html` (MAJOR Warrior update - lines 467-562)
- `turtle-wow-changelogs/1.17.2-2025.04.01-changes.html` (Concussion Blow buff, Improved Pummel rework)
- `turtle-wow-changelogs/1.18.0-warrior-changes.html` (complete file including August 2025 revision)

**Last Updated:** Based on changelogs through Patch 1.18.0 (Scars of the Past) including August 2025 revision, and all hotfixes through April 2025
