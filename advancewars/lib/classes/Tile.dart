import 'package:advancewars/classes/Terrain.dart';

import 'Unit.dart';

class Tile {
  bool hasUnit = false;
  Terrain terrainType;
  Unit unit;
  bool canMoveHere = false;

  Tile(Terrain t) {
    terrainType = t;
  }

  Tile.unit(Terrain terrain, Unit unit) {
    terrainType = terrain;
    this.unit = unit;
    hasUnit = true;
  }

  Tile.fromMap(Unit unit, Terrain terrain) {
    this.unit = unit;
    this.terrainType = terrain;
  }

  String getImagePath() {
    if (hasUnit) {
      return "resources/terrainUnits/" + unit.teamColor + "/" + terrainType.name + unit.name + ".png";
    }
    return terrainType.imagePath;
  }

  setUnit(Unit unit) {
    this.unit = unit;
    hasUnit = true;
  }

  clearUnit(){
    this.unit = null;
    hasUnit = false;
  }
}
