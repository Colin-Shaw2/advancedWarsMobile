import 'package:advancewars/classes/Terrain.dart';

import 'Unit.dart';

class Tile{
  bool hasUnit = false;
  Terrain terrainType;
  Unit unit;

  Tile(Terrain t){
    terrainType = t;
  }
  
  Tile.unit(Terrain t, Unit u){
    terrainType = t;
    unit = u;
    hasUnit = true;
  }
}