# ItemsOfPower - Ingame Testing Guide (Turtle WoW)

## Übersicht

Dieser Guide hilft beim systematischen Testen des ItemsOfPower Addons mit den neuen Turtle WoW StatSets.

**Geschätzte Testdauer:** 2-3 Stunden (vollständig), 30-45 Minuten (Basis-Tests)

---

## Phase 1: Installation & Setup (5-10 Minuten)

### 1.1 Addon Installation

**Vorbereitung:**
```bash
# 1. Kopiere den gesamten iop-claude Ordner nach:
World of Warcraft/_classic_/Interface/AddOns/ItemsOfPower/

# 2. Stelle sicher, dass die Struktur korrekt ist:
AddOns/ItemsOfPower/
  ├── ItemsOfPower.toc
  ├── ItemsOfPower.lua
  ├── StatSet.lua
  ├── statsets/
  │   ├── vanilla_baseline_all.lua
  │   ├── turtlewow_hunter.lua
  │   ├── turtlewow_rogue.lua
  │   ├── ... (alle anderen)
  ├── tools/
  │   └── turtle_wow_adjustments.lua
  └── Libs/
```

**Checkliste:**
- [ ] Addon-Ordner korrekt kopiert
- [ ] Keine Unterordner-Verschachtelung (häufiger Fehler!)
- [ ] .toc Datei vorhanden
- [ ] Alle .lua Dateien vorhanden

### 1.2 Erster Start

1. **Starte WoW Client** (mit aktiviertem Addon)
2. **Login** mit einem beliebigen Character
3. **Öffne Chat Log** (`/chatlog` falls nicht sichtbar)

**Erwartetes Verhalten:**
```
ItemsOfPower loaded successfully
Loading Turtle WoW adjustments...
Turtle WoW - Hunter - Beast Mastery:
  TOHIT: 5.97 → 6.72 (+12.5%)
  RAP: 0.43 → 0.516 (+20%)
  ...
Created StatSet: Turtle WoW - Hunter - Beast Mastery
...
All Turtle WoW Hunter StatSets created!
Total: 3 specs
```

**Fehlerbehandlung:**
- ❌ **"Interface action failed"**: Lua-Fehler → Prüfe /bugerror
- ❌ **Keine Ausgabe im Chat**: Addon nicht geladen → Prüfe AddOn-Liste
- ❌ **"attempt to index nil value"**: Fehlende Abhängigkeiten

---

## Phase 2: Grundfunktionalität (10-15 Minuten)

### 2.1 Addon Interface öffnen

**Befehle:**
```
/iop                  # Öffnet Hauptmenü
/iop show             # Zeigt alle Sets
/itemsofpower         # Alternative
```

**Checkliste:**
- [ ] Interface öffnet sich ohne Fehler
- [ ] Alle Menü-Einträge sichtbar
- [ ] Keine Lua-Fehler im /bugerror

### 2.2 StatSet-Liste überprüfen

1. **Öffne** `/iop show`
2. **Scroll durch die Liste**

**Erwartete Sets:**
- Vanilla Sets (9 Klassen × ~3 Specs = ~28 Sets)
- Turtle WoW Sets (9 Klassen × ~3 Specs = ~28 Sets)

**Naming Convention:**
```
✓ "Vanilla - Hunter - Beast Mastery"
✓ "Turtle WoW - Hunter - Beast Mastery"
✗ "TurtleWoW-Hunter-BM"  # Falsch!
```

**Checkliste:**
- [ ] Alle Vanilla Sets vorhanden
- [ ] Alle Turtle WoW Sets vorhanden
- [ ] Naming konsistent
- [ ] Keine doppelten Einträge

### 2.3 Item-Bewertung testen

1. **Öffne Inventar** (B)
2. **Wähle ein StatSet** (z.B. "Turtle WoW - Hunter - Beast Mastery")
3. **Hover über Items** im Inventar

