import 'package:flutter/material.dart';

import '../widgets/customListView.dart';

class MapasScreen extends StatelessWidget {
  const MapasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomListView(
      icon: Icons.map_outlined,
    );
  }
}
