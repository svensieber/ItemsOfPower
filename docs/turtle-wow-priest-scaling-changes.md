# Turtle WoW Priest Scaling Changes

This document tracks all Priest-specific changes from Turtle WoW that affect stat scaling and item valuation for the Pawn addon.

**Base Reference:** Vanilla 1.12.1 stat scaling is implemented in `ClassicHawsJon_small.lua`.

**Related Documentation:** See `turtle-wow-general-scaling-changes.md` for non-class-specific changes (weapon skill rework, hit cap changes, armor cap removal, etc.).

---

## Version 1.16.1 - First Class Changes

### Baseline Changes

#### Holy Fire
- **Spell Power Coefficient:** 0.75 → 0.857 (increased by 14.3%)
- **Impact:** Better spell power scaling for baseline Holy damage ability

#### Divine Spirit
- **Change:** Now baseline for all Priests at level 30 (was Holy talent)
- **Impact:** All Priests gain Spirit buff baseline

#### Lightwell
- **Change:** Now baseline at level 40 (was Holy talent)
- **Impact:** All Priests gain healing utility baseline

---

### New Abilities

#### Improved Shadowform (Passive)
- **Learned:** Level 60, automatic
- **Effect:**
  - Reduces mana cost of Shadow spells by 15%
  - Allows 15% of mana regeneration to continue while casting in Shadowform
- **Impact:** CRITICAL for Shadow - mana sustain and Spirit value increased significantly

#### Pain Spike
- **Learned:** Level 60
- **Cooldown:** 15 seconds
- **Damage:** 333-377 Shadow damage instantly, heals itself over 5 seconds
- **Requires:** Shadowform
- **Impact:** New rotational Shadow ability

#### Shadowmend
- **Learned:** Book at level 58
- **Cooldown:** 30 seconds
- **Healing:** 518-615
- **Effect:** Reduced threat, requires Shadowform
- **Impact:** Shadow Priest healing utility

---

### Talent Changes

#### Vampiric Embrace (Previously Improved Vampiric Touch)
- **Renamed:** Improved Vampiric Touch → Vampiric Embrace
- **New Effect:**
  - Increases percentage healed by Vampiric Embrace by 5/10%
  - Party members gain mana equal to 2/4% of Shadow spell damage dealt
- **Impact:** Shadow becomes mana battery for party, massive raid utility value

#### Holy Nova (Talent)
- **Spell Power Coefficient:** 0.107 → 0.161 (increased by 50.5%)
- **Impact:** Significantly better AoE damage/healing scaling

#### Holy Champion (NEW Talent)
- **Location:** Holy, Tier 7
- **Effect:** Proclaim Champion on friendly target for 2 hours
- **Buffs Provided:**
  - +230 armor, +10 all resistances
  - Champion's Grace: +10% priest healing for 2 hours
  - Champion's Bond: 20 damage redirected to Champion for 10 minutes
  - Empower Champion: +20 spell damage/healing, +30 AP for 2 hours
  - Champion's Resolve: Fear immunity ward for 10 seconds
  - Revive Champion: 2500 HP/2600 mana resurrection
- **Impact:** New support playstyle, buffs scale with healing power

#### Reflective Shields (NEW Talent)
- **Location:** Discipline, Tier 5
- **Prerequisite:** Improved Power Word: Shield
- **Effect:** 20% of damage absorbed by Power Word: Shield reflected back
- **Threat:** Reflected damage causes no threat
- **Impact:** Minor damage scaling for shielding

---

## Version 1.17.0

### Talent Changes

#### Champion's Grace
- **Change:** Now available from class trainers at level 40
- **Requirement:** Must have Proclaim Champion talented
- **Impact:** Quality of life improvement for Holy Champion users

---

## Version 1.17.2 - Mysteries of Azeroth

### Baseline Changes

#### Inner Fire (MAJOR CHANGE)
- **Previous:** Granted Attack Power
- **New:** Grants Spell Damage
- **Values:**
  - Rank 1 (Level 12): 13 spell damage
  - Rank 2 (Level 20): 24 spell damage
  - Rank 3 (Level 30): 34 spell damage
  - Rank 4 (Level 40): 46 spell damage
  - Rank 5 (Level 50): 61 spell damage
  - Rank 6 (Level 60): 74 spell damage
