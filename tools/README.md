# ItemsOfPower Tools

Dieses Verzeichnis enthält Hilfsskripte für die Konvertierung von Pawn Stat-Weights zu ItemsOfPower StatSets.

## Dateien

### `convert_pawn_to_iop.lua`
Hauptkonvertierungsskript. Konvertiert Pawn Scales (ClassicHawsJon Format) zu ItemsOfPower StatSet Creation Code.

### `test_conversion_output.lua`
Zeigt die erwartete Ausgabe für Hunter Marksmanship Konvertierung (Referenz).

### `turtle_wow_adjustments.lua` (TODO - Phase 1)
Utilities für Turtle WoW spezifische Anpassungen (Hit Cap, Armor Cap, etc.).

---

## In-Game Testing Anleitung

### Vorbereitung

1. **AddOn installiert?** ItemsOfPower muss installiert und geladen sein.

2. **Skript laden:**
   ```lua
   /run LoadFile("Interface\\AddOns\\ItemsOfPower\\tools\\convert_pawn_to_iop.lua")
   ```

   **Alternativ:** Kopiere den Inhalt von `convert_pawn_to_iop.lua` und führe ihn direkt als `/script` aus (in mehreren Teilen, da Chat-Limit).

### Test: Hunter Marksmanship

**Schritt 1: Scale Data vorbereiten**

Kopiere diese Scale aus `ClassicHawsJon_small.lua` (Lines 104-111, Pre-calculated):

```lua
local hunterMM = {
  Strength=0.05, Agility=1, Dps=0, MeleeDps=0.75, RangedDps=2.6,
  Ap=0.55, Rap=0.55, FeralAp=0,
  HitRating=9.37931, ExpertiseRating=0.11724,
  CritRating=5.1, HasteRating=3.212, ArmorPenetration=1.3875,
  Intellect=0.9, Mana=0.085, Spirit=0.05, Mp5=2.4,
  Healing=0, SpellDamage=0, FireSpellDamage=0, FrostSpellDamage=0,
  ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0,
  SpellPower=0, SpellHitRating=0, SpellCritRating=0, SpellHasteRating=0, SpellPenetration=0,
  Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005,
  DefenseRating=0.075, DodgeRating=0.472, ParryRating=0.472,
  BlockRating=0, BlockValue=0, ResilienceRating=0.2,
  AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04,
  ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36
}
```

**Schritt 2: Konvertierung ausführen**

```lua
ConvertPawnScale(hunterMM, "Hunter", "Marksmanship", true)
```

**Schritt 3: Output prüfen**

Du solltest folgendes sehen:
- **WARNINGS:** MeleeDps/RangedDps ignored, AllResist distributed
- **Generated Code:** StatSet Creation Code

**Schritt 4: StatSet erstellen**

Kopiere den generierten Code (zwischen `do` und `end`) und führe ihn aus.

**Schritt 5: Verifizierung**

```lua
/ipw
```

- Navigiere zu "Sets" → "Vanilla - Hunter - Marksmanship"
- Prüfe Stat Weights:
  - AGI sollte 1.0 sein
  - TOHIT sollte ~9.38 sein
  - CRIT sollte ~5.1 sein

**Schritt 6: Item Test**

Teste mit einem bekannten Item:

```lua
-- Beispiel: Devilsaur Set (bekanntes Hunter BiS)
-- Kopiere Item-Link und hovere drüber
-- Tooltip sollte "Vanilla - Hunter - Marksmanship: XXX" zeigen
```

Vergleiche mit Pawn (falls installiert) oder Community BiS Lists.

---

## Expected Conversion Results

### Hunter Marksmanship (Vanilla Baseline)

**Top 5 Stats:**
1. TOHIT = 9.38 (Hit Rating)
2. CRIT = 5.10 (Crit Rating)
3. HASTE = 3.21 (Haste Rating)
4. MANAREG = 2.40 (Mp5)
5. ARMORIGNORE = 1.39 (Armor Pen)

**Vergleiche mit bekannten Prioritäten:**
- ✓ Hit bis Cap (9%)
- ✓ Agility (1.0 baseline)
- ✓ Crit nach Hit
- ✓ AP/RAP moderate Weights

---

## Troubleshooting

### "LoadFile not found"
Kopiere das Skript manuell Stück für Stück mit `/script`.

### "ItemsOfPower.SetTypes.StatSet not found"
ItemsOfPower ist nicht geladen. Führe `/reload` aus.

### "StatSet already exists"
Das ist OK! Der StatSet existiert bereits. Nutze:
```lua
ItemsOfPower:UnregisterSet(ItemsOfPower.SetByName["Vanilla - Hunter - Marksmanship"])
```
Um ihn zu entfernen bevor du neu erstellst.

### Weights scheinen falsch
- Prüfe ob Pawn's Pre-Multiplication korrekt ist (HitRatingPer = 9.37931 für Classic Era)
- Prüfe ob Item Tooltips aktiviert sind (`/ipw` → Settings → Tooltip → Enable)
- Prüfe ob das richtige Set ausgewählt ist (Display In Tooltip muss an sein)

---

## Nächste Schritte (Nach Phase 0)

1. **Phase 1:** Turtle WoW Adjustments
   - `turtle_wow_adjustments.lua` erstellen
   - Hit Cap Adjustment (9% → 8%)
   - Armor Cap Adjustment für Tanks
   - Neue Stats (CASTINGREG, VAMPIR) Defaults

2. **Phase 2:** Alle Vanilla Baselines
   - Alle 27+ Specs aus ClassicHawsJon konvertieren
   - Als `statsets/vanilla_baseline_all.lua` sammeln

3. **Phase 3-11:** Klassenweise Turtle WoW Anpassungen

---

## Ressourcen

- **Mapping-Dokumentation:** `docs/pawn-to-iop-mapping.md`
- **Turtle WoW Changes:** `docs/turtle-wow-general-scaling-changes.md`
- **Implementation Guide:** `docs/ScalingTurtleWoWClaude-Implementation.md`
