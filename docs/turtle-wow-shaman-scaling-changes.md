# Turtle WoW Shaman Scaling Changes

This document tracks all Shaman-specific changes from Turtle WoW that affect stat scaling and item valuation for the Pawn addon.

**Base Reference:** Vanilla 1.12.1 stat scaling is implemented in `ClassicHawsJon_small.lua`.

**Related Documentation:** See `turtle-wow-general-scaling-changes.md` for non-class-specific changes (weapon skill rework, hit cap changes, armor cap removal, etc.).

---

## Version 1.16.1 - First Class Changes

### New Abilities

#### Water Shield
- **Level:** 60
- **Mana Cost:** 15
- **Duration:** 10 minutes
- **Charges:** 3
- **Effect:** Restores 83 mana when hit (spell/melee/ranged)
- **Cooldown:** Several seconds between activations
- **Impact:** Mana regeneration utility

#### Earth Shield
- **Level:** 60
- **Mana Cost:** 300
- **Duration:** 10 minutes
- **Charges:** 3
- **Effect:**
  - 30% chance to ignore spell interruption when damaged
  - Heals shielded target for 150 on attacks
  - Cooldown between activations
- **Impact:** Tank/self survivability, passive healing

#### Totemic Recall
- **Level:** 40
- **Mana Cost:** 0
- **Effect:** Returns totems to earth, refunds 25% of mana cost
- **Impact:** Mana efficiency for totem management

#### Racial Abilities (Level 40 Quest)

**Orc - Feral Spirit:**
- **Cooldown:** 5 minutes
- **Cost:** 21% base mana
- **Duration:** 20 seconds
- **Effect:** Summons two Spirit Wolves
- **Impact:** Burst DPS cooldown

**Tauren - Spirit Link:**
- **Cooldown:** 10 minutes
- **Cost:** 21% base mana
- **Duration:** 20 seconds
- **Effect:** Links ally and 3 closest within 15 yards, 15% damage distributed
- **Impact:** Party damage mitigation

**Troll - Hex:**
- **Cooldown:** 5 minutes
- **Cost:** 21% base mana
- **Duration:** 4 seconds
- **Effect:** Transforms enemy into frog (-66% damage, cannot cast)
- **Restriction:** Beasts, Humanoids, Critters only
- **Impact:** Crowd control utility

---

### Baseline Changes

#### Stormstrike Rank 2
- **Level:** 60
- **Cooldown:** 20 seconds → 12 seconds
- **Mana Cost:** 21% base → 12% base
- **Impact:** More frequent burst ability, reduced mana cost

---

### Talent Changes

#### Thunderhead (NEW - Enhancement Tier 3)
- **Prerequisite:** Improved Lightning Shield
- **Effect:**
  - Allows Lightning Shield cast on allies
  - Reduces Lightning Shield mana cost by 20%
- **Impact:** Party utility, mana efficiency

#### Bloodlust (NEW - Enhancement Tier 7)
- **Type:** Capstone talent
- **Effect:** Increases melee, ranged, and spell casting speed
- **Duration:** 15 seconds
- **Ranks:**
  - Rank 1 (Talent): 15% speed
  - Rank 2 (Level 60): 20% speed
- **Impact:** Major haste cooldown for party member

#### Spirit Armor (NEW - Enhancement Tier 4)
- **Points:** 3
- **Effect:** Increases armor gained from shields by 10/20/30%
- **Impact:** Tank survivability, armor scaling for shields

#### Ancestral Guidance (NEW - Enhancement Tier 3)
- **Replaces:** Toughness + Anticipation
- **Effect:**
  - Increases armor from items by 2/4/6/8/10%
  - Increases dodge by 1/2/3/4/5%
- **Impact:** Tank survivability, armor and avoidance scaling

#### Elemental Focus (Reworked - Elemental Tier 3)
- **Previous:** Reduced mana cost after landing crit
- **New Mechanic:** Clearcasting state after Fire/Frost/Nature crit or melee crit
- **Effect:** Next 2 damage spells have 40% reduced mana cost
- **Impact:** Mana efficiency, rewards critical strike

#### Flame Shock Buffs
- **Initial Damage:** Increased
- **Mana Cost:** Decreased (example Rank 6: 450 → 410)
- **Impact:** More efficient rotational ability

---

## Version 1.17.2 - Mysteries of Azeroth

### Baseline Changes (MAJOR REWORK)

#### Windfury Totem (Complete Redesign)
- **Previous:** Weapon imbue, competed with other enchants
- **New:** Aura effect in range
- **Changes:**
  - Now an aura (not weapon imbue)
  - Only works on main-hand attacks
  - One rank only
  - No longer grants AP bonus on extra attacks
  - Internal cooldown: 1 second → 1.5 seconds
  - Shaman's imbues take priority (totem doesn't affect shaman with imbue active)
- **Impact:** CRITICAL - no longer competes with temporary weapon enchants, reduced power but affects party

#### Flametongue Totem (Redesigned)
- **Changes:**
  - Now an aura
  - Stacks with Windfury Totem
  - No longer scales with Spell Power
  - Shaman's imbues take priority
  - Extra damage cannot trigger on-hit effects
- **Impact:** Party physical DPS buff, no longer scales with spell power

#### Totemic Slam (NEW Tauren Racial)
- **Replaces:** Spirit Link (moved to Restoration capstone)
- **Cooldown:** 1.5 minutes
- **Cost:** 5% base mana
- **Damage:** 10% of Attack Power
- **Effect:** Reduces target attack/casting speed by 25% for 8 seconds
- **Impact:** Attack Power scaling, utility ability

