import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/currency.dart';

class AppDB {
  static Database? _db;
  static String accGroups = 'accGroups';
  static String currencies = 'currencies';
  static String accRestrichions = 'accRestrichions';
  static String customers = 'customers';

  static Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  static intialDb() async {
    String dataBasepath = await getDatabasesPath();
    String path = join(dataBasepath, 'accounts_book.db');
    Database mydb = await openDatabase(path, onCreate: _ocCreate, version: 1);
    return mydb;
  }

  static Future<void> _ocCreate(Database db, int version) async {
    await db.execute('''
   CREATE TABLE $currencies(
   currencyId integer primary key autoincrement,
   currencyName Text,
   currencySymbol STRING
   )
   ''');
    await db.execute('''
   CREATE TABLE $accGroups(
   accGroupId integer primary key autoincrement,
   accGroupName Text,
   created_at STRING,
   status integer
   )
   ''');

    await db.execute('''
   CREATE TABLE $accRestrichions(
   accRestrichionId integer primary key autoincrement,
   accRestrichionDetails Text,
   customerId integer,
   currencyId integer,
   registerdon STRING,
   credit integer,
   debit integer,
   accGroupId integer
   )
   ''');
    await db.execute('''
   CREATE TABLE $customers(
   customerId integer primary key autoincrement,
   customerName Text,
   customerPhone Text,
   created_at STRING,
   status INTEGER 
   )
   ''');
    print('Create DataBase And Table .......................');
  }

  insertTable(String tableName, Map<String, Object?> toMap) async {
    Database? mydb = await db;
    try {
      return await mydb!.insert(
        tableName!,
        toMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
      return 90000;
    }
  }

  Future<List<Map<String, dynamic>>> getTableData(String tableName) async {
    Database? mydb = await db;
    return await mydb!.query(tableName);
  }

  updateDate(
      String tableName, Map<String, Object?> toMap, String nameId) async {
    Database? mydb = await db;
    return await mydb!.update(
      tableName,
      toMap,
      where: '$nameId =?',
      whereArgs: [toMap['$nameId']],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteRow(
      String tableName, Map<String, Object?> toMap, String nameId) async {
    Database? mydb = await db;
    return await mydb!
        .delete(tableName, where: nameId, whereArgs: [toMap['$nameId']]);
  }

  // deleteOptionTable() async {
  //   Database? mydb = await db;
  //   mydb!.rawDelete("Delete * from $nameTable");
  // }
  //
  static Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);
}
