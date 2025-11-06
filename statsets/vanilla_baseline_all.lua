--[[
  Vanilla Baseline StatSets
  Generated from ClassicHawsJon_small.lua
  
  Total: 28 specs
  
  Usage:
    1. Copy this entire file
    2. Execute in-game (in chunks if needed)
    3. All StatSets will be created
]]

-- Generated: 2025-11-06 10:11:56

-- Vanilla - Druid - Balance
do
  local stats = {
    AGI = 0.05000,
    ARCANEDMG = 0.64000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    DEFENSE = 0.07500,
    DMG = 1.00000,
    DODGE = 0.47200,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    INT = 0.38000,
    MANA = 0.03200,
    MANAREG = 0.58000,
    NATUREDMG = 0.43000,
    NATURERES = 0.24000,
    PARRY = 0.47200,
    RESILIENCE = 0.20000,
    SHADOWRES = 0.24000,
    SPELLCRIT = 4.96000,
    SPELLHASTE = 6.42400,
    SPELLPEN = 0.21000,
    SPELLTOHIT = 9.68000,
    SPI = 0.34000,
    STA = 0.10000,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Druid - Balance"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Druid - Balance", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Druid - Balance")
  else
    print("StatSet already exists: Vanilla - Druid - Balance")
  end
end

-- Vanilla - Druid - Feral Damage
do
  local stats = {
    AGI = 1.00000,
    ARCANERES = 0.24000,
    ARMOR = 0.02000,
    ARMORIGNORE = 1.50000,
    ATTACKPOWER = 0.59000,
    ATTACKPOWERFERAL = 0.59000,
    CRIT = 5.01500,
    DEFENSE = 0.07500,
    DODGE = 0.47200,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HASTE = 3.45290,
    HEAL = 0.02500,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    INT = 0.10000,
    MANA = 0.00900,
    MANAREG = 0.30000,
    NATURERES = 0.24000,
    PARRY = 0.47200,
    RESILIENCE = 0.20000,
    SHADOWRES = 0.24000,
    SPI = 0.05000,
    STA = 0.10000,
    STR = 1.48000,
    TOHIT = 5.72138,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Druid - Feral Damage"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Druid - Feral Damage", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Druid - Feral Damage")
  else
    print("StatSet already exists: Vanilla - Druid - Feral Damage")
  end
end

-- Vanilla - Druid - Feral Tank
do
  local stats = {
    AGI = 0.48000,
    ARCANERES = 1.20000,
    ARMOR = 0.10000,
    ARMORIGNORE = 0.75000,
    ATTACKPOWER = 0.34000,
    ATTACKPOWERFERAL = 0.34000,
    CRIT = 1.27500,
    DEFENSE = 0.39000,
    DODGE = 3.58720,
    FIRERES = 1.20000,
    FROSTRES = 1.20000,
    HASTE = 2.48930,
    HEAL = 0.02500,
    HEALTH = 0.08000,
    HEALTHREG = 2.00000,
    INT = 0.10000,
    MANA = 0.00900,
    MANAREG = 0.30000,
    NATUREDMG = 0.02500,
    NATURERES = 1.20000,
    RESILIENCE = 0.20000,
    SHADOWRES = 1.20000,
    SPI = 0.05000,
    STA = 1.00000,
    STR = 0.20000,
    TOHIT = 1.50069,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Druid - Feral Tank"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Druid - Feral Tank", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Druid - Feral Tank")
  else
    print("StatSet already exists: Vanilla - Druid - Feral Tank")
  end
end

-- Vanilla - Druid - Restoration
do
  local stats = {
    AGI = 0.05000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    DEFENSE = 0.07500,
    DODGE = 0.47200,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HEAL = 1.21000,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    INT = 1.00000,
    MANA = 0.09000,
    MANAREG = 1.70000,
    NATURERES = 0.24000,
    PARRY = 0.47200,
    RESILIENCE = 0.20000,
    SHADOWRES = 0.24000,
    SPELLCRIT = 2.80000,
    SPELLHASTE = 3.93470,
    SPI = 0.87000,
    STA = 0.10000,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Druid - Restoration"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Druid - Restoration", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Druid - Restoration")
  else
    print("StatSet already exists: Vanilla - Druid - Restoration")
  end
end

-- Vanilla - Hunter - Beast Mastery
do
  local stats = {
    AGI = 1.00000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    ARMORIGNORE = 0.63750,
    ATTACKPOWER = 0.43000,
    CRIT = 6.80000,
    DEFENSE = 0.07500,
    DODGE = 0.47200,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HASTE = 4.01500,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    INT = 0.80000,
    MANA = 0.07500,
    MANAREG = 2.40000,
    NATURERES = 0.24000,
    PARRY = 0.47200,
    RANGEDATTACKPOWER = 0.43000,
    RESILIENCE = 0.20000,
    SHADOWRES = 0.24000,
    SPI = 0.05000,
    STA = 0.10000,
    STR = 0.05000,
    TOHIT = 9.37931,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Hunter - Beast Mastery"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Hunter - Beast Mastery", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Hunter - Beast Mastery")
  else
    print("StatSet already exists: Vanilla - Hunter - Beast Mastery")
  end
end

-- Vanilla - Hunter - Marksmanship
do
  local stats = {
    AGI = 1.00000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    ARMORIGNORE = 1.38750,
    ATTACKPOWER = 0.55000,
    CRIT = 5.10000,
    DEFENSE = 0.07500,
    DODGE = 0.47200,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HASTE = 3.21200,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    INT = 0.90000,
    MANA = 0.08500,
    MANAREG = 2.40000,
    NATURERES = 0.24000,
    PARRY = 0.47200,
    RANGEDATTACKPOWER = 0.55000,
    RESILIENCE = 0.20000,
    SHADOWRES = 0.24000,
    SPI = 0.05000,
    STA = 0.10000,
    STR = 0.05000,
    TOHIT = 9.37931,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Hunter - Marksmanship"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Hunter - Marksmanship", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Hunter - Marksmanship")
  else
    print("StatSet already exists: Vanilla - Hunter - Marksmanship")
  end
end

-- Vanilla - Hunter - Survival
do
  local stats = {
    AGI = 1.00000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    ARMORIGNORE = 1.05000,
    ATTACKPOWER = 0.55000,
    CRIT = 5.52500,
    DEFENSE = 0.07500,
    DODGE = 0.47200,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HASTE = 3.21200,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    INT = 0.80000,
    MANA = 0.07500,
    MANAREG = 2.40000,
    NATURERES = 0.24000,
    PARRY = 0.47200,
    RANGEDATTACKPOWER = 0.55000,
    RESILIENCE = 0.20000,
    SHADOWRES = 0.24000,
    SPI = 0.05000,
    STA = 0.10000,
    STR = 0.05000,
    TOHIT = 9.37931,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Hunter - Survival"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Hunter - Survival", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Hunter - Survival")
  else
    print("StatSet already exists: Vanilla - Hunter - Survival")
  end
end

-- Vanilla - Mage - Arcane
do
  local stats = {
    AGI = 0.05000,
    ARCANEDMG = 0.88000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    DEFENSE = 0.07500,
    DMG = 1.00000,
    DODGE = 0.47200,
    FIREDMG = 0.06400,
    FIRERES = 0.24000,
    FROSTDMG = 0.52000,
    FROSTRES = 0.24000,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    INT = 0.46000,
    MANA = 0.03800,
    MANAREG = 1.13000,
    NATURERES = 0.24000,
    PARRY = 0.47200,
    RESILIENCE = 0.20000,
    SHADOWRES = 0.24000,
    SPELLCRIT = 4.80000,
    SPELLHASTE = 4.73770,
    SPELLPEN = 0.09000,
    SPELLTOHIT = 6.96000,
    SPI = 0.59000,
    STA = 0.10000,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Mage - Arcane"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Mage - Arcane", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Mage - Arcane")
  else
    print("StatSet already exists: Vanilla - Mage - Arcane")
  end
end

-- Vanilla - Mage - Fire
do
  local stats = {
    AGI = 0.05000,
    ARCANEDMG = 0.16800,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    DEFENSE = 0.07500,
    DMG = 1.00000,
    DODGE = 0.47200,
    FIREDMG = 0.94000,
    FIRERES = 0.24000,
    FROSTDMG = 0.32000,
    FROSTRES = 0.24000,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    INT = 0.44000,
    MANA = 0.03600,
    MANAREG = 0.90000,
    NATURERES = 0.24000,
    PARRY = 0.47200,
    RESILIENCE = 0.20000,
    SHADOWRES = 0.24000,
    SPELLCRIT = 6.16000,
    SPELLHASTE = 6.58460,
    SPELLPEN = 0.09000,
    SPELLTOHIT = 7.44000,
    SPI = 0.06600,
    STA = 0.10000,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Mage - Fire"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Mage - Fire", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Mage - Fire")
  else
    print("StatSet already exists: Vanilla - Mage - Fire")
  end
end

-- Vanilla - Mage - Frost
do
  local stats = {
    AGI = 0.05000,
    ARCANEDMG = 0.13000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    DEFENSE = 0.07500,
    DMG = 1.00000,
    DODGE = 0.47200,
    FIREDMG = 0.05000,
    FIRERES = 0.24000,
    FROSTDMG = 0.95000,
    FROSTRES = 0.24000,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    INT = 0.37000,
    MANA = 0.03200,
    MANAREG = 0.80000,
    NATURERES = 0.24000,
    PARRY = 0.47200,
    RESILIENCE = 0.20000,
    SHADOWRES = 0.24000,
    SPELLCRIT = 4.64000,
    SPELLHASTE = 5.05890,
    SPELLPEN = 0.07000,
    SPELLTOHIT = 9.76000,
    SPI = 0.06000,
    STA = 0.10000,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Mage - Frost"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Mage - Frost", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Mage - Frost")
  else
    print("StatSet already exists: Vanilla - Mage - Frost")
  end
end

-- Vanilla - Paladin - Holy
do
  local stats = {
    AGI = 0.05000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    BLOCK = 0.06900,
    DEFENSE = 0.07500,
    DODGE = 0.47200,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HEAL = 0.54000,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    INT = 1.00000,
    MANA = 0.00900,
    MANAREG = 1.24000,
    NATURERES = 0.24000,
    PARRY = 0.47200,
    RESILIENCE = 0.20000,
    SHADOWRES = 0.24000,
    SPELLCRIT = 3.68000,
    SPELLHASTE = 3.13170,
    SPI = 0.28000,
    STA = 0.10000,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Paladin - Holy"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Paladin - Holy", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Paladin - Holy")
  else
    print("StatSet already exists: Vanilla - Paladin - Holy")
  end
end

-- Vanilla - Paladin - Protection
do
  local stats = {
    AGI = 0.60000,
    ARCANERES = 1.20000,
    ARMOR = 0.02000,
    ARMORIGNORE = 0.33750,
    ATTACKPOWER = 0.06000,
    BLOCK = 4.14000,
    BLOCKVALUE = 0.15000,
    CRIT = 1.27500,
    DEFENSE = 1.05000,
    DMG = 0.44000,
    DODGE = 6.60800,
    FIRERES = 1.20000,
    FROSTRES = 1.20000,
    HASTE = 4.01500,
    HEALTH = 0.09000,
    HEALTHREG = 2.00000,
    HOLYDMG = 0.44000,
    INT = 0.50000,
    MANA = 0.04500,
    MANAREG = 1.00000,
    NATURERES = 1.20000,
    PARRY = 5.66400,
    RESILIENCE = 0.20000,
    SHADOWRES = 1.20000,
    SPELLCRIT = 4.80000,
    SPELLHASTE = 0.96360,
    SPELLPEN = 0.03000,
    SPELLTOHIT = 6.24000,
    SPI = 0.05000,
    STA = 1.00000,
    STR = 0.20000,
    TOHIT = 1.50069,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Paladin - Protection"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Paladin - Protection", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Paladin - Protection")
  else
    print("StatSet already exists: Vanilla - Paladin - Protection")
  end
end

-- Vanilla - Paladin - Retribution
do
  local stats = {
    AGI = 0.64000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    ARMORIGNORE = 0.33750,
    ATTACKPOWER = 0.41000,
    CRIT = 5.61000,
    DEFENSE = 0.07500,
    DMG = 0.33000,
    DODGE = 0.47200,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HASTE = 2.00750,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    HOLYDMG = 0.33000,
    INT = 0.34000,
    MANA = 0.03200,
    MANAREG = 1.00000,
    NATURERES = 0.24000,
    PARRY = 0.47200,
    RESILIENCE = 0.20000,
    SHADOWRES = 0.24000,
    SPELLCRIT = 0.96000,
    SPELLHASTE = 0.32120,
    SPELLPEN = 0.01500,
    SPELLTOHIT = 1.68000,
    SPI = 0.05000,
    STA = 0.10000,
    STR = 1.00000,
    TOHIT = 7.87862,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Paladin - Retribution"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Paladin - Retribution", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Paladin - Retribution")
  else
    print("StatSet already exists: Vanilla - Paladin - Retribution")
  end
end

-- Vanilla - Priest - Discipline
do
  local stats = {
    AGI = 0.05000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    DEFENSE = 0.07500,
    DODGE = 0.47200,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HEAL = 0.72000,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    INT = 1.00000,
    MANA = 0.09000,
    MANAREG = 1.19000,
    NATURERES = 0.24000,
    PARRY = 0.47200,
    RESILIENCE = 0.20000,
    SHADOWRES = 0.24000,
    SPELLCRIT = 2.56000,
    SPELLHASTE = 4.57710,
    SPI = 0.48000,
    STA = 0.10000,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Priest - Discipline"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Priest - Discipline", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Priest - Discipline")
  else
    print("StatSet already exists: Vanilla - Priest - Discipline")
  end
end

-- Vanilla - Priest - Holy
do
  local stats = {
    AGI = 0.05000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    DEFENSE = 0.07500,
    DODGE = 0.47200,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HEAL = 0.81000,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    INT = 1.00000,
    MANA = 0.09000,
    MANAREG = 1.35000,
    NATURERES = 0.24000,
    PARRY = 0.47200,
    RESILIENCE = 0.20000,
    SHADOWRES = 0.24000,
    SPELLCRIT = 1.92000,
    SPELLHASTE = 4.81800,
    SPI = 0.73000,
    STA = 0.10000,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Priest - Holy"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Priest - Holy", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Priest - Holy")
  else
    print("StatSet already exists: Vanilla - Priest - Holy")
  end
end

-- Vanilla - Priest - Shadow
do
  local stats = {
    AGI = 0.05000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    DEFENSE = 0.07500,
    DMG = 1.00000,
    DODGE = 0.47200,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    INT = 0.19000,
    MANA = 0.01700,
    MANAREG = 1.00000,
    NATURERES = 0.24000,
    PARRY = 0.47200,
    RESILIENCE = 0.20000,
    SHADOWDMG = 1.00000,
    SHADOWRES = 0.24000,
    SPELLCRIT = 6.08000,
    SPELLHASTE = 5.21950,
    SPELLPEN = 0.08000,
    SPELLTOHIT = 8.96000,
    SPI = 0.21000,
    STA = 0.10000,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Priest - Shadow"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Priest - Shadow", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Priest - Shadow")
  else
    print("StatSet already exists: Vanilla - Priest - Shadow")
  end
end

-- Vanilla - Rogue - Assassination
do
  local stats = {
    AGI = 1.00000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    ARMORIGNORE = 0.90000,
    ATTACKPOWER = 0.45000,
    CRIT = 6.88500,
    DEFENSE = 0.07500,
    DODGE = 0.47200,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HASTE = 7.22700,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    NATURERES = 0.24000,
    PARRY = 1.13280,
    RESILIENCE = 0.20000,
    SHADOWRES = 0.24000,
    SPI = 0.05000,
    STA = 0.10000,
    STR = 0.50000,
    TOHIT = 9.37931,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Rogue - Assassination"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Rogue - Assassination", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Rogue - Assassination")
  else
    print("StatSet already exists: Vanilla - Rogue - Assassination")
  end
end

-- Vanilla - Rogue - Combat
do
  local stats = {
    AGI = 1.00000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    ARMORIGNORE = 0.90000,
    ATTACKPOWER = 0.45000,
    CRIT = 6.88500,
    DEFENSE = 0.07500,
    DODGE = 0.47200,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HASTE = 7.22700,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    NATURERES = 0.24000,
    PARRY = 1.13280,
    RESILIENCE = 0.20000,
    SHADOWRES = 0.24000,
    SPI = 0.05000,
    STA = 0.10000,
    STR = 0.50000,
    TOHIT = 9.37931,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Rogue - Combat"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Rogue - Combat", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Rogue - Combat")
  else
    print("StatSet already exists: Vanilla - Rogue - Combat")
  end
end

-- Vanilla - Rogue - Subtlety
do
  local stats = {
    AGI = 1.00000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    ARMORIGNORE = 0.90000,
    ATTACKPOWER = 0.45000,
    CRIT = 6.88500,
    DEFENSE = 0.07500,
    DODGE = 0.47200,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HASTE = 7.22700,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    NATURERES = 0.24000,
    PARRY = 1.13280,
    RESILIENCE = 0.20000,
    SHADOWRES = 0.24000,
    SPI = 0.05000,
    STA = 0.10000,
    STR = 0.50000,
    TOHIT = 9.37931,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Rogue - Subtlety"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Rogue - Subtlety", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Rogue - Subtlety")
  else
    print("StatSet already exists: Vanilla - Rogue - Subtlety")
  end
end

-- Vanilla - Shaman - Elemental
do
  local stats = {
    AGI = 0.05000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    BLOCK = 0.06900,
    DEFENSE = 0.07500,
    DMG = 1.00000,
    DODGE = 0.47200,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    INT = 0.31000,
    MANA = 0.02400,
    MANAREG = 1.14000,
    NATUREDMG = 1.00000,
    NATURERES = 0.24000,
    PARRY = 1.13280,
    RESILIENCE = 0.20000,
    SHADOWRES = 0.24000,
    SPELLCRIT = 8.40000,
    SPELLHASTE = 7.22700,
    SPELLPEN = 0.38000,
    SPELLTOHIT = 7.20000,
    SPI = 0.09000,
    STA = 0.10000,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Shaman - Elemental"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Shaman - Elemental", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Shaman - Elemental")
  else
    print("StatSet already exists: Vanilla - Shaman - Elemental")
  end
end

-- Vanilla - Shaman - Enhancement
do
  local stats = {
    AGI = 0.87000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    ARMORIGNORE = 0.45000,
    ATTACKPOWER = 0.50000,
    CRIT = 8.33000,
    DEFENSE = 0.07500,
    DMG = 0.30000,
    DODGE = 0.47200,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HASTE = 5.13920,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    INT = 0.34000,
    MANA = 0.03200,
    MANAREG = 1.00000,
    NATUREDMG = 0.30000,
    NATURERES = 0.24000,
    PARRY = 0.47200,
    RESILIENCE = 0.20000,
    SHADOWRES = 0.24000,
    SPELLCRIT = 2.60800,
    SPELLHASTE = 0.64240,
    SPELLPEN = 0.11000,
    SPELLTOHIT = 1.78400,
    SPI = 0.05000,
    STA = 0.10000,
    STR = 1.00000,
    TOHIT = 6.28414,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Shaman - Enhancement"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Shaman - Enhancement", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Shaman - Enhancement")
  else
    print("StatSet already exists: Vanilla - Shaman - Enhancement")
  end
end

-- Vanilla - Shaman - Restoration
do
  local stats = {
    AGI = 0.05000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    BLOCK = 0.06900,
    DEFENSE = 0.07500,
    DODGE = 0.47200,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HEAL = 0.90000,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    INT = 1.00000,
    MANA = 0.00900,
    MANAREG = 1.33000,
    NATURERES = 0.24000,
    PARRY = 0.47200,
    RESILIENCE = 0.20000,
    SHADOWRES = 0.24000,
    SPELLCRIT = 3.84000,
    SPELLHASTE = 5.94220,
    SPI = 0.61000,
    STA = 0.10000,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Shaman - Restoration"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Shaman - Restoration", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Shaman - Restoration")
  else
    print("StatSet already exists: Vanilla - Shaman - Restoration")
  end
end

-- Vanilla - Warlock - Affliction
do
  local stats = {
    AGI = 0.05000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    DEFENSE = 0.07500,
    DMG = 1.00000,
    DODGE = 0.47200,
    FIREDMG = 0.35000,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    INT = 0.40000,
    MANA = 0.03000,
    MANAREG = 1.00000,
    NATURERES = 0.24000,
    PARRY = 0.47200,
    RESILIENCE = 0.20000,
    SHADOWDMG = 0.91000,
    SHADOWRES = 0.24000,
    SPELLCRIT = 3.12000,
    SPELLHASTE = 6.26340,
    SPELLPEN = 0.08000,
    SPELLTOHIT = 9.60000,
    SPI = 0.10000,
    STA = 0.10000,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Warlock - Affliction"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Warlock - Affliction", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Warlock - Affliction")
  else
    print("StatSet already exists: Vanilla - Warlock - Affliction")
  end
end

-- Vanilla - Warlock - Demonology
do
  local stats = {
    AGI = 0.05000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    DEFENSE = 0.07500,
    DMG = 1.00000,
    DODGE = 0.47200,
    FIREDMG = 0.80000,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    INT = 0.40000,
    MANA = 0.03000,
    MANAREG = 1.00000,
    NATURERES = 0.24000,
    PARRY = 0.47200,
    RESILIENCE = 0.20000,
    SHADOWDMG = 0.80000,
    SHADOWRES = 0.24000,
    SPELLCRIT = 5.28000,
    SPELLHASTE = 5.62100,
    SPELLPEN = 0.08000,
    SPELLTOHIT = 9.60000,
    SPI = 0.50000,
    STA = 0.10000,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Warlock - Demonology"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Warlock - Demonology", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Warlock - Demonology")
  else
    print("StatSet already exists: Vanilla - Warlock - Demonology")
  end
end

-- Vanilla - Warlock - Destruction
do
  local stats = {
    AGI = 0.05000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    DEFENSE = 0.07500,
    DMG = 1.00000,
    DODGE = 0.47200,
    FIREDMG = 0.23000,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    INT = 0.34000,
    MANA = 0.02800,
    MANAREG = 0.65000,
    NATURERES = 0.24000,
    PARRY = 0.47200,
    RESILIENCE = 0.20000,
    SHADOWDMG = 0.95000,
    SHADOWRES = 0.24000,
    SPELLCRIT = 6.96000,
    SPELLHASTE = 9.23450,
    SPELLPEN = 0.08000,
    SPELLTOHIT = 12.80000,
    SPI = 0.25000,
    STA = 0.10000,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Warlock - Destruction"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Warlock - Destruction", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Warlock - Destruction")
  else
    print("StatSet already exists: Vanilla - Warlock - Destruction")
  end
end

-- Vanilla - Warrior - Arms
do
  local stats = {
    AGI = 0.69000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    ARMORIGNORE = 4.12500,
    ATTACKPOWER = 0.45000,
    CRIT = 7.22500,
    DEFENSE = 0.07500,
    DODGE = 0.47200,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HASTE = 4.57710,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    NATURERES = 0.24000,
    PARRY = 0.47200,
    RESILIENCE = 0.20000,
    SHADOWRES = 0.24000,
    SPI = 0.05000,
    STA = 0.10000,
    STR = 1.00000,
    TOHIT = 9.37931,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Warrior - Arms"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Warrior - Arms", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Warrior - Arms")
  else
    print("StatSet already exists: Vanilla - Warrior - Arms")
  end
end

-- Vanilla - Warrior - Fury
do
  local stats = {
    AGI = 0.57000,
    ARCANERES = 0.24000,
    ARMOR = 0.00500,
    ARMORIGNORE = 1.76250,
    ATTACKPOWER = 0.54000,
    CRIT = 5.95000,
    DEFENSE = 0.07500,
    DODGE = 0.47200,
    FIRERES = 0.24000,
    FROSTRES = 0.24000,
    HASTE = 3.29230,
    HEALTH = 0.01000,
    HEALTHREG = 1.00000,
    NATURERES = 0.24000,
    PARRY = 1.13280,
    RESILIENCE = 0.20000,
    SHADOWRES = 0.24000,
    SPI = 0.05000,
    STA = 0.10000,
    STR = 1.00000,
    TOHIT = 5.34621,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Warrior - Fury"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Warrior - Fury", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Warrior - Fury")
  else
    print("StatSet already exists: Vanilla - Warrior - Fury")
  end
end

-- Vanilla - Warrior - Protection
do
  local stats = {
    AGI = 0.59000,
    ARCANERES = 1.20000,
    ARMOR = 0.02000,
    ARMORIGNORE = 0.71250,
    ATTACKPOWER = 0.06000,
    BLOCK = 4.07100,
    BLOCKVALUE = 0.35000,
    CRIT = 2.38000,
    DEFENSE = 1.21500,
    DODGE = 6.60800,
    FIRERES = 1.20000,
    FROSTRES = 1.20000,
    HASTE = 1.68630,
    HEALTH = 0.09000,
    HEALTHREG = 2.00000,
    NATURERES = 1.20000,
    PARRY = 5.47520,
    RESILIENCE = 0.20000,
    SHADOWRES = 1.20000,
    SPI = 0.05000,
    STA = 1.00000,
    STR = 0.33000,
    TOHIT = 6.28414,
  }
  
  if not ItemsOfPower.SetByName["Vanilla - Warrior - Protection"] then
    local set = ItemsOfPower.SetTypes.StatSet:new("Vanilla - Warrior - Protection", stats)
    ItemsOfPower:RegisterSet(set)
    print("Created StatSet: Vanilla - Warrior - Protection")
  else
    print("StatSet already exists: Vanilla - Warrior - Protection")
  end
end


print("All Vanilla Baseline StatSets loaded!")
print("Total: 28 specs created")