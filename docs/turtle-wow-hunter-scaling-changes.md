# Turtle WoW Hunter Scaling Changes

This document tracks all Hunter-specific changes from Turtle WoW that affect stat scaling and item valuation for the Pawn addon.

**Base Reference:** Vanilla 1.12.1 Hunter stat scaling is implemented in `ClassicHawsJon_small.lua`.

---

## Version 1.16.1 - First Class Changes

### New Ability: Trueshot

**Developer Context:** Hunter's main problem in vanilla: DPS doesn't scale well with gear and pets are too fragile in raids. Burning Crusade fixed this with pet scaling, Kill Command, and Steady Shot - but all three at once made them overpowered. Turtle WoW addresses this gradually.

#### Trueshot Ability
- **Type:** Precise ranged shot
- **Damage:** 100% weapon damage + X additional damage
- **Cooldown:** Equal to ranged weapon attack speed
- **Cost:** 5% base mana
- **Ranks:**
  - Rank 1 (36): +10 damage
  - Rank 2 (42): +20 damage
  - Rank 3 (48): +30 damage
  - Rank 4 (54): +40 damage
  - Rank 5 (60): +50 damage
- **Impact:** CRITICAL - First ability that scales with ranged weapon speed, adds consistent DPS
- **Note:** Later renamed to Steady Shot in 1.17.2

---

## Version 1.17.0 - Hyjal

### Quality of Life Changes

#### Trueshot Aura Toggle
- **Previous:** Had mana cost and duration
- **New:** Aura/state spell (toggle on/off)
- **Cost:** None
- **Duration:** Permanent until toggled off
- **Impact:** Can be active alongside other auras (Aspects)

#### New Race/Class Combination
- **Human Hunter:** Now available

---

## Version 1.17.2 - Tower of Karazhan

### Baseline Changes

#### Trueshot → Steady Shot Rename
- **Previous:** Trueshot (from 1.16.0 class changes)
- **New:** Renamed to Steady Shot
- **Impact:** No mechanical change, just naming

#### Steady Shot Level Adjustments
- **Rank 1:** Level 36 → 20 (moved to Marksmanship talent tree)
- **Rank 2:** 42 → 30
- **Rank 3:** 48 → 40
- **Rank 4:** 54 → 50
- **Rank 5:** 60 → 60

#### Aimed Shot
- **Change:** Now baseline, learned at level 20
- **Impact:** No longer requires Marksmanship tree

#### Avoidance (Pet Passive)
- **AoE Mitigation:** Area damage reduction increased 50% → 80%
- **Persistence:** No longer removed when resetting pet abilities
- **Impact:** Pets survive raid AoE more reliably, slightly reducing pressure on stamina/armor stacking

#### Aspect of the Wolf
- **Change:** Now has multiple ranks matching Aspect of the Hawk
- **Effect:** Grants melee AP instead of ranged AP
- **Ranks:** Same mana costs, AP values, and level requirements as Hawk
- **Note:** No longer prevents ranged attacks
- **Rank 7:** Acquirable in the world (location mystery)
- **Impact:** Melee AP more valuable for Survival hunters

#### Wing Clip Changes
- **Cooldown:** Added 6 second cooldown (later reduced to 3s in October hotfix)
- **Damage:** Now deals weapon damage % instead of flat
  - Rank 1 (12): 25% weapon damage, 50% slow
  - Rank 2 (38): 30% weapon damage, 55% slow
  - Rank 3 (60): 35% weapon damage, 60% slow
- **Impact:** Weapon DPS more valuable for melee hunters

#### Mongoose Bite Rework
- **Previous:** Required dodge to use
- **New:** Usable anytime, resets auto-attack swing timer
- **Weapon Damage:** Adds 60% weapon damage to all ranks
  - Rank 1 (16): 60% weapon + 25 flat
  - Rank 2 (30): 60% weapon + 45 flat
  - Rank 3 (44): 60% weapon + 75 flat
  - Rank 4 (58): 60% weapon + 115 flat
- **Impact:** Major buff for melee hunters, weapon DPS much more valuable

#### Scorpid Sting Simplification
- **Ranks:** Reduced to 1 rank
- **Cost:** 10% base mana
- **Effect:** Reduces physical damage by 2%, attack speed by 10% for 20 seconds
- **Note:** Doesn't stack with Thunderfury, Frostguard, Dream's Herald

#### Viper Sting
- **Mana Burn:** Reduced by 15%
- **Cooldown:** Added 6 second cooldown

