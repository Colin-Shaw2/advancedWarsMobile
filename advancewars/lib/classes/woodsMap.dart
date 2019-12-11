import 'package:advancewars/classes/terrain/Mountain.dart';
import 'package:advancewars/classes/terrain/Wood.dart';
import 'package:advancewars/classes/units/Infantry.dart';
import 'package:advancewars/classes/units/Recon.dart';
import 'package:advancewars/classes/units/Tank.dart';

import 'terrain/Plain.dart';
import 'Tile.dart';
import 'WarMap.dart';
import 'terrain/Road.dart';
import 'units/MTank.dart';
import 'units/Mech.dart';

class WoodsMap extends WarMap {
  WoodsMap() : super(16, 9) {
    
    tileMap[0][0] = Tile.unit(Plain(), MTank.orange());
    tileMap[1][0] = Tile(Wood());
    tileMap[2][0] = Tile(Wood());
    tileMap[3][0] = Tile(Plain());
    tileMap[4][0] = Tile(Wood());
    tileMap[5][0] = Tile(Mountain());
    tileMap[6][0] = Tile(Wood());
    tileMap[7][0] = Tile(Plain());
    tileMap[8][0] = Tile(Road());
    tileMap[9][0] = Tile(Wood());
    tileMap[10][0] = Tile(Wood());
    tileMap[11][0] = Tile(Plain());
    tileMap[12][0] = Tile(Wood());
    tileMap[13][0] = Tile(Plain());
    tileMap[14][0] = Tile(Wood());
    tileMap[15][0] = Tile.unit(Wood(), MTank.blue());

    
    
    tileMap[0][1] = Tile(Plain());
    tileMap[1][1] = Tile.unit(Wood(), Recon.orange());
    tileMap[2][1] = Tile(Wood());
    tileMap[3][1] = Tile(Wood());
    tileMap[4][1] = Tile(Mountain());
    tileMap[5][1] = Tile.unit(Wood(), Infantry.orange());
    tileMap[6][1] = Tile(Plain());
    tileMap[7][1] = Tile(Mountain());
    tileMap[8][1] = Tile(Road());
    tileMap[9][1] = Tile(Mountain());
    tileMap[10][1] = Tile.unit(Plain(), Infantry.blue());
    tileMap[11][1] = Tile(Wood());
    tileMap[12][1] = Tile(Wood());
    tileMap[13][1] = Tile(Plain());
    tileMap[14][1] = Tile.unit(Wood(), Recon.blue());
    tileMap[15][1] = Tile(Plain());

    
    
    tileMap[0][2] = Tile(Wood());
    tileMap[1][2] = Tile(Plain());
    tileMap[2][2] = Tile(Wood());
    tileMap[3][2] = Tile.unit(Plain(), Tank.orange());
    tileMap[4][2] = Tile(Wood());
    tileMap[5][2] = Tile.unit(Wood(), Mech.orange());
    tileMap[6][2] = Tile(Plain());
    tileMap[7][2] = Tile(Wood());
    tileMap[8][2] = Tile(Road());
    tileMap[9][2] = Tile(Plain());
    tileMap[10][2] = Tile.unit(Wood(), Mech.blue());
    tileMap[11][2] = Tile(Wood());
    tileMap[12][2] = Tile.unit(Plain(), Tank.blue());
    tileMap[13][2] = Tile(Wood());
    tileMap[14][2] = Tile(Plain());
    tileMap[15][2] = Tile(Road());

    
    
    tileMap[0][3] = Tile(Road());
    tileMap[1][3] = Tile(Wood());
    tileMap[2][3] = Tile(Wood());
    tileMap[3][3] = Tile.unit(Plain(), Tank.orange());
    tileMap[4][3] = Tile(Wood());
    tileMap[5][3] = Tile.unit(Wood(), Mech.orange());
    tileMap[6][3] = Tile(Plain());
    tileMap[7][3] = Tile(Mountain());
    tileMap[8][3] = Tile(Mountain());
    tileMap[9][3] = Tile(Wood());
    tileMap[10][3] = Tile.unit(Plain(), Mech.blue());
    tileMap[11][3] = Tile(Wood());
    tileMap[12][3] = Tile.unit(Plain(), Tank.blue());
    tileMap[13][3] = Tile(Wood());
    tileMap[14][3] = Tile(Wood());
    tileMap[15][3] = Tile(Plain());

    
    
    tileMap[0][4] = Tile(Road());
    tileMap[1][4] = Tile(Wood());
    tileMap[2][4] = Tile(Wood());
    tileMap[3][4] = Tile(Wood());
    tileMap[4][4] = Tile(Wood());
    tileMap[5][4] = Tile.unit(Wood(), Infantry.orange());
    tileMap[6][4] = Tile(Wood());
    tileMap[7][4] = Tile(Wood());
    tileMap[8][4] = Tile(Plain());
    tileMap[9][4] = Tile(Wood());
    tileMap[10][4] = Tile.unit(Wood(), Infantry.blue());
    tileMap[11][4] = Tile(Wood());
    tileMap[12][4] = Tile(Plain());
    tileMap[13][4] = Tile(Wood());
    tileMap[14][4] = Tile(Plain());
    tileMap[15][4] = Tile(Road());

    
    
    tileMap[0][5] = Tile(Road());
    tileMap[1][5] = Tile(Wood());
    tileMap[2][5] = Tile(Wood());
    tileMap[3][5] = Tile.unit(Plain(), Tank.orange());
    tileMap[4][5] = Tile(Wood());
    tileMap[5][5] = Tile.unit(Plain(), Infantry.orange());
    tileMap[6][5] = Tile(Wood());
    tileMap[7][5] = Tile(Wood());
    tileMap[8][5] = Tile(Mountain());
    tileMap[9][5] = Tile(Mountain());
    tileMap[10][5] = Tile.unit(Wood(), Infantry.blue());
    tileMap[11][5] = Tile(Plain());
    tileMap[12][5] = Tile.unit(Wood(), Tank.blue());
    tileMap[13][5] = Tile(Wood());
    tileMap[14][5] = Tile(Wood());
    tileMap[15][5] = Tile(Road());

    
    
    tileMap[0][6] = Tile(Plain());
    tileMap[1][6] = Tile.unit(Wood(), Recon.orange());
    tileMap[2][6] = Tile(Plain());
    tileMap[3][6] = Tile.unit(Wood(), Tank.orange());
    tileMap[4][6] = Tile(Wood());
    tileMap[5][6] = Tile.unit(Wood(), Mech.orange());
    tileMap[6][6] = Tile(Plain());
    tileMap[7][6] = Tile(Road());
    tileMap[8][6] = Tile(Road());
    tileMap[9][6] = Tile(Road());
    tileMap[10][6] = Tile.unit(Wood(),Mech.blue());
    tileMap[11][6] = Tile(Wood());
    tileMap[12][6] = Tile.unit(Plain(), Tank.blue());
    tileMap[13][6] = Tile(Wood());
    tileMap[14][6] = Tile.unit(Plain(), Recon.blue());
    tileMap[15][6] = Tile(Wood());

    
    
    tileMap[0][7] = Tile(Plain());
    tileMap[1][7] = Tile(Wood());
    tileMap[2][7] = Tile(Wood());
    tileMap[3][7] = Tile(Wood());
    tileMap[4][7] = Tile(Wood());
    tileMap[5][7] = Tile(Road());
    tileMap[6][7] = Tile(Road());
    tileMap[7][7] = Tile(Road());
    tileMap[8][7] = Tile(Mountain());
    tileMap[9][7] = Tile(Road());
    tileMap[10][7] = Tile(Road());
    tileMap[11][7] = Tile(Wood());
    tileMap[12][7] = Tile(Wood());
    tileMap[13][7] = Tile(Wood());
    tileMap[14][7] = Tile(Wood());
    tileMap[15][7] = Tile(Plain());

    
    
    tileMap[0][8] = Tile.unit(Wood(), MTank.orange());
    tileMap[1][8] = Tile(Road());
    tileMap[2][8] = Tile(Road());
    tileMap[3][8] = Tile(Plain());
    tileMap[4][8] = Tile(Plain());
    tileMap[5][8] = Tile(Wood());
    tileMap[6][8] = Tile(Wood());
    tileMap[7][8] = Tile(Plain());
    tileMap[8][8] = Tile(Wood());
    tileMap[9][8] = Tile(Mountain());
    tileMap[10][8] = Tile(Wood());
    tileMap[11][8] = Tile(Plain());
    tileMap[12][8] = Tile(Plain());
    tileMap[13][8] = Tile(Road());
    tileMap[14][8] = Tile(Road());
    tileMap[15][8] = Tile.unit(Plain(), MTank.blue());

    


  }
}
