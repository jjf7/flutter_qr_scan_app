import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/scan_model.dart';
import '../providers/scan_list_provider.dart';
import '../utils/utils.dart';

class CustomScanButton extends StatelessWidget {
  const CustomScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color.fromARGB(255, 180, 43, 205),
      radius: 40,
      child: IconButton(
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        iconSize: 40,
        color: Colors.white,
        icon: const Icon(Icons.qr_code_scanner_sharp),
        onPressed: () async {
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              '#72c02c', 'Cancel', false, ScanMode.QR);

          if (barcodeScanRes == '-1') return;

          final scanListProvider =
              Provider.of<ScanListProvider>(context, listen: false);

          final scan = await scanListProvider.addScan(barcodeScanRes);

          launchWebsite(scan, context);
        },
      ),
    );
  }
}