- **Impact:** CRITICAL change - Inner Fire now benefits spell casters instead of melee, massive spell power gain

#### Buff Mana Cost Reductions
- **Power Word: Fortitude:**
  - Rank 1: 60 → 50
  - Rank 2: 155 → 100
  - Rank 3: 400 → 160
  - Rank 4: 745 → 240
  - Rank 5: 1170 → 340
  - Rank 6: 1695 → 445
- **Prayer of Fortitude:**
  - Rank 1: 2600 → 900
  - Rank 2: 3400 → 1200
- **Divine Spirit:**
  - Rank 1: 285 → 160
  - Rank 2: 420 → 240
  - Rank 3: 785 → 340
  - Rank 4: 970 → 445
- **Prayer of Spirit:** Rank 1: 1940 → 900
- **Shadow Protection:**
  - Rank 1: 250 → 240
  - Rank 2: 450 → 340
  - Rank 3: 650 → 445
- **Prayer of Shadow Protection:** Rank 1: 1300 → 900
- **Feedback:**
  - Rank 2: 245 → 175
  - Rank 3: 355 → 190
  - Rank 4: 470 → 205
  - Rank 5: 580 → 220
- **Impact:** Significantly reduced mana costs for buffing, MP5 slightly less valuable

#### Pain Spike
- **Change:** No longer requires Shadowform to learn, can be cast outside Shadowform
- **New Ranks:** Now acquired at earlier levels
  - Rank 1 (Level 30): 80 Mana, 66-85 Shadow damage
  - Rank 2 (Level 40): 140 Mana, 149-172 Shadow damage
  - Rank 3 (Level 50): 185 Mana, 209-240 Shadow damage
  - Rank 4 (Level 60): 265 Mana, 333-378 Shadow damage
- **Impact:** Earlier access, usable outside Shadowform

#### Power Word: Shield (MAJOR BUFF)
- **Spell Power Coefficient:** 10% → 35% (increased by 250%)
- **Note:** Does not affect pre-level 20 ranks
- **Impact:** CRITICAL change - spell power massively more valuable for shielding

#### Mana Burn
- **Change:** Moved from Discipline specialization to Shadow
- **Impact:** Benefits from Shadow talent tree bonuses

#### Fear Ward
- **Change:** Now baseline at level 20 (was Dwarf Priest racial)
- **Impact:** All Priests gain fear immunity utility

#### Racial Changes

**Dwarf Priest - Avatar (NEW):**
- **Replaces:** Fear Ward (now baseline)
- **Effect:** Turns target into stone, +25% armor, +150% of level as all resistances for 15 seconds
- **Cost:** 6% base mana
- **Cooldown:** 1 minute (later changed to 5 minutes in hotfix)
- **Impact:** New defensive utility for Dwarf Priests

**Night Elf Priest - Searing Shot (NEW):**
- **Replaces:** Elune's Grace (removed)
- **Additional:** Can now use Bows with auto-shoot
- **Effect:** Fire searing arrow dealing weapon damage plus Fire damage
- **Values:**
  - Rank 1 (Level 20): 14-18 Fire damage
  - Rank 2 (Level 32): 25-29 Fire damage
  - Rank 3 (Level 44): 37-42 Fire damage
  - Rank 4 (Level 58): 51-57 Fire damage
  - Rank 5 (Level 60/Book): 68-74 Fire damage
- **Spell Power Coefficient:** 33%
- **Cost:** 5% base mana (later 10% in hotfix)
- **Cooldown:** 10 seconds
- **Impact:** Night Elf Priests gain ranged weapon capability and ranged spell

#### Lightwell Improvements
- **Changes:**
  - No longer removed on damage taken
  - Cannot be re-clicked while HoT is active
  - Now scales with 17% of healing power
  - Benefits from Spiritual Healing and Swift Recovery talents
- **New Rank:** Rank 1 at level 30 (shifts other ranks up)
- **Impact:** Much more viable healing tool, healing power scaling added

#### Healing Baseline Nerf
- **Change:** Base healing values and spell power scaling reduced by 15% for ranks above level 30
- **Affected Spells:** Lesser Heal, Renew, Heal, Flash Heal, Prayer of Healing, Greater Heal, Desperate Prayer, Lightwell
- **Developer Note:** Compensated by Spiritual Healing talent buff (+6/12/18/24/30%)
- **Impact:** CRITICAL - healing requires deeper Holy spec investment to match vanilla values

