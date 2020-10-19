import 'package:flutter/material.dart';

class CounterModel with ChangeNotifier {
  bool _isLogin = false;
  bool get value => _isLogin;

  void increment(bool flag) {
    print('改变值了');
    _isLogin = flag;
    notifyListeners();
  }
}