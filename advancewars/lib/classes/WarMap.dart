import 'package:advancewars/classes/Tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Unit.dart';

class WarMap {
  int xDim;
  int yDim;
  List<List<Tile>> tileMap; // array of tiles
  int xSelection;
  int ySelection;
  Unit selectedUnit;
  bool hasSelectedUnit = false;
  bool inUnconfirmedMoveState = false;

  WarMap(int x, int y) {
    xDim = x;
    yDim = y;
    tileMap = new List.generate(xDim, (_) => List(yDim));
  }

  //returns a gridview with all the terain images.
  Widget display() {
    if (inUnconfirmedMoveState) {
      return _displayMenu();
    }
    return _displayGrid();
  }

  Widget _displayMenu() {
    return Stack(
      children: <Widget>[
        _displayGrid(),
        Container(
          color: Colors.blue,
          child: GestureDetector(
            onTapDown: (tapDownDetails) {
              if (tapDownDetails.localPosition.dy < 65) {
                print("fire");
              } else {
                hasSelectedUnit = false;
                inUnconfirmedMoveState = false;
                _clearMovableTiles();
                print("wait");
              }
            },
            child: Image.asset("resources/menu/firewait.png"),
          ),
        ),
      ],
    );
  }

  Widget _displayGrid() {
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

  //select and move a unit
  void tileSelect(int x, int y) async {
    //have a selected unit already
    if (hasSelectedUnit) {
      //selecting your self
      if (x == xSelection && y == ySelection) {
        hasSelectedUnit = false;
        _clearMovableTiles();
      }
      //moving unit to new tile
      else if (tileMap[x][y].canMoveHere) {
        tileMap[xSelection][ySelection].clearUnit();
        tileMap[x][y].setUnit(selectedUnit);

        //attack
        List<Unit> adjUnit = _getAdjacentUnits(x, y);

        //TO DO make popup
        for (Unit unit in adjUnit) {}

        inUnconfirmedMoveState = true;

      }
    } else if (inUnconfirmedMoveState) {
    }
    //no unit selected
    else {
      //selecting a unit
      if (tileMap[x][y].hasUnit) {
        xSelection = x;
        ySelection = y;
        selectedUnit = tileMap[x][y].unit;
        hasSelectedUnit = true;
        _findMovableTiles(x, y);
      }
    }
  }

  void _findMovableTiles(int xOrigin, int yOrigin) {
    int movementRange = selectedUnit.movement;
    //owntile
    //tileMap[xOrigin][yOrigin].canMoveHere = true;

    for (var j = 0; j < movementRange; j++) {
      //straightDown
      tileMap[xOrigin][_bindIndexY(yOrigin + j + 1)].canMoveHere =
          !tileMap[xOrigin][_bindIndexY(yOrigin + j + 1)].hasUnit;
      //straightUp
      tileMap[xOrigin][_bindIndexY(yOrigin - j - 1)].canMoveHere =
          !tileMap[xOrigin][_bindIndexY(yOrigin - j - 1)].hasUnit;
      //right
      for (var i = 1; i <= movementRange - j; i++) {
        //down right
        tileMap[_bindIndexX(xOrigin + i)][_bindIndexY(yOrigin + j)]
            .canMoveHere = !tileMap[_bindIndexX(xOrigin + i)]
                [_bindIndexY(yOrigin + j)]
            .hasUnit;
        //up right
        tileMap[_bindIndexX(xOrigin + i)][_bindIndexY(yOrigin - j)]
            .canMoveHere = !tileMap[_bindIndexX(xOrigin + i)]
                [_bindIndexY(yOrigin - j)]
            .hasUnit;

        //down left
        tileMap[_bindIndexX(xOrigin - i)][_bindIndexY(yOrigin + j)]
            .canMoveHere = !tileMap[_bindIndexX(xOrigin - i)]
                [_bindIndexY(yOrigin + j)]
            .hasUnit;
        //up left
        tileMap[_bindIndexX(xOrigin - i)][_bindIndexY(yOrigin - j)]
            .canMoveHere = !tileMap[_bindIndexX(xOrigin - i)]
                [_bindIndexY(yOrigin - j)]
            .hasUnit;
      }
    }
  }

  int _bindIndexX(index) {
    if (index < 0) {
      index = 0;
    }
    if (index >= xDim) {
      index = xDim - 1;
    }
    return index;
  }

  int _bindIndexY(index) {
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

  List<Unit> _getAdjacentUnits(int x, int y) {
    List<Unit> adjUnits = List<Unit>();
    if (tileMap[_bindIndexX(x + 1)][_bindIndexY(y)].hasUnit) {
      adjUnits.add(tileMap[_bindIndexX(x + 1)][_bindIndexY(y)].unit);
    }
    if (tileMap[_bindIndexX(x - 1)][_bindIndexY(y)].hasUnit) {
      adjUnits.add(tileMap[_bindIndexX(x - 1)][_bindIndexY(y)].unit);
    }
    if (tileMap[_bindIndexX(x)][_bindIndexY(y + 1)].hasUnit) {
      adjUnits.add(tileMap[_bindIndexX(x)][_bindIndexY(y + 1)].unit);
    }
    if (tileMap[_bindIndexX(x)][_bindIndexY(y - 1)].hasUnit) {
      adjUnits.add(tileMap[_bindIndexX(x)][_bindIndexY(y - 1)].unit);
    }
    return adjUnits;
  }
}