#### Weapon Imbues Duration
- **Previous:** 5 minutes
- **New:** 1 hour (Flametongue, Frostbrand, Rockbiter)
- **Impact:** Quality of life, reduced buff maintenance

#### Spirit Wolves
- **Change:** No longer scale with Attack Power
- **Impact:** Fixed damage summons

#### Earthshaker Slam (NEW Baseline)
- **Range:** 5 yards
- **Cooldown:** 10 seconds
- **Cost:** 3% base mana
- **Requirement:** Shield
- **Effect:** Taunts target (no effect if already attacking)
- **Impact:** Tank utility, shield requirement

#### Earth Shock
- **Threat Modifier:** 2x → 1.5x
- **Impact:** Reduced threat generation for DPS

#### Earth Shield (Earlier Access)
- **New Ranks:**
  - Rank 1 (Level 40): 200 mana, 85 healing
  - Rank 2 (Level 48): 245 mana, 115 healing
  - Rank 3 (Level 56): 300 mana, 150 healing
- **Pushback Reduction:** 30% for all ranks
- **Impact:** Earlier survivability tool

#### Water Shield (Earlier Access)
- **New Ranks:**
  - Rank 1 (Level 26): 34 mana restoration
  - Rank 2 (Level 34): 55 mana restoration
  - Rank 3 (Level 42): 76 mana restoration
  - Rank 4 (Level 50): 102 mana restoration
  - Rank 5 (Level 58): 130 mana restoration
- **Impact:** Earlier mana sustain tool

#### Chain Heal
- **Cast Time:** 2.5 seconds → 3 seconds
- **Reason:** Encourage deeper Restoration investment (Improved Chain Heal reduces by 1 second)
- **Impact:** Base healing slower, requires talent for old speed

#### Totemic Recall
- **Level:** 40 → 10
- **Fix:** Now correctly refunds mana for all totems
- **Impact:** Earlier mana efficiency

#### Windfury Weapon (Nerf)
- **Proc Chance:** 20% → 15%
- **Cooldown:** 3 seconds → 6 seconds
- **Reason:** Overwhelming damage performance (2/3 of Enhancement DPS)
- **Impact:** CRITICAL - significant DPS reduction, later partially reverted

---

### Enhancement Attack Power Scaling (CRITICAL)

#### Earth Shock Rank 7
- **Attack Power Scaling:** 10% of AP added to damage
- **Base Damage:** Reduced by 25 (compensates for base AP)
- **Impact:** Scales with gear

#### Frost Shock Rank 4
- **Attack Power Scaling:** 10% of AP added to damage
- **Base Damage:** Reduced by 25
- **Impact:** Scales with gear

#### Flame Shock Ranks 5-6
- **Initial Damage Scaling:** 6% of AP
- **DoT Scaling:** 1.5% of AP per tick (6% total for 4 ticks)
- **Base Damage:** Reduced by 16 initial, 4 per tick
- **Impact:** Scales with gear

#### Shock Auto-Attack Enabler
- **Change:** Fire/Earth/Frost Shock now enable auto-attacks
- **Impact:** Quality of life for melee rotation

#### Rockbiter Weapon (Reworked)
- **Previous:** Flat threat per attack
- **New:** Increases all threat generated by 30%
- **Impact:** Percentage-based threat scaling for tanks

---

### Elemental Specialization

#### Elemental Devastation (Complete Rework)
- **Previous:** Crit granted +9% crit for 10 seconds
- **New Effect:**
  - +1/2/3% hit chance (melee and spells)
  - Melee crits grant additional +3/6/9% spell hit for 15 seconds
- **Impact:** CRITICAL - hit rating more valuable, hybrid melee/caster synergy

#### Elemental Focus (Buffed)
- **Mana Cost Reduction:** 40% → 60%
- **Impact:** Better mana sustain from clearcasting

#### Call of Flame (Buffed)
- **New Effect:** Also increases Fire damage by 5/10/15%
- **Impact:** Fire damage amplification

#### Flame Guidance (NEW Capstone - Tier 5)
- **Effect:**
  - Increases Searing Totem and Flame Shock range by 10 yards
  - Flame Shock causes Searing Totem to focus that target
- **Impact:** Better Fire totem control

#### Elemental Fury → Electrify (Complete Rework)
- **Previous:** +100% crit damage
- **New Mechanic:** Lightning Bolt and Chain Lightning grant stacking buff
- **Effect:**
  - +2% Nature damage per stack
  - +20% crit damage bonus
  - Duration: 20 seconds
  - Max stacks: 5 (10% Nature damage, 20% crit bonus at max)
- **Impact:** CRITICAL - ramping damage system, Nature damage and crit damage scale with rotation

#### Elemental Mastery (Buffed)
- **New Effect:** Also grants 2 stacks of Electrify buff
- **Impact:** Synergy with stacking system

---

### Enhancement Specialization (MAJOR REWORK)

#### Ancestral Knowledge (Reworked)
- **Previous:** Increases maximum mana
- **New:** Increases all base stats by 2/4/6/8/10%
- **Note:** Only base stats, not gear stats
- **Impact:** Strength, Agility, Stamina, Intellect, Spirit all benefit

#### Shield Specialization (Buffed)
- **Block Amount:** 5/10/15/20/25% → 6/12/18/24/30%
- **Impact:** Better block value scaling

#### Guardian Totems
- **Change:** Merged into Enhancing Totems

#### Totemic Alignment (NEW - Tier 2)
- **Points:** 2
- **Effect:** 30/60% of totem threat transferred to shaman
- **Synergy:** Amplified by Rockbiter Weapon 30% threat increase
- **Impact:** Tank threat generation from totems

