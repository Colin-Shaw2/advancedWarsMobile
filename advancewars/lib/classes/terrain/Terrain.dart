import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Terrain{
  String name;
  int wheelsCost;
  int walkCost;
  int treadCost;
  int airCost = 1;
  int landerCost;
  int boatCost;
  int defenceBonus;
  String imagePath;

  Terrain();

  Terrain.fromName(String name) {
    this.name = name;
  }

}

// enum TerrainName{
//   plain,
//   river,
//   road,
//   bridge,
//   forest,
//   mountain,
//   sea,
//   reef,
//   shoal,
// }