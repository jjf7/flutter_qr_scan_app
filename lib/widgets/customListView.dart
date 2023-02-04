import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../providers/scan_list_provider.dart';
import '../utils/utils.dart';

class CustomListView extends StatelessWidget {
  final IconData icon;

  const CustomListView({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);

    final scanList = scanListProvider.scans;

    return ListView.builder(
      itemCount: scanList.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          background: Container(
            decoration: const BoxDecoration(color: Colors.red),
          ),
          onDismissed: (direction) {
            Provider.of<ScanListProvider>(context, listen: false)
                .deleteScanById(scanList[index].id!);
          },
          child: ListTile(
            leading: Icon(icon, color: Theme.of(context).primaryColor),
            title: Text(scanList[index].valor),
            subtitle: Text(
              'id: ${scanList[index].id}',
              style: const TextStyle(color: Colors.grey),
            ),
            trailing: const Icon(Icons.arrow_circle_right_outlined),
            onTap: () async {
              launchWebsite(scanList[index], context);
            },
          ),
        );
      },
    );
  }
}
