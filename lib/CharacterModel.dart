import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'model/db_utils.dart';
import 'Character.dart';

class CharacterModel{
  Future<int> insertCharacter() async {
    final db = await DBUtils.init();
    return await db.insert(
      'character_save',
      Character.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateCharacter() async{
    final db = await DBUtils.init();
    return await db.update(
      'character_save',
      Character.toMap(),
      where: 'name = ?',
      whereArgs: [Character.name],
    );
  }

  Future<void> getCharacter(String name) async {
    final db = await DBUtils.init();
    List<Map<String,dynamic>> maps = await db.query(
      'character_save',
      where: 'name = ?',
      whereArgs: [name],
    );
    if(maps.length>0){
      Character.fromMap(maps[0]);
    }
  }
}