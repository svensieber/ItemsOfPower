# Turtle WoW Paladin Scaling Changes

This document tracks all Paladin-specific changes from Turtle WoW that affect stat scaling and item valuation for the Pawn addon.

**Base Reference:** Vanilla 1.12.1 stat scaling is implemented in `ClassicHawsJon_small.lua`.

**Related Documentation:** See `turtle-wow-general-scaling-changes.md` for non-class-specific changes (weapon skill rework, hit cap changes, armor cap removal, etc.).

---

## Version 1.16.1 - First Class Changes

### Baseline Changes

#### Consecration
- **Change:** Now baseline ability (was Holy talent)
- **Spell Power Coefficient:** 0.042 → 0.119 (increased by 183%)
- **Mana Cost:** Reduced
- **Impact:** Massive damage scaling improvement for all Paladins, AoE threat generation significantly enhanced

#### Judgement of Righteousness
- **Spell Power Coefficient:** 0.5 → 0.728 (increased by 45.6%)
- **Impact:** Significantly improves spell power scaling for single-target damage

#### Retribution Aura
- **Spell Power Coefficient:** 0.033 added
- **Impact:** Now scales with spell power, increasing damage reflection

#### Crusader Strike (NEW)
- **Type:** New baseline ability
- **Effect:** Melee attack that applies stacking Holy damage debuff on target
- **Mechanics:** Each stack increases Holy damage taken
- **Impact:** New rotational ability, synergizes with Holy damage dealing

#### Holy Shock
- **Rework:** Complete ability redesign
- **Cooldown:** Reduced to 20 seconds
- **Healing:** Increased
- **Damage:** Increased
- **Impact:** More viable as both healing and damage tool

### Holy Specialization

#### Healing Light
- **Update:** Now also amplifies Holy Shock alongside Holy Light and Flash of Light.
- **Impact:** Ensures Holy Shock benefits from the core +healing talent, improving spell power scaling.

### Protection Specialization

#### Redoubt
- **Trigger:** Now has a 2/4/6/8/10% chance to activate from any direct attack instead of only critical hits.
- **Impact:** Provides steadier block uptime, increasing block value effectiveness.

#### Precision (NEW)
- **Effect:** Increases hit chance with melee and spells by 1/2/3%.
- **Impact:** Reduces required hit rating for both threat and spell-based abilities.

#### Shield Specialization
- **Effect:** Increases blocked damage by 10/20/30% and restores 2% mana on block (1 second internal cooldown).
- **Impact:** Elevates block value scaling and adds mana sustain for Protection.

#### Ardent Defender (NEW Talent)
- **Effect:** Reduces damage taken by 25% while below 35% health.
- **Impact:** Adds an execute-range survival layer, boosting stamina valuations.

### Retribution Specialization

#### Heart of the Crusader
- **Effect:** Renamed from Improved Seal of the Crusader and now also increases the Holy damage bonus applied by Crusader Strike.
- **Impact:** Directly ties Crusader Strike debuff strength to talent investment, improving Holy damage scaling.

---

## Version 1.17.0

### Baseline Changes

#### Divine Shield
- **Change:** -100% attack speed penalty removed
- **New Penalty:** -50% damage dealt
- **Impact:** Paladins can now attack while bubbled, but at reduced effectiveness

#### Righteous Fury
- **Change:** Now a toggle ability (was temporary buff)
- **Mana Cost:** Removed
- **Duration:** Permanent (until toggled off)
- **Impact:** Quality of life improvement for Protection, no ongoing mana cost

---

## Version 1.17.2 - Mysteries of Azeroth

### Baseline Changes

#### Crusader Strike (REWORK)
- **Mechanic:** Instant melee strike dealing 80–100% weapon damage plus flat Holy damage with a 33% spell power coefficient; shares a 6 second cooldown with Holy Strike.
- **Zeal:** Grants a Zeal stack (3% attack and casting speed, stacks to 3 for 30 seconds) and refreshes Judgement durations.
- **Impact:** Establishes Crusader Strike as the cornerstone of every paladin rotation and bakes haste value into the kit.

