import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtils {
  static Future<Database> init() async {
    return openDatabase(
      path.join(await getDatabasesPath(), 'tiles.db'),
      onCreate: (db, version) {
        if (version > 1) {
          // downgrade path
        }
        db.execute(
          'CREATE TABLE tiles(id INTEGER PRIMARY KEY, y_index INTEGER, x_index INTEGER, terrain TEXT, unit_name TEXT, unit_health INT)');
      },
      version: 1,
    );
  }
}