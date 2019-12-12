import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'db_utils.dart';
import 'Item.dart';

//used for database access for the item
class ItemModel{
  //insert item into database
  Future<int> insertItem(Item item) async {
    final db = await DBUtils.init();
    return await db.insert(
      'inventory_items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

//update item
  Future<int> updateItem(Item item) async{
    final db = await DBUtils.init();
    return await db.update(
      'inventory_items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.getID()],
    );
  }


//delete item
  Future<int> deleteItem(Item item) async{
    final db = await DBUtils.init();
    return await db.delete(
      'inventory_items',
      where: 'id = ?',
      whereArgs: [item.getID()],
    );
  }

//return all items in database
  Future<List<Item>> getAllItems() async {
    final db = await DBUtils.init();
    List<Map<String,dynamic>> maps = await db.query('inventory_items');
    List<Item> items = [];
    for (int i=0;i<maps.length;i++){
      print(Item.fromMap(maps[i]).toString());
      items.add(Item.fromMap(maps[i]));
    }
    return items;
  }
}