import 'package:camellia_cultivar/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

enum Table { users }

class DatabaseHelper {
  static const _databaseName = "camellia_database.db";
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  _initDatabase() async {
    String documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE users(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, email TEXT, password TEXT, reputation INTEGER)',
    );
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    try {
      Database? db = await instance.database;
      return db.insert(table, row);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<User?> getUser(String email) async {
    try {
      Database db = await instance.database;
      List<Map> maps =
          await db.query("users", where: 'email = ?', whereArgs: [email]);
      if (maps.isNotEmpty) {
        Map first = maps.first;
        return User(
            id: first["id"],
            email: first["email"],
            firstName: first["firstName"],
            lastName: first["lastName"],
            password: first["password"],
            reputation: first["reputation"]);
      }
      return null;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<int> update(String table, Map<String, dynamic> row) async {
    try {
      Database db = await instance.database;
      int id = row["id"];
      return await db.update(table, row, where: 'id = ?', whereArgs: [id]);
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<int> delete(String table, int id) async {
    try {
      Database db = await instance.database;
      return await db.delete(table, where: 'id = ?', whereArgs: [id]);
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
