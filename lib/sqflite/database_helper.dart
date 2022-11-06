//suport for Directory
import 'dart:io';

import 'package:sqflite/sqflite.dart';
//suport for getApplicationDocumentsDirectory
import 'package:path_provider/path_provider.dart';
//suport for join()
import 'package:path/path.dart';
import '../models/trip_entity.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'trip.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE trip(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tripName TEXT,
        destination TEXT,
        tripDate TEXT,
        riskAssessment TEXT,
        description TEXT
      )
    ''');
  }

  Future<List<TripEntity>> getTrips() async {
    Database db = await instance.database;
    var trips = await db.query('trip');
    List<TripEntity> tripList = trips.isNotEmpty
        ? trips.map((t) => TripEntity.fromMap(t)).toList()
        : [];
    return tripList;
  }

  Future<int> add(TripEntity trip) async {
    Database db = await instance.database;
    return await db.insert('trip', trip.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('trip', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(TripEntity trip) async {
    Database db = await instance.database;
    return await db
        .update('trip', trip.toMap(), where: 'id = ? ', whereArgs: [trip.id]);
  }
}