#### Holy Strike (REWORK)
- **Mechanic:** Instant Holy strike sharing the 6 second cooldown with Crusader Strike; damage scales with 43% spell power.
- **Support:** Restores flat health and mana to you and your party equal to the rank value, with healing scaling at 5% of your healing power.
- **Impact:** Provides raid sustain that now scales cleanly with both spell power and healing gear.

#### Hand of Reckoning (NEW)
- **Type:** 10-yard taunt with a 10 second cooldown that generates high threat.
- **Impact:** Supplies Paladins with a reliable baseline single-target taunt for the first time.

#### Hands and Blessings
- **Rename:** Blessing of Freedom, Sacrifice, and Protection become Hands and no longer overwrite active Blessings.
- **Duration:** All Blessings now last 10 minutes; Greater Blessings last 30 minutes.
- **Judgement of the Crusader:** Restored to original functionality so it no longer interacts with chance-on-hit effects.
- **Seal of Wisdom:** Mana return from Judgement procs doubled and new ranks added at levels 18 and 28.
- **Impact:** Reduces buff maintenance overhead while improving baseline mana sustain.

#### Flash of Light (Rank 8)
- **Addition:** New level 60 rank added to keep healing throughput scaling with late-game gear.

---

### Holy Specialization

#### Holy Power
- **Ranks:** Now 3 ranks providing 2/4/6% critical strike to Flash of Light and Holy Light (no longer affects Holy Shock).
- **Impact:** Concentrates crit scaling on core single-target heals.

#### Holy Judgement (NEW Talent)
- **Location:** Tier 2, 3 points.
- **Effect:** Casting Judgement reduces the cast time of your next Holy Light by 0.3/0.6/1.0 seconds.
- **Impact:** Rewards melee uptime with faster tank-heal throughput.

#### Spiritual Focus
- **Adjustment:** Reduced from 5 to 2 talent points while retaining full spell-pushback protection.
- **Impact:** Frees points for new melee-healing synergies.

#### Illumination
- **Mana Return:** Reduced from 20/40/60/80/100% to 12/24/36/48/60% of the spell cost.
- **Impact:** Lowers crit/Intellect driven mana loops, raising the value of external sustain tools.

#### Improved Seal of Righteousness
- **Damage Bonus:** Now adds 10% to total Seal damage (after spell power) instead of 15% base damage.
- **Impact:** Gives hybrid spell-power builds better late-game scaling.

#### Blessed Strikes (NEW Talent)
- **Location:** Tier 6, 5 points.
- **Effect:** Crusader Strike has a 20/40/60/80/100% chance to reset Holy Shock (and reduces the spell’s next global cooldown by 1 second), while Holy Strike’s healing is increased by 30/60/90/120/150%.
- **Impact:** Turns Crusader Strike uptime into Holy Shock throughput and greatly increases Holy Strike’s healing scaling.

#### Daybreak (NEW Capstone)
- **Effect:** Critical heals apply Daybreak for 12 seconds, increasing the target’s healing taken from Flash of Light, Holy Light, and Holy Shock by 20% and boosting maximum health by 5%.
- **Impact:** Pushes Holy Paladins to stack critical strike for sustained single-target support. (Replaced by the 1.18.0 rework detailed below.)

---

### Protection Specialization

#### Shield Specialization
- **Mana Return:** Internal cooldown on the mana restoration proc increased to 5 seconds (was 1 second).
- **Impact:** Keeps multi-target mana sustain from spiraling with the new strikes.

#### Improved Righteous Fury
- **Threat Bonus:** Now increases threat generated by 25/50/75% (up from 16/33/50%).
- **Impact:** Raises baseline threat scaling without tying it to stamina gains.