### Pet Scaling Changes

#### New Pet Families
- **Serpents:** New family with Poison Spit ability
- **Foxes:** New family

#### Pet Ability Scaling
All damaging pet abilities now scale with Attack Power and/or Spell Power:
- **Poison Spit (Serpent):** 0.25 coefficient per tick
- **Lightning Breath (Wind Serpent):** 0.5 coefficient
- **Scorpid Poison:** 0.1 per tick, cooldown 4s → 3s, base damage +20%
- **Thunderstomp (Gorilla):** 0.21 coefficient, cooldown 60s → 40s, 1.5x threat, new Rank 4
- **Bite:** 1 damage per 20 Attack Power, cooldown 10s → 6s
- **Claw:** 1 damage per 42 Attack Power

#### Pet Ability Improvements
- **Charge (Boar):** Rank 4 now available in world
- **Lightning Breath:** Rank 1 now available in world
- **Dash:** Raptors can now learn Dash
- **Furious Howl (Wolf):** Focus cost 60 → 50, range 15y → 40y
- **Shell Shield (Turtle):** Attack speed reduction 43% → 35%

---

### Beast Mastery Changes (1.17.2)

#### Swift Aspects (formerly Improved Predator Aspects)
- **Proc Chance:** 1/2/3/4/5% → 10% (all ranks)
- **Attack Speed:** 30% → 3/6/9/12/15% (scales with talent)
- **Impact:** More consistent procs, haste value increases with talent points

#### Endurance Training
- **New:** Also grants pet 6/12/18/24/30% of your Stamina
- **Impact:** Stamina more valuable for Beast Mastery

#### Thick Hide
- **New:** Also grants pet 12/24/36% of your Armor
- **Impact:** Armor more valuable for Beast Mastery

#### New Talent: Elusiveness (Row 3, 2 Points)
- **Effect:** Pet gains 20/40% of your resistances + 2/4% dodge
- **Impact:** Resistance gear has value for Beast Mastery

#### Bestial Swiftness (Row 4)
- **Pathfinding merged:** +6% Aspect of Cheetah/Pack speed
- **New:** Pet gains 3% attack speed
- **Impact:** Haste value for pets

#### New Talent: Bestial Precision (Row 5, 2 Points)
- **Effect:** Pet gains 4/8% physical hit, 6/12% spell hit
- **Impact:** CRITICAL - Pets can now cap hit chance for raids

#### Improved Mend Pet
- **New:** Also increases Mend Pet healing by 20/40%
- **Impact:** Healing power has minor value if healing pet

#### Intimidation
- **Change:** Now grants pet 50% increased threat for 8s (even if stun resisted)
- **Impact:** Pet threat more consistent

#### Spirit Bond (Row 6)
- **Previous:** Periodic healing only
- **New:** Pet gains 12/25% of your Ranged AP as Melee AP
- **New:** Pet gains 7/15% of your Ranged AP as Spell Power
- **Healing:** Interval reduced 10s → 5s
- **Impact:** CRITICAL - Main pet scaling talent, Ranged AP extremely valuable for Beast Mastery

#### Bestial Wrath
- **Damage:** Reduced 50% → 30%
- **Note:** Compensated by Spirit Bond scaling

---

### Marksmanship Changes (1.17.2)

#### Improved Hunter's Mark
- **Position:** Row 2 → Row 3
- **Points:** 5 → 3

#### Improved Stings (formerly Improved Serpent Sting)
- **Position:** Row 4 → Row 2
- **Serpent Sting Damage:** 2/4/6/8/10% → 6/12/18/24/30%
- **New:** Viper Sting mana drain +1/2/3/4/5%
- **Impact:** Serpent Sting damage much more valuable

#### Improved Scorpid Sting
- **Points:** 3 → 2
- **Position:** Row 5 → Row 3
- **Effect:** Attack speed -5/10%, damage -1/2% additional
- **Total:** Attack speed -15/20%, physical damage -3/4%

#### New Keystone: Steady Shot (Row 3)
- **Effect:** 100% weapon damage + 10 damage
- **Cost:** 5% base mana
- **Cast Time:** 1 second
- **Range:** 8-35 yards
- **Impact:** Main Marksmanship DPS ability

#### Hawk Eye
- **Points:** 3 → 2
- **Position:** Row 3 → Row 4

#### Swiftshot (formerly Improved Arcane Shot)
- **Points:** 5 → 3
- **New:** Also reduces Aimed Shot cooldown
- **Impact:** More talent point efficiency

