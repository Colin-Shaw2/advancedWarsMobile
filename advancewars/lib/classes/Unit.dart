
import 'package:flutter/material.dart';

abstract class Unit{
  String name;
  int health;
  int movement;
  MovementType movementType;
  UnitType unitType;
  num attackPower;
  num defencePower;
  int cost;
  String imagePath;


  void select(){

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