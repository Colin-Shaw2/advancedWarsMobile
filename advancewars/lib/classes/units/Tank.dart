import 'package:advancewars/classes/units/Unit.dart';

class Tank extends Unit {
  Tank() {
    health = 100;
    movement = 6;
    movementType = MovementType.tread;
    unitType = UnitType.land;
    attackPower = 3.0;
    defencePower = 1.5;
    cost = 1000;
    imagePath = "resources/units/Tank.png";
    name = "Tank";
  }
  Tank.orange() {
    health = 100;
    teamId = 0;
    teamColor = "orange";
    movement = 6;
    movementType = MovementType.tread;
    unitType = UnitType.land;
    attackPower = 3.0;
    defencePower = 1.5;
    cost = 1000;
    imagePath = "resources/units/" + teamColor + "Tank.png";
    name = "Tank";
  }
  Tank.blue() {
    health = 100;
    teamId = 1;
    teamColor = "blue";
    movement = 6;
    movementType = MovementType.tread;
    unitType = UnitType.land;
    attackPower = 3.0;
    defencePower = 1.5;
    cost = 1000;
    imagePath = "resources/units/" + teamColor + "Tank.png";
    name = "Tank";
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
