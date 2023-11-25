/*import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Database {
  Database? mydb;

  //add get and remove brackets to make the function into a Singleton function
  //***get mydbcheck async */
  Future<Database?> mydbcheck () async { //future operation means that the results are yielded in the future
    if (mydb == null) {
      mydb = await initialise();//initialise database class fields and methods 
      return mydb;
    } else {
      return mydb;
    }
  }

  int Version = 1;
  //to add data , either change the version to allow new create of another version old table instead of update
  //update works on records from now forth, older ones no, as well as insert 
  //drop database and recreate or copy 
  initialise() async { //don't run until future operation is done
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'userfile.db');  ///name the database
    Database myMainData = await openDatabase(path, version:Version,
    onCreate:(db, Version){ //on first time
      db.execute('''CREATE TABLE IF NOT EXIST 'USERTABLE'(
        'ID' INTEGER NOT NULL PRIMARY KEY,
        'NAME' TEXT NOT NULL,
        'GPA' TEXT NOT NULL) ''');
      }
      );       //open the db now

    return myMainData;

  }

    reseting() async {
    String databasedestination = await getDatabasesPath();
    String databasepath = join(databasedestination, 'mydatabase22.db');
    await deleteDatabase(databasepath);
  } //no 5

  reading(sql) async {
    Database? somevariable = await mydbcheck();
    Future <List<Map>> response = somevariable!.rawQuery(sql);
    return response;
  }  //no 1 

  writing(sql) async {
    Database? somevariable = await mydbcheck();
    bool response = somevariable!.rawInsert(sql);
    return response;
  } //no 2

  deleting(sql) async {
    Database? somevariable = await mydbcheck();
    bool response = somevariable!.rawDelete(sql);
    return response;
  }//no 3

  updating(sql) async {
    Database? somevariable = await mydbcheck();
    var response = somevariable!.rawUpdate(sql);
    return response;
  }//no 4 

  ifexist() async {
    String databasePath = await getDatabasesPath();
    String path = join(dbPath, 'userfile.db');
    await databaseExists(databasepath) ? print("database exists") : print("database doesn't exist")
  }
}*/