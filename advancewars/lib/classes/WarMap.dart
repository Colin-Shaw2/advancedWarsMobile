import 'package:advancewars/classes/Terrain.dart';
import 'package:advancewars/classes/Tile.dart';

abstract class WarMap{
  int xDim;
  int yDim;
  List<Tile> terrainMap;// array of tiles

  WarMap(int x, int y){
    xDim = x;
    yDim = y;
    terrainMap = new List(xDim*yDim);
  }
}