#### Improved Lightning Shield → Stable Shields (Reworked)
- **Effect:**
  - Increases shield charges by 2/4/6
  - Increases cooldown between activations by 1 second
- **Impact:** More shield procs, trade-off with activation frequency

#### Lightning Strike (NEW Capstone - Tier 3)
- **Cooldown:** 10 seconds
- **Cost:** 8% base mana
- **Damage:** 60% weapon Physical + 20% weapon Nature damage
- **Effect:** Triggers empowered shield, consuming 1 charge
- **Empowered Shield Attack Power Scaling:**
  - Lightning Shield: 4 AP = 1 extra damage
  - Water Shield: 20 AP = 1 extra mana
  - Earth Shield: 15 AP = 1 extra healing
- **Impact:** CRITICAL - Attack Power now scales shields, active shield interaction

#### Calming Winds (NEW - Tier 3)
- **Points:** 3
- **Effect:** Reduces threat from physical attacks, weapon imbues, Lightning Strike, Stormstrike by 5/10/15%
- **Impact:** Threat management for DPS

#### Ancestral Guardian (Improved)
- **Points:** 5 → 3
- **Armor Bonus:** 10% → 15% from items
- **Dodge:** 5% → 6%
- **Impact:** Better tank scaling

#### Spirit Armor (Improved)
- **Points:** 3 → 2
- **Impact:** Easier access to shield armor bonus

#### Enhancing Totems (Moved and Buffed)
- **Location:** Tier 3 → Tier 5
- **New Effect:**
  - Strength of Earth/Grace of Air effect +8/15%
  - Grounding Totem cooldown -1/2 seconds
  - Stoneskin damage reduction +15/30%
  - Stoneskin block amount +15/30%
- **Impact:** Significant totem amplification

#### Stormstrike (Reworked)
- **Ranks:** 2 → 1
- **Cooldown:** 12 seconds → 8 seconds
- **Mana Cost:** 12% base → 7% base
- **Previous Effect:** Debuff on target (+20% Nature damage taken)
- **New Effect:** Buff on shaman (+20% damage on next 2 Nature damage sources)
- **Requirement:** Weapon equipped
- **Impact:** CRITICAL - self-buff instead of debuff, other classes can't consume

#### Elemental Weapons (Complete Rework)
- **New Effects by Imbue:**
  - **Flametongue:** +5/10/15% Fire totem/spell damage
  - **Rockbiter:** -4/7/10% damage taken
  - **Frostbrand:** +8/16/25% proc chance, guaranteed crit if target has Frost Shock
  - **Windfury:** If bonus attack misses, +10/20/30% attack speed for next strike
- **Impact:** CRITICAL - each imbue has defined niche and scaling

#### Weapon Mastery (Buffed)
- **New Effect:** Now also affects melee skills
- **Impact:** Buffs Stormstrike and Lightning Strike damage

#### Bloodlust (Reworked)
- **Ranks:** 2 → 1
- **Self Effect:** 15% melee/casting speed
- **Duration:** 20 seconds → 30 seconds
- **Party Effect:** Shaman melee crits grant party 5% speed for 5 seconds
- **Restriction:** Can only cast on self
- **Impact:** Personal DPS cooldown, party buff tied to performance

---

### Restoration Specialization (MAJOR REWORK)

#### Tidal Focus (Buffed)
- **New Effect:** Also reduces totem mana cost by 5/10/15/20/25%
- **Impact:** Mana efficiency for totems

#### Totemic Focus
- **Change:** Merged into Tidal Focus

#### Ancestral Healing (Moved)
- **Location:** Tier 3 → Tier 2

#### Tidal Mastery (Moved)
- **Location:** Tier 4 → Tier 2

#### Nature's Guidance
- **Change:** Merged into Elemental Devastation

#### Healing Focus (Improved)
- **Points:** 5 → 2
- **Impact:** Easier access to pushback resistance

#### Nature's Grace (Buffed)
- **Previous:** Threat reduction for healing spells only
- **New:** Threat reduction for all Nature spells
- **Impact:** Threat management for all specs

#### Restorative Totems (Changed)
- **Previous:** Increases Mana Spring Totem effect
- **New:** Reduces Mana Spring Totem mana cost by 10/20/30/40/50%
- **Stacking:** Stacks with Tidal Focus
- **Impact:** Mana efficiency

#### Improved Water Shield (NEW - Tier 4)
- **Points:** 3
- **Effect:** Allows 2/4/6% mana regen to continue while casting
- **Bonus:** +1/2/3% per Water Shield charge
- **Max Benefit:** 6% + 9% (3 charges) = 15% mana regen while casting
- **Impact:** CRITICAL - Spirit value significantly increased for Restoration

#### Undertow (NEW - Tier 5)
- **Points:** 2
- **Effect:** Healing Wave/Lesser Healing Wave have 25/50% chance to restore Water Shield charge
- **Overflow:** Consumes charge when at maximum
- **Impact:** Water Shield charge management, synergy with Improved Water Shield

#### Healing Way (Moved and Buffed)
- **Location:** Tier 5 → Tier 3
- **New Effect:**
  - 11/22/33% chance to trigger from Chain Heal
  - Also increases subsequent Chain Heal healing
- **Impact:** Chain Heal synergy

#### Tidal Surge (NEW - Tier 5)
- **Points:** 2
- **Effect:** Healing target with Healing Way grants Tidal Surge stack
- **Tidal Surge:** 15/30% chance for next heal to refund 10% base mana
- **Max Stacks:** 3
- **Impact:** Mana efficiency for sustained healing

