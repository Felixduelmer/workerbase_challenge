import 'dart:io';


import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workerbase_challenge/models/qr_entry.dart';

class DBProvider {
  // Why we need singleton: We use the singleton pattern to ensure that we have only one class instance
  // and provide a global point access to it
  DBProvider._();

  static final DBProvider db = DBProvider._();
  int dbEntries = 0;

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<void> insertEntry(QREntry entry) async {
    // Get a reference to the database.
    print("trying to insert something in database");
    final Database db = await database;

    await db.insert(
      'entries',
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<QREntry>> fetchEntries() async {
    // Get a reference to the database.
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('entries');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return QREntry(
        uri: maps[i]['uri'],
        insertionTime: maps[i]['insertionTime'],
      );
    });
  }

  Future<void> deleteEntry(int insertionTime) async {
    // Get a reference to the database.
    final db = await database;
    await db.delete(
      'entries',
      where: "insertionTime = ?",
      whereArgs: [insertionTime],
    );
  }


  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Data.db");
    if (await File(path).exists()) {
      print("Database already exists and is located at: $path");
      return await openDatabase(path);
    }
    print("Creating new Database at: $path");
    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE entries (insertionTime INTEGER PRIMARY KEY, uri TEXT)",);
    });
  }
}
