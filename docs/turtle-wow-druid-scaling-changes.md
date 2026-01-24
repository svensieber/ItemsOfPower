# Turtle WoW Druid Scaling Changes

This document tracks all Druid-specific changes from Turtle WoW that affect stat scaling and item valuation for the Pawn addon.

**Base Reference:** Vanilla 1.12.1 Druid stat scaling is implemented in `ClassicHawsJon_small.lua`.

---

## Version 1.16.1 - Mysteries of Azeroth

### Balance Changes

#### Natural Weapons Talent
- **Change:** Ranks reduced to 3 (from 5) and now add 1/2/3% melee and spell hit alongside 3/6/10% physical damage.
- **Impact:** Hit Rating becomes a core part of early Balance/Feral talent scaling, and fewer points are required to unlock deeper tiers.

#### Nature's Grace Update
- **Change:** Spell critical strikes now reduce both the cast time *and* global cooldown of the next spell by 0.5 seconds.
- **Impact:** Spell Crit directly accelerates follow-up casts, pushing crit rating higher in Balance stat weights.

#### Moonkin Form Mana Reduction
- **Change:** Moonkin Form now reduces the mana cost of Balance spells by 20% while maintaining the 3% party crit aura and 360% armor bonus.
- **Impact:** Sustained casting improves; Intellect and Spirit gain relative value through better mana efficiency.

### Feral Combat Changes

#### Thick Hide Consolidation
- **Change:** Talent now has 3 ranks granting 3/6/10% armor from items (previously 5 ranks for the same max bonus).
- **Impact:** Bears reach full armor scaling with fewer points, freeing talents for damage or utility picks.

#### Feral Instinct Consolidation
- **Change:** Threat bonus reduced to 3 ranks providing 5/10/15% increased threat in Bear/Dire Bear Form (was 5 ranks).
- **Impact:** Full threat modifier is cheaper, letting bear tanks invest elsewhere while keeping AoE threat scaling intact.

#### New Talent: Blood Frenzy
- **Effect:** Extends Tiger's Fury by 3/6 seconds, grants 5/10 rage when activating Enrage, and adds 6/12% attack speed for 6/12 seconds after Tiger's Fury or Enrage.
- **Impact:** Attack Power, Haste, and rage generation gain new synergy windows for both cat DPS and bear threat.

#### New Talent: Berserk
- **Effect:** 6-minute cooldown; doubles Cat Form energy regeneration and increases Bear Form health by 20% for 20 seconds while breaking fear.
- **Impact:** Creates burst resource/health windows that reward stacking AP, crit, and stamina for respective forms.

### Restoration Changes

#### Subtlety Threat Reduction
- **Change:** Now reduces threat from Balance spells in addition to healing spells (4/8/12/16/20%).
- **Impact:** Balance/resto hybrids can chase higher spell damage and crit without surpassing tank threat caps.

#### New Talent: Tree of Life Form
- **Effect:** Aura increases party healing received by 20% of the druid's Spirit and reduces healing spell mana costs by 20% while limiting the form to HoT-focused casting.
- **Impact:** Spirit becomes a premier resto stat and healing power gains multiplicative payoff when combined with later Tree of Life upgrades.

## Version 1.17.0 - Hyjal

### New Abilities

#### Emerald Blessing (Raid Buff)
- **Acquisition:** Quest in Emerald Sanctum
- **Cost:** 1 Bright Dream Shard per cast
- **Effect:** Raid members within 80 yards gain:
  - 10% movement speed
  - 1% spell hit
  - 5% mana regeneration in combat
- **Impact:** Major raid utility, makes Spirit more valuable (5% combat regen)

### Restoration Changes

#### Tree of Life Aura
- **Previous:** Increases healing by flat value
- **New:** Increases healing power (%)
- **Impact:** CRITICAL - Healing power now scales multiplicatively with this aura
- **Note:** Makes healing power much more valuable for Tree of Life spec

---

## Version 1.17.2 - Tower of Karazhan

### Baseline Changes

