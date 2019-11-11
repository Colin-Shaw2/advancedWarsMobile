import 'package:advancewars/classes/Unit.dart';

class Infantry extends Unit{
  Infantry(){
  movement = 3;
  movementType = MovementType.walk;
  unitType = UnitType.land;
  attackPower = 1.5;
  defencePower = 0.5;
  cost = 1000;
  imagePath = "resources/units/Infantry.png";
  name = "Infantry";
  }
}