import 'package:advancewars/classes/Unit.dart';

class Infantry extends Unit {
  Infantry() {
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
    teamColor = TeamColor.orange;
    movement = 3;
    movementType = MovementType.walk;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    imagePath = "resources/units/Infantry.png";
    name = "Infantry";
  }
  Infantry.blue() {
    teamColor = TeamColor.blue;
    movement = 3;
    movementType = MovementType.walk;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    imagePath = "resources/units/Infantry.png";
    name = "Infantry";
  }
  Infantry.yellow() {
    teamColor = TeamColor.yellow;
    movement = 3;
    movementType = MovementType.walk;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    imagePath = "resources/units/Infantry.png";
    name = "Infantry";
  }
  Infantry.green() {
    teamColor = TeamColor.green;
    movement = 3;
    movementType = MovementType.walk;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    imagePath = "resources/units/Infantry.png";
    name = "Infantry";
  }
  Infantry.black() {
    teamColor = TeamColor.black;
    movement = 3;
    movementType = MovementType.walk;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    imagePath = "resources/units/Infantry.png";
    name = "Infantry";
  }

  @override
  void attack() {
    // TODO: implement attack
  }

  
}
