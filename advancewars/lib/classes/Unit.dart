
import 'package:flutter/material.dart';

abstract class Unit{
  int movement;
  MovementType movementType;
  UnitType unitType;
  num attack;
  num defence;
  int cost;
  String imagePath;
  
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