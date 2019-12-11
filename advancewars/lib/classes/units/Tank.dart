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
    strongAgainst = ["Infantry", "Recon", "Tank", "Mech"];
  }
  Tank.orange() {
    health = 100;
    movement = 6;
    movementType = MovementType.tread;
    unitType = UnitType.land;
    attackPower = 3.0;
    defencePower = 1.5;
    cost = 1000;
    teamId = 0;
    teamColor = "orange";
    imagePath = "resources/units/" + teamColor + "Tank.png";
    name = "Tank";
    strongAgainst = ["Infantry", "Recon", "Tank", "Mech"];
  }
  Tank.blue() {
    health = 100;
    movement = 6;
    movementType = MovementType.tread;
    unitType = UnitType.land;
    attackPower = 3.0;
    defencePower = 1.5;
    cost = 1000;
    teamId = 1;
    teamColor = "blue";
    imagePath = "resources/units/" + teamColor + "Tank.png";
    name = "Tank";
    strongAgainst = ["Infantry", "Recon", "Tank", "Mech"];
  }
}
