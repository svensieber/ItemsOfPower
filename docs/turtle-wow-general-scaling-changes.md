# Turtle WoW General Scaling Changes

This document tracks all general (non-class-specific) changes from Turtle WoW that affect stat scaling and item valuation for the Pawn addon.

**Important:** This document does NOT include class-specific or spec-specific changes. Those will be documented separately.

**Base Reference:** Vanilla 1.12.1 stat scaling is implemented in `ClassicHawsJon_small.lua`.

---

## Version 1.15.0 - Expansion Prelude

### Racial Stat Baselines

#### High Elf (Alliance)
- **Arcane Resistance:** +10 Arcane resistance becomes baseline, increasing mitigation against arcane burst effects.
- **Bow Specialization:** +5 Bow weapon skill raises ranged hit and lowers glancing penalties relative to Vanilla.
- **Arcane Meditation:** Restores 40% mana while casting (25% HP for non-casters), raising the value of Spirit and mana regeneration on gear.
- **Enchanting Specialization:** +10 Enchanting skill (profession-only impact; note for crafting-related stat sources).

#### Goblin (Horde)
- **Chemical Superfreak:** +10 Alchemy skill (profession-only impact; informs access to crafted consumables).
- **Prospecting:** +10 Mining skill (profession-only impact; affects gem material access).
- **Exit Strategy:** +30% movement speed for 5 seconds (mobility utility, no direct stat weight change).
- **Aggressive Negotiations:** +5 Dagger & Mace weapon skill, increasing melee hit chance and reducing glancing damage versus Vanilla.

---

## Version 1.16.0 - Mysteries of Azeroth

### New Stats Introduced

#### Meditation
- **Effect:** Allows 5% of mana regeneration to continue during combat per item with Meditation
- **Scaling:** Benefits from Spirit stat
- **Impact:** New stat weight consideration for mana-using classes
- **Note:** Found on new set bonuses and items

#### Haste
- **Effect:** Increases attack speed with diminishing returns
- **Range:** 1-5% depending on item
- **Impact:** New stat weight for melee classes
- **Note:** First introduction of Haste mechanic to Classic WoW

### Combat Changes

#### Debuff Limit (Patch 1.16.1)
- **Change:** Debuff limit increased from 16 to 24
- **Impact:** More debuffs can be active on targets, affecting DoT-based builds

### New Races
- High Elves (Alliance) with racial bonuses
- Goblins (Horde) with racial bonuses

### Version 1.16.4 - Tel'Abim & World Updates
- No general stat scaling changes included; content additions impact questing only.

---

## Version 1.17.0 - Beyond the Greymane Wall

### Raid Buff Additions
- **Emerald Blessing (Druid quest reward):** Grants 10% movement speed, 1% spell hit, and 5% in-combat mana regeneration to the raid at the cost of a Bright Dream Shard. Adjust spell hit caps and Spirit valuations when this aura is expected.

### Defensive Itemization
- **New anti-crit gear:** Level 68 PvP rings, the Bloody Belt Buckle attunement, and Gurubashi Gumbo each reduce the chance to be critically hit by 1%. These additions provide extra paths to reach the 5.6% boss crit immunity cap without relying solely on Defense Rating.

## Version 1.17.1 - Goblin Starting Experience Refresh
- No general stat scaling changes; patch focuses on leveling content.

---

## Version 1.17.2 - Tower of Karazhan

### Major Mechanical Changes

#### Weapon Skill Formula Rework
- **Previous:** Used awkward breakpoints, with diminishing returns at specific skill levels
- **New:** Linear scaling system
- **Hit Cap Change:** 9% → 8% against +3 level bosses
- **Key Changes:**
  - 1% hit suppression against bosses removed
  - Soft cap of 305 skill no longer exists
  - Each point of weapon skill now provides exactly 0.2% hit chance
  - Each point reduces glancing damage penalty by 2%
  - Benefits from skill 300-304 and 305-308 smoothed out
- **Racial Weapon Skill:** Reduced from +5 to +3
- **New:** Weapon skill books available via quests (+5 to specific weapon types)

#### Throwing Weapons Rework
- **Previous:** Consumed stacks when used
- **New:** Use durability like other weapons
- **Changes:**
  - Now disenchantable
  - Higher buy/sell prices
  - Stack to 1 only
  - Higher durability based on quality
- **Impact:** Throwing weapons now scale with durability and can provide stats like regular weapons

### New Profession: Jewelcrafting

#### Overview
- Over 200 new craftable items
- Two specializations: Goldsmith and Gemology
- Requires level 40 and skill 225 to specialize

