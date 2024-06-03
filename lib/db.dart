import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'note.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    db.batch();
    await db.batch().commit();

    print("====> On Upgrade Called <=====================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "notes" (
      "id" INTEGER PRIMARY KEY AUTOINCREMENT,
      "title" TEXT NOT NULL,
      "content" TEXT,
      "color" VARCHAR(50) DEFAULT 'white'
    )
    ''');
    print("====> On Create Called <=====================");
  }

  // SELECT
  Future<List<Map>> readData(sql) async {
    Database? mydb = await db;
    Future<List<Map>> response = mydb!.rawQuery(sql);
    return response;
  }

  // INSERT
  Future<int> insertData(sql) async {
    Database? mydb = await db;
    Future<int> response = mydb!.rawInsert(sql);
    return response;
  }

  // UPDATE
  Future<int> updateData(sql) async {
    Database? mydb = await db;
    Future<int> response = mydb!.rawUpdate(sql);
    return response;
  }

  // DELETE
  Future<int> deleteData(sql) async {
    Database? mydb = await db;
    Future<int> response = mydb!.rawDelete(sql);
    return response;
  }

  // DATABASE DELETE
  // deleteDatabase() async {
  //   String databasePath = await getDatabasesPath();
  //   String path = join(databasePath, 'note.db');
  //   await databaseFactory.deleteDatabase(path);
  // }
}
