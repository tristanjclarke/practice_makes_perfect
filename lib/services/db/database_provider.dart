import 'dart:io';

import 'package:path/path.dart';
import 'package:practice_makes_perfect/dog/model/dog_model.dart';
import 'package:practice_makes_perfect/services/db/database_keys.dart';
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
        await txn.execute((DogModel.createDogTableString));
      });
    }

    final path = join(await getDatabasesPath(), 'doggie_database.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<List<DogModel>> getDogs() async {
    final db = await database;

    final dogsMaps = await db.query(DBKeys.tableDogs);

    final dogs = <DogModel>[];
    for (final dogMap in dogsMaps) {
      dogs.add(DogModel.fromMap(dogMap));
    }
    return dogs;
  }

  Future<void> insertDog(DogModel dog) async {
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
