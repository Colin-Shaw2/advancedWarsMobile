
import 'package:flutter/material.dart';

abstract class Unit{
  String teamColor;
  String name;
  int health;
  int movement;
  MovementType movementType;
  UnitType unitType;
  num attackPower;
  num defencePower;
  int cost;
  String imagePath;


  void attack();

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

