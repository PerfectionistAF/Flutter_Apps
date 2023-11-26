import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common/sqflite.dart';
//import 'package:sqflite_common/sqflite_dev.dart';
//import 'package:sqflite_common/sqflite_logger.dart';
//import 'package:sqflite_common/sql.dart';
//import 'package:sqflite_common/sqlite_api.dart';

class mydatabaseclass {
  Database? mydb;

  Future<Database?> mydbcheck() async {
    if (mydb == null) {
      mydb = await initiatedatabase();
      return mydb;
    } else {
      return mydb;
    }
  }

  int Version = 1;
  initiatedatabase() async {
    String databasedestination = await getDatabasesPath();
    String databasepath = join(databasedestination, 'CARDS.db');
    Database mydatabase1 = await openDatabase(
      databasepath,
      version: Version,
      onCreate: (db, version) {
        db.execute('''CREATE TABLE IF NOT EXISTS 'TABLE1'(
      'INDEX' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      'NAME' TEXT NOT NULL,
      'COMPANY' TEXT NOT NULL,
      'EMAIL' TEXT MOT NULL)
       ''');
        print("Database has been created");
      },
    );
    return mydatabase1;
  }

  checking() async {
    String databasedestination = await getDatabasesPath();
    String databasepath = join(databasedestination, 'CARDS.db');
    await databaseExists(databasepath) ? print("EXISTENT") : print("NONEXISTENT");
  }

  reseting() async {
    String databasedestination = await getDatabasesPath();
    String databasepath = join(databasedestination, 'CARDS.db');
    await deleteDatabase(databasepath);
  }

  reading(sql) async {
    Database? somevariable = await mydbcheck();
    var response = somevariable!.rawQuery(sql);
    return response;
  }

  writing(sql) async {
    Database? somevariable = await mydbcheck();
    var response = somevariable!.rawInsert(sql);
    return response;
  }

  deleting(sql) async {
    Database? somevariable = await mydbcheck();
    var response = somevariable!.rawDelete(sql);
    return response;
  }

  updating(sql) async {
    Database? somevariable = await mydbcheck();
    var response = somevariable!.rawUpdate(sql);
    return response;
  }
}
