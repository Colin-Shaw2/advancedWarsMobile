import 'package:advancewars/classes/terrain/Mountain.dart';
import 'package:advancewars/classes/terrain/Road.dart';
import 'package:advancewars/classes/terrain/Wood.dart';
import 'package:advancewars/classes/units/Infantry.dart';
import 'package:advancewars/classes/units/Tank.dart';
import 'package:advancewars/classes/units/Unit.dart';

import 'terrain/Plain.dart';
import 'Tile.dart';
import 'WarMap.dart';
import "terrain/Mountain.dart";
import 'units/Mech.dart';

class MountainMap extends WarMap {
  MountainMap() : super(16, 9) {
    //terrain
    for (var i = 0; i < xDim; i++) {
      for (var j = 0; j < yDim; j++) {
        tileMap[i][j] = Tile(Mountain());
        if((i % 5 == 0) && (j % 3) == 0){
          tileMap[i][j] = Tile(Plain());
        } else if ((i >3) && (j == 3 || j == 7 || j == 13) && (i <14)){
            tileMap[i][j] = Tile(Road());
        }
        else if((i % 5 == 0) && (j % 3) == 0){
            tileMap[i][j] = Tile(Wood());
        }
      }

    }

    tileMap[0][3].setUnit(Infantry.orange());
    tileMap[0][5].setUnit(Infantry.orange());
    tileMap[1][4].setUnit(Infantry.orange());
    tileMap[2][2].setUnit(Infantry.orange());

    tileMap[1][5].setUnit(Mech.orange());
    tileMap[2][3].setUnit(Mech.orange());
    tileMap[3][6].setUnit(Mech.orange());
    tileMap[1][2].setUnit(Mech.orange());


    tileMap[13][3].setUnit(Infantry.blue());
    tileMap[15][6].setUnit(Infantry.blue());
    tileMap[12][4].setUnit(Infantry.blue());
    tileMap[15][7].setUnit(Infantry.blue());

    tileMap[12][2].setUnit(Mech.blue());
    tileMap[15][2].setUnit(Mech.blue());
    tileMap[14][3].setUnit(Mech.blue());
    tileMap[14][6].setUnit(Mech.blue());



  }
}
