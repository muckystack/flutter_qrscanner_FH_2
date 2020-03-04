import 'dart:async';

import 'package:qrreaderappfh/src/providers/db_provider.dart';

class ScansBloc {
  
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    // Obtener Scans de la Base de datos
  }

  // Se pone el .broadcast() por que se va ha estar utilizando en varios ligares
  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream;

  dispose() {
    // El ? es una validación por si no existe ningun objeto
    _scansController?.close();
  }

}