---

### Discipline Specialization (COMPLETE REWORK)

**Design Philosophy:** Transformed into Holy damage dealing support specialization

#### Smite Buffs
- **Base Damage:** Increased by 10%
- **Mana Cost Reductions:**
  - Rank 3: 60 → 40
  - Rank 4: 95 → 60
  - Rank 5: 140 → 105
  - Rank 6: 185 → 135
  - Rank 7: 230 → 165
  - Rank 8: 280 → 210
  - Rank 9: 300 → 240
- **Impact:** Primary rotational DPS ability for Discipline

#### Holy Fire Buffs
- **Spell Power Coefficient:** 85% → 100% (initial cast damage)
- **Base Damage:** Increased by 10%
- **Impact:** Major spell power scaling improvement

#### Wand Specialization (Reworked)
- **Points Required:** 5 → 2
- **New Effects:**
  - Increases hit chance with wands by 5/10%
  - Wands have chance on hit to grant mana equal to your level
- **Impact:** Makes wand usage more viable for Discipline

#### Piercing Light (NEW Talent)
- **Location:** Tier 1, 3 points
- **Effect:** Reduces chance for enemies to resist Holy and Discipline spells by 2/4/6%
- **Impact:** Spell penetration for Holy damage

#### Mental Agility (Moved and Buffed)
- **Location:** Tier 4 → Tier 1
- **New Effect:** Also reduces mana cost of offensive Holy and Discipline spells by 2/4/6/8/10%
- **Impact:** Mana efficiency for DPS spells

#### Spell Warding
- **Change:** Moved from Holy Tier 2 to Discipline Tier 2
- **Points Required:** 5 → 3
- **Impact:** Available to Discipline for spell damage reduction

#### Improved Inner Fire (Moved and Buffed)
- **Location:** Tier 4 → Tier 3
- **Points Required:** 3 → 2
- **Note:** Also affects new spell damage component of Inner Fire
- **Impact:** Increases spell damage from Inner Fire

#### Searing Light (NEW Talent)
- **Location:** Tier 4, 3 points
- **Effect:** Holy and Discipline spell crits have 33/66/100% chance to make next Smite instant cast with no mana cost
- **Duration:** 10 seconds
- **Impact:** Crit value increased for Discipline, burst damage capability

#### Purifying Flames (NEW Talent)
- **Location:** Tier 4, 2 points
- **Effect:** Holy Fire has 50/100% chance to increase Holy damage by 12% for 8 seconds
- **Impact:** Holy damage amplification mechanic

#### Mental Strength (Reworked)
- **Points Required:** 5 → 3
- **New Effects:**
  - Increases total Intellect (was mana)
  - Increases casting speed by 1/2/3%
- **Impact:** Intellect more valuable, adds haste scaling

#### Enlighten (NEW Keystone Talent)
- **Location:** Tier 5
- **Effect:** Bring party member under tutelage
  - 15% chance when casting damaging Discipline/Holy spell to burn them for 4% total health as Holy damage
  - Increases spell damage and healing by 10% for both (15% if self-cast)
  - Duration: 8 seconds
- **Cost:** 10% base mana
- **Cooldown:** 1 minute
- **Duration:** 30 minutes
- **Impact:** Party-wide spell damage amplification, significant raid utility

#### Resurgent Shield (NEW Capstone Talent)
- **Location:** Tier 5
- **Effect:** When Power Word: Shield breaks:
  - Refunds 25% of base mana cost
  - Holy spell damage increased by 6% of shield's absorption for 8 seconds
- **Impact:** Links shielding to DPS output, spell power from absorb amount

#### Reflective Shields
- **Change:** Removed

#### Force of Will (Buffed)
- **New Effect:** Also increases Power Word: Shield absorption by 4/8/12/16/20%
- **Impact:** Shield absorption scaling improved

