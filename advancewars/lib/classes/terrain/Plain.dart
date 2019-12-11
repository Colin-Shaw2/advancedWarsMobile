import 'package:advancewars/classes/terrain/Terrain.dart';

class Plain extends Terrain{
  Plain():super(){
    
  wheelsCost = 2;
  walkCost = 1;
  treadCost= 1;
  airCost = 1;
  landerCost = -1;
  boatCost = -1;
  defenceBonus = 1;
  imagePath ="resources/terrain/Plain.png";
  name = "Plain";
  }

}