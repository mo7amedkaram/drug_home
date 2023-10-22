import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../db_provider/db_provider.dart';

class DrugsLackRepository {
  DBProvider dbProvider;
  DrugsLackRepository({
    required this.dbProvider,
  });
  // add item to database

  static Future<int> createItem(String drugName, int numberOfDrugs,
      double price, String arabicDrugName) async {
    final db = await DBProvider.db();
    final data = {
      "drugName": drugName,
      "numberOfDrugs": numberOfDrugs,
      "price": price,
      "arabicDrugName": arabicDrugName
    };
    final id = await db.insert("drugsLack", data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  //-------- get Items From database------
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DBProvider.db();
    return db.query("drugsLack", orderBy: "id");
  }

  //----------- delete lack drugs

  static Future<void> deleteAllDrugs() async {
    final db = await DBProvider.db();
    try {
      await db.delete("drugsLack");
    } catch (E) {
      debugPrint(E.toString());
    }
  }

  //-------------
  static Future<void> deletSpecificDrug({required int id}) async {
    final db = await DBProvider.db();
    try {
      await db.delete("drugsLack", where: "id = ?", whereArgs: [id]);
    } catch (E) {
      debugPrint(E.toString());
    }
  }
}
