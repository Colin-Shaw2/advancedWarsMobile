import 'package:advancewars/classes/DayAnimation.dart';
import 'package:advancewars/classes/Tile.dart';
import 'package:advancewars/classes/VictoryAnimation.dart';
import 'package:advancewars/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'units/Unit.dart';

const ColorFilter darken = ColorFilter.matrix(<double>[
  0.9126,
  0.9152,
  0.9722,
  0.9,
  0.9,

  0.9126,
  0.9152,
  0.9722,
  0.9,
  0.9,

  0.9126,
  0.9152,
  0.9722,
  0.9,
  0.9,

  0.9,
  0.9,
  0.9,
  1,
  0.9,
]);

class WarMap {
  int xDim;
  int yDim;
  List<List<Tile>> tileMap; // array of tiles
  int xSelection;
  int ySelection;
  Unit selectedUnit;

  bool turnEnded = false;
  bool gameOver = false;
  bool blueVictory = false;
  bool orangeVictory = false;
  bool hasSelectedUnit = false;
  bool inUnconfirmedMoveState = false;
  bool waitingToAttack = false;
  bool pressedLeftHalf = false;
  int newX, newY;
  int day = 1;

  WarMap(int x, int y) {
    xDim = x;
    yDim = y;
    tileMap = new List.generate(xDim, (_) => List(yDim));
  }

    //returns a gridview with all the terain images.
  Widget display(int activePlayer, BuildContext context) {

    if (inUnconfirmedMoveState && !waitingToAttack) {
      return _displayMenu(activePlayer, context);
    }
    return Stack(children: _showMapItems());
  }