#### Craftable Items
- Rings
- Necklaces
- Staves
- Trinkets
- Off-hand frills
- Helmets
- Gemstones

#### New Materials
- Amber Topaz
- Pure Moonstone
- Imperial Topaz (key high-level material, similar to Black Lotus rarity)
- Gemstone Clusters (for material recycling)

#### Gemstone Deposits
- New rare ore deposits in the world
- Requires Mining skill 310
- Can replace thorium veins
- Guaranteed Imperial Topaz drop

### Racial Changes (Patch 1.17.2)

**Implementation Note:** ClassicHawsJon_small.lua does not directly implement race-specific stat weights. However, these racial changes affect the *effective value* of stats for different races (e.g., Human Spirit is more valuable due to +5% mana regen while casting, High Elf Agility scales 2% better). These are documented for context and for potential future race-aware implementations.

**Note:** All weapon skill racial bonuses reduced from +5 to +3

#### Human
- **Perception:** Now grants 2% increased physical and spell critical strike chance
- **The Human Spirit:** Now allows 5% of mana regeneration to continue while casting

#### Dwarf
- **Stoneform:** Now reduces physical damage taken by 5% (was 10% armor increase)

#### Night Elf
- **Quickness:** Now also increases attack speed, casting speed, and movement speed by 1%
- **Shadowmeld:** Cooldown increased from 10 seconds to 3 minutes (later reduced to 1 minute), persists for 2 seconds after canceling

#### Gnome
- **Escape Artist:** Cooldown increased from 1 minute to 1.5 minutes
- **Arcane Resistance:** Removed
- **Disassembler (New):** 5% increased damage versus Mechanicals

#### High Elf
- **Quel'dorei Meditation:** Reworked (cooldown reduced 6 min → 3 min, generates 10% total mana/20 rage/50 energy over 5 seconds)
- **Arcane Resistance:** Removed
- **Swiftness of the Rangers (New):** 2% increased Agility

#### Orc
- **Blood Fury:** Now increases Attack Power and spell damage by 2x level for 15 seconds, no longer on GCD
- **Hardiness:** Now reduces Stun duration by 15% (was 25% chance to resist)

#### Troll
- **Berserking:** Attack/casting speed bonus reduced from 10-30% to 10-15%
- **Regeneration:** Health regen increased to 20% (was 10%), allows 25% to continue in combat (was 10%)

#### Undead
- **Will of the Forsaken:** Duration reduced to 3 seconds, cooldown increased to 2.5 minutes
- **Shadow Resistance:** Removed
- **Vengeance (New):** 2% increased damage against non-player Humanoids

#### Tauren
- **War Stomp:** Duration: 2 seconds, cooldown increased to 2.5 minutes

#### Goblin
- **Exit Strategy:** Cooldown reduced from 5 minutes to 3 minutes, no longer slows after use
- **Prospecting:** Now grants both Mining and Jewelcrafting skill
- **Chemical Superfreak:** Removed

### Consumable Changes

#### Tea Consumables (Patch 1.17.2)
- **Tea With Sugar & Nordanaar Herbal Tea:**
  - Health/Mana reduced: 1050-1750 → 525-875 health, 810-1350 mana
  - Stack size increased: 5 → 20
  - **Impact:** Demonic/Dark Runes now more valuable for mana restoration

### Miscellaneous Changes

#### Bow Specialization (Hyjal)
- **Tome of Expertise: Bows** removed from the game
- Quest removed
- Players refunded 50 Bright Dream Shards

---

## Version 1.17.2 - Hotfixes

### October 21, 2024
- Minor racial adjustments (see racial changes above for final values)

### November 1, 2024
- No general scaling changes

### November 20, 2024
- No general scaling changes

### December 20, 2024

#### Item Changes
- **Shadow Oil & Frost Oil:** No longer scale with spell power
- **Stratholme Holy Water:** No longer causes any threat
- **The Black Book:** Damage and armor bonus reduced from 100% to 50%
- **Halycon's Muzzle:** Intellect reduced 22 → 17, added 10 Spellpower
- **Wyrmthalak's Shackles:** Intellect reduced 9 → 7, Spirit 15 → 14, added 12 Healing Power
- **Demonfork:** Health leech increased 50 → 125 over 25 sec, PPM increased 1 → 2
- **Tattered Hakkari Cloak:** Removed 6 Stamina and 6 HP5, added 1% Physical Crit and Vampirism, Strength 7 → 8
- **Faded Hakkari Cloak:** Removed 5 Stamina and 6 MP5, added 1% Spell Crit and Vampirism, Intellect 8 → 10
- **Chillpike:** PPM increased 1 → 1.8
- **Sphere of the Endless Gulch:** Stacks required 10 → 8, duration 15 → 12 seconds

