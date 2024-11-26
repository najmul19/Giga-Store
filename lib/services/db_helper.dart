// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class DBHelper {
//   static Database? _db;

//   Future<Database> get db async {
//     if (_db != null) return _db!;
//     _db = await initDB();
//     return _db!;
//   }

//   initDB() async {
//     var databasesPath = await getDatabasesPath();
//     String path = join(databasesPath, 'products.db');

//     return await openDatabase(path, version: 1, onCreate: (db, version) async {
//       await db.execute('''
//         CREATE TABLE products (
//           id INTEGER PRIMARY KEY AUTOINCREMENT,
//           name TEXT,
//           image TEXT,
//           price TEXT,
//           detail TEXT,
//           category TEXT
//           status TEXT,
//           user_email TEXT
//         )
//       ''');
//     });
//   }

//   Future<int> insertProduct(Map<String, dynamic> product) async {
//     final dbClient = await db;
//     return await dbClient.insert('products', product);
//   }


// //   Future<int> updateProduct(Map<String, dynamic> product, int id) async {
// //   final dbClient = await db;
// //   return await dbClient.update('products', product, where: 'id = ?', whereArgs: [id]);
// // }
// // Future<int> deleteProduct(int id) async {
// //   final dbClient = await db;
// //   return await dbClient.delete('products', where: 'id = ?', whereArgs: [id]);
// // }


  
// }
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'products.db');

    return await openDatabase(
      path,
      version: 2, // Incremented version
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            image TEXT,
            price TEXT,
            detail TEXT,
            category TEXT,
            status TEXT,
            user_email TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE products ADD COLUMN user_email TEXT');
        }
      },
    );
  }

  Future<int> insertProduct(Map<String, dynamic> product) async {
    final dbClient = await db;
    return await dbClient.insert('products', product);
  }
}
