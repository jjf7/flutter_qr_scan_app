import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

import '../models/scan_model.dart';
export '../models/scan_model.dart';

class DBProvider {
  static Database? _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
                        CREATE TABLE scans(
                          id INTEGER PRIMARY KEY,
                          tipo TEXT,
                          valor TEXT
                        )
                      ''');
      },
    );
  }

  Future<int> addScan(ScanModel newRecord) async {
    final db = await database;
    final res = await db.insert('scans', newRecord.toJson());
    return res;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('scans');
    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;
    final res = await db.query('scans', where: 'tipo = ?', whereArgs: [type]);
    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<int> updateScan(ScanModel scanModel) async {
    final db = await database;
    final res = await db.update('scans', scanModel.toJson(),
        where: 'id = ?', whereArgs: [scanModel.id]);

    return res;
  }

  Future<int> deleteScanById(int id) async {
    final db = await database;
    final res = await db.rawDelete('''
          DELETE from scans where id=$id
      ''');

    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.delete('scans');
    print('all records have been deleted');
    return res;
  }
}
