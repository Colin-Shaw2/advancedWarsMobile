
import 'package:flutter/material.dart';

abstract class Unit{
  String teamColor;
  int teamId;// 0 orange 1 blue 2 yellow 3 green 4 black
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

