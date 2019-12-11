import 'package:advancewars/classes/units/Unit.dart';

class Recon extends Unit {
  Recon() {
    health = 100;
    movement = 8;
    movementType = MovementType.wheels;
    unitType = UnitType.land;
    attackPower = 3.0;
    defencePower = 1.5;
    cost = 1000;
    imagePath = "resources/units/Recon.png";
    name = "Recon";
  }
  Recon.orange() {
    health = 100;
    movement = 8;
    movementType = MovementType.wheels;
    unitType = UnitType.land;
    attackPower = 3.0;
    defencePower = 1.5;
    cost = 1000;
    teamId = 0;
    teamColor = "orange";
    imagePath = "resources/units/" + teamColor + "Recon.png";
  }
  Recon.blue() {
    health = 100;
    movement = 8;
    movementType = MovementType.wheels;
    unitType = UnitType.land;
    attackPower = 3.0;
    defencePower = 1.5;
    cost = 1000;
    teamId = 1;
    teamColor = "blue";
    imagePath = "resources/units/" + teamColor + "Recon.png";
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
