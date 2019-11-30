import 'package:advancewars/classes/Tile.dart';
import 'package:flutter/widgets.dart';

import 'Unit.dart';

abstract class WarMap {
  int xDim;
  int yDim;
  List<List<Tile>> tileMap; // array of tiles
  int xSelection;
  int ySelection;
  Unit selectedUnit;
  bool hasSelectedUnit = false;

  WarMap(int x, int y) {
    xDim = x;
    yDim = y;
    tileMap = new List.generate(xDim, (_) => List(yDim));
  }

  //returns a gridview with all the terain images.
  GridView display() {
    return GridView.count(
      crossAxisCount: xDim,
      children: List.generate(
        xDim * yDim,
        (int count) {
          int i = count % xDim;
          int j = (count ~/ xDim);
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: (tileMap[i][j].canMoveHere)
                      ? ColorFilter.linearToSrgbGamma()
                      : null,
                  image: AssetImage(tileMap[i][j].getImagePath()),
                  fit: BoxFit.fill),
            ),
          );
        },
      ),
    );
  }

  void tileSelect(int x, int y) {

    //reselect unit to deselect it
    if (hasSelectedUnit && (x == xSelection && y == ySelection)) {
      hasSelectedUnit = false;
      _clearMovableTiles();
    } 
    //moving unit to new tile
    else if (hasSelectedUnit && tileMap[x][y].canMoveHere) {
      tileMap[xSelection][ySelection].clearUnit();
      tileMap[x][y].setUnit(selectedUnit);
      hasSelectedUnit = false;
      _clearMovableTiles();
    }
    //selecting a unit
    else if (tileMap[x][y].hasUnit) {
      xSelection = x;
      ySelection = y;
      selectedUnit = tileMap[x][y].unit;
      hasSelectedUnit = true;
      _findMovableTiles(x, y);
    }
  }

  void _findMovableTiles(int xOrigin, int yOrigin) {
    int movementRange = selectedUnit.movement;
    //owntile
    //tileMap[xOrigin][yOrigin].canMoveHere = true;

    for (var j = 0; j < movementRange; j++)       
    {
      //straightDown
      tileMap[xOrigin][_bindIndexY(yOrigin + j +1)].canMoveHere = true;
      //straightUp
      tileMap[xOrigin][_bindIndexY(yOrigin - j - 1)].canMoveHere = true;
      //right
      for (var i = 1; i <= movementRange-j; i++) {
        //down right
        tileMap[_bindIndexX(xOrigin + i)][_bindIndexY(yOrigin + j)].canMoveHere = true;
        //up right
        tileMap[_bindIndexX(xOrigin + i)][_bindIndexY(yOrigin - j)].canMoveHere = true;

        //down left
        tileMap[_bindIndexX(xOrigin - i)][_bindIndexY(yOrigin + j)].canMoveHere = true;
        //up left
        tileMap[_bindIndexX(xOrigin - i)][_bindIndexY(yOrigin - j)].canMoveHere = true;
      }
    }
  }

  int _bindIndexX(index){
        if (index < 0) {
          index = 0;
        }
        if (index >= xDim) {
          index = xDim - 1;
        }
      return index;
  }
  int _bindIndexY(index){
        if (index < 0) {
          index = 0;
        }
        if (index >= yDim) {
          index = yDim - 1;
        }
      return index;
  }

  void _clearMovableTiles() {
    for (List<Tile> tileRow in tileMap) {
      for (Tile tile in tileRow) {
        tile.canMoveHere = false;
      }
    }
  }
}
