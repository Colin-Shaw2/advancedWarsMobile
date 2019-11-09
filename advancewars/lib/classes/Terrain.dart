import 'package:flutter/foundation.dart';

abstract class Terrain{
  TerrainName name;
  int wheelsCost;
  int walkCost;
  int treadCost;
  int airCost = 1;
  int landerCost;
  int boatCost;
  int defenceBonus;

  Terrain();

}

enum TerrainName{
  plain,
  river,
  road,
  bridge,
  forest,
  mountain,
  sea,
  reef,
  shoal,
}