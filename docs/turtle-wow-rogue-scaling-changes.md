# Turtle WoW Rogue Scaling Changes

This document tracks all Rogue-specific changes from Turtle WoW that affect stat scaling and item valuation for the Pawn addon.

**Base Reference:** Vanilla 1.12.1 stat scaling is implemented in `ClassicHawsJon_small.lua`.

**Related Documentation:** See `turtle-wow-general-scaling-changes.md` for non-class-specific changes (weapon skill rework, hit cap changes, armor cap removal, etc.).

---

## Version 1.16.1 - First Class Changes

### New Abilities

#### Deadly Throw
- **Type:** Finishing move
- **Energy Cost:** 30
- **Range:** 8-30 yards
- **Cooldown:** Equal to ranged weapon speed
- **Damage by Combo Points:**
  - 1 point: 132-228
  - 2 points: 216-312
  - 3 points: 300-396
  - 4 points: 384-480
  - 5 points: 468-564
- **Impact:** Ranged finishing move, scales with thrown weapon damage

#### Agitating Poison
- **Level:** 60
- **Duration:** 30 minutes
- **Proc Chance:** 20%
- **Damage:** 67-85 Nature damage
- **Effect:** Causes additional threat
- **Charges:** 115
- **Impact:** Tank utility poison

#### Flourish
- **Level:** 42
- **Energy Cost:** 25
- **Type:** Finishing move
- **Effect:** +20% parry chance
- **Duration by Combo Points:**
  - 1 point: 3 seconds
  - 2 points: 4 seconds
  - 3 points: 5 seconds
  - 4 points: 6 seconds
  - 5 points: 7 seconds
- **Impact:** Tank utility finisher, avoidance scaling

---

### Talent Changes

#### Close Quarters Combat (NEW - Combat Tier 4)
- **Replaces:** Dagger Specialization + Fist Weapon Specialization
- **Effect:** +1/2/3/4/5% crit chance with Daggers and Fist Weapons
- **Impact:** Critical strike value increased for dagger/fist weapons

#### Throwing Weapon Specialization (NEW - Combat Tier 5)
- **Effect:** Increases range of throwing weapons by 3/6 yards
- **Impact:** Range extension for Deadly Throw

#### Improved Sap (Buffed - Subtlety Tier 4)
- **Effect:** 50/100% chance to return to stealth after Sap
- **Impact:** Quality of life, stealth management

---

## Version 1.17.0

### Baseline Changes

#### Flourish
- **Change:** Now has 40 second cooldown
- **Reason:** Prevent avoidance capping, addressed rogue tanking exploits
- **Impact:** Limited uptime for avoidance scaling

---

## Version 1.17.2 - Mysteries of Azeroth

### Baseline Changes

#### Combo Points
- **Change:** No longer vanish upon switching targets
- **Mechanic:** Reset when applying combo points on new target
- **Impact:** Quality of life, maintains DPS rotation flexibility

#### Weapon Proficiency
- **Change:** Rogues can now wield One-Handed Axes
- **Impact:** More weapon options, increased itemization flexibility

#### Ghostly Strike
- **Change:** Now baseline at level 20 (was Subtlety talent)
- **Impact:** All Rogues gain +15% dodge for 7 seconds baseline

#### Heightened Senses
- **Change:** Now baseline at level 30
- **Effect:** Stealth detection increase (fully talented version)
- **Nerf:** No longer reduces chance to be hit by attacks
- **Impact:** Stealth detection utility baseline

#### Sinister Strike
- **Energy Cost:** 45 → 40
- **Reason:** Improved Sinister Strike went baseline
- **Impact:** Energy efficiency improved for primary rotational ability

#### Corrosive Poison (NEW)
- **Levels:** Rank 1 (56), Rank 2 (60/Book)
- **Proc Chance:** 30%
- **Damage:** 100 (R1), 128 (R2) Physical damage over 12 seconds
- **Stacks:** Up to 5 times
- **Charges:** 105
- **Key Feature:** Bypasses Nature and poison immunities (Physical damage)
- **Impact:** CRITICAL - poison damage reliable against all targets

#### Sprint and Evasion
- **Cooldown:** 5 minutes → 4 minutes
- **Reason:** Endurance talent removed
- **Impact:** More frequent defensive/mobility cooldowns

#### Wound Poison (Reworked)
- **Previous:** Reduced target's healing power attribute
- **New:** Reduces effectiveness of ANY healing by 5% per stack
- **Max Stacks:** 5 (25% healing reduction)
- **Envenom Boost:** 6.25% per stack (31.25% total at 5 stacks)
- **Impact:** CRITICAL - counters ALL healing sources including potions, not just healing power

#### Crippling Poison
- **Rank 2 Slow:** 70% → 60%
- **Envenom Boost:** 75% slow at 60% base
- **Impact:** Slightly reduced slow baseline, still strong with Envenom

---

### Assassination Specialization

#### Remorseless Attacks
- **Duration:** 20 seconds → 40 seconds
- **Impact:** Longer damage buff window

#### Ruthlessness
- **Proc Chance:** 20/40/60% → 33/66/100%
- **Impact:** More reliable extra combo point generation

