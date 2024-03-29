import 'package:advancewars/classes/terrain/Mountain.dart';
import 'package:advancewars/classes/terrain/Wood.dart';
import 'package:advancewars/classes/units/Infantry.dart';
import 'package:advancewars/classes/units/Mech.dart';
import 'package:advancewars/classes/units/Tank.dart';

import 'terrain/Plain.dart';
import 'Tile.dart';
import 'WarMap.dart';

class StarterMap extends WarMap {
  StarterMap() : super(16, 9) {
    //terrain
    for (var i = 0; i < xDim; i++) {
      for (var j = 0; j < yDim; j++) {
        ((i + j * i) % 3 == 0)
            ? tileMap[i][j] = new Tile(Plain())
            : tileMap[i][j] = new Tile(Wood());
      }
    }

    //units
    // tileMap[0][3] = new Tile.unit(tileMap[0][3].terrainType, Infantry.orange());
    // tileMap[3][3] = new Tile.unit(tileMap[3][3].terrainType, Infantry.blue());
    // tileMap[1][3] = new Tile.unit(tileMap[1][3].terrainType, Tank.orange());
    // tileMap[4][3] = new Tile.unit(tileMap[4][3].terrainType, Tank.blue());

    tileMap[7][4] = new Tile(Mountain());
    tileMap[8][5] = new Tile(Mountain());
    tileMap[7][5] = new Tile(Mountain());
    tileMap[8][4] = new Tile(Mountain());    
    tileMap[7][3] = new Tile(Mountain());
    tileMap[8][3] = new Tile(Mountain());


    tileMap[0][3].setUnit(Infantry.orange());
    tileMap[0][5].setUnit(Infantry.orange());
    tileMap[1][4].setUnit(Infantry.orange());
    tileMap[2][2].setUnit(Infantry.orange());
    tileMap[1][8].setUnit(Tank.orange());    
    tileMap[2][8].setUnit(Tank.orange());

    tileMap[1][5].setUnit(Mech.orange());
    tileMap[2][3].setUnit(Mech.orange());
    tileMap[3][6].setUnit(Mech.orange());
    tileMap[1][2].setUnit(Mech.orange());


    tileMap[13][3].setUnit(Infantry.blue());
    tileMap[15][6].setUnit(Infantry.blue());
    tileMap[12][4].setUnit(Infantry.blue());
    tileMap[15][7].setUnit(Infantry.blue());
    tileMap[15][8].setUnit(Tank.blue());
    tileMap[11][6].setUnit(Tank.blue());


    tileMap[12][2].setUnit(Mech.blue());
    tileMap[15][2].setUnit(Mech.blue());
    tileMap[14][3].setUnit(Mech.blue());
    tileMap[14][6].setUnit(Mech.blue());

  }
}
