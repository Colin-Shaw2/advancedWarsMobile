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
    strongAgainst = ["Infantry", "Mech"];
  }
  Recon.orange() {
    health = 100;
    movement = 8;
    movementType = MovementType.wheels;
    unitType = UnitType.land;
    attackPower = 4.5;
    defencePower = .5;
    cost = 1000;
    teamId = 0;
    teamColor = "orange";
    imagePath = "resources/units/" + teamColor + "Recon.png";
    name = "Recon";
    strongAgainst = ["Infantry", "Mech"];
  }
  Recon.blue() {
    health = 100;
    movement = 8;
    movementType = MovementType.wheels;
    unitType = UnitType.land;
    attackPower = 4.5;
    defencePower = .5;
    cost = 1000;
    teamId = 1;
    teamColor = "blue";
    imagePath = "resources/units/" + teamColor + "Recon.png";
    name = "Recon";
    strongAgainst = ["Infantry", "Mech"];
  }

}
