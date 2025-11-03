# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

ItemsOfPower is a World of Warcraft 1.12 (Vanilla) addon that provides flexible item stat valuation and power calculation. It allows players to create custom "Stat Sets" with weighted item attributes and calculates "Item Power" values that display on tooltips. Built for Turtle WoW with added support for Vampirism, regen % while casting, and resilience stats.

## Technology Stack

- Language: Lua 5.0 (WoW 1.12 API)
- Framework: Ace2 library framework
- Key Dependencies: ItemBonusLib-1.0, Gratuity-2.0, Deformat-2.0, Tablet-2.0, Dewdrop-2.0, FuBarPlugin-2.0

## Architecture

### Core Class System

The addon uses an object-oriented design via AceOO-2.0 with four main set types:

1. **StatSet** (StatSet.lua): Base stat weight system mapping ItemBonusLib stats to numeric weights
2. **SetGroup** (SetGroup.lua): Composite sets combining multiple StatSets with multipliers for hybrid valuations
3. **ItemFormula** (ItemFormula.lua): Custom Lua formula evaluator for single-item calculations
4. **FullEquipmentFormula** (FullEquipmentFormula.lua): Custom Lua formula evaluator for full equipment calculations

### Main Components

- **ItemsOfPower.lua**: Core addon initialization, tooltip hooking, equipment scanning, set registration/management
- **BestItems.lua**: "Top 15" item finder based on selected sets
- **Libs/**: Third-party Ace2 libraries (DO NOT modify these)
- **Locale/**: Translation files (enGB, deDE)

### Key Data Flow

1. ItemBonusLib scans items and extracts stat bonuses
2. StatSets/Groups/Formulas calculate power values from stats
3. Values cached in TooltipTextCache/TooltipTextCache2
4. Tooltip hooks inject calculated values into game tooltips
5. Equipment scanner tracks player/inspect stats via ItemBonusLib

### TOC File Structure

ItemsOfPower.toc defines load order (CRITICAL):
1. Libraries (AceLibrary, Ace* modules, utility libs)
2. Locales
3. Core files (ItemsOfPower.lua must load first)
4. Set type classes (StatSet, SetGroup, ItemFormula, FullEquipmentFormula)
5. Tools (BestItems)

## Development Commands

### Testing
No automated test suite. Test in-game by:
1. Load addon in WoW 1.12 client
2. Use `/ipw` or `/itempower` to access configuration
3. Create test sets and hover over items to verify tooltip values
4. Check `/console scriptErrors 1` for Lua errors

### Debugging
Enable debug output via AceDebug:
```lua
ItemsOfPower:SetDebugging(true)
```

## Code Conventions

### Lua Patterns
- Local function closure for private state (see tnew/tdel pattern in ItemsOfPower.lua:25-80)
- Prototype-based OOP via AceOO with `Class.prototype:method()` syntax
- SavedVariables persistence via AceDB-2.0 namespaces
- Event-driven hooks via AceHook-2.1 and AceEvent-2.0

### ItemBonusLib Stats
Core stat tokens defined in StatSet.lua:14-22:
- Base: STR, AGI, STA, INT, SPI
- Physical: ATTACKPOWER, CRIT, HASTE, TOHIT, ARMORIGNORE
- Spell: DMG, SPELLDMG variants, SPELLCRIT, SPELLHASTE, SPELLTOHIT, SPELLPEN
- Healing: HEAL, MANAREG, CASTINGREG
- Tank: ARMOR, DEFENSE, RESILIENCE, BLOCK, DODGE, PARRY
- Resistance: ARCANERES, FIRERES, NATURERES, FROSTRES, SHADOWRES
- Misc: MANA, HEALTH, HEALTHREG, VAMPIR, FISHING, MINING, HERBALISM, SKINNING

### Item String Format
`item:itemId:enchantId:suffixId:uniqueId`
- Parsed/constructed via strsplit and GetItemString methods
- Enchant handling configurable: Ignore, Do nothing, Always own, Fill with own

## Important Implementation Details

### Caching System
TooltipTextCache uses weak table references (`__mode = "kv"`) for automatic garbage collection. Always call `ItemsOfPower:ClearCache()` after:
- Modifying stat weights
- Creating/deleting sets
- Changing display options
- Updating equipment

### Set Registration
All set types MUST:
1. Implement `GetEquipValue(eq)` and `GetItemValue(ItemString)` methods
2. Provide `Serialize()` and `Deserialize(t)` for addon comm sharing
3. Call `ItemsOfPower:RegisterSetType(name, class)` on load
4. Implement `OnDelete()` for cleanup

### Formula Execution
Formulas use sandboxed environment (IVFD) with `__index` metamethod returning 0 for missing stats. Math library exposed, no other globals accessible. Use `loadstring` + `setfenv` pattern.

## Common Pitfalls

- Never modify library files in Libs/ - these are external dependencies
- Tooltip hooks must handle nil ItemLink gracefully (checking before ItemLinkToItemString)
- Equipment comparison requires careful slot mapping (see GetInventorySlot in ItemsOfPower.lua:1338-1387)
- Custom sorting (SetIds) optional - code must handle nil SetIds table
- Ace2 uses 1-indexed tables and custom table management (tnew/tdel pool)

## File Organization

Core addon files only at root level. Libraries contained in Libs/ subdirectory. Localization in Locale/. All files must be declared in ItemsOfPower.toc in dependency order.
