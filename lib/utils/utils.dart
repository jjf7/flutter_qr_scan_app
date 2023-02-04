import 'package:flutter/cupertino.dart';
import 'package:qr_scanner_app_flutter/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchWebsite(ScanModel scan, BuildContext context) async {
  final Uri url = Uri.parse(scan.valor);

  if (scan.tipo == 'http') {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
