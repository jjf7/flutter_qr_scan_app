import 'package:flutter/material.dart';
import 'package:qr_scanner_app_flutter/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> addScan(String valor) async {
    final scan = ScanModel(valor: valor);

    final id = await DBProvider.db.addScan(scan);

    scan.id = id;

    if (scan.tipo == tipoSeleccionado) {
      scans.add(scan);
      notifyListeners();
    }

    return scan;
  }

  getAllScans() async {
    final res = await DBProvider.db.getAllScans();
    scans = [...res];
    notifyListeners();
  }

  getScansByType(String tipo) async {
    final res = await DBProvider.db.getScansByType(tipo);
    scans = res;
    tipoSeleccionado = tipo;
    notifyListeners();
  }

  deleteScanById(int id) async {
    await DBProvider.db.deleteScanById(id);
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }
}
