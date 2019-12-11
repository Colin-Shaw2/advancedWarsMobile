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
  }
  Infantry.orange() {
    health = 100;
    movement = 3;
    movementType = MovementType.inf;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    teamId = 0;
    teamColor = "orange";
    imagePath = "resources/units/" + teamColor + "Infantry.png";
    name = "Infantry";
  }
  Infantry.blue() {
    health = 100;
    movement = 3;
    movementType = MovementType.inf;
    unitType = UnitType.land;
    attackPower = 1.5;
    defencePower = 0.5;
    cost = 1000;
    teamId = 1;
    teamColor = "blue";
    imagePath = "resources/units/" + teamColor + "Infantry.png";
    name = "Infantry";
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