#### Improved Hand of Reckoning (NEW Talent)
- **Location:** Tier 4, 2 points; adds 4/8% hit chance to Hand of Reckoning.
- **Impact:** Ensures the new taunt lands even when under the melee hit cap.

#### Righteous Defense (NEW Talent)
- **Location:** Tier 5, 3 points; reduces damage taken by 3/6/10% while Righteous Fury is active.
- **Impact:** Provides a new multiplicative mitigation lever for tank gearing.

#### Sacred Duty (NEW Talent)
- **Location:** Tier 6, 3 points; increases total Stamina by 2/4/6%. (Removed in the 21 Oct 2024 hotfix.)
- **Impact:** Temporarily raised stamina scaling until its removal.

#### Holy Shield
- **Block Chance:** Increased to 50% (was 30%).
- **Spell Power Scaling:** Holy damage on block now scales at 33% spell power (up from 5%).
- **Threat Modifier:** Increased to 45%.
- **Impact:** Makes block value and spell power far more meaningful for Protection.

#### Reckoning (REWORK)
- **Mechanic:** Now grants a 5/10/15/20/25% chance to gain an extra attack after blocking an enemy attack.
- **Impact:** Aligns the talent with block-focused mitigation instead of relying on being critically hit.

#### Righteous Strikes (NEW Talent)
- **Location:** Tier 6, 5 points.
- **Effect:** Zeal increases block chance by 1/2/3/4/5% per stack and Holy Strike gains +10/20/30/40/50% damage along with 50% extra threat.
- **Impact:** Converts Crusader Strike uptime into both mitigation and threat scaling.

#### Bulwark of the Righteous (NEW Capstone)
- **Effect:** 5 minute cooldown shield slam dealing Holy damage (43% spell power coefficient) and granting 12 seconds of 30% damage reduction.
- **Impact:** Gives Protection a true defensive cooldown tied to spell power.

---

### Retribution Specialization

#### Improved Blessings
- **Change:** Blessing of Might talent now also increases Blessing of Wisdom by 4/8/12/16/20%.
- **Impact:** Elevates group mana regeneration scaling.

#### Heart of the Crusader
- **Adjustment:** Restored to the original +5/10/15% Seal of the Crusader attack power and Judgement holy damage bonus.
- **Impact:** Keeps Holy damage amplification predictable.

#### Vindication
- **Effect:** Now has a chance to reduce enemy damage output by 1/2/3% for 10 seconds instead of reducing Strength/Agility.
- **Impact:** Works reliably on bosses and adds raid mitigation value.

#### Two-Handed Weapon Specialization
- **Adjustment:** Grants 1/2/3 weapon skill to two-handed swords, maces, and axes.
- **Impact:** Increases effective hit and lowers glancing penalties, boosting weapon skill value.

#### Sanctified Command
- **Status:** Removed (Holy Strike now covers mana sustain/utility duties).
- **Impact:** Simplifies the tree and shifts support to the new strikes.

#### Vengeance (REWORK)
- **Mechanic:** Moved to row 5; grants 1/2/3/4/5% damage per stack, stacks up to 3 for 30 seconds, and reduces threat by 2/4/6/8/10%.
- **Impact:** Converts crit bursts into sustainable damage while easing threat management.

#### Seal and Judgement of Command
- **Scaling:** Seal gains a spell power coefficient; Judgement gains an attack power coefficient.
- **Impact:** Encourages hybrid stat stacking and raises spell power valuation.

#### Crusading Strikes (NEW Talent)
- **Location:** Row 6, 5 points.
- **Effect:** Crusader Strike deals +3/6/9/12/15% damage, Zeal grants an additional 2% attack/casting speed per stack, and Holy Strike grants 4/8/12/16/20% Strength for 20 seconds.
- **Impact:** Ties Strength, haste, and Holy Strike throughput directly to strike uptime.