#### Manual Crowd Pummeler Nerf
- **Previous:** 50% attack speed increase, no cooldown
- **New:** 20% swing speed increase, 20 minute cooldown
- **Impact:** CRITICAL - Removes MCP dependency for optimal DPS/threat
- **Note:** No longer functions in shapeshifting forms
- **Stat Weight Impact:** Attack Power, Agility, and Strength become relatively more valuable

#### Consumables in Forms
- **New:** Can use consumable items in Cat and Bear forms
- **Items:** Potions, healthstones, and similar consumables

#### New Ability: Ferocious Bite (Rank 1)
- **Level:** 24
- **Type:** Finishing move
- **Scaling:** Scales with Attack Power
- **Energy Conversion:** Each extra point of energy = 1 additional damage
- **Impact:** New finisher option for leveling cats

#### Cat Form Combo Points
- **Change:** Combo points no longer vanish when switching targets
- **Mechanic:** Reset when applying combo points on new target
- **Impact:** Quality of life, allows target switching without losing combo points

#### Swipe AP Scaling
- **Scaling:** All ranks now scale with 8% of Attack Power
- **Impact:** Benefits from AP stacking for AoE threat/damage

#### Savage Bite Threat
- **Change:** Threat from damage increased 175% → 350%
- **Impact:** Increased threat generation for bear tanks

#### Frenzied Regeneration Rework
- **Formula:** Converts 10 rage per second into health
- **Scaling:** Each rage point = 6/7/8% of total stamina (by rank)
- **Cooldown:** Increased to 6 minutes
- **Impact:** Stamina becomes more valuable for self-healing

#### New Ability: Barkskin (Feral)
- **Level:** 44, 52, 60
- **Effect:** Reduces damage of next 5/10/15 melee attacks by 50%
- **Duration:** 12 seconds
- **Cooldown:** 10 minutes
- **Drawback:** 20% movement speed reduction
- **Impact:** New defensive cooldown for feral druids

#### DoT Duration Increases
- **Moonfire (Ranks 2-10):** Duration increased to 18 seconds (+2 ticks)
- **Insect Swarm (All ranks):** Duration increased to 18 seconds (+3 ticks)
- **Impact:** More damage per cast, better mana efficiency, higher total spell damage value

#### Spell Damage Increases
- **Wrath:** Base damage and spell power coefficient increased by 5%
- **Impact:** Spell damage slightly more valuable for Balance

#### Ability Scaling Changes
- **Rake:** Initial damage scales with 12% AP, bleed scales with 3% AP
- **Tiger's Fury Rank 3/4:** Damage bonus increased to 35/50 (was lower)
- **Impact:** Attack Power more valuable for cat DPS

#### Regrowth Mana Cost
- **Change:** Reduced by 20% for all ranks
- **Impact:** Spirit and Mp5 relatively less important, spell damage/healing power more valuable per mana

#### Hurricane Changes
- **Attack Speed Slow:** Removed from baseline (moved to talent)
- **Cooldown:** Reduced to 30 seconds (was longer)
- **Spell Power Scaling:** Increased to 9.6% per tick
- **Impact:** Spell damage more valuable for AoE scenarios

---

### Balance Changes (1.17.2)

#### New Talent: Sylvan Blessing (Row 1, 2 Ranks)
- **Effect:** 50/100% chance on kill to allow 100% mana regen while casting for 15 seconds
- **Impact:** Spirit extremely valuable while leveling with this talent

#### Improved Moonfire
- **Change:** Now 2 points instead of 5
- **Impact:** Talent point efficiency increased

#### New Talent: Guidance of the Dream (Row 2, 3 Ranks)
- **Effect:** 23/46/70% chance to avoid interruption while casting Balance spells
- **Impact:** Reduces need for concentration/spell pushback resistance

#### Moonfury (Moved to Row 3)
- **Change:** Now 3 ranks (down from 5), includes Hurricane and Insect Swarm
- **Impact:** More efficient talent point investment for spell damage scaling

#### Moonkin Form Armor Change
- **Level 30:** 180% armor increase
- **Level 40 (Improved):** Returns to 360% armor increase
- **Impact:** Armor value changes based on talent investment timing

