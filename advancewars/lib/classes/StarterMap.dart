import 'package:advancewars/classes/terrain/Wood.dart';
import 'package:advancewars/classes/units/Infantry.dart';
import 'package:advancewars/classes/units/Tank.dart';

import 'terrain/Plain.dart';
import 'Tile.dart';
import 'WarMap.dart';

class StarterMap extends WarMap {
  StarterMap(x, y) : super(x, y) {
    //terrain
    for (var i = 0; i < xDim; i++) {
      for (var j = 0; j < yDim; j++) {
        ((i + j * i) % 3 == 0)
            ? tileMap[i][j] = new Tile(Plain())
            : tileMap[i][j] = new Tile(Wood());
      }
    }

    //units
    tileMap[0][3] = new Tile.unit(tileMap[0][3].terrainType, Infantry.orange());
    tileMap[3][3] = new Tile.unit(tileMap[3][3].terrainType, Infantry.blue());
    tileMap[1][3] = new Tile.unit(tileMap[1][3].terrainType, Tank.orange());
    tileMap[4][3] = new Tile.unit(tileMap[4][3].terrainType, Tank.blue());
  }
}
