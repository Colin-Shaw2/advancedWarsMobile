import 'package:advancewars/classes/units/Unit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Terrain{
  String name;
  int wheelsCost;
  int walkCost;
  int treadCost;
  int airCost = 1;
  int landerCost;
  int boatCost;
  int defenceBonus;
  String imagePath;

  Terrain();

  Terrain.fromName(String name) {
    this.name = name;
  }

  int getMoveCost(MovementType moveType){
    if(moveType == MovementType.air){
      return airCost;
    }
    
    if(moveType == MovementType.boat){
      return boatCost;
    }
    
    if(moveType == MovementType.lander){
      return landerCost;
    }
    
    if(moveType == MovementType.tread){
      return treadCost;
    }
    
    if(moveType == MovementType.walk){
      return walkCost;
    }

    if(moveType == MovementType.wheels){
      return wheelsCost;
    }
  }

}

// enum TerrainName{
//   plain,
//   river,
//   road,
//   bridge,
//   forest,
//   mountain,
//   sea,
//   reef,
//   shoal,
// }