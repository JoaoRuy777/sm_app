import 'db.dart';

class UserDAO {
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await LocalDatabase.database;
    return await db.query('users');
  }

  Future<void> insertUser(String name, String role) async {
    final db = await LocalDatabase.database;
    await db.insert('users', {'name': name, 'role': role});
  }

  Future<void> deleteUser(int id) async {
    final db = await LocalDatabase.database;
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
