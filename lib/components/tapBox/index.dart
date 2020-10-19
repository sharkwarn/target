import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';

class TapBox extends StatefulWidget{
  TapBox({
    Key key,
    this.active: false,
    this.child,
    @required this.onTap
  }) : super(key: key);
  final bool active;
  final GestureTapCallback onTap;
  final Widget child;
  _TapBox createState() => _TapBox();
}


class _TapBox extends State<TapBox> {
  // bool _highligth = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      // _highligth = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      // _highligth = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      // _highligth = false;
    });
  }

  void _handleTap() {
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp, 
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: widget.child,
    );
  }
}