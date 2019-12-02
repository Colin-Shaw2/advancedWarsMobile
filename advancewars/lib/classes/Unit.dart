
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
  String imagePath;
  bool hasMoved = false;


  void attack( Unit defender);

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
      myPath += "seven.png";
    }
    else if(health> 60){
      myPath += "eight.png";
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
    }
    
    return myPath;
    
  }
}

enum MovementType{
  wheels,
  walk,
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