#### New Talent: Piercing Shots (Row 5, 2 Points)
- **Effect:** Crit Aimed/Steady/Multi-Shot applies bleed for 10/20% of damage over 8s
- **Threat:** Generates no threat
- **Impact:** Critical strike more valuable, adds DoT damage component

#### New Talent: Improved Steady Shot (Row 5, 2 Points)
- **Effect:** +13/25% Steady Shot damage
- **Impact:** Direct damage boost for main ability

#### New Talent: Endless Quiver (Row 6, 2 Points)
- **Effect:** 3/6% chance for Auto/Arcane/Steady/Multi-Shot to fire extra normal attack
- **Note:** Doesn't consume ammo, doesn't reset swing timer
- **Impact:** Proc-based damage increase

#### Trueshot Aura Scaling
- **Previous:** Flat AP only
- **New:** Flat AP + % AP
  - Rank 1 (40): 50 → 30 + 3% AP
  - Rank 2 (50): 75 → 40 + 4% AP
  - Rank 3 (60): 100 → 55 + 5% AP
- **Note:** Scales with recipient's gear, not hunter's
- **Impact:** CRITICAL - Scales into late game, raid-wide buff value increases

---

### Survival Changes (1.17.2) - New Melee Spec

#### Philosophy
Survival completely redesigned as melee Hunter archetype with pet and traps.

#### New Talent: Resourcefulness (Row 1, 5 Points)
- **Effect:** -2/4/6/8/10% mana cost for traps and melee abilities
- **Impact:** Mana efficiency for melee rotation

#### Swift Reflexes (formerly Deflection)
- **Points:** 5 → 2
- **Effect:** 2% melee/ranged attack speed + 2% parry per point
- **Impact:** Haste and parry more valuable

#### Savage Strikes
- **Crit Chance:** 10/20% → 3/6%
- **Abilities:** Now affects all melee abilities (Raptor Strike, Mongoose Bite, Carve, Wing Clip)
- **Impact:** Still valuable, but balanced for more abilities

#### Improved Wing Clip
- **Points:** 5 → 3
- **Proc Chance:** 7/14/20% → 14/28/40% (November hotfix)

#### New Talent: Planning Ahead (Row 3, 2 Points)
- **Effect:** +13/25% trap damage/duration if not triggered for 5s
- **Impact:** Rewards pre-placed traps

#### New Keystone: Carve (Row 3)
- **Effect:** 60% weapon damage to 5 enemies in 10y cone
- **Cooldown:** 6 seconds
- **Cost:** 8% base mana
- **Note:** Shares cooldown with Multi-Shot
- **Impact:** AoE melee damage, weapon DPS valuable

#### New Talent: Stinging Nettle Lacing (Row 4, 2 Points)
- **Effect:** Mongoose Bite and Fire traps apply Serpent Sting (80/60% reduced duration)
- **Duration:** 3/6 seconds (2 ticks)
- **Impact:** Applies Serpent Sting in melee range

#### Killer Instinct
- **New:** Also increases melee crit damage by 7/14/20%
- **Impact:** Melee crit much more valuable

#### Trap Mastery
- **Points:** 2 → 3
- **Effect:** +10/20/30% Frost trap duration and Fire trap damage

#### New Keystone: Rapid Strikes (Row 5)
- **Effect:** Rapid Fire increases melee attack speed by 40%
- **Effect:** Raptor Strike and Mongoose Bite cooldown -1s (6s → 5s)
- **Impact:** Major DPS cooldown for melee

#### New Talent: Vicious Bite (Row 6, 2 Points)
- **Effect:** Mongoose Bite +15/30% weapon damage
- **Total:** 60% → 75/90% weapon damage
- **Impact:** Weapon DPS scaling for main melee ability

#### Lightning Reflexes
- **Agility:** 3/6/9/12/15% → 2/4/6/8/10%
- **New:** Melee AP = 20/40/60/80/100% of Agility
- **Impact:** CRITICAL - Agility becomes primary melee stat (2 AP per Agi at rank 5!)

#### New Capstone: Untamed Trapper (Row 7)
- **Effect:** Fire traps scale with melee AP
- **Effect:** Can use traps in combat
- **Scaling:**
  - Immolation DoT: 1 damage per 10 AP per tick
  - Explosive initial: 1 damage per 6.5 AP
  - Explosive DoT: 1 damage per 30 AP per tick
- **Impact:** Melee AP scales trap damage, major DPS increase