#### Owlkin Frenzy (Row 5, 3 Ranks)
- **Previous:** Baseline ability
- **New:** Talent with 30% pushback protection
- **Effect:** Regenerates 1% max mana per second for 10 seconds
- **Cooldown:** Can trigger once every 25 seconds
- **Impact:** Mana regeneration and pushback protection tied to talent

#### New Talent: Balance of All Things (Row 6, 5 Ranks)
- **Insect Swarm:** 6/12/18/24/30% chance to reduce Starfire cast time by 0.5s (stacks 3x)
- **Moonfire:** 6/12/18/24/30% chance to reduce Wrath mana cost by 50% (stacks 3x)
- **Impact:** Major rotation change, increases value of maintaining DoTs

#### New Talent: Gale Winds (Row 6, 2 Ranks)
- **Effect:** Hurricane reduces attack speed by 12/25%
- **Impact:** Utility talent, no direct stat scaling impact

#### New Capstone: Eclipse (Row 7)
- **Starfire Crit:** +25% Nature damage for 15 seconds
- **Wrath Crit:** +25% Arcane damage for 15 seconds
- **Cooldown:** Each effect has separate 30s cooldown
- **Note:** Both effects cannot occur simultaneously
- **Impact:** Critical strike chance becomes MUCH more valuable - directly increases damage bonus

#### Omen of Clarity
- **Change:** Now passive when learned
- **Impact:** Always active, no need to buff

---

### Feral Combat Changes (1.17.2)

#### New Talent: Open Wounds (Row 2, 3 Ranks)
- **Effect:** Claw damage +10/20/30% if target has Rake
- **Effect:** Rip increases Claw damage by 3/4/5% per combo point spent for 15s
- **Impact:** Bleed effects become critical for maximizing Claw damage

#### Feline Swiftness → Feral Swiftness
- **Change:** Now also grants dodge bonus to Bear and Dire Bear form
- **Impact:** Dodge rating more valuable for bears

#### Blood Frenzy
- **Change:** Attack speed bonus increased 12% → 30%
- **Rage Generation:** Now generates 10 rage (was double, bug fixed)
- **Impact:** Significant haste value increase when active

#### New Talent: Feral Adrenaline (Row 5, 3 Ranks)
- **Effect:** Physical crit against you = +15/30/45% dodge until next dodge
- **Cooldown:** Once every 30 seconds
- **Impact:** Dodge rating more valuable for damage mitigation after crits

#### New Talent: Ancient Brutality (Row 6, 3 Ranks)
- **Effect (Bear):** Dodging returns 5/10/15% damage dealt as healing + 1/2/3 rage/sec for 5s
- **Cooldown:** Once every 6 seconds
- **Impact:** Dodge rating generates rage and healing for bears

---

### Restoration Changes (1.17.2)

#### New Passive: Efflorescence (Level 60)
- **Requirement:** Tree of Life Form
- **Effect:** When Regrowth/Rejuvenation replaced, instantly heals for portion of remaining duration
- **Impact:** Multiple resto druids scale better together, HoT healing power more valuable

#### New Talent: Genesis (Row 4, 3 Ranks)
- **Effect:** Increases damage and healing of periodic spells by 5/10/15%
- **Impact:** Healing power and spell damage on DoTs/HoTs scale better

#### Tranquil Spirit
- **Change:** Now includes Regrowth
- **Impact:** Mana efficiency for Regrowth improved

#### New Talent: Aessina's Bloom (Row 5, 2 Ranks)
- **Effect:** 30/60% chance for Healing Touch to instantly heal = 6s of Regrowth if target has Regrowth
- **Impact:** Synergy between multiple druids, increases value of healing power

#### New Talent: Preservation (Row 5, 3 Ranks)
- **Effect:** Regrowth periodic healing +10/20/30% if target has Rejuvenation
- **Impact:** Healing power scales better when maintaining both HoTs

#### Improved Tranquility (Row 6)
- **Effect:** +20/40% healing from Tranquility
- **Impact:** Healing power more valuable for raid healing

