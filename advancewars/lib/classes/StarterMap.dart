import 'package:advancewars/classes/Infantry.dart';

import 'Plain.dart';
import 'Tile.dart';
import 'WarMap.dart';

class StarterMap extends WarMap {
  StarterMap(x, y) : super(x, y) {
    //terrain
    for (var i = 0; i < yDim; i++) {
      for (var j = 0; j < xDim; j++) {
        terrainMap[i][j] = new Tile(Plain());
      }
    }

    //units
    terrainMap[0][3] = new Tile.unit(Plain(), Infantry());
  }
}