#### Chastise (NEW Capstone Talent)
- **Location:** Tier 7
- **Effect on Enemies:** Holy damage, disorients for 3 seconds
- **Effect on Allies:** Increases attack/casting speed by 10/13/15% for 6 seconds (8 seconds on crit)
- **Restriction:** Cannot cast on allies below 50% health or below certain level
- **Damage Values:**
  - Rank 1 (Level 40): 139-161 damage, 10% haste, below level 35
  - Rank 2 (Level 50): 209-241 damage, 13% haste, below level 45
  - Rank 3 (Level 60): 278-322 damage, 15% haste, below level 55
- **Spell Power Coefficient:** 65%
- **Cost:** 6% base mana
- **Cooldown:** 30 seconds
- **Impact:** Haste buff for party members, unique support ability

#### Power Infusion
- **Change:** Removed

---

### Holy Specialization

**Design Philosophy:** Encourage deeper Holy spec investment for healing

#### Healing Focus → Holy Focus
- **Change:** Now affects all Holy spells (not just healing)
- **Impact:** Pushback resistance for Discipline Holy damage spells

#### Holy Specialization → Divinity
- **Change:** Now affects Holy AND Discipline spells (not just Holy healing)
- **Impact:** Crit chance for both healing and Discipline DPS

#### Martyrdom → Blessed Concentration
- **Change:** Moved from Discipline Tier 2 to Holy Tier 2
- **Impact:** Threat reduction available to Holy

#### Holy Reach (Moved and Buffed)
- **Location:** Tier 4 → Tier 2
- **New Effect:** Now affects all offensive Holy and Discipline spells
- **Impact:** Range increase for Discipline DPS

#### Holy Nova
- **Change:** Now causes normal threat (was reduced threat)
- **Impact:** Threat management more important

#### Searing Light (Holy Talent)
- **Change:** Removed (different version added to Discipline)

#### Swift Recovery (NEW Talent)
- **Location:** Tier 4, 2 points
- **Prerequisite:** Connects to Improved Renew
- **Effect:** Healing spells heal for 3/6% more if target has Renew active
- **Impact:** Synergy bonus for keeping Renew active

#### Improved Healing (Buffed)
- **Change:** Now includes Prayer of Healing
- **Impact:** AoE healing efficiency improved

#### Spiritual Guidance
- **Location:** Tier 5 → Tier 4
- **Impact:** More accessible Spirit-to-healing conversion

#### Improved Prayer of Healing
- **Change:** Removed

#### Spirit of Redemption (Buffed)
- **New Effect:** Increases Spirit by 5% in addition to death angel effect
- **Impact:** Spirit stat more valuable for Holy

#### Reservoir of Light (NEW Talent)
- **Location:** Tier 5, 3 points
- **Effect:** Increases Lightwell charges by 1/3/5
- **Impact:** Lightwell longevity improved

#### Spiritual Healing (MAJOR BUFF)
- **Healing Increase:** 2/4/6/8/10% → 6/12/18/24/30%
- **Impact:** CRITICAL - compensates for 15% baseline healing nerf, requires deep Holy investment

---

### Shadow Specialization

#### Pain Spike Nerfs
- **Spell Power Coefficient:** 42.85% → 25%
- **Cooldown:** 30 seconds → 40 seconds
- **Impact:** Damage scaling reduced significantly

#### Blackout
- **Stun Duration:** 3 seconds → 2 seconds
- **Impact:** PvP utility slightly reduced

#### Mind Flay (MAJOR BUFF)
- **Spell Power Coefficient:** 45% → 75% (increased by 66.7%)
- **Impact:** CRITICAL - spell power much more valuable for Shadow rotation

#### Mind Blast (Buff)
- **Spell Power Coefficient:** 42.85% → 60% (increased by 40%)
- **Note:** Does not affect pre-level 20 ranks
- **Impact:** Spell power scaling significantly improved

#### Vampiric Embrace
- **Cast Time:** Instant → 2 seconds
- **Impact:** PvP nerf, less reactive application

#### Vampiric Touch (Previously Improved Vampiric Embrace)
- **Healing Increase:** 5/10% → 2/5%
- **Mana Granted:** 2/4% → 1/2% of Shadow spell damage
- **Impact:** Party utility reduced, but compensated by coefficient buffs

#### Improved Mana Burn
- **Change:** Moved from Discipline Tier 4 to Shadow Tier 3
- **Impact:** Available to Shadow specs

#### Holy Nova in Shadowform
- **Change:** Now usable in Shadowform
- **Effect:** Causes self-damage instead of self-healing
- **Impact:** AoE damage option for Shadow

