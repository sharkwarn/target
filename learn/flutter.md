
# flutter 常用方法总结。

### 设置TextFormField 默认值

```dart
TextFormField(
    decoration: const InputDecoration(
        hintText: '标签名称',
        // border: InputBorder.none,
    ),
    validator: (value) {
        if (value.isEmpty) {
        return '请输入标签名称';
        }
        return null;
    },
    controller: new TextEditingController(text: widget.name),
    onSaved: (val) {
        name = val;
    },
)
```

### TextStyle 属性

```dart
const TextStyle({
    this.inherit: true,         // 为false的时候不显示
    this.color,                    // 颜色 
    this.fontSize,               // 字号
    this.fontWeight,           // 字重，加粗也用这个字段  FontWeight.w700
    this.fontStyle,                // FontStyle.normal  FontStyle.italic斜体
    this.letterSpacing,        // 字符间距  就是单个字母或者汉字之间的间隔，可以是负数
    this.wordSpacing,        // 字间距 句字之间的间距
    this.textBaseline,        // 基线，两个值，字面意思是一个用来排字母的，一人用来排表意字的（类似中文）
    this.height,                // 当用来Text控件上时，行高（会乘以fontSize,所以不以设置过大）
    this.decoration,        // 添加上划线，下划线，删除线 
    this.decorationColor,    // 划线的颜色
    this.decorationStyle,    // 这个style可能控制画实线，虚线，两条线，点, 波浪线等
    this.debugLabel,
    String fontFamily,    // 字体
    String package,
})
```


### flutter 绘制一个动画

```dart
import 'package:flutter/material.dart';


class AniWave extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _AniWave();
  }
}

class _AniWave extends State<AniWave> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;
  
  @override
  void initState() {
    super.initState();
    // 创建 AnimationController 对象
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 2000)
    );
    // 通过 Tween 对象 创建 Animation 对象
    animation = Tween(begin: 50.0, end: 200.0).animate(controller)
      ..addListener(() {
        // 注意：这句不能少，否则 widget 不会重绘，也就看不到动画效果
        setState(() {});
      });
    // 执行动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // 获取动画的值赋给 widget 的宽高
      width: animation.value,
      height: animation.value,
      decoration: BoxDecoration(
          color: Colors.redAccent
      ),
    );
  }

  @override
  void dispose() {
    // 资源释放
    controller.dispose();
    super.dispose();
  }
}
```

### 颜色16进制透明度

```
记录颜色十六进制透明度
100% — FF
99% — FC
98% — FA
97% — F7
96% — F5
95% — F2
94% — F0
93% — ED
92% — EB
91% — E8
90% — E6
89% — E3
88% — E0
87% — DE
86% — DB
85% — D9
84% — D6
83% — D4
82% — D1
81% — CF
80% — CC
79% — C9
78% — C7
77% — C4
76% — C2
75% — BF
74% — BD
73% — BA
72% — B8
71% — B5
70% — B3
69% — B0
68% — AD
67% — AB
66% — A8
65% — A6
64% — A3
63% — A1
62% — 9E
61% — 9C
60% — 99
59% — 96
58% — 94
57% — 91
56% — 8F
55% — 8C
54% — 8A
53% — 87
52% — 85
51% — 82
50% — 80
49% — 7D
48% — 7A
47% — 78
46% — 75
45% — 73
44% — 70
43% — 6E
42% — 6B
41% — 69
40% — 66
39% — 63
38% — 61
37% — 5E
36% — 5C
35% — 59
34% — 57
33% — 54
32% — 52
31% — 4F
30% — 4D
29% — 4A
28% — 47
27% — 45
26% — 42
25% — 40
24% — 3D
23% — 3B
22% — 38
21% — 36
20% — 33
19% — 30
18% — 2E
17% — 2B
16% — 29
15% — 26
14% — 24
13% — 21
12% — 1F
11% — 1C
10% — 1A
9% — 17
8% — 14
7% — 12
6% — 0F
5% — 0D
4% — 0A
3% — 08
2% — 05
1% — 03
0% — 00
```