#### Purification
- **Change:** Removed

#### Improved Chain Heal (NEW - Tier 6)
- **Points:** 5
- **Effect:** Reduces Chain Heal cast time by 0.2/0.4/0.6/0.8/1 second
- **Max Effect:** 3 second → 2 second cast time
- **Note:** Replaces Stormcaller 5-piece set bonus
- **Impact:** CRITICAL - Chain Heal cast speed requires talent investment

#### Mana Tide Totem
- **Change:** Removed

#### Spirit Link (NEW Capstone - Tier 7)
- **Replaces:** Tauren racial (moved to Totemic Slam)
- **Cooldown:** 6 minutes
- **Range:** 15 yards
- **Duration:** 30 seconds
- **Effect:** Links target ally and 2 closest within 15 yards, 30% damage distributed
- **Impact:** Major damage mitigation cooldown

---

## Version 1.17.2 - Hotfixes

### October 21, 2024

#### Lightning Shield
- **Change:** Now guaranteed to land
- **Includes:** Empowered version from Lightning Strike
- **Impact:** Reliable damage/mana generation

---

### November 1, 2024

#### Windfury Weapon (Partial Revert)
- **Internal Cooldown:** 6 seconds → 0.5 seconds
- **Proc Chance:** 15% → 20%
- **Reason:** Original nerf too harsh
- **Impact:** Significant Enhancement DPS increase

#### Stormstrike and Lightning Strike
- **Mana Cost Increases:**
  - Stormstrike: 7% → 12% base mana
  - Lightning Strike: 8% → 15% base mana
- **Reason:** Compensate for Windfury buff
- **Impact:** Higher mana costs

#### Shaman's Flurry (Nerf)
- **Attack Speed:** 10/15/20/25/30% → 7/9/11/13/15%
- **Impact:** Reduced attack speed scaling

#### Stormstrike and Lightning Strike
- **Change:** Can no longer trigger chance-on-hit effects (Windfury)
- **Impact:** Prevents double-dipping proc synergy

#### Flame Guidance (Buffed)
- **New Effect:** Increases Fire totem crit damage modifier by 100%
- **Reason:** Compensate for Elemental Fury removal
- **Impact:** Fire totem crit damage restored

---

### November 20, 2024

#### Stormstrike
- **Change:** Can now proc weapon enhancement effects
- **Impact:** Synergy with imbue procs

#### Lightning Strike (New Ranks)
- **Reason:** Earlier ranks too strong while leveling
- **New Values:**
  - Rank 1 (Level 20/Talent): 20% weapon Physical + 10% weapon Nature
  - Rank 2 (Level 38): 40% weapon Physical + 15% weapon Nature
  - Rank 3 (Level 56): 60% weapon Physical + 20% weapon Nature
- **Impact:** Leveling balance adjustment

---

### December 20, 2024

#### Flurry (Buffed)
- **Attack Speed:** 7/9/11/13/15% → 8/11/14/17/20%
- **Impact:** Attack speed scaling improved

#### Ancestral Knowledge (Reworked)
- **Previous:** 2/4/6/8/10% base stats
- **New:** 1/2/3/4/5% total stats
- **Impact:** CRITICAL - now scales with gear, massively more valuable

#### Flame Shock (Buffed)
- **Duration:** 12 seconds → 15 seconds
- **Initial Damage AP Scaling:** 6% → 8.5%
- **Impact:** Better uptime, stronger burst damage

#### Lightning Strike (Buffed)
- **Change:** Can now proc Windfury Weapon
- **Impact:** CRITICAL - major DPS increase from proc synergy

#### Electrify (Complete Rework)
- **Maximum Stacks:** 5 → 2
- **Per Stack:** 2% Nature damage → 5% Nature damage
- **Critical Damage Bonus:** 20% per stack → 50% per stack (now 100% at max stacks)
- **Duration:** 20 seconds → 15 seconds
- **Impact:** CRITICAL - simpler stacking system, faster ramp-up, higher per-stack value

#### Elemental Mastery (Adjusted)
- **Electrify Stacks Granted:** 2 → 1
- **Impact:** Adjusted for new 2-stack Electrify system

#### Elemental Tier 3 (8 Set Bonus - Buffed)
- **Shock Damage Bonus:** 4% → 10%
- **Impact:** Compensates for Electrify max stack reduction

#### Improved Water Shield (Complete Rework)
- **Previous:** 2/4/6% mana regen while casting + 1/2/3% per charge
- **New:** 3/6/9 mana per 5 seconds while active + 1/1.5/2% total passive mana regen per charge
- **Impact:** Changed to mp5 system, different mana regeneration model

#### Elemental Weapons (Flametongue - Buffed)
- **Flametongue Fire Damage Bonus:** 5/10/15% → 10/20/30%
- **Impact:** Doubled effectiveness for Fire-focused Enhancement builds

---

### April 1, 2025

#### Elemental Focus (Buffed)
- **New Effect:** Mana cost reduction now also affects Stormstrike and Lightning Strike
- **Impact:** Mana efficiency for Enhancement melee abilities

#### Lightning Strike (Buffed)
- **Cooldown:** 10 seconds → 9 seconds
- **Nature Damage:** Now gains damage equal to 5% of spell power
- **Impact:** Faster rotation, hybrid scaling for Enhancement

#### Bloodlust (Buffed)
- **Self:** 15% → 20% speed
- **Party on Crit:** 5% → 8% speed for 5 → 6 seconds
- **Party Effect:** No longer applied to caster
- **Impact:** Stronger personal cooldown

