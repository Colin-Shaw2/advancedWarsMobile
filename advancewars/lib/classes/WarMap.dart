import 'package:advancewars/classes/Terrain.dart';

abstract class WarMap{
  int xDim;
  int yDim;
  var terrainMap;// array of tiles
  
  WarMap(int x, int y){
    xDim = x;
    yDim = y;
    terrainMap = new List(xDim*yDim);
  }
}