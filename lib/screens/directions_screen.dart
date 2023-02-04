import 'package:flutter/material.dart';

import '../widgets/customListView.dart';

class DirectionsScreen extends StatelessWidget {
  const DirectionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomListView(
      icon: Icons.ad_units_rounded,
    );
  }
}
