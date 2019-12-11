import 'package:advancewars/classes/terrain/Terrain.dart';

class Mountain extends Terrain{
  Mountain():super(){
    
  wheelsCost = -1;
  infCost = 2;
  mechCost = 1;
  treadCost= -1;
  airCost = -1;
  landerCost = -1;
  boatCost = -1;
  defenceBonus = 4;
  imagePath ="resources/terrain/Mountain.png";
  name = "Mountain";
  }

}