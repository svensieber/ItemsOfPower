# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

ItemsOfPower is a World of Warcraft 1.12 (Vanilla) addon for item stat valuation. It calculates "Item Power" by assigning weights to item attributes, allowing players to compare gear effectiveness for different builds and playstyles.

**Target Platform:** World of Warcraft 1.12.1 (Vanilla)
**Language:** Lua 5.0
**Framework:** Ace2 library ecosystem

## Architecture

### Core Components

The addon is structured around a modular class system using Ace2's AceOO framework:

1. **ItemsOfPower.lua** - Main addon core
   - Manages set registration and lifecycle
   - Handles tooltip hooks for displaying item values
   - Provides FuBar plugin integration
   - Implements player/inspect equipment value display
   - Contains tooltip caching system (`TooltipTextCache`, `TooltipTextCache2`)

2. **StatSet.lua** - Simple weighted stat calculation
   - Basic stat weights (STR, AGI, STA, INT, SPI, etc.)
   - Grouped by categories: Base Stats, Physical DPS, Magical DPS, Healing, Tanking, Resistances, Misc
   - Uses ItemBonusLib for stat extraction

3. **SetGroup.lua** - Combines multiple StatSets with multipliers
   - Allows hybrid valuations (e.g., Effective Health + Threat)
   - Each set can have its own multiplier

4. **ItemFormula.lua** - Arbitrary Lua formula evaluation for single items
   - Custom formulas using Lua math expressions
   - Access to all stats as variables
   - Uses sandboxed environment (IVFD) for formula execution

5. **FullEquipmentFormula.lua** - Formula evaluation across full equipment set
   - Similar to ItemFormula but evaluates entire equipment

6. **BestItems.lua** - Tool for finding top items based on sets

### Key Libraries (Libs/)

- **ItemBonusLib-1.0.lua** - Critical library for extracting stats from items
  - Scans tooltips using Gratuity to parse item bonuses
  - Handles set bonuses, enchants, and gem sockets
  - Provides `ScanItem()`, `GetUnitEquipment()`, `MergeDetails()`, `BuildBonusSet()`
  - Defines stat constants (STR, AGI, STA, ATTACKPOWER, DMG, HEAL, etc.)

- **Ace2 Libraries** - Framework providing:
  - AceAddon-2.0: Addon initialization/lifecycle
  - AceOO-2.0: Object-oriented class system
  - AceDB-2.0: Saved variables management
  - AceConsole-2.0: Chat command handling
  - AceHook-2.1: Function hooking for tooltips
  - AceEvent-2.0: Event system

- **Dewdrop-2.0** - Dropdown menu system
- **Tablet-2.0** - Tooltip framework
- **Gratuity-2.0** - Tooltip text extraction
- **Deformat-2.0** - String pattern matching
- **FuBarPlugin-2.0** - FuBar integration

### Data Storage

Saved variables defined in ItemsOfPower.toc:
- `ItemsOfPowerDB` - Global profile storage
- `ItemsOfPowerDBPerChar` - Per-character storage

Set data stored in namespaces:
- `ItemsOfPower:AcquireDBNamespace("StatSet")` - StatSet configurations
- `ItemsOfPower:AcquireDBNamespace("Group")` - SetGroup configurations
- `ItemsOfPower:AcquireDBNamespace("Formula")` - ItemFormula configurations

## Turtle WoW Scaling Changes

This addon has been enhanced for Turtle WoW, a private vanilla server with custom scaling changes documented in `docs/turtle-wow-*-scaling-changes.md` and `docs/ScalingTurtleWoWClaude-Implementation.md`.

**Key differences from Vanilla:**
- Hit cap reduced: 9% → 8% (patch 1.17.2)
- Weapon skill rework: Linear scaling instead of breakpoints (patch 1.17.2)
- Armor cap removal: 75% hard cap → diminishing returns (patch 1.18.0)
- New stats: Vampirism, Regen % while casting, Resilience
- New stat: Meditation (5% mana regen during combat per item, patch 1.16.0)
- Class-specific scaling changes documented per class

When modifying stat calculations, refer to the appropriate class-specific scaling document in `docs/`.

## Development Commands

There is no build system or test framework. Development workflow:

1. **Edit Lua files** - Make changes to .lua files
2. **Test in-game** - Copy addon to WoW AddOns folder and reload UI (`/reload`)
3. **Commands:**
   - `/ipw` or `/itempower` - Open configuration UI
   - `/ibonus show` - Debug: Show current equipment bonuses
   - `/ibonus details` - Debug: Show bonuses by slot
   - `/ibonus item <link>` - Debug: Analyze specific item