#### Repentance (REWORK)
- **Effect:** Usable on all creature types; immune targets take 160 Holy damage when attacking/casting (scales with 12% AP and 50% SP, max once every 0.5s) for 30 seconds.
- **Impact:** Provides PvE value and measurable scaling for the capstone.

---

## Version 1.17.2 - Hotfixes

### October 21, 2024

#### Protection
- **Bulwark of the Righteous:** Cooldown increased from 3 minutes to 5 minutes, damage reduction reduced from 40% to 30%
- **Sacred Duty:** Removed from the game (was Stamina increase talent)
- **Impact:** Tank cooldown less available, damage reduction slightly weaker, talent point freed up

---

### November 1, 2024

#### Retribution
- **Crusader Strike:** Weapon damage component reduced by 10%
- **Righteous Strikes:** Holy Strike damage increase reduced to 5/10/15/20/25%
- **Impact:** Retribution single-target damage reduced, affects physical attack power value

---

### November 20, 2024

#### Protection
- **Redoubt:** Block chance bonus reduced from 6/12/18/24/30% to 3/6/9/12/15%
- **Righteous Strikes (Zeal effect):** Reworked - Zeal now increases the amount of damage blocked by 2/4/6/8/10% per stack instead of increasing block chance
- **Impact:** MAJOR - Block chance from Redoubt halved, but Righteous Strikes now provides block value scaling instead of block chance. This shifts Protection scaling from block chance toward block value stats

#### Baseline
- **Crusader Strike:** Reduced weapon damage scaling for lower ranks:
  - Rank 1 (Level 8): 80% → 35%
  - Rank 2 (Level 20): 85% → 50%
  - Rank 3 (Level 30): 90% → 65%
  - Rank 4 (Level 40): 95% → 80%
  - Rank 5 (Level 50): 100% → 90%
- **Impact:** Leveling power reduced, endgame unchanged (Rank 5+ unaffected)

#### Retribution
- **Judgement of Command:** Now uses melee hit chance instead of spell hit chance
- **Impact:** Retribution Paladins now need melee hit rating instead of spell hit rating for Judgement of Command, affects stat priority

---

### December 20, 2024

#### Baseline
- **Crusader Strike:** Normalized weapon damage, reducing the advantage of extremely slow weapons.
- **Holy Strike:** Self-healing reduced by 50% but now heals up to four wounded allies within 10 yards.
- **Impact:** Weapon speed matters less for Retribution, and Holy Strike leans further into group sustain instead of personal burst.

#### Holy
- **Holy Shock:** Healing increased by ~8%, damage increased by ~12%, and mana costs reduced across all ranks.
- **Blessed Strikes:** Holy Strike base healing bonus reduced to 20/40/60/80/100% but now gains an additional 5/10/15/20/25% of your healing power.
- **Divine Favor:** Holy Shock critical strike chance bonus increased to 10/20/30/40/50%.
- **Daybreak:** Holy Shock now contributes 30% (up from 20%) additional healing to targets affected by Daybreak.
- **Blessing of Light:** Now adds +120/+180/+240 healing power to Holy Shock.
- **Impact:** Holy Shock-centric play gains significant throughput while Blessed Strikes shifts from flat gains to scaling with healing power.

#### Protection
- **Holy Shield:** Block chance reduced to 45% (from 50%), spell power scaling lowered to 15%, and threat modifier reduced to 30%.
- **Righteous Strikes:** Holy Strike bonus threat lowered to 6/12/18/24/30%.
- **Impact:** Protection threat is toned down and relies more on block value and disciplined strike uptime.

#### Retribution
- **Seal of Righteousness:** Spell power coefficient increased to 0.082 × weapon speed (1H) and 0.098 × weapon speed (2H).
- **Seal of Command:** Spell power coefficient increased, improving hybrid damage uptime.
- **Vengeance:** Now increases all damage types (previously Holy and Physical only).
- **Crusading Strikes → Vengeful Strikes:** Talent renamed; Crusader Strike damage bonus reduced to 2/4/6/8/10% while retaining the extra Zeal haste and Holy Strike Strength buff.
- **Impact:** Hybrid spell power builds remain competitive while talent throughput is tuned to curb runaway threat.