---

### Hotfix Changes (Post-1.17.2)

#### October 21, 2024
- **Insect Swarm:** Now stacks when cast by multiple druids (same rank)
- **Mighty Rage Potion:** Can now be used by Druids

#### November 1, 2024
- **Blood Frenzy:** Attack speed 30% → 20%, duration 12s → 18s
- **Swipe:** AP scaling 8% → 6%
- **Swipe:** Threat modifier 175% → 140%
- **Savage Bite:** Threat modifier 350% → 225%
- **Improved Shred:** Now increases Shred damage by 5/10% for 5s after entering Cat Form
- **Open Wounds:** Claw damage per combo point from Rip: 3/4/5% → 2/4/6%

#### November 20, 2024
- **Barkskin (Feral):** No longer magic effect, only direct physical damage consumes charges
- **Improved Shred:** Buff duration 5s → 10s

#### December 20, 2024
- **Open Wounds:** Reworked - Claw +10/20/30% per active Bleed, Ferocious Bite +3/4/5% per active Bleed
- **Ancient Brutality:** Bleed ticks restore 2/3/4 Energy in Cat Form, dodge generates 1/2/3 rage/sec for 5s in Bear (cooldown increased to 9s, vampirism removed)
- **Feral Adrenaline:** Dodge bonus 15/30/45% → 20/40/60%
- **Swipe:** AP scaling 6% → 4%
- **Frenzied Regeneration:** Cooldown 6 min → 5 min
- **Balance of All Things:** Starfire cast time reduction 0.5s → 0.75s
- **Eclipse:** Now adds debuff showing which Eclipse is on cooldown
- **Savage Bite:** Damage reduced (100% weapon damage + 61 → 80% weapon damage + 30)
- **Grizzled Hide (Feral T3 8pc):** Duration 15s, max stacks 10 → 4, damage reduction 1% → 2% per stack
- **Rip:** No longer replaces Pounce

#### April 1, 2025
- **Form Shifting:** Can now shift between forms without shifting out first
- **Ancient Brutality:** 3 points → 2 points, Energy 2/3/4 → 5/10, Rage 1/2/3 → 2/4
- **Claw Rank 5:** Weapon damage increased by 5%
- **Shred Rank 6:** Weapon damage increased by 5%
- **Rake Rank 4:** Base damage and DoT increased by 5%
- **Predatory Strikes:** 50/100/150% of level AP → 3/6/10% total AP
- **Mark/Gift of the Wild:** Now castable in Moonkin Form
- **Balance T3 6pc:** Can no longer be resisted
- **Owlkin Frenzy:** Pushback always 30%, cooldown scales 30/25/20s by rank
- **Hurricane:** Cooldown 30s → 10s
- **Feral Combat T2.5 3pc:** Now also reduces Shred energy cost by 3
- **Eclipse:** Arcane/Nature damage bonus 25% → 30%

---

## Version 1.18.0 - Scars of the Past

### Baseline Changes

#### New Spell: Reshift (Level 60)
- **Effect:** Cancels and reapplies current shapeshift form
- **Cost:** 35% base mana
- **Impact:** Easier Furor energy generation for high-ping players

#### Additional Consumables in Forms
- **New:** Jujus, Gift of Arthas, Lucidity Potion, Bandages usable in Cat/Bear forms

#### Tiger's Fury Energy Generation
- **New:** Generates 10 Energy every 3 seconds
- **Impact:** Additional energy source, less reliance on Furor for energy management

#### Ferocious Bite Energy Conversion
- **Previous:** Each extra energy point adds flat damage
- **New:** Each extra energy point increases damage by 0.5%
- **Impact:** Scales better with gear, Attack Power more valuable for Ferocious Bite

#### Rip Duration Scaling
- **Previous:** Always 12 seconds regardless of combo points
- **New Durations:**
  - 1 CP: 10 seconds
  - 2 CP: 12 seconds (unchanged)
  - 3 CP: 14 seconds
  - 4 CP: 16 seconds
  - 5 CP: 18 seconds
