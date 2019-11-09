import 'package:advancewars/classes/Terrain.dart';
import 'package:flutter/cupertino.dart';

class Plain extends Terrain{
  Plain():super(){
    
  name = TerrainName.plain;
  wheelsCost = 2;
  walkCost = 1;
  treadCost= 1;
  airCost = 1;
  landerCost = -1;
  boatCost = -1;
  defenceBonus = 1;
  image = Image.asset("resources/classes/plain.png");
  }
  
}