---

## Version 1.17.2 - Hotfixes

### October 21, 2024

#### Power Word: Shield
- **Change:** Can be cast in Shadowform
- **Impact:** Shadow survivability improved

#### Enlighten
- **Change:** Can now trigger off healing spells
- **Impact:** Holy can also use Enlighten effectively

#### Proclaim Champion
- **Buff:** Now restores small portion of damage taken by Champion as mana
- **Impact:** Mana sustain for Holy Champion users

#### Champion's Resolve
- **Change:** Removed

#### Revive Champion
- **Cooldown:** 300 seconds → 45 minutes
- **Cast Time:** 10.8 seconds → 5 seconds
- **Mana Cost:** Increased
- **Change:** Can now be used in combat
- **Impact:** Less frequent but more flexible resurrection

#### Searing Shot (Night Elf)
- **Mana Cost:** 5% → 10% base mana
- **Impact:** More expensive, mana efficiency reduced

#### Avatar (Dwarf)
- **Cooldown:** 1 minute → 5 minutes
- **Impact:** Less frequent defensive utility

---

### November 1, 2024

#### Feedback (Human Racial)
- **Change:** Mana burn and damage effects doubled
  - Rank 1: 18 → 36
  - Rank 2: 35 → 70
  - Rank 3: 54 → 108
  - Rank 4: 77 → 154
  - Rank 5: 105 → 210
- **Impact:** Significantly stronger mana burn for Human Priests

#### Starshards (Night Elf Racial)
- **Complete Rework:**
  - Damage significantly buffed
  - Mana cost doubled
  - New 30 second cooldown
  - Damage pattern: 2 small, 2 medium, 2 large ticks
- **Values:**
  - Rank 1: 100 mana, 24/24/36/36/48/48 Arcane damage
  - Rank 2: 170 mana, 40/40/60/60/80/80 Arcane damage
  - Rank 3: 280 mana, 70/70/105/105/140/140 Arcane damage
  - Rank 4: 380 mana, 105/105/158/158/210/210 Arcane damage
  - Rank 5: 490 mana, 145/145/218/218/290/290 Arcane damage
  - Rank 6: 600 mana, 190/190/285/285/380/380 Arcane damage
  - Rank 7: 700 mana, 240/240/360/360/480/480 Arcane damage
- **Spell Power Coefficient:** 0.4 (Ranks 3-7), 0.2/0.35 (Ranks 1-2)
- **Impact:** Major burst damage ability for Night Elf Priests

#### Force of Will
- **Change:** Spell damage boost now applies to Channels and DoT effects
- **Impact:** Benefits Mind Flay and Shadow Word: Pain

#### Searing Light (Discipline Talent)
- **Mana Cost Reduction:** 100% → 40%
- **Impact:** Less mana efficiency on proc

#### Purifying Flames
- **Buff Duration:** 8 seconds → 10 seconds
- **Impact:** Longer Holy damage amplification window

---

### November 20, 2024

**Developer Note:** Discipline overperformed in PvE and PvP, these changes address this

#### Smite (Nerf)
- **Base Damage:** Reduced by 10% (reverts 1.17.2 buff)
- **Reason:** Return to original Vanilla base values
- **Impact:** Discipline DPS baseline reduced, compensated by other mechanics

#### Resurgent Shield
- **Nerf:** Reduced spell damage bonus (specific values not documented)
- **Impact:** Lower DPS benefit from shield breaking

#### Searing Light
- **Cooldown:** 0 seconds → 3 seconds internal cooldown
- **Mana Cost Reduction:** 40% → 20%
- **Impact:** Significant burst damage and mana efficiency reduction

#### Chastise
- **Disorient Duration (Enemies):** 3 seconds → 2 seconds
- **Range:** 30 yards → 25 yards
- **Additional:** Tier 2.5 3-set bonus no longer affects disorient duration
- **Impact:** Crowd control utility reduced

---

### December 20, 2024

#### Holy Champion
- **Buff:** Mana returned from Champion damage taken: 1% → 2%
- **Impact:** Better mana sustain for Holy Champion users

#### Chastise (Discipline)
- **Global Cooldown:** Reduced from 1.5 seconds to 1 second
- **Impact:** Smoother rotation, higher DPS throughput for Discipline

