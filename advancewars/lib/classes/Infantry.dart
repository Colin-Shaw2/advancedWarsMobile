import 'package:advancewars/classes/Unit.dart';

class Infantry extends Unit {
  Infantry() {
    health = 100;
    movement = 3;
    movementType = MovementType.walk;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    imagePath = "resources/units/Infantry.png";
    name = "Infantry";
  }
  Infantry.orange() {
    health = 100;
    teamId = 0;
    teamColor = "orange";
    movement = 3;
    movementType = MovementType.walk;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    imagePath = "resources/units/" + teamColor + "Infantry.png";
    name = "Infantry";
  }
  Infantry.blue() {
    health = 100;
    teamId = 1;
    teamColor = "blue";
    movement = 3;
    movementType = MovementType.walk;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    imagePath = "resources/units/" + teamColor + "Infantry.png";
    name = "Infantry";
  }
  Infantry.yellow() {
    health = 100;
    teamId = 2;
    teamColor = "yellow";
    movement = 3;
    movementType = MovementType.walk;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    imagePath = "resources/units/" + teamColor + "Infantry.png";
    name = "Infantry";
  }
  Infantry.green() {
    health = 100;
    teamId = 3;
    teamColor = "green";
    movement = 3;
    movementType = MovementType.walk;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    imagePath = "resources/units/" + teamColor + "Infantry.png";
    name = "Infantry";
  }
  Infantry.black() {
    health = 100;
    teamId = 4;
    teamColor = "black";
    movement = 3;
    movementType = MovementType.walk;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    imagePath = "resources/units/" + teamColor + "Infantry.png";
    name = "Infantry";
  }

  @override
  void attack(Unit defender) {
    defender.health -= 50;
    health -= 20;
  }
}
