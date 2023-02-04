import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

import 'package:qr_scanner_app_flutter/providers/ui_provider.dart';
import 'package:qr_scanner_app_flutter/screens/directions_screen.dart';
import 'package:qr_scanner_app_flutter/screens/mapas_screen.dart';

import '../providers/scan_list_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    if (uiProvider.indice == 0) {
      scanListProvider.getScansByType('geo');
    } else {
      scanListProvider.getScansByType('http');
    }

    List<Widget> widgetsToRender = <Widget>[
      const MapasScreen(),
      const DirectionsScreen()
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Text("Historial",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: widgetsToRender[uiProvider.indice],
        ),
      ],
    );
  }
}