#### Resurgent Shield (Discipline)
- **Spell Power Buff:** Holy spell power from shield breaking increased from 6% to 10% of shield's total absorption
- **Impact:** MAJOR - Significantly higher spell power gain when shields break, improves Discipline DPS scaling

#### Searing Shot (Night Elf)
- **Change:** Documented adjustments (specifics not detailed beyond earlier mana cost increase)

#### Wand Specialization
- **Buff:** Now also affects Bows
- **Impact:** Night Elf Priests get bow benefit from wand talent

#### Night Elf Priest Bow Mechanic
- **Change:** Casting a spell resets bow's shot timer
- **Impact:** Better integration of bow usage with spellcasting

---

### April 1, 2025

#### Smite (Discipline)
- **Spell Power Coefficient:** Increased by approximately 5% for all ranks
- **Impact:** Discipline DPS slightly improved

#### Chastise (Discipline)
- **Duration:** Effect duration increased:
  - Non-critical: 6 seconds → 8 seconds
  - Critical: 9 seconds → 12 seconds (when cast on allies)
- **Haste Bonus:** Attack and casting speed increased:
  - Rank 1: 10% → 13%
  - Rank 2: 13% → 17%
  - Rank 3: 15% → 20%
- **Cooldown:** Increased from 30 seconds to 40 seconds
- **Impact:** MAJOR - Much stronger support ability, longer uptime and higher haste bonus offset longer cooldown

#### Pain Spike (Shadow)
- **Spell Power Coefficient:** Increased from 25% to 43%
- **Impact:** MAJOR - Shadow burst damage significantly improved, compensates for earlier nerf

#### Spell Warding ↔ Blessed Concentration
- **Change:** Swapped talent locations (Spell Warding to Holy Tier 2, Blessed Concentration to Discipline Tier 2)
- **Developer Note:** Improve Shadow build diversity by making Blessed Concentration more accessible
- **Impact:** Easier access to threat reduction for Shadow PvP, improves build flexibility

#### Enlighten (Discipline)
- **Nerf:** Chance to trigger from healing spells reduced from 15% to 10%
- **Developer Note:** Reduce Holy usage to give Holy Champion more spotlight
- **Impact:** Less frequent proc for Holy healers using Enlighten

---

## Version 1.18.0 - Scars of the Past

### Baseline Changes

#### Smite
- **Rank 9 Mana Cost:** 240 → 225
- **Impact:** Better damage-to-mana ratio

#### Mind Blast
- **Threat Modifier:** 200% → 170%
- **Impact:** Easier threat management for Shadow

---

### Shadow Specialization

#### Vampiric Embrace
- **Cast Time:** 2 seconds → Instant (reverted)
- **Developer Note:** Feedback heard, returning to instant cast
- **Impact:** PvP and mobility significantly improved

#### Shadow Weaving
- **Debuff Rename:** "Shadow Vulnerability" → "Shadow Weaving"
- **Reason:** Avoid confusion with Warlock talent
- **Impact:** Clarity only, no mechanical change

#### Shadow Mend (COMPLETE REWORK)
- **Previous:** 3 second cast, 635 mana, 518-616 healing, 85.71% coefficient, 30s cooldown
- **New:**
  - Cast Time: 1.5 seconds
  - Mana Cost: 270
  - Healing: 759-896
  - Healing Power Coefficient: 50%
  - Shadow Spell Power Coefficient: 20% of shadow spell power
  - Cannot target self
  - Damages caster for 50% of effective healing (no damage from overhealing)
  - Self-damage cannot kill caster
- **Impact:** CRITICAL - scales with shadow spell power now, hybrid scaling mechanic, much faster and cheaper

---

### Holy Specialization

#### Holy Nova
- **Mana Cost Reduction:** ~20% for all ranks
  - Rank 1: 185 → 150
  - Rank 2: 290 → 235
  - Rank 3: 400 → 360
  - Rank 4: 520 → 415
  - Rank 5: 635 → 510
  - Rank 6: 750 → 600
- **Base Damage:** Reduced by 5%
- **Spell Power Coefficient:** 16% → 15%
- **Threat Generation:** Now generates 25% reduced threat
- **Impact:** More mana efficient, better threat management

