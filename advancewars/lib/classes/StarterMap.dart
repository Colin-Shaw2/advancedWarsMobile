import 'package:advancewars/classes/units/Infantry.dart';
import 'package:advancewars/classes/units/Tank.dart';

import 'Plain.dart';
import 'Tile.dart';
import 'WarMap.dart';

class StarterMap extends WarMap {
  StarterMap(x, y) : super(x, y) {
    //terrain
    for (var i = 0; i < xDim; i++) {
      for (var j = 0; j < yDim; j++) {
        tileMap[i][j] = new Tile(Plain());
      }
    }

    //units
    tileMap[0][3] = new Tile.unit(Plain(), Infantry.orange());
    tileMap[3][3] = new Tile.unit(Plain(), Infantry.blue());
    tileMap[1][3] = new Tile.unit(Plain(), Tank.orange());
    tileMap[4][3] = new Tile.unit(Plain(), Tank.blue());

  }
}
