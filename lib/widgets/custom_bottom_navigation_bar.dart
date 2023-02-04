import 'package:flutter/material.dart';

import '../providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    Key? key,
    required this.uiProvider,
  }) : super(key: key);

  final UiProvider uiProvider;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      type: BottomNavigationBarType.shifting,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey[300],
      items: const [
        BottomNavigationBarItem(
          backgroundColor: Color.fromARGB(255, 224, 50, 239),
          activeIcon: Icon(Icons.map_outlined),
          icon: Icon(
            Icons.map_rounded,
          ),
          label: "Map",
        ),
        BottomNavigationBarItem(
          backgroundColor: Color.fromARGB(255, 121, 65, 233),
          activeIcon: Icon(Icons.wifi_1_bar),
          icon: Icon(
            Icons.wifi_2_bar_outlined,
          ),
          label: "Direcctions",
        )
      ],
      onTap: (int i) {
        print(i);
        uiProvider.indice = i;
      },
      currentIndex: uiProvider.indice,
    );
  }
}