#### Fire Nova Totem and Grounding Totem
- **Change:** Now trigger global cooldown
- **Impact:** Cannot be used simultaneously with other abilities

---

## Version 1.18.0 - Scars of the Past

### Baseline Changes

#### Totem Range Increase
- **Previous:** 20 yards (most), 30 yards (Tremor)
- **New:** 30 yards (most), 40 yards (Tremor)
- **Reason:** Totemic Mastery felt mandatory
- **Impact:** Better group coverage baseline

#### Fire Totems (Major Buff)
- **Change:** Now inherit shaman's spell crit and spell hit
- **Impact:** CRITICAL - crit and hit rating now scale Fire totems

#### Molten Blast (NEW Baseline Spell)
- **Type:** Fire damage spell
- **Cast Time:** 2 seconds
- **Range:** 36 yards
- **Spell Power Coefficient:** 57.14%
- **Effect:**
  - Deals Fire damage
  - Refreshes Flame Shock duration
  - Focuses Searing Totem on target
- **Ranks:**
  - Rank 1 (Level 20): 61-73 damage, 65 mana
  - Rank 2 (Level 28): 96-119 damage, 95 mana
  - Rank 3 (Level 36): 136-155 damage, 120 mana
  - Rank 4 (Level 44): 185-204 damage, 145 mana
  - Rank 5 (Level 52): 238-268 damage, 175 mana
  - Rank 6 (Level 60/Book): 290-331 damage, 210 mana
- **Impact:** CRITICAL - new rotational spell, Flame Shock maintenance tool

#### Windfury Totem
- **Change:** Animation restored for extra attacks
- **Impact:** Visual clarity

#### Rockbiter Weapon (Buffed)
- **Threat Bonus:** 30% → 35%
- **Impact:** Tank threat generation

#### Earthshaker Slam
- **Change:** Updated icon and description

#### Grounding Totem (Nerf)
- **Change:** Breaks after grounding CC effect
- **Cooldown:** 15 seconds → 20 seconds
- **Reason:** Too oppressive in PvP
- **Impact:** Less reliable CC protection

#### Chain Heal (Nerf)
- **Spell Power Coefficient:** 71.42% → 61.42%
- **Reason:** Dominant in Restoration healing
- **Impact:** CRITICAL - healing power less valuable for Chain Heal

---

### Elemental Specialization

#### Convection and Concussion (Buffed)
- **Previous:** Affected specific spells
- **New:** Affects all offensive Fire/Frost/Nature spells
- **Includes:** Earthquake, Molten Blast
- **Impact:** Mana efficiency and damage for all spells

#### Reverberation (Improved)
- **Points:** 5 → 3
- **Impact:** Easier access

#### Improved Molten Blast (NEW - Tier 3)
- **Points:** 2
- **Effect:** Refreshing Flame Shock with Molten Blast deals damage equal to 30/60% of refreshed duration
- **Impact:** Rewards frequent Molten Blast usage

#### Improved Fire Totems (Buffed)
- **New Effect:** Also increases Searing Totem attack speed by 10/20%
- **Impact:** Single-target Fire totem damage

#### Call of Flame (Buffed)
- **New Effect:** Also increases Flame Shock range by 3/6/10 yards
- **Impact:** Better range for Flame Shock

#### Electrify → Elemental Fury (Reworked)
- **Previous:** Stacking system (Electrify)
- **New Name:** Elemental Fury
- **Points:** 1 → 2
- **Effect:**
  - +5/10% Fire and Nature spell damage
  - +50/100% crit damage for Fire/Frost/Nature spells and Fire totems
- **Impact:** CRITICAL - simpler system, immediate crit damage bonus

#### Elemental Mastery (Moved and Reworked)
- **Location:** Tier 7 → Tier 5
- **Previous:** Guaranteed crit on next spell
- **New Effect:**
  - +15% Fire/Frost/Nature damage
  - -20% mana cost for offensive spells
  - Duration: 10 seconds
- **Cooldown:** (unchanged)
- **Impact:** Sustained burst window instead of single-spell burst

#### Earthquake (NEW Capstone - Tier 7)
- **Type:** Nature AoE spell
- **Cast Time:** 2.5 seconds
- **Cooldown:** 20 seconds
- **Range:** 36 yards
- **Spell Power Coefficient:** 60%
- **Effect:**
  - Initial damage to target
  - 35% of initial damage to targets within 10 yards
  - Creates broken earth patch (15% slow)
  - After 4 seconds: aftershock deals 30% of initial damage to all in patch
- **Ranks:**
  - Rank 1 (Level 40): 227-252 damage, 225 mana
  - Rank 2 (Level 50): 343-386 damage, 335 mana
  - Rank 3 (Level 60): 510-550 damage, 440 mana
- **Impact:** CRITICAL - major AoE damage cooldown, spell power scaling

---

### Enhancement Specialization

#### Totemic Alignment (Buffed)
- **Threat Transfer:** 30/60% → 45/90%
- **Impact:** Better multi-target threat generation

#### Calming Winds (Modified)
- **Change:** Threat reduction disabled while Rockbiter Weapon active
- **Reason:** Match Vengeance (Warrior) behavior
- **Impact:** Proper threat management for tanks

#### Spirit Armor (Buffed)
- **New Effect:** Also increases threat generation by 5/10% while wearing shield
- **Impact:** Tank threat with shields

#### Enhancing Totems (Buffed)
- **Stat Totem Effect:** 8/15% → 12/25%
- **Impact:** Significant buff to Strength of Earth and Grace of Air

