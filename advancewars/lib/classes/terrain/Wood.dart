import 'package:advancewars/classes/terrain/Terrain.dart';

class Wood extends Terrain{
  Wood():super(){
    
  wheelsCost = 3;
  walkCost = 1;
  treadCost= 2;
  airCost = 1;
  landerCost = -1;
  boatCost = -1;
  defenceBonus = 2;
  imagePath ="resources/terrain/Wood.png";
  name = "Wood";
  }

}