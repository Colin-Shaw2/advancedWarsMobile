import 'package:advancewars/classes/units/Unit.dart';

class Infantry extends Unit {
  Infantry(){
    health = 100;
    movement = 3;
    movementType = MovementType.inf;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    imagePath = "resources/units/Infantry.png";
    name = "Infantry";
    strongAgainst = ["Infantry", "Mech"];
  }
  Infantry.orange() {
    health = 100;
    movement = 3;
    movementType = MovementType.inf;
    unitType = UnitType.land;
    attackPower = 4;
    defencePower = 0.0;
    cost = 1000;
    teamId = 0;
    teamColor = "orange";
    imagePath = "resources/units/" + teamColor + "Infantry.png";
    name = "Infantry";
    strongAgainst = ["Infantry", "Mech"];
  }
  Infantry.blue() {
    health = 100;
    movement = 3;
    movementType = MovementType.inf;
    unitType = UnitType.land;
    attackPower = 4;
    defencePower = 0.0;
    cost = 1000;
    teamId = 1;
    teamColor = "blue";
    imagePath = "resources/units/" + teamColor + "Infantry.png";
    name = "Infantry";
    strongAgainst = ["Infantry", "Mech"];
  }
  Infantry.yellow() {
    health = 100;
    movement = 3;
    movementType = MovementType.inf;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    teamId = 2;
    teamColor = "yellow";
    imagePath = "resources/units/" + teamColor + "Infantry.png";
    name = "Infantry";
    strongAgainst = ["Infantry", "Mech"];
  }
  Infantry.green() {
    health = 100;
    movement = 3;
    movementType = MovementType.inf;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    teamId = 3;
    teamColor = "green";
    imagePath = "resources/units/" + teamColor + "Infantry.png";
    name = "Infantry";
    strongAgainst = ["Infantry", "Mech"];
  }
  Infantry.black() {
    health = 100;
    movement = 3;
    movementType = MovementType.inf;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    teamId = 4;
    teamColor = "black";
    imagePath = "resources/units/" + teamColor + "Infantry.png";
    name = "Infantry";
    strongAgainst = ["Infantry", "Mech"];
  }
}