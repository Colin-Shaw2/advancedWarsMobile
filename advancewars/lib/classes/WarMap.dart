import 'package:advancewars/classes/Tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'units/Unit.dart';

class WarMap {
  int xDim;
  int yDim;
  List<List<Tile>> tileMap; // array of tiles
  int xSelection;
  int ySelection;
  Unit selectedUnit;

  bool hasSelectedUnit = false;
  bool inUnconfirmedMoveState = false;
  bool waitingToAttack = false;
  int newX, newY;

  WarMap(int x, int y) {
    xDim = x;
    yDim = y;
    tileMap = new List.generate(xDim, (_) => List(yDim));
  }

  //returns a gridview with all the terain images.
  Widget display(int activePlayer) {
    if (inUnconfirmedMoveState && !waitingToAttack) {
      return _displayMenu(activePlayer);
    }
    return _displayGrid();
  }

  Widget _displayMenu(int activePlayer) {
    return Stack(
      children: <Widget>[
        _displayGrid(),
        Container(
          color: Colors.blue,
          child: GestureDetector(
            onTapDown: (tapDownDetails) {
              if (tapDownDetails.localPosition.dy < 65) {
                //TODO make snack bar appear
                waitingToAttack = true;
                _clearMovableTiles();
                _setAdjacentEnemyUnits(newX, newY, activePlayer);
              }

              //cancel
              else if (tapDownDetails.localPosition.dy < 115) {
                tileMap[newX][newY].clearUnit();
                tileMap[xSelection][ySelection].setUnit(selectedUnit);
                hasSelectedUnit = false;
                inUnconfirmedMoveState = false;
                _clearMovableTiles();
              } else {
                hasSelectedUnit = false;
                inUnconfirmedMoveState = false;
                _clearMovableTiles();
              }
            },
            child: Image.asset("resources/menu/firecancelwait.png"),
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
          return Stack(
            children: <Widget>[
              //terrain
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: (tileMap[i][j].canMoveHere ||
                              tileMap[i][j].canAttackHere)
                          ? ColorFilter.linearToSrgbGamma()
                          : null,
                      image: AssetImage(tileMap[i][j].getImagePath()),
                      fit: BoxFit.fill),
                ),
              ),

              //unit
              Container(
                decoration: (tileMap[i][j].hasUnit)
                    ? BoxDecoration(
                        image: DecorationImage(
                            colorFilter: (tileMap[i][j].canMoveHere ||
                                    tileMap[i][j].canAttackHere)
                                ? ColorFilter.linearToSrgbGamma()
                                : null,
                            image: AssetImage(tileMap[i][j].unit.imagePath),
                            fit: BoxFit.fill),
                      )
                    : BoxDecoration(),
              ),
              Container(
                margin: EdgeInsets.only(left: 24, top: 24),
                width: 24,
                height: 24,
                decoration:
                    //if no damage on this unit it does not display a number
                    (tileMap[i][j].getHealthImagePath() != null)
                        ? BoxDecoration(
                            image: DecorationImage(
                              alignment: Alignment.bottomRight,
                              colorFilter: (tileMap[i][j].canMoveHere ||
                                      tileMap[i][j].canAttackHere)
                                  ? ColorFilter.linearToSrgbGamma()
                                  : null,
                              image: AssetImage(
                                  tileMap[i][j].getHealthImagePath()),
                              //(tileMap[i][j].unit.getHealthImagePath()== null)?null:AssetImage(tileMap[i][j].unit.getHealthImagePath()),
                              fit: BoxFit.fill,
                            ),
                          )
                        : BoxDecoration(),
              ),
            ],
          );
        },
      ),
    );
  }

  //select and move a unit
  void tileSelect(int x, int y, int activePlayer) {
    //have a selected unit already
    if (waitingToAttack) {
      bool isAdj = false;

      //determine if the selected tile is adj and an enemy
      if (tileMap[x][y].hasEnemy(activePlayer)) {
        if (x == newX) {
          if ((y - newY).abs() == 1) {
            isAdj = true;
          }
        } else if (y == newY) {
          if ((x - newX).abs() == 1) {
            isAdj = true;
          }
        }

        if (isAdj) {
          selectedUnit.attack(tileMap[x][y].unit);
          waitingToAttack = false;
          inUnconfirmedMoveState = false;
          hasSelectedUnit = false;
          _clearAllDeadUnits();
          _clearMovableTiles();
          _clearAdjEnemies();
        }
      }
    }
    //menu is up so we don't want to be able to do anything
    else if (inUnconfirmedMoveState) {
    } else if (hasSelectedUnit) {
      //moving unit to new tile
      if (tileMap[x][y].canMoveHere) {
        _moveUnit(x, y, activePlayer);
      }
    }
    //no unit selected
    else {
      //selecting a unit
      if (tileMap[x][y].hasUnit) {
        if (tileMap[x][y].unit.teamId == activePlayer) //is it your own unit
          _selectUnit(x, y);
      }
    }
  }

  void cancelAll() {
    waitingToAttack = false;
    inUnconfirmedMoveState = false;
    hasSelectedUnit = false;
    tileMap[newX][newY].clearUnit();
    tileMap[xSelection][ySelection].setUnit(selectedUnit);
    _clearAllDeadUnits();
    _clearMovableTiles();
    _clearAdjEnemies();
    _clearMovableTiles();
  }

  bool inWaitingState() {
    return (waitingToAttack || inUnconfirmedMoveState || hasSelectedUnit);
  }

  void _selectUnit(int x, int y) {
    xSelection = x;
    ySelection = y;
    selectedUnit = tileMap[x][y].unit;
    hasSelectedUnit = true;
    _findMovableTiles(x, y);
  }

  void _moveUnit(int x, int y, int activePlayer) {
    newX = x;
    newY = y;
    tileMap[xSelection][ySelection].clearUnit();
    tileMap[x][y].setUnit(selectedUnit);
    //attack
    // List<Unit> adjUnit = _getAdjacentEnemyUnits(x, y, activePlayer);

    // //TO DO make popup
    // for (Unit unit in adjUnit) {
    //   print(unit);
    // }

    inUnconfirmedMoveState = true;
  }

  void _findMovableTiles(int xOrigin, int yOrigin) {
    _recusivePathSearch(xOrigin, yOrigin, selectedUnit.movement, -1, selectedUnit.movementType);
  }

  void _recusivePathSearch(int x, int y, int movementRemaining,
      int prevDirection,  MovementType moveType) {
    tileMap[x][y].canMoveHere = true;
    //0 left 1 up  2 right 3 down -1 intial value

    //if less than 0 we can't move there
    if (movementRemaining <= 0) {
      return;
    }
    int newX = x, newY = y;

    if (prevDirection != 0) {
      newX = x - 1;
      //in bounds
      if (newX < 0) {
      }
      //unit collision
      else if (tileMap[newX][y].hasUnit) {
      }
      //enough movement
      else if(movementRemaining -tileMap[newX][y].terrainType.getMoveCost(moveType) < 0){
      }
      else{
      _recusivePathSearch(
          newX,
          y,
          (movementRemaining -
              tileMap[newX][y].terrainType.getMoveCost(moveType)),
          prevDirection,
          moveType);
      }
    }


    if (prevDirection != 1) {
      newY = y - 1;
      //in bounds
      if (newY < 0) {
      }
      //unit collision
      else if (tileMap[x][newY].hasUnit) {
      }
      //enough movement
      else if(movementRemaining -tileMap[x][newY].terrainType.getMoveCost(moveType) < 0){
      }
      else{
      _recusivePathSearch(
          x,
          newY,
          (movementRemaining -
              tileMap[x][newY].terrainType.getMoveCost(moveType)),
          prevDirection,
          moveType);
      }
    }
    if (prevDirection != 0) {
      newX = x + 1;
      //in bounds
      if (newX < 0) {
      }
      //unit collision
      else if (tileMap[newX][y].hasUnit) {
      }
      //enough movement
      else if(movementRemaining -tileMap[newX][y].terrainType.getMoveCost(moveType) < 0){
      }
      else{
      _recusivePathSearch(
          newX,
          y,
          (movementRemaining -
              tileMap[newX][y].terrainType.getMoveCost(moveType)),
          prevDirection,
          moveType);
      }
    }
    if (prevDirection != 0) {
      newY = y +1;
      //in bounds
      if (newY < 0) {
      }
      //unit collision
      else if (tileMap[x][newY].hasUnit) {
      }
      //enough movement
      else if(movementRemaining -tileMap[x][newY].terrainType.getMoveCost(moveType) < 0){
      }
      else{
      _recusivePathSearch(
          x,
          newY,
          (movementRemaining -
              tileMap[x][newY].terrainType.getMoveCost(moveType)),
          prevDirection,
          moveType);
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

  void _setAdjacentEnemyUnits(int x, int y, int activePlayer) {
    List<Tile> adjUnits = List<Tile>();
    if (tileMap[_bindIndexX(x + 1)][_bindIndexY(y)].hasEnemy(activePlayer)) {
      adjUnits.add(tileMap[_bindIndexX(x + 1)][_bindIndexY(y)]);
    }
    if (tileMap[_bindIndexX(x - 1)][_bindIndexY(y)].hasEnemy(activePlayer)) {
      adjUnits.add(tileMap[_bindIndexX(x - 1)][_bindIndexY(y)]);
    }
    if (tileMap[_bindIndexX(x)][_bindIndexY(y + 1)].hasEnemy(activePlayer)) {
      adjUnits.add(tileMap[_bindIndexX(x)][_bindIndexY(y + 1)]);
    }
    if (tileMap[_bindIndexX(x)][_bindIndexY(y - 1)].hasEnemy(activePlayer)) {
      adjUnits.add(tileMap[_bindIndexX(x)][_bindIndexY(y - 1)]);
    }
    for (Tile u in adjUnits) {
      u.canAttackHere = true;
    }
  }

  void _clearAdjEnemies() {
    for (List<Tile> tileRow in tileMap) {
      for (Tile tile in tileRow) {
        tile.canAttackHere = false;
      }
    }
  }

  void _clearAllDeadUnits() {
    for (List<Tile> tileRow in tileMap) {
      for (Tile tile in tileRow) {
        if (tile.hasUnit) {
          if (tile.unit.health <= 0) {
            tile.clearUnit();
          }
        }
      }
    }
  }
}