#### Improved Slice and Dice → Improved Blade Tactics
- **Change:** Renamed for clarity
- **Effect:** Also includes Flourish duration increase by 15/30/45%
- **Impact:** Clarification, benefits tank rogues

#### Throwing Weapon Specialization (Moved)
- **Location:** Combat Tier 5 → Assassination Tier 4
- **New Effect:** Deadly Throw has 50/100% chance to interrupt for 3 seconds
- **Impact:** Assassination gains ranged interrupt utility

#### Vile Poisons (Buffed)
- **Points Required:** 5 → 3
- **Impact:** Easier access to poison damage increase

#### Improved Poisons (Buffed)
- **Points Required:** 5 → 3
- **Impact:** Easier access to poison proc chance

#### Improved Kidney Shot → Taste For Blood (NEW)
- **Location:** Tier 5, 3 points
- **Effect:** Casting Rupture grants +3/6/10% damage for 6 sec + 2 sec per combo point
- **Duration:** 12/14/16/18/20 seconds (1-5 CP)
- **Impact:** New damage amplifier tied to Rupture usage

#### Efficient Poisons (NEW - Tier 5)
- **Points:** 3
- **Effect:**
  - Reduces chance for poisons to be resisted by 4/8/12%
  - 15/30/45% chance to not consume a poison charge
- **Impact:** Poison reliability and charge efficiency

#### Vigor (Moved and Reworked)
- **Location:** Tier 7 → Tier 6
- **Points:** 1 → 2
- **New Effect:** 50/100% chance to gain 5 Energy when applying poison
- **Cooldown:** 8 seconds per proc
- **Impact:** Energy generation tied to poison application, competes with Adrenaline Rush

#### Envenom (NEW Capstone - Tier 7)
- **Type:** Finishing move
- **Energy Cost:** 25
- **Effect:** Increases poison application chance and effectiveness by 25%
- **Duration by Combo Points:**
  - 1 point: 12 seconds
  - 2 points: 16 seconds
  - 3 points: 20 seconds
  - 4 points: 24 seconds
  - 5 points: 28 seconds
- **Impact:** CRITICAL - amplifies all poison damage, slow, and healing reduction by 25%

---

### Combat Specialization

#### Improved Sinister Strike
- **Change:** Now baseline
- **Replaced By:** Swift Strikes (see below)
- **Impact:** Energy efficiency baseline for all Rogues

#### Swift Strikes (NEW - Tier 1)
- **Points:** 2
- **Effect:** +1/2% melee attack speed
- **Impact:** Attack speed scaling, minor DPS increase

#### Improved Backstab (Buffed)
- **New Effect:** Also gives Backstab 15/30/45% chance to award additional combo point
- **Impact:** Combo point generation for dagger builds

#### Setup (Moved)
- **Location:** Subtlety Tier 4 → Combat Tier 3
- **Impact:** Accessible to Combat for combo point generation

#### Blade Flurry (Moved)
- **Location:** Tier 5 → Tier 3
- **Change:** No longer grants 20% attack speed baseline
- **Reason:** Make cleave available to all specs
- **Impact:** All specs can access AoE cleave

#### Mace Specialization → Concussive Blows
- **Location:** Tier 5 → Tier 4
- **Change:** No longer grants weapon skill to Maces
- **Reason:** Maces now in Close Quarters Combat, stun interfered with fights
- **Impact:** Stun effect separated from weapon specialization

#### Close Quarters Combat (Buffed)
- **Points:** 5 → 2
- **New Inclusion:** Also includes Maces
- **Effect:** +2/5% crit chance with Daggers, Fist Weapons, and Maces
- **Impact:** Critical strike highly valuable for these weapon types

#### Surprise Attack (NEW - Tier 5 Capstone)
- **Type:** Reactive attack (like Heroic Strike)
- **Trigger:** Only usable after target dodges
- **Damage:** 120% weapon damage
- **Energy Cost:** 10
- **Cooldown:** 10 seconds
- **Combo Points:** Awards 1
- **Impact:** Active playstyle reward for dodge tracking

#### Sword Specialization → Hack and Slash (Reworked)
- **Points:** 5 → 2
- **New Inclusion:** Also includes Axes
- **Effect:** 2/5% chance for extra attack with Swords or Axes
- **Impact:** Proc-based DPS for sword/axe weapons

#### Blade Rush (NEW - Tier 5)
- **Points:** 2
- **Effect:**
  - Reduces Blade Flurry cooldown by 30/60 seconds
  - Blade Flurry grants 5/10% attack speed during duration
- **Impact:** Attack speed and AoE uptime for Combat

#### Weapon Expertise (Buffed)
- **Change:** Now also grants weapon skill to Maces
- **Impact:** Mace hit chance improved

#### Aggression (Buffed)
- **Damage Buff:** 2/4/6% → 3/6/10%
- **New Inclusion:** Also includes Riposte and Surprise Attack
- **Impact:** Significant damage amplifier for Combat abilities

---

### Subtlety Specialization (MAJOR REWORK - Support Focus)

