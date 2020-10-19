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
      return Container(
        width: MediaQuery.of(context).size.width * 0.50,
        height: 64,
        child: TapBox(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.50,
                height: 64,
                margin: EdgeInsets.fromLTRB(12, 8, 12, 8),
                color: ColorsUtil.hexStringColor(_color)
              ),
              Offstage(
                offstage: color != _color,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: 64,
                  child: Center(
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 44,
                    ),
                  ),
                ),
              ),
            ],
          ),
          onTap: () {
            setState(() {
              color = _color;
              if (widget.onChange != null) {
                widget.onChange(color);
              }
            });
          },
        )
      );
    }).toList();
    return Container(
      child: Wrap(
        children: tags,
      )
    );
  }

}