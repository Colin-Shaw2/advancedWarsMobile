import 'Plain.dart';
import 'Tile.dart';
import 'WarMap.dart';

class StarterMap extends WarMap {
  StarterMap(x, y) : super(x, y) {
    for (var i = 0; i < yDim; i++) {
      for (var j = 0; j < xDim; j++) {
        terrainMap[i * xDim + j] = new Tile(Plain());
      }
    }
  }
}
