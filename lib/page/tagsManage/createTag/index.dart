
import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import '../../../components/colorPicker/index.dart';
import '../../../utils/request/index.dart';
import '../../../config.dart';



class CreateTags extends StatefulWidget {

  CreateTags({
    Key key,
    this.tagId,
    this.name,
    this.color
  }) : super(key: key);

  final int tagId;
  final String name;
  final String color;

  _CreateTags createState() => new _CreateTags();
}

class _CreateTags extends State<CreateTags> {

  String name = '';

  String color = '';



  final _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    print(widget.name);
    name = widget.name ?? '';
    color = widget.color ?? '';
  }

  _submit() async {
    final String action = widget.tagId != null ? '/tag/edit' : '/tag/create';
    final params = {
      'name': name,
      'color': color,
      'tagId': widget.tagId
    };
    final result = await Request.post(Urls.env + action, params);
    if (result != null && result['success'] == true) {
      Navigator.pop(context, 'create');
    }
  }
  


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(''),
            Text('标签'),
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
                )
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                child: Text(
                  '选择标签的颜色:',
                  style: TextStyle(
                    fontSize: 16
                  ),
                )
              )
            ],
          ),
          ColorPicker(
            value: color,
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