**Design Philosophy:** Transformed from pure damage to damage + party support specialization

#### Master of Deception
- **Change:** Merged into Camouflage
- **Impact:** Stealth bonuses consolidated

#### Camouflage (Buffed)
- **Location:** Tier 2 → Tier 1
- **New Effect:** Also reduces chance for enemies to detect stealth
- **Impact:** Stealth detection resistance

#### Sleight of Hand
- **Change:** Removed

#### Improved Ambush (Moved and Buffed)
- **Location:** Tier 3 → Tier 2
- **New Effect:** Refunds 5/10/15 Energy if Ambush does not crit
- **Impact:** Energy efficiency for non-crit openers

#### Serrated Blades (Moved and Buffed)
- **Location:** Tier 4 → Tier 2
- **New Effect:** Also increases Garrote damage by 10/20/30%
- **Impact:** DoT damage scaling

#### Initiative (Buffed)
- **Proc Chance:** 25/50/75% → 33/66/100%
- **Impact:** Reliable combo point on crit openers

#### Ghostly Strike
- **Change:** Now baseline (see Baseline Changes)

#### Improved Ghostly Strike (NEW - Tier 3)
- **Points:** 3
- **Effect:** Ghostly Strike has 33/66/100% chance to increase party dodge by 3% for 7 seconds
- **Impact:** Party-wide avoidance buff, support utility

#### Smoke Bomb (NEW Keystone - Tier 3)
- **Cooldown:** 5 minutes
- **Energy Cost:** 35
- **Effect:** 8 yard radius smoke cloud, 20% reduced hit chance for all targets inside for 8 seconds
- **Impact:** Party-wide damage reduction cooldown

#### Hemorrhage (Moved and Reworked)
- **Location:** Tier 5 → Tier 3
- **Ranks:** Multiple ranks → 1 rank
- **Effect:** +2% physical damage dealt (was flat value)
- **Charges:** 30 → 50
- **Energy Cost:** 35 → 45
- **Change:** Subject to weapon normalization
- **Impact:** CRITICAL - party-wide physical damage amplifier, scales to end

#### Irritating Agent (NEW - Tier 4)
- **Points:** 3
- **Effect:** Blind reduces target damage dealt by 2/4/6% for 8 seconds
- **Key:** Applied even if Blind is resisted or target is immune
- **Impact:** Boss debuff utility, guaranteed application

#### Blinding Haze (NEW - Tier 4)
- **Points:** 3
- **Effect:** Distract reduces target hit chance by 2/4/6% for 5 seconds
- **Key:** Guaranteed application
- **Impact:** Hit chance debuff for bosses

#### Heightened Senses
- **Change:** Now baseline (see Baseline Changes)

#### Dust of Disappearance (NEW Keystone - Tier 5)
- **Cooldown:** 2 minutes
- **Range:** 30 yards
- **Energy Cost:** 25
- **Cost:** 1 Flash Powder
- **Effect:**
  - Reduces friendly player threat by 20%
  - Reduces detection chance for 5 seconds
  - Next damaging spell/ability deals 15% more damage
- **Impact:** Threat management + damage buff for party member

#### Bloody Mess (NEW - Tier 5)
- **Points:** 2
- **Effect:**
  - Reduces Hemorrhage energy cost by 5/10
  - Increases Hemorrhage physical damage bonus by 50/100%
- **Impact:** Hemorrhage becomes 3-4% party physical damage buff

#### Deadliness
- **Change:** Removed

#### Honor Among Thieves (NEW - Tier 6)
- **Points:** 2
- **Effect:** Party physical crits within 20 yards grant 2/5 Energy
- **Cooldown:** 2 seconds per proc
- **Impact:** Energy generation from party DPS

#### Tricks of the Trade (NEW - Tier 6)
- **Points:** 5
- **Effect:** Opening/finishing moves have 4/8/12/16/20% chance per combo point to increase party crit by 2% for 10 seconds
- **Stacks:** Up to 2 times (4% max)
- **Impact:** Party-wide critical strike buff

#### Premeditation
- **Change:** Removed

#### Exploit Vulnerability (NEW Capstone - Tier 7)
- **Cooldown:** 3 minutes
- **Energy Cost:** 40
- **Damage:** 135% weapon damage
- **Combo Points:** Awards 2
- **Effect:** Party members deal 15% more damage to target for 6 seconds
- **Impact:** CRITICAL - massive party-wide damage amplifier

---

## Version 1.17.2 - Hotfixes

### October 21, 2024

#### Improved Backstab
- **Clarification:** Documentation of additional combo point chance (already mentioned above)

#### Close Quarters Combat
- **Change:** Points 5 → 2, effect +2/5% crit (documented above)

#### Hack and Slash
- **Change:** Points 5 → 2, effect 2/5% extra attack (documented above)

---

### November 1, 2024

#### Throwing Weapon Specialization (Reworked)
- **Previous:** 50/100% interrupt chance
- **New:** 10/20% chance per combo point to interrupt
- **Impact:** Scales with combo points spent on Deadly Throw

#### Surprise Attack (Buffed)
- **Change:** Can no longer be blocked, dodged, or parried
- **Impact:** Guaranteed to land, reliable combo point generation

