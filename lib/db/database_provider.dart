import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:practice_makes_perfect/db/database_keys.dart';
import 'package:practice_makes_perfect/models/dog.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider();

  static final DatabaseProvider db = DatabaseProvider();

  Future<Database> _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = openDB();
    return _database;
  }

  Future<Database> openDB() async {
    Future<void> _onCreate(Database db, int version) async {
      await db.transaction((txn) async {
        await txn.execute((Dog.createDogTableString));
      });
    }

    final path = join(await getDatabasesPath(), 'doggie_database.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<List<Dog>> getDogs() async {
    final db = await database;

    final dogsMaps = await db.query(DBKeys.tableDogs);

    final dogs = <Dog>[];
    for (final dogMap in dogsMaps) {
      dogs.add(Dog.fromMap(dogMap));
    }
    return dogs;
  }

  Future<void> insertDog(Dog dog) async {
    final db = await database;

    // Replace if dog already exists
    await db.insert(
      DBKeys.tableDogs,
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future closeDb() async {
    final db = await database;
    db.close();
  }
}