**Erwartetes Verhalten:**
- Items zeigen Punktwerte im Tooltip
- Grüne/rote Pfeile für bessere/schlechtere Items
- Punktwerte basierend auf gewähltem StatSet

**Checkliste:**
- [ ] Tooltips zeigen Punktwerte
- [ ] Pfeile zeigen Verbesserungen korrekt an
- [ ] Keine Lua-Fehler beim Hovern

---

## Phase 3: StatSet-Registrierung (15-20 Minuten)

### 3.1 Alle Turtle WoW Sets testen

**Systematisches Vorgehen:**

Für **jede Klasse** (Hunter, Rogue, Warlock, Shaman, Paladin, Druid, Mage, Priest, Warrior):

1. **Prüfe Chat-Ausgabe** beim Login:
   ```
   Turtle WoW - [Class] - [Spec]:
     [Stat]: [Old] → [New] ([Change])
     ...
   Created StatSet: Turtle WoW - [Class] - [Spec]
   ```

2. **Wähle das Set** in `/iop`
3. **Hovere über ein Item**

**Checkliste pro Klasse:**
```
[ ] Hunter
  [ ] Beast Mastery - Chat OK, Set verfügbar, Item-Bewertung funktioniert
  [ ] Marksmanship - Chat OK, Set verfügbar, Item-Bewertung funktioniert
  [ ] Survival - Chat OK, Set verfügbar, Item-Bewertung funktioniert

[ ] Rogue
  [ ] Assassination
  [ ] Combat
  [ ] Subtlety

[ ] Warlock
  [ ] Affliction
  [ ] Demonology
  [ ] Destruction

[ ] Shaman
  [ ] Elemental
  [ ] Enhancement
  [ ] Restoration

[ ] Paladin
  [ ] Holy
  [ ] Protection
  [ ] Retribution

[ ] Druid
  [ ] Balance
  [ ] Feral Damage
  [ ] Feral Tank
  [ ] Restoration

[ ] Mage
  [ ] Arcane
  [ ] Fire
  [ ] Frost

[ ] Priest
  [ ] Discipline
  [ ] Holy
  [ ] Shadow

[ ] Warrior
  [ ] Arms
  [ ] Fury
  [ ] Protection
```

**Total:** 28 Specs zu testen

---

## Phase 4: Stat-Berechnung validieren (30-40 Minuten)

### 4.1 Hit Cap Test (Physical)

**Test-Setup:**
- **Character:** Beliebiger Melee DPS (Hunter/Rogue/Warrior)
- **StatSets:** Vanilla vs Turtle WoW (gleiche Klasse/Spec)

**Test-Item:**
- Item mit **+1% Hit** (z.B. Ring mit Hit)

**Erwartetes Verhalten:**
```
Vanilla (9% Cap):
  +1% Hit = Basis-Wert (z.B. 10 Punkte)

Turtle WoW (8% Cap):
  +1% Hit = Basis-Wert × 1.125 (z.B. 11.25 Punkte)
```

**Durchführung:**
1. Wähle **Vanilla - Hunter - Beast Mastery**
2. Hover über Hit-Item → Notiere Punktwert
3. Wähle **Turtle WoW - Hunter - Beast Mastery**
4. Hover über Hit-Item → Notiere Punktwert
5. **Berechne Differenz:** Sollte ~12.5% sein

**Checkliste:**
- [ ] Turtle WoW Hit-Wert > Vanilla Hit-Wert
- [ ] Differenz ungefähr +12.5%
- [ ] Gilt für alle Melee-Specs

### 4.2 Spell Hit Cap Test

**Test-Setup:**
- **Character:** Beliebiger Caster DPS (Mage/Warlock/Priest Shadow)
- **Test-Item:** Item mit **+1% Spell Hit**

**Durchführung:** (wie 4.1)

**Checkliste:**
- [ ] Turtle WoW Spell Hit > Vanilla Spell Hit
- [ ] Differenz ungefähr +12.5%
- [ ] Gilt für alle Caster-Specs