#### Stormstrike (Buffed)
- **Nature Damage Bonus:** 20% → 25%
- **Impact:** Earth Shock damage increased

#### Weapon Mastery → Element's Grace (Reworked)
- **New Name:** Element's Grace
- **New Effect:** Also increases instant-cast spell crit by 2/4/6/8/10%
- **Impact:** Critical strike valuable for shocks

---

### Restoration Specialization

#### Improved Healing Wave (Buffed)
- **Cast Time Reduction:** 0.1/0.2/0.3/0.4/0.5s → 0.15/0.3/0.45/0.6/0.75s
- **Impact:** Faster Healing Wave casting

#### Healing Way (Buffed)
- **New Effect:**
  - 33/66/100% chance to apply from Lesser Healing Wave
  - Effect also increases Lesser Healing Wave healing
- **Impact:** Lesser Healing Wave viability improved

#### Totemic Mastery (Reworked)
- **Previous:** +10 yard totem range
- **New Effect:**
  - +20% duration for friendly-target totems
  - +15% mana refunded by Totemic Recall
- **Reason:** 30-yard range now baseline
- **Impact:** Totem longevity and mana efficiency

#### Tidal Surge (Simplified)
- **Previous:** Complex stacking mechanic
- **New Effect:** Healing target with Healing Way has 15/30% chance to refund 15% base mana cost
- **Impact:** Simpler mana refund mechanic

#### Spirit Link (Buffed)
- **Cast Time:** Cast time removed (instant)
- **Range:** 15 yards → 35 yards (casting and linking)
- **Duration:** 30 seconds → 20 seconds
- **Cooldown:** 6 minutes → 10 minutes
- **Impact:** More flexible usage, longer cooldown

---

### August 2025 Revision (1.18.0 Hotfix)

#### Calming Winds (Buffed)
- **Threat Reduction:** 5/10/15% → 8/16/25%
- **Impact:** Better threat management for DPS

#### Improved Fire Totems (Buffed)
- **New Effect:** Also increases Searing Totem range by 5/10 yards
- **Impact:** Better Searing Totem positioning

#### Purge
- **Change:** Now has 8 second cooldown
- **Impact:** Cannot spam dispel

#### Eye of the Storm (Nerf)
- **Previous:** Prevented losing cast time on all spells
- **New:** Only prevents losing cast time on damaging spells
- **Impact:** Healing spells no longer benefit

#### Nature's Swiftness → Ancestral Swiftness (Reworked)
- **New Name:** Ancestral Swiftness
- **Effect:** Next Nature spell <10s cast becomes instant
- **Nerf:** Affected damaging spells have 25% reduced effectiveness
- **Impact:** Healing instant-cast remains full power, damage spells nerfed

---

## Version 1.18.1

### General Changes

#### Lightning Shield
- **Mana Cost:** Reduced by approximately 25% across all ranks
- **Impact:** Better mana efficiency for all specs using Lightning Shield

---

### Enhancement Specialization

#### Stormstrike (Nerf)
- **Change:** Can no longer proc Windfury Weapon twice
- **Impact:** Reduced burst damage potential

#### Windfury Weapon (Buffed)
- **Proc Chance:** 20% → 25%
- **Impact:** More frequent extra attacks, significant DPS increase

#### Elemental Weapons (Complete Rework)
- **Windfury Effect:**
  - Previous: +10/20/30% attack speed after miss
  - New: Grants 1% attack speed per extra attack for 5 seconds
  - Stacks: 2/4/6 times based on talent rank
  - Impact: Attack speed stacking buff on proc
- **Flametongue Effect:**
  - Previous: +10/20/30% Fire totem and spell damage
  - New: +10/20/30% Fire Totem and spell damage for 5 seconds on hit
  - Impact: Now a temporary buff on melee hit
- **Rockbiter Effect:**
  - Previous: -4/7/10% damage taken
  - New: Builds absorb shield equal to 20% of physical damage dealt
  - Shield amount: Tripled when using a shield
  - Absorbs: 5/10/15% of incoming damage
  - Maximum: 20% of HP
  - Impact: CRITICAL - damage reduction replaced with active absorb mechanic

#### Flurry (Reworked)
- **New Effect:** +8/11/14/17/20% attack speed for next 3 swings after landing a critical strike
- **Impact:** Now charge-based (3 swings) instead of time-based duration; crit-dependent uptime

#### Lightning Strike (Adjusted)
- **Water Shield AP-to-Mana Ratio:** 20:1 → 18:1
- **Impact:** Water Shield empowerment slightly more efficient (18 AP = 1 mana instead of 20)

---

### Elemental Specialization

#### Eye of the Storm → Call of Earth (Reworked)
- **New Name:** Call of Earth
- **Effect:**
  - Earth Shield gains +1/2 additional charges
  - +35/70% spell pushback resistance
- **Impact:** Earth Shield longevity, survivability for casters

#### Elemental Fury (Buffed)
- **Change:** Now also affects Frost spells
- **Previous:** +50/100% crit damage for Fire/Nature spells and Fire totems
- **New:** +50/100% crit damage for Fire/Frost/Nature spells and Fire totems
- **Impact:** Frost crit damage now scales with talent

#### Earthquake (Buffed)
- **Base Damage:** Increased by 15%
- **Cooldown:** 20 seconds → 18 seconds
- **Impact:** Higher burst AoE damage, more frequent usage

---

### Tier Set Changes

#### Restoration Tier 1 (3-piece Bonus)
- **Clarification:** Totem radius increased by +10 yards (not set to 30 yards)
- **Impact:** Documentation fix, actual effect unchanged

