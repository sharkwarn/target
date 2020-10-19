import 'package:flutter/material.dart';
import 'package:toBetter/page/taskDetail/index.dart';

class ListModal with ChangeNotifier {
  List<TaskDetail> _list = [];
  List<TaskDetail> get value => _list;

  void setList(List<TaskDetail> list) {
    _list = list;
    notifyListeners();
  }
}