### 4.3 Spezielle Stats testen

#### Test 1: Hunter Ranged Attack Power

**Test-Item:** Quiver/Ammo Pouch mit Ranged AP

**Erwartung:**
```
Turtle WoW - Hunter - Beast Mastery:
  RAP = vanilla × 1.2 (+20%)
```

**Checkliste:**
- [ ] RAP-Wert in Turtle WoW höher
- [ ] Differenz ungefähr +20%

#### Test 2: Warrior Block Value

**Test-Item:** Schild mit Block Value

**Test für Protection:**
```
Turtle WoW - Warrior - Protection:
  Block Value = vanilla × 1.5 (+50%)
```

**Checkliste:**
- [ ] Block Value in Turtle WoW deutlich höher
- [ ] Differenz ungefähr +50%

#### Test 3: Priest Discipline (Holy DPS)

**Test-Items:**
- Item mit **Spell Damage**
- Item mit **Holy Damage**

**Erwartung:**
```
Vanilla - Priest - Discipline:
  Spell Damage = niedrig (Heiler-Spec)

Turtle WoW - Priest - Discipline:
  Spell Damage = hoch (DPS-Spec)
  Holy Damage = sehr hoch
```

**Checkliste:**
- [ ] Spell Damage in Turtle WoW viel höher
- [ ] Holy Damage besonders wertvoll
- [ ] Healing Power immer noch wertvoll (PW:Shield)

#### Test 4: Paladin Holy Spell Damage

**Test-Item:** Item mit Spell Damage

**Erwartung:**
```
Vanilla - Paladin - Holy:
  Spell Damage = (nicht vorhanden/sehr niedrig)

Turtle WoW - Paladin - Holy:
  Spell Damage = NEU vorhanden (Holy Strike, Daybreak)
```

**Checkliste:**
- [ ] Vanilla: Spell Damage wenig/nicht bewertet
- [ ] Turtle WoW: Spell Damage zeigt Wert
- [ ] Wert nicht zu hoch (konservativ)

---

## Phase 5: Vergleichstests (20-30 Minuten)

### 5.1 Pre-Raid BiS Item vergleichen

**Ziel:** Sicherstellen dass Turtle WoW Sets plausible Änderungen zeigen

**Durchführung:**

