

import 'package:flutter/material.dart';

abstract class IconsGet {

  static List<IconData> getIconList() {
    return [
      Icons.menu
    ];
  }

  static IconData get(String type) {
    switch(type) {
      case 'menu':
        return Icons.menu;
      default:
        return Icons.note;
    }
  }
}