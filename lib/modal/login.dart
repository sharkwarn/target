import 'package:flutter/material.dart';

class LoginModal with ChangeNotifier {
  bool isLogin = false;

  bool get value => isLogin;
  
  void changeStatus(bool login) {
    isLogin = login;
    notifyListeners();
  }
}