---

### December 20, 2024

#### Relentless Strikes (Major Buff)
- **Energy Return:** 25 → 20
- **New Effect:** Increases finisher damage by 5% per stack
- **Max Stacks:** 5 (25% finisher damage increase)
- **Duration:** 30 seconds
- **Impact:** CRITICAL - stacking damage amplifier for all finishers

#### All Finishers (QoL Buff)
- **Energy Cost:** Reduced by 5 for all finishers
- **Affected:** Eviscerate, Envenom, Deadly Throw, Flourish, Slice and Dice, Expose Armor, Rupture, Kidney Shot
- **Impact:** More responsive finisher usage, less energy waiting

#### Instant Poison (Attack Power Scaling)
- **New Scaling:** Gains damage equal to 5% of Attack Power
- **Impact:** CRITICAL - poison damage now scales with gear

#### Deadly and Corrosive Poison (Attack Power Scaling)
- **New Scaling:** Gains damage equal to 2% of AP per tick (8% total for full duration per stack)
- **Impact:** CRITICAL - DoT poisons scale with gear

#### Tricks of the Trade (Buffed)
- **Duration:** 10 seconds → 12 seconds
- **Impact:** Slightly longer crit buff window

#### Surprise Attack (Complete Rework)
- **Previous:** 120% weapon damage queued attack
- **New:** Instant attack dealing 25% of Attack Power
- **Impact:** More reactive, AP scaling instead of weapon damage

#### Adrenaline Rush (Major Buff)
- **Cooldown:** 5 minutes → 3 minutes
- **Impact:** More frequent 100% energy regen cooldown

#### Blade Rush (Buffed)
- **Cooldown Reduction:** 30/60 seconds → 15/30 seconds
- **Attack Speed Bonus:** 5/10% → 10/20%
- **Impact:** Stronger attack speed scaling for Blade Flurry

---

### April 1, 2025

#### Hemorrhage (Buff)
- **Weapon Damage:** 100% → 110%
- **Impact:** Better personal damage for Subtlety support

#### Deadly Throw (COMPLETE REWORK)
- **Previous:** Finishing move spending combo points
- **New Mechanics:**
  - No longer spends combo points
  - Energy cost: 35 → 40
  - Deals 100% weapon damage
  - Shares cooldown with Kick
  - Interrupts target for 3 seconds baseline
- **Impact:** CRITICAL - becomes ranged interrupt tool instead of finisher

#### Throwing Weapon Specialization (Reworked)
- **Previous:** Combo point-scaled interrupt chance
- **New Effect:** 50/100% chance to apply off-hand weapon poison with Deadly Throw
- **Range Increase:** Unchanged (3/6 yards)
- **Impact:** Poison application from range, synergizes with Assassination

#### Vile Poisons (Buffed)
- **Damage Bonus:** 7/14/20% → 10/20/30%
- **Impact:** Significant poison damage increase

#### Envenom (Buffed)
- **Effectiveness Bonus:** 25% → 30%
- **Impact:** Poisons amplified more during Envenom

---

## Version 1.18.0 - Scars of the Past

### Baseline Changes

#### Quickfooted (NEW Passive)
- **Learned:** Level 30
- **Effect:** +7% movement speed
- **Stacking:** Stacks with other movement speed effects
- **Impact:** Permanent mobility increase baseline

#### Blade Flurry (Major Rework)
- **Change:** Now baseline at level 30
- **Mechanic:** Toggle ability (no longer cooldown-based)
- **Cooldown:** 2 minutes → 4 seconds
- **Duration:** Removed (stays active until toggled off)
- **Penalties:**
  - -30% energy generation
  - -20% damage dealt
- **Effect:** Cleave to nearby target
- **Impact:** CRITICAL - AoE available to all specs, requires energy management decision-making

#### Expose Armor (Earlier Access)
- **Level Changes:**
  - Rank 1: 14 → 10
  - Rank 2: 26 → 22
  - Rank 3: 36 → 34
  - Rank 4: Unchanged (46)
  - Rank 5: Unchanged (56)
- **Impact:** Earlier armor reduction access

#### Dissolvent Poison (NEW)
- **Levels:** Rank 1 (52), Rank 2 (60)
- **Proc Chance:** 20%
- **Damage:**
  - Rank 1: 88-113 Physical damage
  - Rank 2: 106-142 Physical damage
- **Charges:** 100 (R1), 115 (R2)
- **Key Feature:** Ignores armor, Physical damage
- **Attack Power Scaling:** 4.75% (5% lower than Instant Poison)
- **Impact:** Physical burst poison for armor-heavy targets

#### Blind (Debuff Type Change)
- **Previous:** Poison effect
- **New:** Physical effect
- **Reason:** Reduce cleansability (insignias remove all CC)
- **Impact:** More reliable CC in PvP

---

### Assassination Specialization

#### Remorseless Attacks (Buffed)
- **New Inclusion:** Also includes Hemorrhage, Noxious Assault, Surprise Attack
- **Impact:** All combo generators benefit