- **Impact:** Up to 50% more damage at 5 CP, bleed damage much more valuable

#### Rejuvenation & Regrowth Tick Rate
- **Previous:** Heals every 3 seconds
- **New:** Heals every 2 seconds
- **Impact:** Total healing unchanged, but faster response time
- **Note:** Regrowth duration reduced 21s → 20s to match intervals

#### Efflorescence Bug Fix
- **Fix:** Now heals correct amount as intended

---

### Balance Changes (1.18.0)

#### Nature's Reach
- **New:** Also increases range of Abolish Poison and Remove Curse
- **Impact:** Utility improvement for hybrid specs

#### Balance of All Things
- **Change:** Starfire cast time reduction 0.8s → 0.5s
- **Impact:** Reduces value of cast time reduction, increases value of Haste rating

#### Gale Winds
- **New:** Reduces Hurricane mana cost by 10/20%
- **Change:** Attack speed reduction duration 10s → 2s (when leaving Hurricane area)
- **Impact:** Mana efficiency improved for AoE situations

#### Eclipse Rework
- **Previous:** Critical strikes trigger 25% damage buff for 15s
- **New Formula:**
  - Wrath: 30% chance to grant Arcane Eclipse
  - Starfire: 50% chance to grant Natural Eclipse
  - Damage bonus = 10% + (60% of crit chance)
- **Example:** At 30% crit, Eclipse grants 10% + 18% = 28% damage
- **Impact:** MAJOR - Crit scaling now multiplicative with Eclipse bonus, crit becomes EXTREMELY valuable

#### Balance T3.5 5pc Bonus
- **Improved Balance of All Things:** Bonus 33% → 50%

---

### Feral Combat Changes (1.18.0)

#### Open Wounds (Moved Row 2 → Row 5, then back to Row 2 in August 2025)
- **Previous:** Ferocious Bite +3/4/5% per Bleed
- **New:** Rip damage +5/10/15%, Claw +10/20/30% per active Bleed
- **Impact:** Focus shifted entirely to Bleeds, Rip damage directly increased
- **August 2025:** Moved back to Row 2 for better talent accessibility

#### Improved Shred
- **Previous:** +5/10% for 5s after entering Cat Form
- **New:** Always +5/10% damage
- **Impact:** No longer requires form dancing, consistent DPS increase

#### Primal Fury
- **Position:** Moved Row 4 → Row 3

#### Savage Fury → Predatory Strikes Merge
- **Savage Fury:** Removed
- **Predatory Strikes:** Now includes +7/14/20% damage to Claw, Rake, Maul, Savage Bite, Swipe
- **Impact:** Talent consolidation, more points available for other talents

#### Ancient Brutality (Moved Row 6 → Row 5)
- **Change:** Energy from Bleed ticks reduced 5/10 → 3/5
- **Impact:** Bleed energy generation nerfed, but Tiger's Fury compensates

#### Feral Adrenaline
- **Status:** Removed

#### New Talent: Carnage (Row 6, 2 Ranks)
- **Effect (Bear):** Maul/Swipe/Savage Bite return 5/10% damage as healing
- **Effect (Cat):** Ferocious Bite 10/20% chance per CP to refresh Rake/Rip and add 1 CP
- **Impact:** Self-healing for bears, major quality of life for cats maintaining bleeds

---

### Restoration Changes (1.18.0)

#### Aessina's Bloom Rework
- **Previous:** Instant heal based on Regrowth
- **New:** Healing Touch on Regrowth/Rejuvenation target reduces next HT cast time by 0.15/0.3s and refunds 5/10% mana
- **Effect Duration:** 20 seconds
- **Prerequisite:** Changed from Swiftmend to Improved Healing Touch
- **Impact:** Healing Touch becomes more viable, healing power more efficient

#### Genesis
- **Position:** Moved Row 4 → Row 3

#### Nature's Swiftness
- **Position:** Swapped with Aessina's Bloom
- **Prerequisite:** Swiftmend → Genesis

#### Improved Regrowth
- **Prerequisite:** Genesis → Gift of Nature

