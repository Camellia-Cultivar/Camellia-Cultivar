import 'dart:io';
import 'package:camellia_cultivar/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

enum Table {  
  users
}

class DatabaseHelper {  
  static final _databaseName = "camellia_database.db";
  static final _databaseVersion = 1;

  // torna esta classe singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  // tem somente uma referência ao banco de dados
  static Database? _database;

  Future<Database> get database async  => _database ??= await _initDatabase();
  
  // abre o banco de dados e o cria se ele não existir
  _initDatabase() async {
    String documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }
  // Código SQL para criar o banco de dados e a tabela
  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE users(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, email TEXT, password TEXT)',
      );
  }  
  // métodos Helper
  //----------------------------------------------------
  // Insere uma linha no banco de dados onde cada chave 
  // no Map é um nome de coluna e o valor é o valor da coluna. 
  // O valor de retorno é o id da linha inserida.
  Future<int> insert(String table, Map<String, dynamic> row) async {
    print(json.encode(row));

    Database? db = await instance.database;
    return db.insert(table, row);
  }
  // Todas as linhas são retornadas como uma lista de mapas, onde cada mapa é
  // uma lista de valores-chave de colunas.
  // Future<List<Map<String, dynamic>>> queryAllRows() async {
  //   Database db = await instance.database;
  //   return await db.query(table);
  // }
  // Todos os métodos : inserir, consultar, atualizar e excluir, 
  // também podem ser feitos usando  comandos SQL brutos. 
  // Esse método usa uma consulta bruta para fornecer a contagem de linhas.
  // Future<int?> queryRowCount() async {
  //   Database db = await instance.database;
  //   return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  // }
  // Assumimos aqui que a coluna id no mapa está definida. Os outros
  // valores das colunas serão usados para atualizar a linha.

  Future<User?> getUser(String email) async {
    Database db = await instance.database;
    List<Map> maps = await db.query("users",
        where: 'email = ?',
        whereArgs: [email]);
    if (maps.isNotEmpty) {
      Map first = maps.first;
      return User(id: first["id"], email: first["email"], firstName: first["firstName"], lastName: first["lastName"], password: first["password"] );
    }
    return null;
  }


  Future<int> update(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row["id"];
    return await db.update(table, row, where: 'id', whereArgs: [id]);
  }

  Future<int> delete(String table, int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: 'id', whereArgs: [id]);
  }
}