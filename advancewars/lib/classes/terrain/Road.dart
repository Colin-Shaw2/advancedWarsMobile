import 'package:advancewars/classes/terrain/Terrain.dart';

class Road extends Terrain{
  Road():super(){
    
  wheelsCost = 1;
  infCost = 1;
  mechCost = 1;
  treadCost= 1;
  airCost = 1;
  landerCost = -1;
  boatCost = -1;
  defenceBonus = 0;
  imagePath ="resources/terrain/Road.png";
  name = "Road";
  }

}