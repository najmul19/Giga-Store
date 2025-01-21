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

// await deleteDatabase(path);
    return await openDatabase(
      path,
      version: 4,
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

        await db.execute('''
        CREATE TABLE orders (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          product_id INTEGER,
          product_name TEXT,
          user_email TEXT,
          quantity INTEGER,
          total_price TEXT,
          date TEXT
        )
      ''');

        await db.execute('''
        CREATE TABLE cart (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          image TEXT,
          price TEXT,
          quantity INTEGER,
          detail TEXT,
          category TEXT,
          status TEXT,
          user_email TEXT
        )
      ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
  if (oldVersion < 4) {
    await db.execute('''
    id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          image TEXT,
          price TEXT,
          quantity INTEGER,
          detail TEXT,
          category TEXT,
          status TEXT,
          user_email TEXT
    )
    ''');
  }
},

    );
  }
  

  Future<int> insertProduct(Map<String, dynamic> product) async {
    final dbClient = await db;
    return await dbClient.insert('products', product);
  }



Future<int> insertCart(Map<String, dynamic> cart) async {
  final dbClient = await db;
  return await dbClient.insert('cart', cart);
}



  Future<int> insertOrder(Map<String, dynamic> order) async {
    final dbClient = await db;
    return await dbClient.insert('orders', order);
  }

  Future<List<Map<String, dynamic>>> fetchOrders(String userEmail) async {
    final dbClient = await db;
    return await dbClient.query(
      'orders',
      where: 'user_email = ?',
      whereArgs: [userEmail],
    );
  }
  Future<List<Map<String, dynamic>>> fetchAllOrders() async {
    final dbClient = await db;
    return await dbClient.query('orders'); // Fetch all orders without filtering
  }
}