#### Gift of Nature (Moved Row 3 → Row 4)
- **Previous:** Increases base healing
- **New:** Increases total healing (benefits from healing power)
- **Impact:** MAJOR - Healing power now scales multiplicatively with this talent

#### Tree of Life Form
- **New:** +180% armor from items
- **Impact:** Armor more valuable for Tree of Life healers

---

## Version 1.18.1

### Feral Combat Changes (1.18.1)

#### Maul Threat Reduction
- **Previous:** Base threat modifier
- **New:** Threat modifier reduced by 15%
- **Impact:** Bear threat generation reduced, may require more Attack Power/Hit to maintain threat

#### Savage Bite Threat Reduction
- **Previous:** Base threat modifier (225% as of November 2024 hotfix)
- **New:** Threat modifier reduced by 12%
- **Impact:** Bear threat generation further reduced, affects overall tanking stat weights

---

### Balance Changes (1.18.1)

#### Balance of All Things Rework
- **Previous:** 5 points, Insect Swarm/Moonfire procs affected Starfire cast time/Wrath mana cost
- **New:** 3 points with reworked effects:
  - Wrath on Insect Swarm targets returns 10/20/30% of mana cost
  - Starfire has 2/4/6% higher crit chance vs Moonfire targets
- **Impact:**
  - Fewer talent points required (3 vs 5)
  - Crit rating value increased due to conditional crit bonus on Starfire
  - Mana efficiency improved for Wrath spam on DoT targets
  - Maintains importance of DoT uptime for rotation optimization

---

## Stat Priority Impact Summary

### Balance Druid

#### Extremely High Priority
1. **Spell Crit** - Eclipse damage bonus = 10% + (60% of crit %) in 1.18.0
2. **Spell Damage** - Wrath/Starfire base damage, Hurricane scaling improved

#### High Priority
3. **Spell Hit** - To 16% cap (8% with talents)
4. **Intellect** - Larger mana pool, 1% crit per 60 Int
5. **Spell Haste** - More casts, more Eclipse procs

#### Medium Priority
6. **Mp5** - Sustained casting
7. **Spirit** - Out of combat regen, Sylvan Blessing synergy while leveling

### Feral Cat DPS

#### Extremely High Priority
1. **Attack Power** - Scales all abilities, Ferocious Bite conversion improved in 1.18.0
2. **Agility** - AP, crit, dodge
3. **Hit Rating** - To 9% melee hit cap (6% with talents)

#### High Priority
4. **Crit Rating** - Primal Fury, more finishers
5. **Strength** - AP conversion (less efficient than Agi for cats)
6. **Haste Rating** - More attacks, more combo points

#### Medium Priority
7. **Stamina** - Survivability
8. **Armor** - Mitigation in cat form

#### Low Priority (But Not Worthless)
9. **Dodge** - Defensive stat only

### Feral Bear Tank

#### Extremely High Priority
1. **Armor** - Primary mitigation stat (no longer capped at 75% in 1.18.0!)
2. **Stamina** - Health pool, Frenzied Regeneration scaling
3. **Agility** - Dodge, some AP

#### High Priority
4. **Dodge Rating** - Ancient Brutality rage generation, Feral Swiftness bonus
5. **Attack Power** - Threat generation (Swipe, Maul, Savage Bite)
6. **Hit Rating** - Consistent threat

#### Medium Priority
7. **Defense Rating** - Crit immunity at 415 (needs 140 defense rating)
8. **Strength** - AP conversion

#### Low Priority
9. **Crit Rating** - Minor threat boost

### Restoration Druid

#### Extremely High Priority
1. **Healing Power** - Tree of Life Aura scales multiplicatively (1.17.0), Gift of Nature scales with total healing (1.18.0)
2. **Mp5** - Sustained raid healing

#### High Priority
3. **Intellect** - Mana pool, longer sustained healing
4. **Spirit** - Mana regen, some in-combat with talents, Emerald Blessing provides 5% combat regen (1.17.0)
5. **Spell Haste** - Faster cast times for Healing Touch

#### Medium Priority
6. **Spell Crit** - Some throughput increase
7. **Stamina** - Survivability