#### Restoration Tier 1 (8-piece Bonus)
- **Previous:** (Unknown/different effect)
- **New:** 25% chance when casting Healing Wave or Lesser Healing Wave to grant target 250 damage absorb for 6 seconds
- **Impact:** Adds damage mitigation to healing rotation

---

## Stat Priority Impact Summary

### All Specializations
1. **Totem Range:** 20 yards → 30 yards baseline (1.18.0)
2. **Windfury/Flametongue Totem:** Now auras, no longer compete with weapon enchants
3. **General:** Totems more accessible, reduced buff maintenance

### Elemental Priority Changes
1. **Spell Power:**
   - Molten Blast: 57.14% coefficient (1.18.0)
   - Earthquake: 60% coefficient (1.18.0)
   - Chain Heal: 71.42% → 61.42% (nerf in 1.18.0)
   - Elemental Mastery: +15% damage for 10 seconds
2. **Critical Strike:**
   - Elemental Fury: +50/100% crit damage for Fire/Frost/Nature (expanded in 1.18.1)
   - Fire totems inherit shaman crit (1.18.0)
   - Elemental Focus: 60% mana reduction on next 2 spells
3. **Hit Rating:**
   - Elemental Devastation: +1/2/3% spell hit (melee crits grant +3/6/9%)
   - Fire totems inherit shaman hit (1.18.0)
4. **Nature Damage:**
   - Electrify stacking: +2% per stack (max 10%)
   - Elemental Fury: +5/10% Fire and Nature damage

### Enhancement Priority Changes
1. **Attack Power:**
   - Earth Shock Rank 7: +10% AP scaling
   - Frost Shock Rank 4: +10% AP scaling
   - Flame Shock Ranks 5-6: 8.5% AP initial, 6% AP total DoT (buffed from 6%)
   - Lightning Strike: Shield empowerment scales with AP (4 AP = 1 dmg for Lightning Shield)
   - Totemic Slam: 10% AP damage (Tauren racial)
2. **Attack Speed:**
   - Flurry: 8/11/14/17/20% for 3 swings after crit (reworked in 1.18.1)
   - Bloodlust: 20% self (buffed from 15%)
   - Windfury Weapon: 25% proc chance, 0.5s cooldown (buffed in 1.18.1)
   - Elemental Weapons (Windfury): +1% attack speed per extra attack, stacks 2/4/6 times (reworked in 1.18.1)
3. **Weapon Damage:**
   - Lightning Strike: 60% Physical + 20% Nature weapon damage
   - Stormstrike: +25% Nature damage on next 2 sources
   - Element's Grace: +2-10% melee skill damage
4. **Critical Strike:**
   - Element's Grace: +2-10% instant spell crit (shocks)
   - Bloodlust: Melee crits grant 8% party speed for 6 seconds
   - Elemental Focus: 60% mana reduction after crit
5. **Spell Power (Hybrid):**
   - Lightning Strike Nature portion: +5% spell power scaling (April 2025)

### Restoration Priority Changes
1. **Healing Power:**
   - Chain Heal: 71.42% → 61.42% coefficient (NERF in 1.18.0)
   - Improved Healing Wave: -0.15-0.75s cast time
   - Healing Way: Amplifies Healing Wave, Lesser Healing Wave, Chain Heal
2. **Spirit:**
   - Improved Water Shield: 2-6% mana regen while casting + 1-3% per charge
   - Max benefit: 15% mana regen while casting (with 3 charges)
   - CRITICAL - Spirit massively more valuable
3. **MP5:**
   - Undertow: 25/50% chance to restore Water Shield charge with Healing Wave/Lesser Healing Wave
   - Tidal Surge: 15/30% chance to refund 15% base mana cost
   - Totemic Recall: +15% mana refund with Totemic Mastery
4. **Critical Strike:**
   - Tidal Mastery: +5% crit

### Tank (Enhancement) Priority Changes
1. **Armor:**
   - Ancestral Guardian: +15% from items
   - Spirit Armor: +10/20% from shields
2. **Block Value:**
   - Shield Specialization: +6-30%
   - Enhancing Totems: Stoneskin +15/30% block amount
3. **Threat Generation:**
   - Rockbiter Weapon: +35% all threat (buffed from 30%)
   - Spirit Armor: +5/10% threat with shield
   - Totemic Alignment: 45/90% totem threat transferred
4. **Stamina:**
   - Ancestral Knowledge: +1-5% total stats (includes Stamina from gear)

---

## Critical Scaling Breakpoints

### Enhancement Attack Power Scaling (December 2024, updated 1.18.1)
- **Flame Shock:** 8.5% initial + 6% DoT total = 14.5% AP per cast
- **Earth/Frost Shock:** 10% AP per cast
- **Lightning Strike:** 4 AP = 1 Lightning Shield damage
- **Water Shield:** 18 AP = 1 mana per proc (improved from 20 AP in 1.18.1)
- **Earth Shield:** 15 AP = 1 healing per proc
- **Impact:** Attack Power primary stat for Enhancement damage

### Improved Water Shield Mana Regen (Restoration - Timeline)
- **1.17.2 Launch:** 2/4/6% mana regen while casting + 1/2/3% per charge
  - Max: 6% + 9% (3 charges) = 15% mana regen while casting
  - Impact: Spirit value massively increased
- **December 2024 Rework:** 3/6/9 mp5 while Water Shield active + 1/1.5/2% total passive mana regen per charge
  - Changed to mp5 system instead of while-casting percentage
  - Still benefits from multiple Water Shield charges

