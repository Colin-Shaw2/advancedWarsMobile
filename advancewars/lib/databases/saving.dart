import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'db_utils.dart';
import 'package:advancewars/classes/WarMap.dart';
import 'package:advancewars/classes/Tile.dart';

class Saving {

  Map<String, dynamic> tileToMap(Tile tile, int xIndex, int yIndex) {
    return {
      "x_index": xIndex,
      "y_index": yIndex,
      "terrain": tile.terrainType.name,
      "unit_name": tile.unit != null ? tile.unit.name : null,
      "unit_health": tile.unit != null ? tile.unit.health : null
    };
  }

  Future<int> saveMap(WarMap warMap) async {
    var tiles = warMap.terrainMap;
    for(var x = 0; x < warMap.xDim; x+=1) {
      for(var y = 0; y < warMap.yDim; y+=1) {
        insertTile(tileToMap(tiles[x][y], x, y));
        saveTileToCloud(tileToMap(tiles[x][y], x, y)); 
      }
    }
  }

  // Local storage saving
  Future<int> insertTile(Map tileData) async {
    final db = await DBUtils.init();
    return await db.insert(
      'tiles',
      tileData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Firestore backup
  Future<void> saveTileToCloud(Map tileData) async {
    Firestore.instance.collection('tiles').document()
  .setData(tileData);
  }
}