#### Low Priority (Tree of Life)
8. **Armor** - Tree of Life grants +180% armor from items in 1.18.0

---

## Critical Scaling Breakpoints

### Balance Eclipse Scaling (1.18.0)
- **Formula:** Damage Bonus = 10% + (60% of crit chance)
- **Examples:**
  - 20% crit = 10% + 12% = 22% damage bonus
  - 30% crit = 10% + 18% = 28% damage bonus
  - 40% crit = 10% + 24% = 34% damage bonus
  - 50% crit = 10% + 30% = 40% damage bonus

### Feral Bear Armor (1.18.0)
- **Previous:** Hard capped at 75% damage reduction
- **New:** Diminishing returns beyond 75%, no hard cap
- **Impact:** Armor stacking beyond old cap still provides value

### Feral Cat Energy Economy
- **Ancient Brutality:** 3/5 energy per Bleed tick (1.18.0)
- **Tiger's Fury:** 10 energy every 3s (1.18.0)
- **Furor + Reshift:** 60 energy (with Reshift QoL in 1.18.0)

---

## Sources

All information compiled from official Turtle WoW changelogs:
- 1.16.1.html (Druid class overhaul, new talents)
- 1.17.0.html (Emerald Blessing, Tree of Life Aura)
- 1.17.2-druid-changes.html
- 1.17.2-2024.10.21-changes.html (Insect Swarm stacking, Mighty Rage Potion)
- 1.17.2-2024.11.01-changes.html (Blood Frenzy, Swipe, Savage Bite nerfs)
- 1.17.2-2024.11.20-changes.html (Barkskin, Improved Shred)
- 1.17.2-2024.12.20-changes.html (Open Wounds, Ancient Brutality, Balance of All Things, Eclipse)
- 1.17.2-2025.04.01-changes.html (Form shifting, stat changes, Hurricane)
- 1.18.0-druid-changes.html
- 1.18.0-general-class-changes.html (Armor cap removal)
- 1.18.1-druid-changes.html (Maul/Savage Bite threat nerfs, Balance of All Things rework)

**Last Updated:** Based on changelogs from Patch 1.16.1 through 1.18.1

---

## Implementation Notes for ClassicHawsJon_small.lua

### Critical Changes Requiring Stat Weight Updates

#### Balance Druid
1. **Eclipse Formula (1.18.0):** Crit value must reflect multiplicative scaling (10% + 60% of crit)
2. **Spell Damage Coefficients:** Wrath +5%, Hurricane scaling increased
3. **DoT Duration:** Moonfire/Insect Swarm now 18s (affects damage per cast)
4. **Natural Weapons Talent (1.16.1):** Provides up to 3% melee/spell hit; incorporate talent-driven hit into caps.

#### Feral Cat
1. **Ferocious Bite:** Energy conversion now 0.5% per point (better AP scaling)
2. **Rip Duration:** Scales 10-18s based on CP (up to +50% damage at 5 CP)
3. **MCP Removed:** AP/Agi/Str relatively more valuable without MCP meta

#### Feral Bear
1. **Armor Cap Removed (1.18.0):** Armor no longer capped at 75%, continues with diminishing returns
2. **Stamina:** Scales Frenzied Regeneration (6/7/8% of stamina per rage point)
3. **Dodge:** Ancient Brutality provides rage generation on dodge

#### Restoration
1. **Tree of Life Aura (1.17.0):** Changed from flat healing to healing power % - healing power now scales multiplicatively
2. **Gift of Nature (1.18.0):** Now increases total healing (multiplicative with healing power)
3. **Healing Power:** Much more valuable due to Tree of Life Aura (1.17.0) and Gift of Nature (1.18.0) changes
4. **Spirit:** Emerald Blessing provides 5% combat mana regen for raid (1.17.0)
5. **Rejuv/Regrowth:** Faster tick rate (2s instead of 3s) - same total healing
6. **Tree of Life Form (1.16.1):** Aura adds 20% of Spirit as group healing received; ensure Spirit weights reflect this baseline bonus.
