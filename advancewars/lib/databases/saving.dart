import 'dart:async';

import 'package:advancewars/classes/Infantry.dart';
import 'package:advancewars/classes/Plain.dart';
import 'package:advancewars/classes/Terrain.dart';
import 'package:advancewars/classes/Unit.dart';
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
  Map<String, dynamic> tileToMap(Tile tile, int xIndex, int yIndex) {
    return {
      "x_index": xIndex,
      "y_index": yIndex,
      "terrain": tile.terrainType.name,
      "team_id": tile.unit != null ? tile.unit.teamId : null,
      "unit_name": tile.unit != null ? tile.unit.name : null,
      "unit_health": tile.unit != null ? tile.unit.health : null
    };
  }

  Future<int> saveMap(WarMap warMap) async {
    var tiles = warMap.tileMap;
    await deleteLocalTiles();
    await deleteCloudTiles();
    for(var x = 0; x < warMap.xDim; x+=1) {
      for(var y = 0; y < warMap.yDim; y+=1) {
        // Wipe previous saved data we only save 1 map at a time
        insertTile(tileToMap(tiles[x][y], x, y));
        saveTileToCloud(tileToMap(tiles[x][y], x, y)); 
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


  Future<WarMap> getLocalSavedMap() async {
    final db = await DBUtils.init();
    List<Map<String, dynamic>> tiles = await db.query('tiles');
    Tile tile;
    if (tiles.length > 0) {
      WarMap warmap = WarMap(tiles.last['x_index']+1, tiles.last['y_index']+1);
      for (int i = 0; i < tiles.length; i += 1) {
        Terrain terrain = Plain();
        // Need to implement other teams and unit types
        Unit unit;
        if(tiles[i]['unit_name'] != null)
        {
          switch(tiles[i]['team_id']) {
            case 0: { 
                unit = Infantry.orange(); 
            } 
            break; 
            
            case 1: { 
                unit = Infantry.blue(); 
            } 
            break; 
            case 2: { 
                unit = Infantry.yellow(); 
            } 
            break; 
            
            case 3: { 
                unit = Infantry.green();
            } 
            break;
            case 4: { 
                unit = Infantry.black();
            } 
            break; 

            default: { 
                unit = Infantry.orange();  
            }
            break; 
          }
          unit.health = tiles[i]['unit_health'];
        }
        tile = Tile.fromMap(terrain, unit);
        warmap.tileMap[tiles[i]['x_index']][tiles[i]['y_index']] = tile;
      }
      return warmap;
    }
    else {
      return null;
    }
  }
}