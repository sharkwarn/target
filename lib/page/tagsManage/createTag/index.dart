
import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import '../../../components/colorPicker/index.dart';
import '../../../globalData/index.dart';
import '../../../types/index.dart';
import '../../../utils/colorsUtil.dart';



class CreateTags extends StatefulWidget {
  _CreateTags createState() => new _CreateTags();
}

class _CreateTags extends State {

  String name = '';

  String color = '';

  List<Tag> tags = [];


  final _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    _getList();
  }

  _submit() async {
    final res = await GlobalData.addTag(
      name, 
      color
    );
    if (res) {
      Navigator.pop(context, 'create');
      _getList();
    }
  }
  
  _getList() async {
    final _lists = await GlobalData.getTagsList();
    final lists = _lists.map((item)=>Tag.fromMap(item)).toList();
    setState(() {
      tags = lists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(''),
            Text('创建标签'),
            CupertinoButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  // Process data.
                  _formKey.currentState.save();
                  _submit();               
                }
              },
              child: new Text(
                '保存',
                style: TextStyle(
                  color: Colors.white
                ),
              )
            )
          ],
        )
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: '标签名称',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '请输入标签名称';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      name = val;
                    },
                  )
                )
              ],
            ),
          ),
          ColorPicker(
            onChange: (val) {
              setState(() {
                color = val;
              });
            }
          )
        ],
      )
    );
  }
}
