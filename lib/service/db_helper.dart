import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:userintegration_sqflite/model/usermodel.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._instance();
  static Database _db;

  DBHelper._instance();

  static const String Id = 'id';
  static const String Name = 'userName';
  static const String Email = 'email';
  static const String DOB = 'dob';
  static const String Address = 'address';
  static const String Password = 'password';
  static const String Table = 'Users';
  static const String DB_Name = 'users_db';

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
    } else {
      print('Database Name : $_db');
      print('Database Check : ${_db.isOpen}');
    }
    return _db;
  }

  _initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, DB_Name);
    final db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $Table ($Id integer primary key autoincrement, $Name TEXT, $Email TEXT,$DOB TEXT,$Address TEXT,$Password TEXT)');
  }

  Future<List<Map<String, dynamic>>> getAllUserMap() async {
    Database dbClient = await db;
    final List<Map<String, dynamic>> result = await dbClient.query(Table);
    print('Get all user map result : $result');
    return result;
  }

  Future<List<UserModel>> getAllUserList() async {
    final List<Map<String, dynamic>> userMapList = await getAllUserMap();
    List<UserModel> userList = [];
    userMapList.forEach((userMap) {
      userList.add(UserModel.fromMap(userMap));
    });
    userList.sort((userA, userB) => userA.id.compareTo(userB.id));
    print('Get all user list result : $userList');
    return userList;
  }

  Future<int> addUser(UserModel userModel) async {
    Database dbClient = await db;
    final int result = await dbClient.insert(Table, userModel.userMap());
    print('Add user result : $result');
    return result;
  }

  Future<int> updateUser(UserModel userModel) async {
    Database dbClient = await db;
    final int result = await dbClient.update(
      Table,
      userModel.userMap(),
      where: '$Id = ?',
      whereArgs: [userModel.id],
    );
    print('Update user result : $result');
    return result;
  }

  Future<int> deleteUser(int id) async {
    Database dbClient = await db;
    final int result =
        await dbClient.delete(Table, where: '$Id = ?', whereArgs: [id]);
    print('Delete user result : $result');
    return result;
  }

  Future<List<Map<String, dynamic>>> searchUser(userName) async {
    Database dbClient = await db;
    return await dbClient.query(Table, where: '$Name LIKE ?',whereArgs: [userName]);
  }

// Future close() async {
//   Database? dbClient = await db;
//   return dbClient!.close();
// }
}