## Important Implementation Details

### Set Type Registration

All set types must register themselves using `ItemsOfPower:RegisterSetType(className, classObject)`. This happens automatically at file load.

Each set class must implement:
- `LoadSets()` - Static method to load saved sets from DB
- `:GetItemValue(ItemString)` - Calculate value for single item
- `:GetEquipValue(equipStats)` - Calculate value for full equipment
- `:Serialize()` - Convert to table for sharing/saving
- `Deserialize(table)` - Reconstruct from table

### Tooltip Caching

Tooltip calculations are cached in weak tables (`TooltipTextCache`, `TooltipTextCache2`). Call `ItemsOfPower:ClearCache()` after any configuration change to force recalculation.

### Item String Format

WoW item strings: `"item:itemId:enchantId:suffixId:uniqueId"`

Use these helper functions:
- `ItemsOfPower:ItemLinkToItemString(link)` - Extract string from link
- `ItemsOfPower:ItemStringToItemLink(string)` - Create colored link
- `ItemsOfPower:GetItemString(itemId, enchantId, suffixId, uniqueId)` - Build string

### Enchant Handling

Configurable via `db.profile.Modifications.Enchants`:
- "Ignore" - Remove all enchants
- "Do nothing" - Use enchants as-is
- "Always own" - Replace all enchants with player's current enchant
- "Fill with own" - Add player's enchant only if item has none

### Formula Environment

ItemFormula and FullEquipmentFormula use a sandboxed environment (IVFD):
```lua
local IVFD = { math = math }
setmetatable(IVFD, { ["__index"] = function() return 0 end })
```

Stats are injected as variables. Undefined stats return 0. Only `math` library is available.

### Table Recycling

The addon uses table pooling for performance:
- `tnew(...)` - Get recycled table
- `tdel(table)` - Return table to pool
- `tnewHash(...)` - Get recycled hash table
- `tddel(table)` - Deep delete and return to pool

Use these instead of `{}` for temporary tables.

## Lua 5.0 Compatibility

This addon targets Lua 5.0 (not 5.1+). Be aware of differences:
- No `table.insert()` with automatic positioning before Lua 5.1
- Use `table.getn(t)` instead of `#t`
- No `...` varargs - use `arg` table with `arg.n` for count
- No `select()` - addon provides `ItemsOfPower:select()`
- `string.gsub()` returns value + count (use first return value)
- No module system
- `loadstring()` instead of `load()`

## File Loading Order

Specified in ItemsOfPower.toc:
1. Libraries (Ace2, supporting libs, ItemBonusLib)
2. Locales
3. Core files (ItemsOfPower.lua, StatSet.lua, SetGroup.lua, ItemFormula.lua, FullEquipmentFormula.lua, BestItems.lua)

Order matters - ItemsOfPower.lua must load before set classes.

## Stat Constants

Defined in ItemBonusLib and referenced in StatSet.lua:

**Base:** STR, AGI, STA, INT, SPI
**Physical DPS:** ATTACKPOWER, ATTACKPOWERFERAL, CRIT, HASTE, TOHIT, RANGEDCRIT, RANGEDATTACKPOWER, ARMORIGNORE
**Magical DPS:** DMG, ARCANEDMG, FIREDMG, FROSTDMG, HOLYDMG, NATUREDMG, SHADOWDMG, SPELLCRIT, SPELLHASTE, SPELLTOHIT, SPELLPEN
**Healing:** HEAL, MANAREG, CASTINGREG
**Tanking:** ARMOR, DEFENSE, RESILIENCE, BLOCK, BLOCKVALUE, DODGE, PARRY
**Resistances:** ARCANERES, FIRERES, NATURERES, FROSTRES, SHADOWRES
**Misc:** MANA, HEALTH, HEALTHREG, VAMPIR, FISHING, MINING, HERBALISM, SKINNING

## Notes

- The addon uses extensive AceOO class inheritance - understand the prototype pattern
- All UI is built through AceOptions tables, rendered by Dewdrop menus
- Set sorting can be customized via `db.profile.SetIds` table
- Inspect functionality requires InspectFrame to be loaded (`InspectFrame_LoadUI()`)
- The addon fires custom event "ItemValue_SetsChanged" when sets are modified