#### Removed
- **Wyvern Sting:** Removed
- **Counterattack:** Removed

---

### Hotfix Changes (Post-1.17.2)

#### October 21, 2024
- **Wing Clip:** Cooldown 6s → 3s
- **Improved Wing Clip:** Proc chance 7/14/20% → 14/28/40%
- **Piercing Shots:** No longer generates threat (prevents breaking Feign Death)

#### November 1, 2024
- **Hawk Eye / Improved Hunter's Mark:** Swapped positions (Hawk Eye to Row 3)

#### November 20, 2024
- **Improved Steady Shot:** Damage bonus reduced 13/25% → 8/15%
- **Piercing Shot:** Bleed damage increased 10/20% → 15/30%
- **Carve:** Cooldown 6s → 10s, added lower rank scaling:
  - Rank 1 (20): 50% weapon damage
  - Rank 2 (38/NEW): 55% weapon damage
  - Rank 3 (56/NEW): 60% weapon damage
- **Mongoose Bite:** Lower rank weapon damage scaling reduced:
  - Rank 1 (16): 60% → 45% weapon + 25 flat
  - Rank 2 (30): 60% → 50% weapon + 45 flat
  - Rank 3 (44): 60% → 55% weapon + 75 flat
  - Rank 4 (58): Unchanged

#### December 20, 2024
- **Mongoose Bite:** Now requires weapon to use
- **Vicious Bite → Vicious Strikes:** Renamed, now affects Raptor Strike too (+10/20% weapon damage)
- **Carve:** Weapon damage increased:
  - Rank 1: 50% → 60%
  - Rank 2: 55% → 65%
  - Rank 3: 60% → 70%
- **Bestial Precision:** Now also increases pet weapon skill by 5/10
- **Steady Shot:** Lower rank scaling reduced:
  - Rank 1 (20): 100% + 10 → 60% + 10
  - Rank 2 (30): 100% + 10 → 70% + 20
  - Rank 3 (40): 100% + 10 → 80% + 30
  - Rank 4 (50): 100% + 10 → 90% + 40
  - Rank 5 (60): Unchanged

#### April 1, 2025
- **Mongoose Bite:** Flat damage reduced ~40% for lower ranks (leveling nerf):
  - Rank 1: 25 → 15
  - Rank 2: 45 → 25
  - Rank 3: 75 → 45
  - Rank 4: 115 → 70
- **Untamed Trapper:** Now also reduces Fire trap mana cost by 20%
- **Savage Strikes:** Now also increases offhand weapon damage by 13/25%

---

## Version 1.18.0 - Scars of the Past

### Baseline Changes

#### New Pet Command: Take Position
- **Effect:** Command pet to move to specific location
- **Rules:** Obeys line of sight
- **Impact:** Better pet positioning for mechanics

#### New Pet Family Abilities
Added unique abilities for all remaining pet families:
- **Tallstriders:** Strider Presence - Party combat HP/mana regen
- **Spiders:** Web - Root then heavy slow
- **Hyenas:** Packleader - Summon temporary ally
- **Bears:** Roar of Fortitude - Party damage reduction + damage increase
- **Crocolisks:** Death Roll - Heavy slow + ramping damage (more vs low HP)
- **Crabs:** Bubble Barrier - Damage absorb, AoE frost on break
- **Raptors:** Savage Rend - Bleed attack, longer on crit

#### Hunter Aspects on Stance Bar
- **Change:** Moved to stance bar like Druid forms/Paladin auras
- **Note:** Lower ranks replaced by highest rank
- **Impact:** Quality of life, saves action bar space

#### Pet Swapping Restrictions
- **Combat:** Cannot swap pets in combat or while feigning death
- **Caretaker Brambleclaw:** 1 minute cooldown between swaps
- **Impact:** Prevents cooldown abuse

#### Mongoose Bite Dual Wield
- **Change:** Now strikes with both weapons if dual wielding
- **Impact:** CRITICAL - Dual wield now viable for Survival, equal to 2H

#### Rapid Fire
- **Change:** Now increases melee AND ranged attack speed baseline
- **Impact:** Major buff for Survival, Rapid Strikes effect baseline

#### Pet Ability Scaling Updates
- **Screech (Carrion Bird/Owl):** 1 damage per 25 AP, 5s cooldown added
- **Furious Howl (Wolf):** 1 extra physical damage per 25 AP on next hit
- **Charge (Boar):** Next attack gains AP equal to 35% of pet AP

#### Growl
- **Focus Cost:** 15 → 10
- **Impact:** Pets have more focus for other abilities while leveling

