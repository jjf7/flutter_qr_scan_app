import 'package:flutter/cupertino.dart';

class UiProvider extends ChangeNotifier {
  int _indice = 0;

  int get indice {
    return _indice;
  }

  set indice(int i) {
    _indice = i;
    notifyListeners();
  }
}
