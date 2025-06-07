import 'package:sqflite/sqflite.dart';
import 'db.dart';

class VehicleDAO {
  Future<List<Map<String, dynamic>>> getAllVehicles() async {
    final db = await LocalDatabase.database;
    return await db.query('vehicles');
  }

  Future<void> insertVehicle(String plate, String model) async {
    final db = await LocalDatabase.database;
    await db.insert('vehicles', {'plate': plate, 'model': model});
  }

  Future<void> deleteVehicle(int id) async {
    final db = await LocalDatabase.database;
    await db.delete('vehicles', where: 'id = ?', whereArgs: [id]);
  }
}