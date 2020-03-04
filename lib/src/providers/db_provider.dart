import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:qrreaderappfh/src/models/scan_model.dart';
export 'package:qrreaderappfh/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';


class DBProvider {
  
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {

    if(database != null) return database;

    _database = await initDB();
    return _database;

  }

  initDB() async {

    Directory documentDirectory = await getApplicationDocumentsDirectory(); // Obtenemos el path donde se encuentra la BD

    final path = join(documentDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Scans ('
          'id INTEGER PRIMARY KEY,'
          'tipo TEXT,'
          'valor TEXT'
          ')'
        );
      }
    );

  }


  // CREAR registros
  nuevoScanRaw(ScanModel nuevoScan) async {

    final db = await database;

    final res = await db.rawInsert(
      "INSERT Into Scans (id, tipo, valor) "
      "VALUES(${nuevoScan.id}, '${nuevoScan.tipo}', '${nuevoScan.valor}')"
    );

    return res;

  }

  nuevoScan(ScanModel nuevoScan) async {

    final db = await database;

    final res = await db.insert('Scans', nuevoScan.toJson());

    // print(res);

    return res;

  }


  // SELECT - Obtener información
  Future<ScanModel> getScanById(int id) async {

    final db = await database;

    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;

  }
  
  
  // SELECT - Obtener todos los registros
  Future<List<ScanModel>> getAllScans() async {

    final db = await database;

    final res = await db.query('Scans');

    List<ScanModel> list = res.isNotEmpty
                          ? res.map((c) => ScanModel.fromJson( c)).toList()
                          : [];

    return list;

  }
  
  
  // SELECT - Obtener todos los registros por tipo
  Future<List<ScanModel>> getAllScansByTipo(String tipo) async {

    final db = await database;

    final res = await db.rawQuery("SELECT * FROM Scans WHERE tipo=$tipo");

    List<ScanModel> list = res.isNotEmpty
                          ? res.map((c) => ScanModel.fromJson( c)).toList()
                          : [];

    return list;

  }
  
  
  // UPDATE
  Future<int> updateScan(ScanModel nuevoScan) async {

    final db = await database;

    final res = await db.update('Scans', nuevoScan.toJson(), where: 'id = ?', whereArgs: [nuevoScan.id]);

    return res;

  }
  
  
  // DELETE
  Future<int> deleteScan(int id) async {

    final db = await database;

    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return res;

  }
  
  
  // DELETE ALL
  Future<int> deleteAllScans() async {

    final db = await database;

    final res = await db.rawDelete('DELETE FROM Scans');

    return res;

  }

}