#### Empower Champion
- **Previous:** +30 Attack Power, +20 Spell Power
- **New:** +5% damage dealt
- **Impact:** Scales with gear/level, percentage-based scaling

#### Proclaim Champion
- **Previous:** +230 Armor, +10 All Resistances
- **New:** +5% damage reduction, All Resistances = 50% of caster level
- **Impact:** Scales with level, percentage-based mitigation

---

### August 2025 Revision (1.18.0 Hotfix)

#### Searing Light (Discipline Talent)
- **Mana Cost Reduction:** 20% → 50%
- **Impact:** Major mana efficiency buff for Discipline DPS

---

## Stat Priority Impact Summary

### All Specializations
1. **Spell Power:** Inner Fire grants spell damage (13-74 based on rank), major value increase for all specs
2. **Inner Fire Scaling:** Improved Inner Fire talent affects spell damage component
3. **Spirit:** Divine Spirit baseline, Spirit of Redemption +5% Spirit for Holy

### Discipline Priority Changes
1. **Spell Power:**
   - Inner Fire: +13-74 spell damage baseline
   - Improved Inner Fire: Amplifies spell damage from Inner Fire
   - Smite: +10% base damage, improved coefficients
   - Holy Fire: 85% → 100% coefficient
   - Enlighten: +10% (15% self) spell damage when active
   - Purifying Flames: +12% Holy damage for 8-10 seconds
   - Resurgent Shield: +6% of shield absorption as Holy spell damage
2. **Critical Strike:**
   - Searing Light: Crits proc instant Smite with 50% mana reduction
   - Divinity: Affects Holy and Discipline spells
3. **Intellect:** Mental Strength increases total Intellect + 1-3% casting speed
4. **Haste:** Mental Strength adds 1-3% casting speed, Chastise grants 10-15% haste to allies

### Holy Priority Changes
1. **Healing Power:**
   - Base healing: -15% on all spells above level 30
   - Spiritual Healing: +6/12/18/24/30% (compensates nerf when deep spec)
   - Swift Recovery: +3/6% when target has Renew
   - Lightwell: 17% healing power scaling
   - Spiritual Guidance: Spirit → healing conversion
2. **Spirit:**
   - Spirit of Redemption: +5% Spirit
   - Spiritual Guidance: Converts Spirit to healing power
   - More valuable for Holy than other specs
3. **Critical Strike:**
   - Divinity: Affects healing spells
4. **Holy Champion Scaling:**
   - Proclaim Champion: 5% damage reduction (was flat armor)
   - Empower Champion: 5% damage increase (was flat AP/spell power)
   - Scales with target's gear/level

### Shadow Priority Changes
1. **Spell Power:**
   - Inner Fire: +13-74 spell damage baseline
   - Mind Flay: 45% → 75% coefficient (MAJOR buff)
   - Mind Blast: 42.85% → 60% coefficient
   - Pain Spike: 42.85% → 25% coefficient (MAJOR nerf)
   - Shadow Mend: Scales with 50% healing power + 20% shadow spell power (1.18.0)
2. **Spirit:**
   - Improved Shadowform: 15% mana regen continues while casting
   - Significantly more valuable than vanilla
3. **MP5:**
   - Combat mana regen from Improved Shadowform reduces MP5 value slightly
4. **Hybrid Healing:**
   - Shadow Mend: Benefits from shadow spell power (20% coefficient)

### Racial Scaling (Night Elf)
1. **Ranged Weapon Stats:** Searing Shot scales with bow weapon damage + 33% spell power
2. **Spell Power:** Searing Shot, Starshards benefit from spell power
3. **Bow Stats:** Night Elf Priests now value ranged weapon stats

---

## Critical Scaling Breakpoints

### Power Word: Shield
- **Coefficient:** 10% → 35% (250% increase)
- **Absorption:** Force of Will adds up to 20% absorption
- **Impact:** Spell power value tripled for shielding

### Healing Power Deep Holy
- **Baseline:** -15% healing for ranks above level 30
- **Spiritual Healing:** +30% at max rank (5 points)
- **Swift Recovery:** +6% with Renew active (2 points)
- **Net Result:** +21% healing with deep Holy spec vs -15% without
- **Breakpoint:** 7+ points in Holy tree to exceed vanilla healing

