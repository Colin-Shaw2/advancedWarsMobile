import 'package:advancewars/classes/units/Unit.dart';

class Mech extends Unit {
  Mech() {
    health = 100;
    movement = 2;
    movementType = MovementType.mech;
    unitType = UnitType.land;
    attackPower = 3.0;
    defencePower = 1.5;
    cost = 1000;
    imagePath = "resources/units/Mech.png";
    name = "Mech";
    strongAgainst = ["Infantry", "Recon", "Tank", "Mech"];
  }
  Mech.orange() {
    health = 100;
    movement = 2;
    movementType = MovementType.mech;
    unitType = UnitType.land;
    attackPower = 4;
    defencePower = 0;
    cost = 1000;
    teamId = 0;
    teamColor = "orange";
    imagePath = "resources/units/" + teamColor + "Mech.png";
    name = "Mech";
    strongAgainst = ["Infantry", "Recon", "Tank", "Mech"];
  }
  Mech.blue() {
    health = 100;
    movement = 2;
    movementType = MovementType.mech;
    unitType = UnitType.land;
    attackPower = 4;
    defencePower = 0;
    cost = 1000;
    teamId = 1;
    teamColor = "blue";
    imagePath = "resources/units/" + teamColor + "Mech.png";
    name = "Mech";
    strongAgainst = ["Infantry", "Recon", "Tank", "Mech"];
  }

}