### Electrify Stacking (Elemental - Timeline)
- **1.17.2 Launch:** 5 max stacks, +2% Nature damage per stack, +20% crit damage, 20 second duration
- **December 2024 Rework:** 2 max stacks, +5% Nature damage per stack, +50% crit damage per stack, 15 second duration
  - Max: 10% Nature damage, 100% crit damage bonus at 2 stacks
- **1.18.0:** Replaced with Elemental Fury (+5/10% Fire/Nature damage, +50/100% crit damage, no stacking)
- **1.18.1:** Elemental Fury expanded to include Frost spells (+50/100% crit damage for Fire/Frost/Nature)
- **Impact:** Evolved from slow ramp-up (5 stacks) → fast ramp-up (2 stacks) → instant bonus (no stacking) → expanded school coverage

### Ancestral Knowledge Scaling (December 2024)
- **Previous:** 2-10% base stats only
- **New:** 1-5% total stats (includes gear)
- **Impact:** CRITICAL - Strength, Agility, Stamina, Intellect, Spirit all scale with gear

### Windfury Weapon Proc Rate
- **Vanilla:** 20% chance, 3s cooldown
- **1.17.2 Launch:** 15% chance, 6s cooldown (heavy nerf)
- **November 2024:** 20% chance, 0.5s cooldown (mostly reverted)
- **1.18.1:** 25% chance, 0.5s cooldown (buffed)
- **Note:** Stormstrike can no longer proc Windfury twice (1.18.1)
- **Impact:** Higher proc rate than vanilla, significantly reduced cooldown

### Fire Totem Scaling (1.18.0)
- **Change:** Inherit shaman spell crit and spell hit
- **Impact:** Crit and hit rating now directly scale totem damage

---

## Implementation Notes for ClassicHawsJon_small.lua

### High Priority Changes

1. **Enhancement Attack Power Scaling:**
   - Flame Shock (R5-6): 8.5% AP initial + 1.5% AP per tick (6% total)
   - Earth Shock (R7): 10% AP
   - Frost Shock (R4): 10% AP
   - Lightning Strike: Shield empowerment (4 AP per Lightning Shield damage, 18 AP per Water Shield mana [improved in 1.18.1], 15 AP per Earth Shield healing)
   - Critical: Attack Power becomes primary damage stat

2. **Ancestral Knowledge (December 2024):**
   - Changed from base stats to total stats (1-5%)
   - Affects Strength, Agility, Stamina, Intellect, Spirit from gear
   - Critical: All stat scaling multiplier

3. **Improved Water Shield (Restoration):**
   - 2-6% mana regen while casting + 1-3% per charge
   - Max: 15% with 3 charges
   - Critical: Spirit massively more valuable

4. **Chain Heal Nerf (1.18.0):**
   - Coefficient: 71.42% → 61.42%
   - Impact: Healing power less valuable for Chain Heal

5. **Fire Totem Scaling (1.18.0):**
   - Inherit spell crit and hit
   - Impact: Crit and hit rating now scale totems

6. **Elemental Fury (1.18.0, updated 1.18.1):**
   - +5/10% Fire/Nature damage
   - +50/100% crit damage for Fire/Frost/Nature (Frost added in 1.18.1)
   - Simplified from Electrify stacking system

### Medium Priority Changes

1. **Windfury Weapon:**
   - 25% proc chance, 0.5s cooldown (buffed in 1.18.1)
   - Lightning Strike can proc (December 2024)
   - Stormstrike can proc but not twice (limited in 1.18.1)
   - Impact: Proc-based DPS significant

2. **Elemental Devastation (Hit Rating):**
   - +1/2/3% spell/melee hit
   - Melee crits: +3/6/9% spell hit for 15 seconds
   - Impact: Hit rating more accessible

3. **Bloodlust:**
   - Self: 20% speed for 30 seconds
   - Party on crit: 8% speed for 6 seconds
   - Impact: Major haste cooldown

4. **Flurry:**
   - 8/11/14/17/20% attack speed for next 3 swings after crit (reworked in 1.18.1)
   - Impact: Proc-based attack speed, requires critical strikes

5. **Rockbiter Weapon:**
   - 35% all threat (buffed from 30%)
   - Impact: Threat scaling for tanks

### Low Priority Changes

1. **Weapon Imbue Duration:** 5 minutes → 1 hour
2. **Totem Range:** 20 yards → 30 yards baseline
3. **Chain Heal Cast Time:** 2.5s → 3s base (Improved Chain Heal reduces to 2s)
4. **Spirit Link:** 35 yard range, 20 second duration, 10 minute cooldown
5. **Molten Blast:** New baseline spell (57.14% spell power coefficient)
6. **Earthquake:** New Elemental capstone (60% spell power coefficient)

---

## Sources

All information compiled from official Turtle WoW changelogs:
- `turtle-wow-changelogs/1.16.1.html` (lines 657-722)
- `turtle-wow-changelogs/1.17.2-shaman-changes.html` (complete file)
- `turtle-wow-changelogs/1.17.2-2024.10.21-changes.html` (Lightning Shield change)
- `turtle-wow-changelogs/1.17.2-2024.11.01-changes.html` (Windfury revert, nerfs)
- `turtle-wow-changelogs/1.17.2-2024.11.20-changes.html` (lines 88-100)
- `turtle-wow-changelogs/1.17.2-2024.12.20-changes.html` (lines 243-271)
- `turtle-wow-changelogs/1.17.2-2025.04.01-changes.html` (lines 255-274)
- `turtle-wow-changelogs/1.18.0-shaman-changes.html` (complete file)
- Patch 1.18.1 changelog (Shaman changes)

**Last Updated:** Based on changelogs through Patch 1.18.1