#### Lethality (Buffed)
- **New Inclusion:** Also includes Noxious Assault and Surprise Attack
- **Impact:** All combo generators benefit from crit damage

#### Corrosive Poison (Nerf)
- **Attack Power Scaling:** Reduced by 5%
- **Reason:** Too close to Deadly Poison damage, reduce dominance
- **Impact:** Deadly Poison more competitive for Nature-vulnerable targets

#### Throwing Weapon Specialization (Moved)
- **Location:** Tier 4 → Tier 3
- **Impact:** Earlier access

#### Relentless Strikes (Buffed)
- **New Effect:** Also increases Shadow of Death damage by 5% per stack
- **Impact:** Synergy with Subtlety capstone

#### Taste For Blood (Moved and Reworked)
- **Location:** Tier 5 → Tier 4
- **New Effect:**
  - Increases Physical damage by 1/2/3% per combo point (was 3/6/10% flat)
  - Increases Rupture duration by 2/4/6 seconds
  - Buff duration also increased by Rupture duration extension
- **Max Effect:** 15% physical damage at 5 CP
- **Duration:** 18-26 seconds (6 base + 2/CP + 2-6 from talent)
- **Impact:** CRITICAL - better scaling, encourages high CP Rupture

#### Envenom (Moved)
- **Location:** Tier 7 → Tier 5
- **Impact:** Earlier capstone access

#### Vigor (Reworked)
- **Cooldown:** Removed (was 8 seconds)
- **Energy Gain:** 5 → 2 per proc
- **Impact:** Higher proc frequency, better energy throughput overall

#### Noxious Assault (NEW Capstone - Tier 7)
- **Type:** Combo point generator
- **Energy Cost:** 45
- **Damage:** 35% of Attack Power + 30/55/85/105 (rank-dependent)
- **Effect:** Dual wield strike, applies poisons from both weapons
- **Combo Points:** Awards 1
- **Ranks:** Level 40 (Talent), 48, 56, 60 (Book)
- **Impact:** CRITICAL - constant poison application, works with all weapon types

---

### Combat Specialization

#### Swift Strikes
- **Change:** Removed

#### Improved Expose Armor (Moved)
- **Location:** Tier 3 Assassination → Tier 1 Combat
- **Impact:** Easier access for all specs to improved armor reduction

#### Blade Flurry
- **Change:** Now baseline (see Baseline Changes)

#### Blade Rush (Complete Rework)
- **Location:** Tier 5 → Tier 6
- **New Effect:**
  - +2/5% melee attack speed
  - Reduces time between Energy regeneration ticks by amount equal to Agility
- **Impact:** CRITICAL - Agility now directly affects energy generation via tick speed

#### Combat Expertise (Moved)
- **Location:** Tier 6 → Tier 5
- **Impact:** Repositioning for talent tree flow

---

### Subtlety Specialization

#### Improved Ghostly Strike (Reworked)
- **Previous:** Party dodge buff
- **New Effect:**
  - Increases your movement speed by 5/10/15%
  - Increases party movement speed by 2/4/6% for 5 seconds (30 yard range)
  - Reduces Ghostly Strike energy cost by 3/6/10
- **Impact:** Mobility buff instead of dodge, energy efficiency

#### Improved Sap → Blackjack (Merged and Buffed)
- **Points:** 3 → 2
- **New Name:** Blackjack
- **Integrated:** Irritating Agent functionality
- **Damage Reduction:** 6% → 10%
- **New Effect:** Sap and Blind reduce target damage by 5/10% for 8 seconds when effect ends or fails
- **Stealth Return:** 50/100% chance to return to stealth after Sap
- **Impact:** Boss damage reduction, works even on immune targets

#### Smoke Bomb
- **Change:** Updated icon (cosmetic)

#### Hemorrhage (Energy Cost Reduction)
- **Energy Cost:** 45 → 40
- **Reason:** High base cost made it hard to use before Bloody Mess
- **Impact:** Earlier viability as combo generator

#### Bloody Mess (Adjusted)
- **Energy Cost Reduction:** 5/10 → 2/5
- **Reason:** Compensate for Hemorrhage base cost reduction
- **Impact:** Total energy cost: 40 → 35/38 with talent

#### Irritating Agent
- **Change:** Removed (merged into Blackjack)

#### Cloaked in Shadows (NEW - Tier 4)
- **Points:** 2
- **Effect:** Vanish grants party members within 20 yards a shield for 20 seconds
- **Shield Amount:** 6/12% of rogue's maximum health
- **Impact:** Party survivability utility, Health scaling

#### Blinding Haze (Buffed)
- **New Effect:** Reduces Distract energy cost by 5/10/15
- **Duration:** 5 seconds → 6 seconds
- **Impact:** Energy efficiency for support rotation

#### Preparation (Buffed)
- **Cooldown:** 10 minutes → 7 minutes
- **Impact:** More frequent cooldown reset for support abilities

#### Dust of Disappearance
- **Change:** Removed

