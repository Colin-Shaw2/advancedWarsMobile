import 'package:advancewars/classes/units/Unit.dart';

class MTank extends Unit {
  MTank() {
    health = 100;
    movement = 5;
    movementType = MovementType.tread;
    unitType = UnitType.land;
    attackPower = 3.0;
    defencePower = 1.5;
    cost = 1000;
    imagePath = "resources/units/MTank.png";
    name = "MTank";
  }
  MTank.orange() {
    health = 100;
    movement = 5;
    movementType = MovementType.tread;
    unitType = UnitType.land;
    attackPower = 3.0;
    defencePower = 1.5;
    cost = 1000;
    teamId = 0;
    teamColor = "orange";
    imagePath = "resources/units/" + teamColor + "MTank.png";
  }
  MTank.blue() {
    health = 100;
    movement = 5;
    movementType = MovementType.tread;
    unitType = UnitType.land;
    attackPower = 3.0;
    defencePower = 1.5;
    cost = 1000;
    teamId = 1;
    teamColor = "blue";
    imagePath = "resources/units/" + teamColor + "MTank.png";
  }

  @override
  void attack(Unit defender) {
    defender.health -= 40;
    if(defender.health<=0){
      return;
    }
    health -= 20;
  }
}
