import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();

  factory DBHelper() => _instance;
  Database _db;

  Future<Database> getDb() async {
    if (_db == null) {
      _db = await initDatabase();
    }
    return _db;
  }

  closeDb() async {
    if (_db != null) {
      _db.close();
    }
  }

  DBHelper.internal();

  initDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "qst.db");

    deleteDatabase(path);
    var exists = await databaseExists(path);

    if (!exists) {
      // Должно произойти только при первом запуске приложения
      print("Creating new copy from asset");

      // Убедитесь, что родительский каталог существует
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Копировать из актива
      ByteData data = await rootBundle.load(join('assets/databases', 'qst.db'));
      List<int> bytes =
          data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);

      // Записываем и очищаем записанные байты
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

    var db = await openDatabase(path);
    return db;
  }
}