---

### April 1, 2025

#### Baseline
- **Hammer of Wrath:** No longer resets your swing timer
- **Impact:** Execute phase DPS improved, makes Hammer of Wrath more viable in rotation

- **Blessing of Salvation:** Threat reduction reduced from 30% to 25%
- **Impact:** Slightly increases threat management importance

#### Retribution
- **Vindication:** Damage reduction increased from 1/2/3% to 3/6/9% (tooltip clarified: boss enemies unaffected)
- **Impact:** MAJOR - Vindication becomes much more valuable for solo play and PvP, nearly 3x more effective

- **Seal of Righteousness:** Spell power scaling increased to 0.092 × Weapon Speed (1H) and 0.128 × Weapon Speed (2H)
- **Impact:** CRITICAL - Hybrid Retribution builds now much more viable, spell power value increased significantly for Seal of Righteousness users
  - 1H: 0.082 → 0.092 (12% increase)
  - 2H: 0.098 → 0.128 (31% increase for 2H!)

- **Judgement of Righteousness:** Now properly uses melee critical strike and hit chance instead of spell critical strike and hit chance
- **Impact:** MAJOR - Changes stat priority for Judgement of Righteousness from spell hit/crit to melee hit/crit, affects gearing significantly

- **Eye for an Eye:** Swapped talent tree positions with Two-Handed Weapon Specialization
- **Impact:** QoL improvement for talent pathing, no stat impact

- **Vengeance:** No longer applies threat reduction when Righteous Fury is active
- **Impact:** Retribution Paladins can now off-tank without penalty, improves build flexibility

#### Protection
- **Reckoning:** Proc chance increased from 5/10/15/20/25% to 10/20/30/40/50%
- **Impact:** MAJOR - Reckoning proc rate doubled, significantly increases value of block chance stat for Protection

#### Holy
- **Holy Light:** Rank 1 spellpower coefficient reduced from 71.4% to 20%
- **Impact:** Prevents downranking abuse, minimal impact on normal healing

---

## Version 1.18.0 - Scars of the Past

### Baseline Changes

#### Hand of Freedom
- **Cooldown:** 20 seconds → 24 seconds
- **Impact:** Slightly less available for PvP utility

#### Crusader Strike
- **Spell Power Coefficient:** 33% → 20%
- **Impact:** Spell power scaling reduced for Crusader Strike

#### Divine Shield
- **Damage Reduction:** 50% → 60%
- **Impact:** Slightly improved bubble survivability in exchange for damage

---

### Holy Specialization

#### Daybreak (REWORK)
- **Effect:** Critical heals leave Daybreak on the target for 30 seconds; the next time that ally takes damage they are healed for 348–389 plus 43% of your spell power. The heal cannot crit and can be triggered by Holy Strike’s healing component.
- **Impact:** Converts Daybreak into a delayed burst heal that scales directly with spell power and rewards Holy Shock usage.

#### Holy Shock
- **Damage Functionality:** Offensive Holy Shock restored with updated rank values (damage scales at 43% spell power).
- **Impact:** Re-enables “Shockadin” hybrid play and adds ranged Holy damage back into the toolkit.

---

### Retribution Specialization

#### Seal of Righteousness
- **Two-Handed Weapon Spell Power Coefficient:** 12.8% × Weapon Speed → 12.5% × Weapon Speed
- **Impact:** Minor spell power nerf for 2H Seal of Righteousness users (~2.4% damage reduction)

---

## Stat Priority Impact Summary

