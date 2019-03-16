import "package:flutter/material.dart";

class Counter with ChangeNotifier {
  int value1 = 0;

  increment() {
    value1++;
    notifyListeners();
  }
}
