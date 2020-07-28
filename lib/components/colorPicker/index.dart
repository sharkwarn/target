import 'package:flutter/material.dart';
import '../tapBox/index.dart';
import '../../utils/colorsUtil.dart';
import '../../theme/colorsSetting.dart';


class ColorPicker extends StatefulWidget {
  ColorPicker({
    Key key,
    this.value,
    @required this.onChange
  }): super(key: key);

  final String value;

  final Function onChange;

  _ColorPicker createState() => new _ColorPicker();
}

class _ColorPicker extends State<ColorPicker> {

  String color = '';

  @override
  void initState() {
    super.initState();
    color = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tags = ThemeColors.colors.map<Widget>((item) {
      String _color = item['color'];
      return TapBox(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
              color: ColorsUtil.hexStringColor(_color)
            ),
            Offstage(
              offstage: color != _color,
              child: Icon(
                Icons.done,
                color: Colors.greenAccent
              )
            ),
          ],
        ),
        onTap: () {
          setState(() {
            color = _color;
            widget.onChange(color);
          });
        },
      );
    }).toList();
    return Wrap(
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 4.0, // gap between lines
      children: tags,
    );
  }

}