### All Specializations
1. **Spell Power:** Consecration (0.119 coefficient), Crusader Strike (33% → 20% after 1.18.0), and Holy Strike (43% damage + healing scaling) keep spell power relevant for every spec.
2. **Hit & Weapon Skill:** The 8% hit cap (see general changes) plus the new two-hand weapon skill talent lower glancing penalties and should be reflected in melee weights.
3. **Haste:** Zeal supplies 9% attack/cast speed at three stacks and jumps to 15% with Vengeful Strikes, making item haste multiplicative rather than optional.
4. **Mana Sustain:** Doubled Seal of Wisdom returns and Blessed Strikes’ Holy Shock resets give Spirit/mp5 renewed importance for long fights.

### Holy Priority Changes
1. **Spell Power:** Holy Strike + Blessed Strikes, Holy Shock buffs, and Daybreak’s delayed heal all scale directly with spell power.
2. **Critical Strike:** Required to proc Daybreak and fuel repeated Holy Shock resets; crit remains the driver of burst throughput.
3. **Haste & Melee Hit:** Holy Judgement rewards frequent Judgements, while Crusader/Holy Strike uptime is mandatory for Blessed Strikes procs.
4. **Intellect/Spirit:** Illumination’s nerf and the stronger Seal of Wisdom loop shift mana longevity toward Spirit, mp5, and on-hit returns.

### Protection Priority Changes
1. **Block Value & Armor:** Post-hotfix Righteous Strikes boosts block damage, and Bulwark plus Holy Shield keep block value and armor at the top of the list.
2. **Spell Power:** Consecration, Holy Strike, and even the nerfed Holy Shield still translate spell power into threat; do not zero it out.
3. **Hit & Weapon Skill:** Higher taunt reliability (Improved Hand of Reckoning) and the need to land Crusader/Holy Strike keep weapon skill and hit meaningful.
4. **Stamina/EH:** Righteous Defense and Bulwark reward effective health stacking even after Sacred Duty’s removal.

### Retribution Priority Changes
1. **Strength & Attack Power:** Holy Strike’s Strength buff and Vengeful Strikes’ damage bonus make raw Strength the best-in-slot offensive stat.
2. **Spell Power:** Seal of Righteousness/Command coefficients, Holy Strike’s healing/mana return, and Vengeance’s all-damage modifier still give spell power a strong secondary role despite the 1.18.0 Crusader Strike nerf.
3. **Haste:** Zeal’s baseline 9% (15% with Vengeful Strikes) makes haste one of the highest marginal gains.
4. **Critical Strike:** Necessary to layer Vengeance stacks, trigger Daybreak support healing, and maintain hybrid spell procs while the new threat reduction keeps crit safer to stack.

---

## Critical Scaling Breakpoints

### Crusader Strike & Zeal
- **Cooldown:** 6 seconds shared between Crusader Strike and Holy Strike; Vengeful Strikes no longer shortens the timer.
- **Zeal Stacking:** Base 3% attack/casting speed per stack (9% total); Vengeful Strikes adds +2% per stack for a 15% cap.
- **Uptime:** Alternating Crusader Strike and Holy Strike maintains full stacks, keeping Zeal effectively permanent in PvE rotations.
- **Impact:** Treat 9–15% haste as baked into the spec when building haste weights—item haste multiplies off this floor.

### Haste Interaction
- **Stacking:** Zeal’s haste is additive with item haste but multiplicative with temporary haste buffs (Bloodlust, trinkets).
- **Holy Shock Windows:** Blessed Strikes resets Holy Shock, so haste and cooldown reduction both convert into extra Holy Shock casts and Holy Strike healing ticks.

### Weapon Normalization (December 2024)
- **Change:** Crusader Strike uses normalized weapon damage
- **Impact:** Weapon speed no longer critical for Ret Paladins
- **Focus:** Raw weapon DPS and stats more important than speed

---

## Implementation Notes for ClassicHawsJon_small.lua

### High Priority Changes

