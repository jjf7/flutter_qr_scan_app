import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_scanner_app_flutter/providers/scan_list_provider.dart';
import 'package:qr_scanner_app_flutter/providers/ui_provider.dart';
import 'package:qr_scanner_app_flutter/screens/mapa_screen.dart';
import 'package:qr_scanner_app_flutter/screens/screens.dart';

import 'widgets/custom_bottom_navigation_bar.dart';
import 'widgets/custom_scan_button.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (context) => ScanListProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //DBProvider.db.deleteAllScans();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR SCANNER',
      initialRoute: 'home',
      routes: {
        'home': (context) => _Home(),
        'mapa': ((context) => const MapaScreen()),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
      ),
    );
  }
}

class _Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('QR Scan by JFdeSousa',
            style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(
              Icons.delete_forever,
              size: 30,
            ),
            onPressed: () async =>
                Provider.of<ScanListProvider>(context, listen: false)
                    .deleteAllScans(),
          ),
        ],
      ),
      body: const HomeScreen(),
      bottomNavigationBar: CustomNavigationBar(uiProvider: uiProvider),
      floatingActionButton: const CustomScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
