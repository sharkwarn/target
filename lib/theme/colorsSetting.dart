/// @file 定义颜色配置
import 'package:flutter/material.dart';

class ThemeColors {
  static const List colors = [
    {
      "name": "微信",
      "color": "#09BB07"
    },
    {
      "name": "支付宝",
      "color": "#1890ff"
    },
    {
      "name": "淘宝",
      "color": "#ff4200"
    },
    {
      "name": "网易云",
      "color": "#ff3a3a"
    },
    {
      "name": "可爱",
      "color": "#66CCCC"
    },
    {
      "name": "可爱",
      "color": "#CCFF66"
    },
    {
      "name": "可爱",
      "color": "#FF99CC"
    },
    {
      "name": "可爱",
      "color": "#FF9999"
    },
    {
      "name": "可爱",
      "color": "#FFCC99"
    },
    {
      "name": "可爱",
      "color": "#FF6666"
    },
    {
      "name": "可爱",
      "color": "#FFFF66"
    },
    {
      "name": "可爱",
      "color": "#99CC66"
    },
    {
      "name": "可爱",
      "color": "#666699"
    },
    {
      "name": "可爱",
      "color": "#FF9999"
    },
    {
      "name": "可爱",
      "color": "#99CC33"
    },
    {
      "name": "可爱",
      "color": "#FF9900"
    },
    {
      "name": "可爱",
      "color": "#FFCC00"
    },
    {
      "name": "可爱",
      "color": "#FF0033"
    },
    {
      "name": "可爱",
      "color": "#FF9966"
    },
    {
      "name": "可爱",
      "color": "#FF9900"
    },
    {
      "name": "可爱",
      "color": "#CCFF00"
    },
    {
      "name": "可爱",
      "color": "#CC3399"
    },
    {
      "name": "可爱",
      "color": "#99CC33"
    },
    {
      "name": "可爱",
      "color": "#FF6600"
    },
    {
      "name": "可爱",
      "color": "#FF6666"
    },
    {
      "name": "可爱",
      "color": "#FFFF00"
    },
    {
      "name": "可爱",
      "color": "#3399CC"
    },
    {
      "name": "可爱",
      "color": "#FF0033"
    },
    {
      "name": "可爱",
      "color": "#993399"
    },
    {
      "name": "可爱",
      "color": "#FF99CC"
    }
  ];
}


// class StatusColors {
//   static Color success = Color(0xFF4ACA6D);
//   static Color warn = Color(0xFFFF9B00);
//   static Color fail = Color(0xFFFD3204);
// }

final Map<String, Color> statusColors = {
  'sign': Color(0xFF4ACA6D),
  'holiday': Color(0xFFFD3204),
  'autoHoliday': Color(0xFFFD3204),
  'nosign': Color(0xFFFD3204),
  'create': Colors.blue[600],
  'done': Color(0xFFFF9B00),
  'fail': Color(0xFFFF9B00),
  'stop': Color(0xFFFF9B00),
  'delete': Color(0xFFFF9B00),
};

final Map<String, String> statusDesc = {
  'sign': '签到',
  'holiday': '休假',
  'nosign': '未签到',
  'create': '创建',
  'done': '完成',
  'fail': '失败',
  'stop': '停止',
  'delete': '删除',
  'autoHoliday': '休假',
};