#### Shadow of Death (NEW Keystone - Tier 5)
- **Type:** Finishing move
- **Cooldown:** 1 minute
- **Energy Cost:** 30
- **Duration:** 6 seconds
- **Mechanic:** Sigil accumulates damage
  - Stores percentage of ALL damage taken by target
  - Max capacity: percentage of rogue's Attack Power
  - Both scale per combo point
  - Deals stored damage when full or expires
- **Values by Combo Points:**
  - 1 point: 50% AP cap, 10% damage accumulated
  - 2 points: 100% AP cap, 20% damage accumulated
  - 3 points: 150% AP cap, 30% damage accumulated
  - 4 points: 200% AP cap, 40% damage accumulated
  - 5 points: 250% AP cap, 50% damage accumulated
- **Impact:** CRITICAL - converts party damage buffs into personal burst, scales with AP and party DPS

#### Honor Among Thieves (Buffed)
- **New Effect:** Also triggers from your own crits
- **Cooldown:** 2 seconds → 1.5 seconds
- **Impact:** Energy generation from own and party crits

#### Mark for Death (Previously Exploit Vulnerability - Reworked)
- **Name Change:** Exploit Vulnerability → Mark for Death
- **Duration:** 6 seconds → 8 seconds
- **Previous Effect:** +15% damage dealt
- **New Effect:**
  - Party Attack Power: +30% of rogue's melee AP
  - Party Spell Power: +18% of rogue's melee AP
- **Additional:** Cannot be blocked, dodged, or parried
- **Impact:** CRITICAL - scales with gear, converts AP into party buffs

---

### August 2025 Revision (1.18.0 Hotfix)

#### Lethality
- **Change:** Now includes Surprise Attack and Noxious Assault
- **Description:** Updated to say "Combo Point generating ability"
- **Impact:** All combo generators benefit from crit damage

#### Talent Position Changes
- **Opportunity:** Moved to Combat Tier 1
- **Improved Gouge:** Moved to Subtlety Tier 1
- **Improved Expose Armor:** Moved to Subtlety Tier 1
- **Impact:** Talent tree accessibility adjustments

---

## Version 1.18.1 - Poison Scaling Nerfs

### General Changes

#### Poison Attack Power Scaling Nerfs (Lower Ranks)

**Deadly Poison:**
- **Rank 1-3:** AP scaling removed entirely (was 2%/tick)
- **Rank 4:** AP scaling 2%/tick → 1%/tick (8% → 4% total)
- **Impact:** Lower level poison builds significantly weaker; max rank still viable at 2%/tick

**Instant Poison:**
- **Rank 1:** AP scaling 5% → 0%
- **Rank 2-3:** AP scaling 5% → 1%
- **Rank 4-5:** AP scaling 5% → 2%
- **Max Rank (6):** Unchanged at 5% AP scaling
- **Impact:** Leveling poison builds nerfed; endgame unchanged

**Corrosive Poison:**
- **Rank 1:** AP scaling 1.9%/tick → 1%/tick (7.6% → 4% total)
- **Max Rank:** Unchanged
- **Impact:** Lower rank less competitive with Deadly Poison

**Dissolvent Poison:**
- **Rank 1:** AP scaling 4.75% → 2%
- **Max Rank:** Unchanged at 4.75% AP scaling
- **Impact:** Lower rank significantly weaker

#### Blade Flurry (Toggle Penalty Reduction)
- **Energy Regen Penalty:** 30% → 20%
- **Damage Penalty:** Unchanged at 20%
- **Impact:** AoE situations less punishing for energy management

---

### Assassination Specialization

#### Taste for Blood (Nerf)
- **Physical Damage Bonus:** 1/2/3% per combo point → 1/1.5/2% per combo point
- **Max Effect:** 15% at 5 CP → 10% at 5 CP
- **Change:** No longer affects Corrosive Poison or Dissolvent Poison damage
- **Impact:** Reduced physical damage amplification; Physical poisons no longer benefit

#### Noxious Assault (Nerf)
- **AP Scaling:** 35% → 30%
- **Impact:** Reduced direct damage from primary Assassination combo generator

---

### Combat Specialization

#### Opportunity (Nerf)
- **Damage Bonus:** 4/8/12/16/20% → 3/6/9/12/15%
- **Impact:** Reduced damage from abilities used from behind or while stealthed

---

## Stat Priority Impact Summary

### All Specializations
1. **Attack Power:**
   - Poison scaling (max rank): Instant (5%), Deadly/Corrosive (8% per stack), Dissolvent (4.75%)
   - Lower poison ranks significantly weaker (1.18.1 nerfs)
   - Surprise Attack: 25% AP scaling
   - Noxious Assault: 30% AP scaling (Assassination, nerfed from 35% in 1.18.1)
   - Shadow of Death: 50-250% AP capacity (Subtlety)
   - Mark for Death: Converts 30% AP to party AP, 18% to spell power
2. **Energy Management:**
   - Blade Flurry: -20% energy regen when active (reduced from 30% in 1.18.1)
   - Blade Rush: Agility reduces energy tick time (1.18.0)
   - Vigor: Energy per poison application
   - Honor Among Thieves: Energy from crits
3. **Movement Speed:**
   - Quickfooted: +7% baseline (1.18.0)
   - Permanent mobility increase

