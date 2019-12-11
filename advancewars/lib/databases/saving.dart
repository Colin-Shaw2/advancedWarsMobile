import 'dart:async';

import 'package:advancewars/classes/GameDriver.dart';
import 'package:advancewars/classes/terrain/Mountain.dart';
import 'package:advancewars/classes/terrain/Road.dart';
import 'package:advancewars/classes/terrain/Wood.dart';
import 'package:advancewars/classes/units/Infantry.dart';
import 'package:advancewars/classes/terrain/Plain.dart';
import 'package:advancewars/classes/terrain/Terrain.dart';
import 'package:advancewars/classes/units/MTank.dart';
import 'package:advancewars/classes/units/Mech.dart';
import 'package:advancewars/classes/units/Recon.dart';
import 'package:advancewars/classes/units/Tank.dart';
import 'package:advancewars/classes/units/Unit.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart';
import 'db_utils.dart';
import 'package:advancewars/classes/WarMap.dart';
import 'package:advancewars/classes/Tile.dart';

class Saving {

  //Saving location in options
  Future<int> saveLocation(String address, LatLng point) async {
    final db = await DBUtils.init();
    return await db.insert(
      'locations',
      locationToMap(address, point),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Map<String, dynamic> locationToMap(String address, LatLng point) {
    return {
      "address": address,
      "latitude": point.latitude,
      "longitude": point.longitude
    };
  }

  Future<List<LatLng>> loadLocations() async {
    final db = await DBUtils.init();
    List<Map<String, dynamic>> locations = await db.query('locations');
    return locations.map((location) =>
      LatLng(location['latitude'], location['longitude'])
    ).toList();

  }

  //Saving game
  Map<String, dynamic> tileToMap(Tile tile, int xIndex, int yIndex, int playerTurn, int day) {
    return {
      "x_index": xIndex,
      "y_index": yIndex,
      "terrain": tile.terrainType.name,
      "team_id": tile.unit != null ? tile.unit.teamId : null,
      "unit_name": tile.unit != null ? tile.unit.name : null,
      "unit_health": tile.unit != null ? tile.unit.health : null,
      "unit_has_moved": tile.unit != null ? tile.unit.hasMoved : null,
      "player_turn": playerTurn,
      "day": day
    };
  }

  Future<int> saveMap(WarMap warMap, int playerTurn) async {
    var tiles = warMap.tileMap;
    // Wipe previous saved data we only save 1 map at a time
    await deleteLocalTiles();
    await deleteCloudTiles();
    for(var x = 0; x < warMap.xDim; x+=1) {
      for(var y = 0; y < warMap.yDim; y+=1) {
        insertTile(tileToMap(tiles[x][y], x, y, playerTurn, warMap.day));
        saveTileToCloud(tileToMap(tiles[x][y], x, y, playerTurn, warMap.day)); 
      }
    }
  }

  Future<int> deleteLocalTiles() async {
    final db = await DBUtils.init();
    return await db.delete('tiles');
  }

  Future<int> deleteCloudTiles() async {
    return await Firestore.instance.collection('tiles').getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents){
        if(!ds.data.containsKey('DEFAULT')) {
          ds.reference.delete();
        }
      }});
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
    Firestore.instance.collection('tiles').document().setData(tileData);
  }

  Unit spawnInfantry(int team) {
    Unit unit; 
    switch(team) {
            case 0: { 
                unit = Infantry.orange(); 
            } 
            break; 
            
            case 1: { 
                unit = Infantry.blue(); 
            } 
            break;
            default: { 
                unit = Infantry.orange();  
            }
            break; 
          }
    return unit;
  }
  Unit spawnTank(int team) {
    Unit unit; 
    switch(team) {
            case 0: { 
                unit = Tank.orange(); 
            } 
            break; 
            
            case 1: { 
                unit = Tank.blue(); 
            } 
            break;
            default: { 
                unit = Tank.orange();  
            }
            break; 
          }
    return unit;
  }
  Unit spawnMech(int team) {
    Unit unit; 
    switch(team) {
            case 0: { 
                unit = Mech.orange(); 
            } 
            break; 
            
            case 1: { 
                unit = Mech.blue(); 
            } 
            break;
            default: { 
                unit = Mech.orange();  
            }
            break; 
          }
    return unit;
  }
  Unit spawnMTank(int team) {
    Unit unit; 
    switch(team) {
            case 0: { 
                unit = MTank.orange(); 
            } 
            break; 
            
            case 1: { 
                unit = MTank.blue(); 
            } 
            break;
            default: { 
                unit = MTank.orange();  
            }
            break; 
          }
    return unit;
  }
  Unit spawnRecon(int team) {
    Unit unit; 
    switch(team) {
            case 0: { 
                unit = Recon.orange(); 
            } 
            break; 
            
            case 1: { 
                unit = Recon.blue(); 
            } 
            break;
            default: { 
                unit = Recon.orange();  
            }
            break; 
          }
    return unit;
  }
  Future<GameDriver> getLocalSavedMap() async {
    final db = await DBUtils.init();
    List<Map<String, dynamic>> tiles = await db.query('tiles');
    Tile tile;
    int playerTurn;
    int day;
    if (tiles.length > 0) {
      WarMap warmap = WarMap(tiles.last['x_index']+1, tiles.last['y_index']+1);
      for (int i = 0; i < tiles.length; i += 1) {
        Terrain terrain;
        // Need to implement other teams and unit types
        Unit unit;
        playerTurn = tiles[i]['player_turn'];
        day = tiles[i]['day'];
        // Spawns Units
        if(tiles[i]['unit_name'] != null)
        {
          switch(tiles[i]['unit_name']) {
            case "Infantry": {
              unit = spawnInfantry(tiles[i]['team_id']);
            }
            break;
            case "Tank": {
              unit = spawnTank(tiles[i]['team_id']);
            }
            break;
            case "Mech": {
              unit = spawnMech(tiles[i]['team_id']);
            }
            break;
            case "Recon": {
              unit = spawnRecon(tiles[i]['team_id']);
            }
            break;
            case "MTank": {
              unit = spawnMTank(tiles[i]['team_id']);
            }
            break;
          }
          unit.health = tiles[i]['unit_health'];
          if(tiles[i]['unit_has_moved'] == 1) {
            unit.hasMoved = true;
          }
          else {
            unit.hasMoved = false;
          }
        }
        //Sets Terrain
        switch(tiles[i]['terrain']) {
            case "Plain": {
              terrain = Plain();
            }
            break;
            case "Mountain": {
              terrain = Mountain();
            }
            break;
            case "Road": {
              terrain = Road();
            }
            break;
            case "Wood": {
              terrain = Wood();
            }
            break;
          }
        tile = Tile.fromMap(terrain, unit);
        warmap.tileMap[tiles[i]['x_index']][tiles[i]['y_index']] = tile;
        warmap.day = day;
      }
      GameDriver driver = GameDriver.twoPlayers(warmap);
      driver.activePlayer = playerTurn;
      return driver;
    }
    else {
      return null;
    }
  }
}