// ignore_for_file: depend_on_referenced_packages, avoid_print, unused_local_variable

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dbsql {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await init();
      return _db;
    } else {
      return _db;
    }
  }

  init() async {
    String datapath = await getDatabasesPath();
    String path = join(datapath, 'ismail.db');
    Database mydb = await openDatabase(
      path,
      version: 1,
      // للقيام بعملية انشاء الداتابيز
      onCreate: (db, version) async {
        await db.execute('''
      CREATE TABLE 'notes' (
        'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        'note' TEXT,
        'title' TEXT,
        'color' TEXT
           )
       ''');
        print("OnCreate.................");
      },
      //عندالقيام بتحديث الداتابيز
      onUpgrade: (db, oldVersion, newVersion) {},
    );
    return mydb;
  }

//لقراءة البيانات من الداتابيز
  readdata(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

//للقيام بعملية ادراج صف في الجدول ضمن الداتابيز
  insertdata(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

//للقيام بتعديل صف ضمن الجدول في الداتابيز
  updatedata(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

//للقيام بحذف صف ضمن الجدول في الداتابيز
  deletedata(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

//للقيام بحذف الداتابيز من جذورها
  mydeletedatabase() async {
    String datapath = await getDatabasesPath();
    String path = join(datapath, 'ismail.db');
    await deleteDatabase(path);
  }

///////////////////////////////////////////////////////////////////////////////
// SQL دوال اسهل جاهزة لكتابة الاكواد بدون كتابة اكواد الـ //

  //لقراءة البيانات من الداتابيز
  read(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

//للقيام بعملية ادراج صف في الجدول ضمن الداتابيز
  insert(String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, values);
    return response;
  }

//للقيام بتعديل صف ضمن الجدول في الداتابيز
  update(String table, Map<String, Object?> values, String? wheress) async {
    Database? mydb = await db;
    int response = await mydb!.update(table, values, where: wheress);
    return response;
  }

//للقيام بحذف صف ضمن الجدول في الداتابيز
  delete(String table, String? wheress) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table, where: wheress);
    return response;
  }
}
