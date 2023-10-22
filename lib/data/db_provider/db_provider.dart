import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "drugz.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "drugz.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    return await openDatabase(path);
  }

  Future<List<Map<String, dynamic>>> getDatabase() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db.rawQuery('SELECT * FROM druglist');
    return results;
  }

  Future<void> updateDatabase(List<Map<String, dynamic>> dataFromServer) async {
    final db = await database;

    var batch = db.batch(); // creates a batch

    for (var item in dataFromServer) {
      batch.insert(
        "druglist",
        {
          'id': item['id'],
          'name': item['name'],
          'arabic': item['arabic'],
          'oldprice': item['oldprice'],
          'price': item['price'],
          'active': item['active'],
          'description': item['description'],
          'company': item['company'],
          'dosage_form': item['dosage_form'],
          'units': item['units'],
          'barcode': item['barcode'],
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true); // commits all the operations
  }

  //--------- Create database table --------
  static Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE drugsLack(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        drugName TEXT,
        arabicDrugName TEXT,
        numberOfDrugs INTEGER,
        price DOUBLE
      )""");
  }

  //-------- open database ------
  static Future<Database> db() async {
    return openDatabase("drugsLack.db", version: 1,
        onCreate: (Database database, int version) async {
      await createTable(database);
    });
  }
  //---------------
}
