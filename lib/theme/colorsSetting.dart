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
      "name": "",
      "color": "#FF9999"
    },
    {
      "name": "",
      "color": "#996699"
    },
    {
      "name": "",
      "color": "#FF9966"
    },
    {
      "name": "",
      "color": "#FF6666"
    },
    {
      "name": "",
      "color": "#99CC66"
    },
    {
      "name": "",
      "color": "#CC3333"
    },
    {
      "name": "",
      "color": "#CCFF99"
    },
    {
      "name": "",
      "color": "#0099CC"
    },
    {
      "name": "",
      "color": "#CC6699"
    },
    {
      "name": "",
      "color": "#009966"
    },
    {
      "name": "",
      "color": "#9933FF"
    },
    {
      "name": "",
      "color": "#99CCFF"
    },
    {
      "name": "",
      "color": "#FFCC00"
    },
    {
      "name": "",
      "color": "#990033"
    },
    {
      "name": "",
      "color": "#FF99CC"
    },
    {
      "name": "",
      "color": "#CCCCFF"
    },
    {
      "name": "",
      "color": "#CCCC99"
    },
    {
      "name": "",
      "color": "#CC99CC"
    },
    {
      "name": "",
      "color": "#FF9933"
    },
    {
      "name": "",
      "color": "#66CC99"
    },
    {
      "name": "",
      "color": "#99CCCC"
    },
    {
      "name": "",
      "color": "#FF3399"
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
  'restart': Colors.blue[600],
  'done': Color(0xFFFF9B00),
  'fail': Color(0xFFFF9B00),
  'stop': Color(0xFFFF9B00),
  'delete': Color(0xFFFF9B00),
};

final Map<String, String> statusDesc = {
  'sign': '打卡',
  'ongoing': '进行中',
  'holiday': '休假',
  'nosign': '未签到',
  'create': '创建',
  'restart': '重新开始',
  'done': '完成',
  'success': '完成',
  'fail': '失败',
  'stop': '停止',
  'delete': '删除',
  'autoHoliday': '系统自动休假',
};