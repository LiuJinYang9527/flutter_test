import "package:flutter/material.dart";

class CurrentIndexPrvide with ChangeNotifier {
  int currentIndex = 0;

  changeIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();        
  }
}
