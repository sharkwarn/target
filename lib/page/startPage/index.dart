import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Image.asset(
            'images/background.jpg',
            fit: BoxFit.cover
          ),
        )
      ),
    );
  }
}