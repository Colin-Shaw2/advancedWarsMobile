import 'package:advancewars/classes/Tile.dart';
import 'package:flutter/widgets.dart';

class WarMap {
  int xDim;
  int yDim;
  List<List<Tile>> terrainMap; // array of tiles

  WarMap(int x, int y) {
    xDim = x;
    yDim = y;
    terrainMap = new List.generate(xDim, (_) => List(yDim));
  }

  //returns a gridview with all the terain images.
  GridView display() {
    return GridView.count(
        crossAxisCount: xDim,
        children: List.generate(xDim * yDim, (int count) {
          int i = count % xDim;
          int j = (count ~/ xDim);
          return GestureDetector(
            onTap: (){
              print("");
              print(i);
              print(j);
            },
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(terrainMap[i][j].getImagePath()),
                          fit: BoxFit.fill))));
        }));
  }
}
