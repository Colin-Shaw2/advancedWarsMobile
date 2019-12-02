import 'package:advancewars/classes/WarMap.dart';
import 'package:flame/game.dart';

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

  endTurn(){
    activePlayer = (activePlayer + 1)%numPlayers;
  }
}