---

### Beast Mastery Changes (1.18.0)

#### Endurance Training
- **Health:** 3/6/9/12/15% → 1/2/3/4/5%
- **Note:** Still grants 6/12/18/24/30% of your Stamina to pet
- **Impact:** Nerf to base scaling, but stamina transfer unchanged

#### Thick Hide
- **Armor:** 10/20/30% → 4/7/10%
- **Note:** Still grants 12/24/36% of your Armor to pet
- **Impact:** Nerf to base scaling, but armor transfer unchanged

#### Bestial Swiftness
- **Status:** Removed

#### New Keystone: Coordinated Assault (Row 3)
- **Effect:** Arcane/Steady/Raptor Strike triggers pet attack for 30% of pet AP
- **Cooldown:** Once every 3 seconds
- **Duration:** Pet has 6s to use it
- **Impact:** Adds pet damage proc to hunter rotation

#### Pathfinding (Row 3, 2 Points) - Returned
- **Effect:** Aspect of Cheetah/Pack +3/6% speed
- **New:** Pet movement speed +15/30%
- **Impact:** Pet mobility increased

#### Bestial Discipline
- **Position:** Moved up one row
- **New Effect:** Reduces pet special ability cooldown by 10/20%
- **Impact:** Pet abilities used more frequently

#### Bestial Precision
- **Spell Hit:** 6/12% → 9/18%
- **Impact:** Spell-based pets now cap spell hit

#### Intimidation
- **Dependency:** No longer required for other talents

#### New Keystone: Kill Command (Row 5)
- **Effect:** Pet's next 2 abilities guaranteed crit with +50% crit damage
- **Duration:** 10 seconds
- **Cooldown:** 12 seconds
- **Cost:** 5% base mana
- **GCD:** 1 second (not 1.5s)
- **Bonus:** Removes crowd control from pet
- **Impact:** MAJOR - Pet damage cooldown, synergy with unique abilities

#### Bestial Wrath
- **Status:** Removed

#### New Capstone: Baited Shot (Row 7)
- **Trigger:** After pet critically strikes
- **Effect:** 125% weapon damage instant shot
- **Debuff:** Target takes 15% more damage from pet, pet attacks generate 5 focus for 8s
- **Focus:** Can trigger once every 2s
- **Cooldown:** 8 seconds
- **Cost:** 7% base mana
- **Impact:** MAJOR - Active pet-focused capstone, focus generation for pet

---

### Marksmanship Changes (1.18.0)

No changes - developers happy with current state.

---

### Survival Changes (1.18.0)

#### Rapid Strikes
- **Status:** Removed (effect moved to baseline Rapid Fire)
- **Cooldown Reduction:** Moved to Vicious Strikes

#### Improved Feign Death
- **Resist Reduction:** 2/4% → 4/8%
- **Impact:** Better threat drop reliability

#### New Keystone: Lacerate (Row 5)
- **Trigger:** After critically striking
- **Damage:** 35% of melee AP + bleed for 20% of damage over 8s
- **Side Bonus:** +10% damage from sides, bleed 100% faster
- **Cooldown:** 10 seconds
- **Cost:** 8% base mana
- **Affected By:** Resourcefulness, Savage Strikes, Killer Instinct
- **Impact:** New proc-based melee ability, rewards positioning

#### Vicious Strikes (formerly Vicious Bite)
- **New:** Reduces Raptor Strike and Mongoose Bite cooldown by 0.5/1s
- **Weapon Damage:** 10/20% → 5/10%
- **Flat Damage:** 10/20 → 5/10
- **Note:** August 2025 revision removed Raptor Strike/Mongoose Bite damage increase

---

## Stat Priority Impact Summary

### Beast Mastery Hunter

#### Extremely High Priority
1. **Ranged Attack Power** - Spirit Bond grants pet 12/25% as Melee AP, 7/15% as Spell Power (1.17.2)
2. **Agility** - Ranged AP conversion, crit for Kill Command/Baited Shot procs (1.18.0)
3. **Ranged Hit Rating** - To 9% cap (6% with talents)

#### High Priority
4. **Critical Strike** - Kill Command procs, Baited Shot trigger, pet crit damage (1.18.0)
5. **Stamina** - Pet gets 6/12/18/24/30% of your Stamina (1.17.2)
6. **Ranged Haste** - More shots, more Coordinated Assault procs (1.18.0)