### Assassination Priority Changes
1. **Attack Power:**
   - All poisons scale with AP (December 2024), lower ranks nerfed (1.18.1)
   - Instant: 5% AP per proc (max rank only; R1=0%, R2-3=1%, R4-5=2%)
   - Deadly/Corrosive: 8% AP per full stack (max rank; R4 Deadly=4%, R1-3 Deadly=0%)
   - Dissolvent: 4.75% AP per proc (max rank; R1=2%)
   - Noxious Assault: 30% AP direct damage (nerfed from 35% in 1.18.1)
2. **Critical Strike:**
   - Relentless Strikes: Finisher damage +5% per stack (max 25%)
   - Lethality: Crit damage for all combo generators
3. **Energy Efficiency:**
   - All finishers: -5 energy cost
   - Noxious Assault: 45 energy but double poison application
   - Vigor: Energy generation from poison procs

### Combat Priority Changes
1. **Attack Speed:**
   - Swift Strikes: +1/2% (removed in 1.18.0)
   - Blade Rush: +2/5% + Agility-based energy regen
   - Blade Flurry: +10/20% during active (talent)
2. **Weapon Damage:**
   - Surprise Attack: Was 120% weapon damage, now 25% AP
   - Deadly Throw: 100% weapon damage (April 2025)
   - Extra attacks: Hack and Slash 2/5% proc
3. **Agility (NEW - 1.18.0):**
   - Blade Rush: Agility reduces energy tick time
   - Direct energy generation scaling
4. **Critical Strike:**
   - Close Quarters Combat: +2/5% crit for daggers/fist/maces
   - Improved Backstab: Combo point gen on Backstab

### Subtlety Priority Changes
1. **Attack Power:**
   - Mark for Death: 30% AP → party AP, 18% → party spell power
   - Shadow of Death: 50-250% AP capacity based on combo points
   - Hemorrhage: 110% weapon damage
2. **Health (NEW):**
   - Cloaked in Shadows: Shield = 6/12% of rogue's max health
   - Party survivability scales with rogue Health stat
3. **Support Multipliers (NOT DIRECT STATS):**
   - Hemorrhage: +2% party physical damage (3-4% with Bloody Mess)
   - Tricks of the Trade: +2-4% party crit
   - Mark for Death: AP/SP based on rogue's AP
   - Exploit Vulnerability: +15% party damage (removed in 1.18.0)

---

## Critical Scaling Breakpoints

### Poison Attack Power Scaling (December 2024 - Present, Nerfed 1.18.1)
- **Instant Poison (Max Rank):** 5% AP per proc
  - Lower ranks: R1=0%, R2-3=1%, R4-5=2% (1.18.1 nerf)
- **Deadly Poison (Max Rank):** 2% AP per tick × 4 ticks = 8% AP per stack
  - 5 stacks = 40% AP total
  - Lower ranks: R1-3=0%, R4=1%/tick (4% total) (1.18.1 nerf)
- **Corrosive Poison (Max Rank):** 2% AP per tick × 4 ticks = 8% AP per stack
  - Lower ranks: R1=1%/tick (4% total) (1.18.1 nerf)
- **Dissolvent Poison (Max Rank):** 4.75% AP per proc (1.18.0)
  - Lower ranks: R1=2% (1.18.1 nerf)
- **Impact:** Attack Power primary stat for endgame poison damage; leveling builds significantly weaker

### Envenom Amplification
- **Base:** 30% increased poison effectiveness (April 2025, was 25%)
- **Combined with AP Scaling:**
  - Instant Poison: 5% × 1.30 = 6.5% AP per proc
  - Deadly/Corrosive: 8% × 1.30 = 10.4% AP per stack (52% for 5 stacks)
- **Duration:** 12-28 seconds (1-5 CP)
- **Impact:** Massive AP scaling multiplier during Envenom

### Relentless Strikes Stacking (December 2024 - Present)
- **Finisher Damage:** +5% per stack, max 5 stacks = 25%
- **Duration:** 30 seconds
- **Affected Finishers:** Eviscerate, Envenom, Deadly Throw (pre-rework), Flourish, Rupture
- **Shadow of Death:** Also benefits (1.18.0)
- **Impact:** Sustained finisher usage = permanent 20-25% damage increase

### Blade Rush Agility Scaling (1.18.0)
- **Mechanic:** Agility reduces time between energy ticks
- **Base Energy Tick:** 2 seconds (10 energy per tick = 5 energy/sec)
- **With Blade Rush:** Tick time reduced by agility value
- **Example:** 300 Agility with rank 2 Blade Rush
  - Base: 2.0 second ticks
  - Modified: Reduced by agility amount (exact formula TBD)
  - Result: More energy per second
- **Impact:** Agility becomes energy generation stat, not just crit/dodge

### Party Damage Amplification (Subtlety)
- **Hemorrhage:** +2% physical damage (3-4% with Bloody Mess)
  - 50 charges, permanent uptime
- **Tricks of the Trade:** +2-4% crit chance
  - 12 second duration, high uptime with good rotation
