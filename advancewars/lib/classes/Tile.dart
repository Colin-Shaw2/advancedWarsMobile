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

  Tile.fromMap(Terrain terrain, [Unit unit]) {
    this.unit = unit;
    if(unit != null) {
      this.hasUnit = true;
    }
    this.terrainType = terrain;
  }

  String getImagePath() {
    if (hasUnit) {
      return "resources/terrainUnits/" + unit.teamColor + terrainType.name + unit.name + ".png";
    }
    return terrainType.imagePath;
  }

  void setUnit(Unit unit) {
    this.unit = unit;
    hasUnit = true;
  }

  void clearUnit(){
    this.unit = null;
    hasUnit = false;
  }

  bool hasEnemy(int activePlayer){
    if(hasUnit  && unit.teamId != activePlayer){
      return true;
    }
    return false;
  }
  String getHealthImagePath(){
   if(hasUnit){
     return unit.getHealthImagePath();
   } 
   return null;
  }
}
