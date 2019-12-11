import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtils {
  static Future<Database> init() async {
    return openDatabase(
      path.join(await getDatabasesPath(), 'player_storage.db'),
      onCreate: (db, version) {
        if (version > 1) {
          // downgrade path
        }
        //inventory storage
        db.execute('CREATE TABLE inventory_items(id INTEGER PRIMARY KEY, type TEXT, description TEXT,name TEXT, health REAL, motivation REAL, iconID INTEGER, inLoadout INTEGER)');
        //character storage
        db.execute('CREATE TABLE character_save(name TEXT PRIMARY KEY, curHealth REAL, maxHealth REAL, curMotiv REAL, maxMotiv REAL, invSize INTEGER, prevLoc TEXT)');
      
        db.execute('CREATE TABLE courses(id INTEGER PRIMARY KEY, courseId TEXT, courseName TEXT, grade REAL)');
      },
      version: 1,
    );
  }
}