- **Mark for Death:** Party gains 30% of rogue AP as AP, 18% as spell power
  - 8 second duration, 3 minute cooldown (2 min with Preparation)
- **Combined Example:** 2000 AP Rogue
  - Party gains: 600 AP or 360 spell power
  - With Hemorrhage: +3% physical damage
  - With Tricks: +4% crit
  - Overall party DPS increase: 10-15%

---

## Implementation Notes for ClassicHawsJon_small.lua

### High Priority Changes

1. **Poison Attack Power Scaling (December 2024, Nerfed 1.18.1):**
   - Instant Poison: 5% AP per proc (max rank only)
     - Lower ranks: R1=0%, R2-3=1%, R4-5=2% (1.18.1)
   - Deadly Poison: 2% AP per tick (8% total per stack, max rank only)
     - Lower ranks: R1-3=0%, R4=1%/tick (4% total) (1.18.1)
   - Corrosive Poison: 2% AP per tick (8% total per stack), reduced by 5% in 1.18.0
     - Lower ranks: R1=1%/tick (4% total) (1.18.1)
   - Dissolvent Poison: 4.75% AP scaling per proc (1.18.0, max rank only)
     - Lower ranks: R1=2% (1.18.1)
   - Critical: Attack Power primary for endgame; leveling builds significantly weaker

2. **Envenom Amplification:**
   - 30% increased poison effectiveness (damage, slow, healing reduction)
   - Duration: 12-28 seconds based on combo points
   - Multiplies with poison AP scaling
   - Critical: Massive stat value multiplier during uptime

3. **Relentless Strikes Finisher Buff:**
   - +5% finisher damage per stack, max 5 stacks (25% total)
   - Duration: 30 seconds
   - Critical: Permanent damage amplifier with proper rotation

4. **Blade Rush Agility Scaling (1.18.0):**
   - Agility reduces energy tick time
   - +2/5% attack speed
   - Critical: Agility becomes energy generation stat

5. **Taste For Blood Scaling (Nerfed 1.18.1):**
   - 1/1.5/2% physical damage per combo point (was 1/2/3%)
   - Max: 10% at 5 CP (was 15%)
   - No longer affects Corrosive/Dissolvent Poison damage
   - Duration: 18-26 seconds (scales with Rupture)
   - Critical: Still valuable for physical damage, but weaker than before

### Medium Priority Changes

1. **Blade Flurry Toggle (1.18.0, Buffed 1.18.1):**
   - Baseline at level 30
   - Penalties: -20% energy regen (was -30%), -20% damage
   - Impact: Energy regen penalty less punishing in AoE situations

2. **Wound Poison Rework:**
   - 5% healing reduction per stack (max 25%)
   - 6.25% per stack with Envenom (max 31.25%)
   - Affects ALL healing sources
   - Impact: Healing reduction utility, not a damage stat

3. **Weapon Specialization Consolidation:**
   - Close Quarters Combat: +2/5% crit for daggers/fist/maces
   - Hack and Slash: 2/5% extra attack for swords/axes
   - Critical strike and proc chance valuable for specific weapon types

4. **Critical Strike Value:**
   - Lethality: Crit damage for all combo generators
   - Relentless Strikes: Triggers from crits
   - Honor Among Thieves: Energy from crits
   - Close Quarters Combat: Weapon-specific crit
   - Impact: Crit valuable for energy generation and damage

### Low Priority Changes

1. **Movement Speed:**
   - Quickfooted: +7% baseline (1.18.0)
   - Improved Ghostly Strike: +5-15% self, +2-6% party
   - Quality of life, not primary stat

2. **Health Scaling (Subtlety):**
   - Cloaked in Shadows: Shield = 6/12% max health
   - Party utility, not personal DPS

3. **Energy Cost Reductions:**
   - Sinister Strike: 45 → 40
   - All finishers: -5 energy
   - Hemorrhage: 45 → 40 (1.18.0)
   - Quality of life improvements

4. **Cooldown Reductions:**
   - Sprint/Evasion: 5min → 4min
   - Adrenaline Rush: 5min → 3min
   - Preparation: 10min → 7min
   - More frequent cooldown access

---

## Sources

All information compiled from official Turtle WoW changelogs:
- `turtle-wow-changelogs/1.16.1.html` (lines 618-656)
- `turtle-wow-changelogs/1.17.0.html` (Flourish cooldown change)
- `turtle-wow-changelogs/1.17.2-rogue-changes.html` (complete file)
- `turtle-wow-changelogs/1.17.2-2024.10.21-changes.html` (Rogue section)
- `turtle-wow-changelogs/1.17.2-2024.11.01-changes.html` (Rogue section)
- `turtle-wow-changelogs/1.17.2-2024.12.20-changes.html` (lines 429-466)
- `turtle-wow-changelogs/1.17.2-2025.04.01-changes.html` (lines 342-368)
- `turtle-wow-changelogs/1.18.0-rogue-changes.html` (complete file)
- Patch 1.18.1 changelog (Poison scaling nerfs, Blade Flurry, Taste for Blood, Noxious Assault, Opportunity)

**Last Updated:** Based on changelogs through Patch 1.18.1
