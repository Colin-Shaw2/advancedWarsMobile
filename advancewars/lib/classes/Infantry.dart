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
    teamColor = "orange";
    movement = 3;
    movementType = MovementType.walk;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    imagePath = "resources/units/"+teamColor+"Infantry.png";
    name = "Infantry";
  }
  Infantry.blue() {
    teamColor = "blue";
    movement = 3;
    movementType = MovementType.walk;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    imagePath = "resources/units/"+teamColor+"Infantry.png";
    name = "Infantry";
  }
  Infantry.yellow() {
    teamColor = "yellow";
    movement = 3;
    movementType = MovementType.walk;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    imagePath = "resources/units/"+teamColor+"Infantry.png";
    name = "Infantry";
  }
  Infantry.green() {
    teamColor = "green";
    movement = 3;
    movementType = MovementType.walk;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    imagePath = "resources/units/"+teamColor+"Infantry.png";
    name = "Infantry";
  }
  Infantry.black() {
    teamColor = "black";
    movement = 3;
    movementType = MovementType.walk;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    imagePath = "resources/units/"+teamColor+"Infantry.png";
    name = "Infantry";
  }

  @override
  void attack() {
    // TODO: implement attack
  }

  
}
