import 'package:advancewars/classes/Infantry.dart';

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

  }
}