1. **Spell & Ability Coefficients:**
   - Consecration coefficient set to 0.119 in 1.16.1.
   - Crusader Strike uses a 33% spell power coefficient post-1.17.2, reduced to 20% in 1.18.0.
   - Holy Strike deals 43% spell power damage and its healing scales with 5% healing power while returning flat health/mana.
   - Daybreak’s 1.18.0 rework heals for 348–389 + 43% spell power when triggered.
   - Holy Shock damage ranks restored with a 43% spell power coefficient.

2. **Zeal / Haste Engine:**
   - Zeal supplies 3% attack/casting speed per stack (9% total); Vengeful Strikes adds +2% per stack (15% total).
   - Righteous Strikes’ post-hotfix effect converts Zeal upkeep into block value/threat scaling for Protection.

3. **Talent-Driven Scaling Hooks:**
   - Blessed Strikes grants Crusader Strike a 20–100% chance to reset Holy Shock (–1s GCD) and multiplies Holy Strike healing by 30–150%, plus Dec 2024 healing-power scaling.
   - Vengeance stacks 1–5% all damage (3 stacks, 30s) with built-in threat reduction; ensure it applies to both spell and physical damage.
   - Vengeful Strikes adds 2/4/6/8/10% Crusader Strike damage and 4–20% Strength from Holy Strike; maintain the Zeal haste bonus.

4. **Threat & Mitigation Adjustments:**
   - Holy Shield’s November nerf reduces block chance to 45%, spell power scaling to 15%, and threat to 30%.
   - Righteous Strikes now boosts block damage per Zeal stack and lowers Holy Strike threat to 6/12/18/24/30%.
   - Bulwark of the Righteous delivers 12 seconds of 30% DR and scales with 43% spell power.

### Medium Priority Changes

1. **Mana Economy:**
   - Seal of Wisdom returns were doubled and new ranks added; integrate into mana-per-swing calculations.
   - Holy Strike restores flat mana and health; Blessed Strikes’ resets demand accounting for extra Holy Shock casts.

2. **Weapon Skill & Hit:**
   - Two-Handed Weapon Specialization adds 1/2/3 weapon skill.
   - Improved Hand of Reckoning supplies +4/8% taunt hit; factor into threat models rather than assuming Judgement taunts.

3. **Hybrid Stat Hooks:**
   - Seal/Judgement of Command gain spell power/attack power coefficients.
   - Seal of Righteousness coefficients jump in Dec 2024 and Apr 2025 (with a slight 1.18.0 nerf to 2H scaling).

### Low Priority Changes

1. **Quality-of-Life Spells:**
   - Hands vs Blessings split and the 10/30 minute durations affect buff bookkeeping but not stat weights.
   - Flash of Light rank 8 ensures coefficient tables include the new max rank.

2. **Bugfixes Affecting Scaling:**
   - Crusader Strike and Holy Strike now refresh Judgements cast by other Paladins.
   - Healing Light talent applies to total healing, not just base, elevating spell power conversions slightly.

---

## Sources

All information compiled from official Turtle WoW changelogs:
- `turtle-wow-changelogs/1.16.1.html` (lines 480-540)
- `turtle-wow-changelogs/1.17.0.html` (Paladin sections)
- `turtle-wow-changelogs/1.17.2-paladin-changes.html` (complete file)
- `turtle-wow-changelogs/1.17.2-2024.10.21-changes.html` (lines 41-46)
- `turtle-wow-changelogs/1.17.2-2024.11.01-changes.html` (lines 24-28)
- `turtle-wow-changelogs/1.17.2-2024.11.20-changes.html` (lines 49-67)
- `turtle-wow-changelogs/1.17.2-2024.12.20-changes.html` (lines 117-197)
- `turtle-wow-changelogs/1.17.2-2025.04.01-changes.html` (lines 166-222)
- `turtle-wow-changelogs/1.18.0-paladin-changes.html` (complete file)

**Last Updated:** Based on changelogs through Patch 1.18.0 (Scars of the Past) and all hotfixes through April 2025
