import 'dart:io';
import 'package:bv_yt_tut_einkaufsliste/models/shopping_item.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Singleton Pattern
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'shopping_items.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE shopping_items(
        id INTEGER PRIMARY KEY,
        name TEXT,
        done INTEGER
      )
    ''');
  }

  Future<List<ShoppingItem>> getShoppingItems() async {
    Database db = await instance.database;
    var shoppingItems = await db.query('shopping_items', orderBy: 'name');
    List<ShoppingItem> shoppingItemsList =
        shoppingItems.isNotEmpty ? shoppingItems.map((e) => ShoppingItem.fromMap(e)).toList() : [];
    return shoppingItemsList;
  }

  Future<int> add(ShoppingItem item) async {
    Database db = await instance.database;
    return await db.insert('shopping_items', item.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('shopping_items', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(ShoppingItem item) async {
    Database db = await instance.database;
    return await db.update('shopping_items', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
  }
}