### April 1, 2025
- No general scaling changes (all changes were class-specific)

---

## Version 1.18.0 - Scars of the Past

### Armor Mechanics Changes

#### Armor Cap Removed
- **Previous:** Physical damage reduction from Armor hard-capped at 75%
- **New:** Hard cap removed, extra reduction beyond 75% is diminished
- **Formula:** Updated formula with diminishing returns beyond 75% (exact formula to be shared by developers)
- **Impact:** Critical change for tank scaling - armor stacking now has value beyond the old 75% cap
- **Note:** Developers are aware of potential balance implications and implemented diminishing returns to prevent excessive mitigation

### Combat Difficulty Changes

#### World Difficulty Increase
- **Dungeon Boss HP:** Increased across all dungeons to lengthen encounters
- **Creature HP/Damage:** 10-15% increase for many creatures on Azeroth to match current gameplay balance
- **Raid Tuning:**
  - Molten Core: HP and damage adjusted for all bosses and creatures
  - Karazhan 10-player: Adjusted
  - Onyxia's Lair: Adjusted
  - Blackwing Lair: Adjusted

### Mining Changes

#### Elemental Earth Drop Rates
- **Small Thorium Vein:** 2% chance
- **Ooze Covered Small Thorium Vein:** 2% chance
- **Rich Thorium Vein:** 5% chance
- **Ooze Covered Rich Thorium Vein:** 5% chance
- **Hakkari Thorium Vein:** 5% chance
- **Impact:** Elemental Earth more accessible for crafting

### PvP Changes

#### PvP Leveling
- **New:** Experience can now be gained in Battlegrounds
- **Note:** Can be disabled manually for twinks

#### Threat Management
- **Context:** Tank threat generation significantly outpaces DPS output in 1.18.0 meta

---

## Summary of Stat Priorities Changes

### New Stats to Consider
1. **Meditation** - Mana regen during combat (5% per item)
2. **Haste** - Attack speed increase (1-5% with diminishing returns)

### Changed Stat Values
1. **Weapon Skill** - Linear scaling, reduced racial bonuses (+5 → +3)
2. **Hit Rating** - Cap reduced to 8% for +3 level bosses (was 9%)
3. **Agility** - High Elf racial adds 2% total Agility
4. **Critical Strike** - Human Perception adds 2% crit
5. **Spell Hit** - Emerald Blessing adds 1% raid spell hit (1.17.0) when druids maintain the aura
6. **Crit Reduction** - New 1% anti-crit sources (PvP rings, Bloody Belt Buckle, Gurubashi Gumbo) supplement Defense for tank cap planning

### Stat Caps and Breakpoints
- **Old Weapon Skill Soft Cap (305):** No longer exists
- **New Hit Cap vs Bosses:** 8% (down from 9%)
- **Debuff Limit:** 24 (up from 16)
- **Armor Cap (75%):** Hard cap removed in 1.18.0, now has diminishing returns beyond 75%

---

## Sources

All information compiled from official Turtle WoW changelogs located in `/turtle-wow-changelogs/`:
- 1.15.0.html
- 1.16.0.html
- 1.16.1.html
- 1.16.4.html
- 1.17.0.html
- 1.17.1.html
- 1.17.2.html
- 1.17.2-general-class-changes.html
- 1.17.2-2024.10.21-changes.html
- 1.17.2-2024.12.20-changes.html
- 1.18.0.html
- 1.18.0-general-class-changes.html

**Last Updated:** Based on changelogs through Patch 1.18.0 (Scars of the Past)

---

## Implementation Notes for Pawn

### High Priority Changes
1. **Armor Cap Removal (1.18.0):** Armor now has diminishing returns beyond 75% instead of hard cap - critical for tank stat weights
2. **Weapon Skill Formula:** Linear scaling needs to be reflected in stat weights
3. **Hit Cap:** Reduce from 9% to 8% for boss calculations
4. **New Stats:** Add Meditation and Haste to stat weight calculations
5. **Racial Bonuses:** Update weapon skill racials from +5 to +3

### Medium Priority Changes
1. **Racial Stat Bonuses:** Documented for context - ClassicHawsJon_small.lua doesn't implement race-specific weights, but these affect effective stat values (e.g., Human Spirit +5% mana regen while casting, High Elf +2% Agility)
2. **Jewelcrafting Items:** New item sources to consider in optimization

### Low Priority Changes
1. **Difficulty Scaling:** Boss HP increases (doesn't directly affect stat weights)
2. **Consumable Changes:** Adjust recommendations for tea vs runes
