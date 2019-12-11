
import 'package:flutter/material.dart';

abstract class Unit{
  String teamColor;
  int teamId;// 0 orange 1 blue 2 yellow 3 green 4 black
  String name;
  int health = 100;
  int movement;
  MovementType movementType;
  UnitType unitType;
  num attackPower;
  num defencePower;
  int cost;
  List<String> strongAgainst = [];
  List<String> weakAgainst = [];
  String imagePath;
  bool hasMoved = false;


  void attack(Unit defender) {
    hasMoved = true;
    if(strongAgainst.contains(defender.unitType)) {
      defender.health -= ((this.attackPower*10*(this.health/100))*1.5 - (defender.defencePower*10*(defender.health/100))).round();
    }
    else if(weakAgainst.contains(defender.unitType)) {
      defender.health -= ((this.attackPower*10*(this.health/100))*0.75 - (defender.defencePower*10*(defender.health/100))).round();
    }
    else {
      defender.health -= (this.attackPower*10*(this.health/100) - defender.defencePower*10*(defender.health/100)).round();
    }
    if(defender.health > 0)
    {
      if(defender.strongAgainst.contains(this.unitType)) {
        this.health -= ( (defender.attackPower*10*(defender.health/100))*1.5 - this.defencePower*10*(this.health/100)).round();
      }
      else if(weakAgainst.contains(defender.unitType)) {
        this.health -= ((defender.attackPower*10*(defender.health/100))*0.75 - this.defencePower*10*(this.health/100)).round();
      }
      else {
        this.health -= (defender.attackPower*10*(defender.health/100) - this.defencePower*10*(this.health/100)).round();
      }
    }
    if(defender.health < 0) {
      defender.health = 0;
    }
    if(this.health < 0) {
      this.health = 0;
    }
  }


  //null if near full health
  String getHealthImagePath(){
    String myPath = "resources/numbers/";
    if(health> 90){
      myPath = null;
    }
    else if(health> 80){
      myPath += "nine.png";
    }
    else if(health> 70){
      myPath += "eight.png";
    }
    else if(health> 60){
      myPath += "seven.png";
    }
    else if(health> 50){
      myPath += "six.png";
    }
    else if(health> 40){
      myPath += "five.png";
    }
    else if(health> 30){
      myPath += "four.png";
    }
    else if(health> 20){
      myPath += "three.png";
    }
    else if(health> 10){
      myPath += "two.png";
    }
    else if(health> 0){
      myPath += "one.png";
    }else{
      myPath = null;
    }
    
    return myPath;
    
  }
}

enum MovementType{
  wheels,
  inf,
  mech,
  tread,
  air,
  lander,
  boat
}

enum UnitType{
  land,
  sea,
  air
}