1. **Wähle bekanntes Pre-Raid BiS Item** (z.B. Devilsaur Set, Satyr's Bow)
2. **Vergleiche Werte:**
   - Vanilla Set
   - Turtle WoW Set

**Beispiel: Satyr's Bow (Hunter)**
```
Item Stats: 51-95 Damage, 2.90 Speed, +14 Agility, +7 Stamina

Erwartung:
  Vanilla BM:     ~85 Punkte
  Turtle WoW BM:  ~95-100 Punkte (+10-15%)
```

**Begründung:**
- Turtle WoW: Agility +10%, Hit Cap +12.5%, RAP +20%
- Item sollte in Turtle WoW wertvoller sein

**Checkliste:**
- [ ] Turtle WoW Wert ≥ Vanilla Wert (für DPS Stats)
- [ ] Differenz plausibel (5-25%)
- [ ] Keine extremen Ausreißer (>100% Differenz)

### 5.2 Tier Set vergleichen

**Test-Items:** T1/T2/T3 Set-Teile

**Für verschiedene Klassen:**
- [ ] Hunter T1 (Beastmaster Armor)
- [ ] Rogue T2 (Bloodfang Armor)
- [ ] Warrior T3 (Dreadnaught's Battlegear)
- [ ] Priest T2 (Vestments of Transcendence)

**Erwartung:**
- Set-Boni sollten korrekt bewertet werden
- Turtle WoW Sets berücksichtigen neue Skalierungen

---

## Phase 6: Edge Cases & Fehlerbehandlung (15-20 Minuten)

### 6.1 Items ohne Stats

**Test-Items:**
- Graue Items (Vendor Trash)
- Weiße Items (keine Stats)
- Quest Items ohne Stats

**Erwartetes Verhalten:**
- Keine Lua-Fehler
- Punktwert = 0 oder "N/A"

**Checkliste:**
- [ ] Keine Errors bei grauen Items
- [ ] Keine Errors bei weißen Items
- [ ] Tooltip zeigt "0 Punkte" oder nichts

### 6.2 Items mit unbekannten Stats

**Test-Items:**
- Items mit procs (z.B. "Chance to restore X mana")
- Items mit Use-Effects
- Items mit Set-Boni

**Erwartetes Verhalten:**
- Base Stats werden bewertet
- Procs/Effects werden ignoriert (OK!)
- Keine Lua-Errors

**Checkliste:**
- [ ] Base Stats korrekt bewertet
- [ ] Keine Errors bei Proc-Items
- [ ] Set-Boni zeigen Warnung oder werden ignoriert

### 6.3 Items mit mehreren Schadenstypen

**Test-Items:**
- Items mit "+Shadow AND Fire Damage"
- Items mit "+Damage and Healing"

**Erwartetes Verhalten:**
- Beide Stats werden addiert
- Korrekte Gewichtung je nach Spec

**Checkliste:**
- [ ] Multi-Type Damage korrekt bewertet
- [ ] +Damage and Healing für Heiler/DPS korrekt

### 6.4 Switching zwischen Sets

**Test:**
1. Wähle Set A (z.B. "Turtle WoW - Hunter - BM")
2. Hover über Item → Notiere Wert
3. Wähle Set B (z.B. "Turtle WoW - Hunter - MM")
4. Hover über gleiches Item → Wert sollte sich ändern

**Checkliste:**
- [ ] Set-Wechsel funktioniert sofort
- [ ] Keine Lua-Errors beim Wechseln
- [ ] Cache wird korrekt geleert

---

## Phase 7: Performance & UI (10-15 Minuten)

### 7.1 Performance Test

**Durchführung:**
1. **Öffne Inventar** mit vielen Items (40+ Items)
2. **Bewege Maus schnell** über alle Items
3. **Beobachte:**
   - Framerate (sollte stabil bleiben)
   - Tooltip Delay (sollte minimal sein)

**Checkliste:**
- [ ] Keine spürbaren Lags
- [ ] Tooltips erscheinen sofort
- [ ] Keine Memory Leaks (über Zeit testen)

### 7.2 UI Test

**Features zu testen:**
- [ ] Interface skaliert korrekt (verschiedene Auflösungen)
- [ ] Menü-Navigation flüssig
- [ ] Scroll-Funktionen arbeiten
- [ ] Buttons reagieren

### 7.3 Kompatibilität mit anderen Addons

**Häufige Konflikte:**
- Tooltip Addons (AtlasLoot, etc.)
- Inventory Addons (Bagnon, etc.)
- Other Stat Addons

**Checkliste:**
- [ ] Tooltips nicht doppelt
- [ ] Keine Addon-Konflikte
- [ ] Performance OK mit anderen Addons

---

## Phase 8: Finaler Validierungstest (10 Minuten)

### 8.1 Smoke Test

**Schneller Durchlauf für alle Hauptfunktionen:**

1. **Login** mit beliebigem Character
   - [ ] Addon lädt ohne Errors
   - [ ] Alle StatSets registriert

2. **Item-Bewertung**
   - [ ] Tooltips zeigen Werte
   - [ ] Werte sind plausibel

3. **Set-Wechsel**
   - [ ] Wechsel zwischen Vanilla/Turtle WoW funktioniert
   - [ ] Werte ändern sich korrekt

4. **Performance**
   - [ ] Keine Lags
   - [ ] Keine Memory Leaks

### 8.2 Kritische Fehler dokumentieren

**Bei Problemen notieren:**
```
[ ] Fehlertyp: _______________________
[ ] Betrifft Klasse/Spec: _____________
[ ] Reproduzierbar: Ja / Nein
[ ] Lua Error Message: _______________
[ ] Screenshot/Video: ________________
```

---

## Anhang: Häufige Probleme & Lösungen

### Problem: "attempt to index nil value"

**Ursache:** Fehlende Dependency oder falsche Ladereihenfolge

**Lösung:**
1. Prüfe .toc Datei: Sind alle Dependencies gelistet?
2. Prüfe Ladereihenfolge: `tools/` vor `statsets/`
3. Prüfe ob turtle_wow_adjustments.lua geladen wird

### Problem: StatSets werden nicht angezeigt

**Ursache:** Registrierung fehlgeschlagen

**Lösung:**
1. Prüfe Chat-Log für Error Messages
2. Prüfe ob `ItemsOfPower:RegisterSet()` aufgerufen wird
3. Prüfe Naming Convention (keine Sonderzeichen!)

### Problem: Werte scheinen falsch

**Ursache:** Multiplier-Fehler oder falsche Baseline

**Lösung:**
1. Vergleiche mit vanilla_baseline_all.lua
2. Prüfe ob AdjustHitCap korrekt angewendet
3. Prüfe ob EnsureMinimumHaste korrekt angewendet

### Problem: Performance Issues

**Ursache:** Cache nicht aktiv oder Memory Leak

**Lösung:**
1. Prüfe ob `ItemsOfPower:ClearCache()` zu oft aufgerufen wird
2. Prüfe auf Memory Leaks mit `/script collectgarbage("collect")`
3. Deaktiviere andere Addons für Test

---

## Testbericht Template

```markdown
# ItemsOfPower Test Report

**Datum:** ___________
**Tester:** ___________
**WoW Version:** Turtle WoW 1.x.x
**Addon Version:** ___________

## Zusammenfassung
- [ ] Alle Tests bestanden
- [ ] Tests mit Einschränkungen bestanden
- [ ] Tests fehlgeschlagen

## Detaillierte Ergebnisse

### Phase 1: Installation
- Status: ✓ / ✗
- Anmerkungen: _______

### Phase 2: Grundfunktionalität
- Status: ✓ / ✗
- Anmerkungen: _______

### Phase 3: StatSet-Registrierung
- Anzahl getesteter Specs: ___/28
- Fehlgeschlagen: _______
- Anmerkungen: _______

### Phase 4: Stat-Berechnung
- Hit Cap Test: ✓ / ✗
- Spell Hit Test: ✓ / ✗
- Spezial-Stats: ✓ / ✗
- Anmerkungen: _______

### Phase 5: Vergleichstests
- BiS Items: ✓ / ✗
- Tier Sets: ✓ / ✗
- Anmerkungen: _______

### Phase 6: Edge Cases
- Leere Items: ✓ / ✗
- Proc Items: ✓ / ✗
- Set-Wechsel: ✓ / ✗
- Anmerkungen: _______

### Phase 7: Performance
- FPS stabil: ✓ / ✗
- Memory OK: ✓ / ✗
- UI responsiv: ✓ / ✗
- Anmerkungen: _______

## Gefundene Bugs
1. _______________________
2. _______________________
3. _______________________

## Empfehlungen
_______________________
_______________________
```

---

## Quick Start (5-Minuten Basis-Test)

**Für schnelle Validierung:**

1. **Login** mit beliebigem Character
2. **Prüfe Chat** für "Turtle WoW - [Class]" Messages
3. **Öffne** `/iop show`
4. **Wähle** ein Turtle WoW Set für deine Klasse
5. **Hover** über 2-3 Items im Inventar
6. **Wechsle** zum Vanilla Set (gleiche Klasse/Spec)
7. **Hover** über die gleichen Items
8. **Vergleiche** Werte (Turtle WoW sollte für Hit/DPS-Stats höher sein)

**Wenn das funktioniert:** ✓ Basis-Funktionalität OK
**Wenn Fehler auftreten:** → Vollständiger Testplan notwendig

---

**Ende des Testing Guide**
