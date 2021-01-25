import 'dart:io';
import 'package:flutter_wishlist/models/item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DataBaseClient {

  Database _dataBase;

  Future<Database> get database async {
    if (_dataBase != null) {
      return _dataBase;
    } else {
      _dataBase = await create();
      return _dataBase;
    }
  }

  Future create() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String databaseDirectory = join(directory.path, 'database.db');
    var bdd = await openDatabase(databaseDirectory, version: 1, onCreate: _onCreate);
    return bdd;
  }

  //CREATION D'UNE TABLE

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE item (
    id INTEGER PRIMARY KEY, 
    nom TEXT NOT NULL)
    ''');
    await db.execute('''
    CREATE TABLE article (
    id INTEGER PRIMARY KEY,
    nom TEXT NOT NULL,
    item INTEGER,
    prix TEXT,
    magasin TEXT,
    imagePath TEXT)
    ''');
  }

  //ECRITURE DES DONNEES
  Future<Item> addItem(Item item) async {
    Database myDatabase = await database;
    item.id = await myDatabase.insert('item', item.toMap());
    return item;
  }
  
  Future<int> deleteItem(int id, String table) async {
    Database myDatabase = await database;
    return await myDatabase.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateItem(Item item) async {
    Database myDatabse = await database;
    return myDatabse.update('item', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
  }

  Future<Item> upsertItem(Item item) async {
    Database myDatabase = await database;
    if (item.id == null) {
      item.id = await myDatabase.insert('item', item.toMap());
    } else {
      await myDatabase.update('item', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
    }
    return item;
  }

  //LECTURE DES DONNEES
  Future<List<Item>> getAllItems() async {
    Database myDatabase = await database;
    List<Map<String, dynamic>> results = await myDatabase.rawQuery('SELECT * FROM item');
    List<Item> items = [];
    results.forEach((map) {
      Item item = Item();
      item.fromMap(map);
      items.add(item);
    });
    return items;
  }

}