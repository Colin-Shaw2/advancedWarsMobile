import 'package:advancewars/classes/Terrain.dart';

import 'Unit.dart';

class Tile {
  bool hasUnit = false;
  Terrain terrainType;
  Unit unit;

  Tile(Terrain t) {
    terrainType = t;
  }

  Tile.unit(Terrain terrain, Unit unit) {
    terrainType = terrain;
    this.unit = unit;
    hasUnit = true;
  }

  String getImagePath() {
    if (hasUnit) {
      return "resources/terrainUnits/" + terrainType.name + unit.name + ".png";
    }
    return terrainType.imagePath;
  }
}