#### Medium Priority
7. **Armor** - Pet gets 12/24/36% of your Armor (1.17.2)
8. **Resistances** - Pet gets 20/40% with Elusiveness (1.17.2)
9. **Intellect** - Mana pool for longer fights

### Marksmanship Hunter

#### Extremely High Priority
1. **Ranged Attack Power** - Trueshot Aura scales with 3/4/5% AP (1.17.2)
2. **Agility** - Ranged AP, critical strike
3. **Ranged Hit Rating** - To 9% cap (6% with talents)

#### High Priority
4. **Critical Strike** - Piercing Shots procs, Endless Quiver procs (1.17.2)
5. **Ranged Haste** - More auto shots, more Endless Quiver procs
6. **Intellect** - Mana pool

#### Medium Priority
7. **Stamina** - Survivability
8. **Mp5** - Sustained DPS

### Survival Hunter (Melee)

#### Extremely High Priority
1. **Agility** - Lightning Reflexes converts to AP at 20/40/60/80/100% (1.17.2)
2. **Melee Attack Power** - Scales all melee abilities and Fire traps (1.17.2)
3. **Melee Hit Rating** - To 9% cap (6% with talents)
4. **Weapon DPS** - All abilities scale with weapon damage

#### High Priority
5. **Critical Strike** - Lacerate trigger, Killer Instinct +7/14/20% crit damage (1.18.0)
6. **Melee Haste** - Rapid Fire buff, more attacks
7. **Strength** - Melee AP conversion

#### Medium Priority
8. **Stamina** - Survivability in melee
9. **Intellect** - Mana for trap-heavy rotation
10. **Armor** - Mitigation

---

## Critical Scaling Breakpoints

### Beast Mastery Pet Scaling (1.17.2)
- **Spirit Bond (2 points):** Pet gains 25% Ranged AP as Melee AP, 15% as Spell Power
- **Pet Hit Cap:** 8% with Bestial Precision (2 points)
- **Pet Spell Hit Cap:** 18% with Bestial Precision (1.18.0)
- **Example:** 2000 Ranged AP = 500 pet Melee AP + 300 pet Spell Power

### Survival Lightning Reflexes (1.17.2)
- **Rank 5:** 10% Agility + 100% Agi → Melee AP
- **Example:** 300 Agility = 330 Agi + 330 Melee AP = 660 total AP contribution

### Trueshot Aura Scaling (1.17.2)
- **Rank 3 (Level 60):** 55 flat + 5% of recipient's AP
- **Example:** Warrior with 2000 AP gains 55 + 100 = 155 AP
- **Impact:** Scales throughout all gear tiers

---

## Sources

All information compiled from official Turtle WoW changelogs:
- 1.16.1.html (Trueshot ability introduction)
- 1.17.0.html (Trueshot Aura toggle, Human Hunter)
- 1.17.2-hunter-changes.html
- 1.17.2-2024.10.21-changes.html
- 1.17.2-2024.11.01-changes.html
- 1.17.2-2024.11.20-changes.html
- 1.17.2-2024.12.20-changes.html
- 1.17.2-2025.04.01-changes.html
- 1.18.0-hunter-changes.html

**Last Updated:** Based on changelogs through Patch 1.18.0 (Scars of the Past)

---

## Implementation Notes for ClassicHawsJon.lua

### Critical Changes Requiring Stat Weight Updates

#### Beast Mastery
1. **Spirit Bond (1.17.2):** Ranged AP converts to pet AP/Spell Power - CRITICAL scaling change
2. **Kill Command + Baited Shot (1.18.0):** Pet-focused rotation, crit very valuable
3. **Stat Transfers:** Stamina, Armor, Resistances all have value through pet scaling
4. **Pet Hit Cap:** Can now be reached with Bestial Precision

#### Marksmanship
1. **Trueshot Aura Scaling (1.17.2):** Now 55 + 5% AP, scales into late game
2. **Steady Shot:** Main DPS ability (1.17.2)
3. **Piercing Shots (1.17.2):** Crit adds DoT component
4. **Endless Quiver (1.17.2):** Proc-based extra attacks

#### Survival (Melee)
1. **Lightning Reflexes (1.17.2):** Agility = 2 AP per point at max rank - CRITICAL
2. **Untamed Trapper (1.17.2):** Fire traps scale with Melee AP
3. **Mongoose Bite Dual Wield (1.18.0):** Dual wield now equal to 2H
4. **Weapon DPS:** All melee abilities scale with weapon damage
5. **Lacerate (1.18.0):** New proc ability, crit valuable
