import 'package:accounts_book/model/currency.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Database? _database;
  static String nameDatabase = 'currencies.db';
  static Future<Database> initDB() async {
    // if (_database != null) {
    //   print('Database Not Null');
    //   return;
    // }
    try {
      String _path = await getDatabasesPath() + 'currencies.db';
      print('In path Database');
      _database =
          await openDatabase(_path, version: 1, onCreate: (db, version) async {
        print('In OnCreate');
        return db.execute(
            "CREATE TABLE currencies(id integer primary key autoincrement,name Text,symbol STRING)");
      });
    } catch (e) {
      print(e);
    }
    return _database!;
  }

//endTime varchar not null
  static Future<int> insertTable(Currency? currency) async {
    try {
      return await _database!.insert('currencies', currency!.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print(e);
      return 90000;
    }
  }

  static Future<List<Map<String, dynamic>>> getTasksData() async {
    final db = await initDB();
    return await _database!.query('currencies');
  }

  static Future<int> updateDate(Currency currency) async {
    final dbUpdate = await initDB();
    return await _database!.update('currencies', currency.toMap(),
        where: 'id = ?',
        whereArgs: [currency.currencyId],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteTasks(Currency currency) async {
    return await _database!.delete(
      'currencies',
      where: 'id = ?',
      whereArgs: [currency.currencyId],
    );
  }

  static deleteOptionTable() async {
    //final db = await database;
    _database!.rawDelete("Delete * from currencies");
  }

  static Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);
}