  Widget _displayMenu(int activePlayer, BuildContext context) {
    //has adjacent enemies
    if (tileMap[_bindIndexX(newX + 1)][newY].hasEnemy(activePlayer) ||
        tileMap[_bindIndexX(newX - 1)][newY].hasEnemy(activePlayer) ||
        tileMap[newX][_bindIndexY(newY + 1)].hasEnemy(activePlayer) ||
        tileMap[newX][_bindIndexY(newY - 1)].hasEnemy(activePlayer)) {
      return Stack(
        children: <Widget>[
          _displayGrid(),
          Container(
            //place menu on opposite side of screen from the pressed location
            padding: (!pressedLeftHalf)
                ? EdgeInsets.all(0)
                : EdgeInsets.only(
                    left: MediaQuery.of(context).size.width - 162),
            child: GestureDetector(
              onTapDown: (tapDownDetails) {
                //fire
                if (tapDownDetails.localPosition.dy < 65) {
                  waitingToAttack = true;
                  _clearMovableTiles();
                  _setAdjacentEnemyUnits(newX, newY, activePlayer);
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Select Unit To Attack"),
                    ),
                  );
                }

                //cancel
                else if (tapDownDetails.localPosition.dy < 115) {
                  tileMap[newX][newY].clearUnit();
                  tileMap[xSelection][ySelection].setUnit(selectedUnit);
                  hasSelectedUnit = false;
                  inUnconfirmedMoveState = false;
                  _clearMovableTiles();
                  //selectedUnit = null;
                } else {
                  tileMap[newX][newY].unit.hasMoved = true;
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
    //no adjacent enemies
    else {
      return Stack(
        children: <Widget>[
          _displayGrid(),
          Container(
            //place menu on opposite side of screen from the pressed location
            padding: (!pressedLeftHalf)
                ? EdgeInsets.all(0)
                : EdgeInsets.only(
                    left: MediaQuery.of(context).size.width - 162),
            child: GestureDetector(
              onTapDown: (tapDownDetails) {
                
                //cancel
                if (tapDownDetails.localPosition.dy < 65) {
                  tileMap[newX][newY].clearUnit();
                  tileMap[xSelection][ySelection].setUnit(selectedUnit);
                  hasSelectedUnit = false;
                  inUnconfirmedMoveState = false;
                  _clearMovableTiles();
                  //selectedUnit = null;
                } else {
                  tileMap[newX][newY].unit.hasMoved = true;
                  hasSelectedUnit = false;
                  inUnconfirmedMoveState = false;
                  _clearMovableTiles();
                }
              },
              child: Image.asset("resources/menu/cancelwait.png"),
            ),
          ),
        ],
      );
    }
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
                                : (tileMap[i][j].hasUnit && tileMap[i][j].unit.hasMoved)
                                    ? ColorFilter.srgbToLinearGamma()
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
                                  ? null
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

  List<Widget> _showMapItems() {
    if (this.turnEnded) {
      return [_displayGrid(), _runDayAnimation()];
    } 
    else if(this.blueVictory) {
      return [_displayGrid(), _runBlueVictoryAnimation()];
    }
    else if(this.orangeVictory) {
      return [_displayGrid(), _runOrangeVictoryAnimation()];
    }
    else {
      return [_displayGrid()];
    }
  }

  Widget _runDayAnimation() {
    if (this.turnEnded) {
      return DayAnimation(day: this.day, warmap: this);
    }
  }
   Widget _runBlueVictoryAnimation() {
      _endGame();
      return VictoryAnimation(warmap: this, colour: "Blue");
  }
   Widget _runOrangeVictoryAnimation() {
      _endGame();
      return VictoryAnimation(warmap: this, colour: "Orange");
  }

  Future<void> _endGame() async {
    await new Future.delayed(Duration(seconds: 8));
    gameOver = true;
  }

  //select and move a unit
  void tileSelect(int x, int y, int activePlayer) {
    //which side of screen was pressed
    (x < xDim / 2) ? pressedLeftHalf = true : pressedLeftHalf = false;

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
          selectedUnit.attack(tileMap[x][y].unit, tileMap[xSelection][ySelection], tileMap[x][y]);
          waitingToAttack = false;
          inUnconfirmedMoveState = false;
          hasSelectedUnit = false;
          _clearAllDeadUnits();
          _clearMovableTiles();
          _clearAdjEnemies();
          _isEndOfGame();
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
      if (tileMap[x][y].hasUnit && !tileMap[x][y].unit.hasMoved) {
        if (tileMap[x][y].unit.teamId == activePlayer) //is it your own unit
          _selectUnit(x, y);
      }
    }
  }

    void _isEndOfGame() {
    int orangeUnits = 0;
    int blueUnits = 0;
    for(var x = 0; x < this.xDim; x+=1) {
      for(var y = 0; y < this.yDim; y+=1) {
        if(this.tileMap[x][y].hasUnit) {
          if(this.tileMap[x][y].unit.teamColor == "orange") {
            orangeUnits += 1;
          }
          else {
            blueUnits += 1;
          }
        }
      }
    }
    if(blueUnits == 0) {
      orangeVictory = true;
    }
    else if(orangeUnits == 0) {
      blueVictory = true;
    }
  }


  void cancelAll() {
    waitingToAttack = false;
    inUnconfirmedMoveState = false;
    hasSelectedUnit = false;
    tileMap[newX][newY].clearUnit();
    tileMap[xSelection][ySelection].setUnit(selectedUnit);
    //selectedUnit = null;
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
    _recursivePathSearch(
        xOrigin, yOrigin, selectedUnit.movement, -1, selectedUnit.movementType);
  }

  void _recursivePathSearch(int x, int y, int movementRemaining,
      int prevDirection, MovementType moveType) {
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
      else if (movementRemaining -
              tileMap[newX][y].terrainType.getMoveCost(moveType) <
          0) {
      }
      //can your movement type move here
      else if (tileMap[newX][y].terrainType.getMoveCost(moveType) < 0) {
      } else {
        _recursivePathSearch(
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
      else if (movementRemaining -
              tileMap[x][newY].terrainType.getMoveCost(moveType) <
          0) {
      }
      //can your movement type move here
      else if (tileMap[x][newY].terrainType.getMoveCost(moveType) < 0) {
      } else {
        _recursivePathSearch(
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
      if (newX >= xDim) {
      }
      //unit collision
      else if (tileMap[newX][y].hasUnit) {
      }
      //enough movement
      else if (movementRemaining -
              tileMap[newX][y].terrainType.getMoveCost(moveType) <
          0) {
      }
      //can your movement type move here
      else if (tileMap[newX][y].terrainType.getMoveCost(moveType) < 0) {
      } else {
        _recursivePathSearch(
            newX,
            y,
            (movementRemaining -
                tileMap[newX][y].terrainType.getMoveCost(moveType)),
            prevDirection,
            moveType);
      }
    }
    if (prevDirection != 0) {
      newY = y + 1;
      //in bounds
      if (newY >= yDim) {
      }
      //unit collision
      else if (tileMap[x][newY].hasUnit) {
      }
      //enough movement
      else if (movementRemaining -
              tileMap[x][newY].terrainType.getMoveCost(moveType) <
          0) {
      }
      //can your movement type move here
      else if (tileMap[x][newY].terrainType.getMoveCost(moveType) < 0) {
      } else {
        _recursivePathSearch(
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
