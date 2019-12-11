import 'package:advancewars/classes/WarMap.dart';

import 'Tile.dart';

class GameDriver{
  WarMap activeMap;
  int numPlayers;
  int activePlayer;//p1 =0 p2 =1...


  GameDriver.twoPlayers(WarMap map){
    activeMap = map;
    numPlayers = 2;
    activePlayer = 0;
  }

  GameDriver.resume(WarMap map, int numPlayers, int activePlayer){
    activeMap = map;
    this.numPlayers = numPlayers;
    this.activePlayer = this.activePlayer;
  }

  handleDownPress(int x, int y){
    activeMap.tileSelect(x, y, activePlayer);
  }

  endTurn(){
    activePlayer = (activePlayer + 1)%numPlayers;
    if(activePlayer == 0) {
      activeMap.day += 1;
    }
    this.activeMap.turnEnded = true;
    for (List<Tile> row in activeMap.tileMap) {
      for (Tile tile in row){
        tile.unit.hasMoved = true;
      }
    }

    startNewTurn();

  }

  Future<void> startNewTurn() async {
    await new Future.delayed(Duration(seconds: 8));
    this.activeMap.turnEnded = false;
  }


}