### Shadow Spell Power
- **Mind Flay:** 75% coefficient (primary filler)
- **Mind Blast:** 60% coefficient
- **Shadow Mend:** 50% healing power + 20% shadow spell power
- **Impact:** Spell power highly valuable, Mind Flay especially strong

### Discipline DPS Combo
- **Searing Light Proc:** Instant Smite with 50% mana reduction
- **Purifying Flames:** +12% Holy damage after Holy Fire
- **Enlighten:** +10-15% spell damage
- **Combined:** Potential for high burst DPS with cooldown stacking

---

## Implementation Notes for ClassicHawsJon_small.lua

### High Priority Changes

1. **Inner Fire Spell Damage:**
   - Add 13-74 spell damage to base values (rank-dependent)
   - Improved Inner Fire: Multiply by 1.1/1.2 at ranks 1/2
   - Critical for all spell-casting Priests

2. **Power Word: Shield Coefficient:**
   - 10% → 35% spell power scaling
   - Force of Will: +4-20% absorption
   - Massive spell power value increase for shielding

3. **Healing Power (Holy Deep Spec):**
   - Baseline: -15% for ranks above level 30
   - Spiritual Healing: +6/12/18/24/30% (5 ranks)
   - Swift Recovery: +3/6% with Renew active (2 ranks)
   - Lightwell: 17% healing power coefficient
   - Net: Requires 7+ Holy talents to exceed vanilla healing

4. **Shadow Spell Power Coefficients:**
   - Mind Flay: 45% → 75%
   - Mind Blast: 42.85% → 60%
   - Pain Spike: 42.85% → 25%
   - Shadow Mend: 50% healing power + 20% shadow spell power (hybrid)
   - Holy Nova (in Shadowform): Available

5. **Discipline Spell Power Coefficients:**
   - Holy Fire: 75% → 85.7% (1.16.1) → 100% (1.17.2)
   - Smite: +10% base damage, +5% coefficient (April 2025)
   - Holy Nova (talent): 10.7% → 16.1%

### Medium Priority Changes

1. **Spirit Value (Shadow):**
   - Improved Shadowform: 15% mana regen continues while casting
   - Spirit significantly more valuable than vanilla for Shadow

2. **Critical Strike (Discipline):**
   - Searing Light: Crits proc instant Smite
   - Divinity: Affects both healing and damage
   - Crit more valuable for burst damage

3. **Intellect (Discipline):**
   - Mental Strength: Increases total Intellect, adds 1-3% casting speed
   - Dual benefit from single talent

4. **Haste:**
   - Mental Strength: +1-3% casting speed
   - Chastise: Grants 10-15% haste to allies
   - New stat consideration

### Low Priority Changes

1. **Buff Mana Costs:** Significantly reduced across the board, MP5 slightly less valuable for buff maintenance

2. **Threat Reduction:**
   - Holy Nova: 25% reduced threat (1.18.0)
   - Mind Blast: 200% → 170% threat modifier
   - Blessed Concentration: Available to Shadow via talent swap

3. **Racial Bonuses:**
   - Night Elf: Searing Shot (bow + spell power), Starshards (reworked)
   - Human: Feedback doubled
   - Dwarf: Avatar defensive utility

---

## Sources

All information compiled from official Turtle WoW changelogs:
- `turtle-wow-changelogs/1.16.1.html` (lines 560-617)
- `turtle-wow-changelogs/1.17.0.html` (Champion's Grace change)
- `turtle-wow-changelogs/1.17.2-priest-changes.html` (complete file, lines 1-331)
- `turtle-wow-changelogs/1.17.2-2024.10.21-changes.html` (lines 49-66)
- `turtle-wow-changelogs/1.17.2-2024.11.01-changes.html` (lines 31-54)
- `turtle-wow-changelogs/1.17.2-2024.11.20-changes.html` (lines 71-85)
- `turtle-wow-changelogs/1.17.2-2024.12.20-changes.html` (lines 209-254)
- `turtle-wow-changelogs/1.17.2-2025.04.01-changes.html` (lines 223-254)
- `turtle-wow-changelogs/1.18.0-priest-changes.html` (complete file, lines 1-80 + August 2025 revision lines 5-7)

**Last Updated:** Based on changelogs through Patch 1.18.0 (Scars of the Past) and all hotfixes through August 2025
