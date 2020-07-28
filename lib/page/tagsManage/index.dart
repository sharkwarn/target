/// 这是一个有状态组件，有状态组件必须由两部分构成。StatefulWidget 和 State

import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import '../../components/colorPicker/index.dart';
import '../../globalData/index.dart';
import '../../types/index.dart';
import '../../utils/colorsUtil.dart';



class TagsManage extends StatefulWidget {
  _TagsManage createState() => new _TagsManage();
}

class _TagsManage extends State {

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
    print(1111);
    print(name);
    print(color);
    final res = await GlobalData.addTag(
      name, 
      color
    );
    if (res) {
      Navigator.pop(context);
      _getList();
    }
  }
  
  _getList() async {
    print('重新加载数据');
    final _lists = await GlobalData.getTagsList();
    print(111111111);
    print(_lists);
    final lists = _lists.map((item)=>Tag.fromMap(item)).toList();
    setState(() {
      tags = lists;
    });
  }

  _createTag() async {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {},
      barrierColor: Colors.grey.withOpacity(.4),
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: Duration(milliseconds: 60),
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.scale(
          scale: anim1.value,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(20))
            ),
            title: Center(
              child: Text('创建标签'),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: ListView(
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
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
                            ],
                          ),
                        ),
                        ColorPicker(
                          onChange: (val) {
                            print(val);
                            setState(() {
                              print(val);
                              color = val;
                            });
                          }
                        )
                      ]
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CupertinoButton(
                        child: Text('取消'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoButton(
                        child: Text('保存'),
                        onPressed: (){
                          if (_formKey.currentState.validate()) {
                            // Process data.
                            _formKey.currentState.save();
                            _submit();
                          }
                        },
                      )
                    ],
                  )
                ]
              ),
            ),
          ),
        );
      }
    );
  }

  
  @override
  Widget build(BuildContext context) {
    final List<Widget> lists = tags.map<Widget>((item) {
      final String name = item.name;
      final String color = item.color;
      print('name:::::::::::::');
      print(item);
      return Card(
        child: Container(
          color: ColorsUtil.hexStringColor(color),
          child: Text(name)
        )
      );
    }).toList();
    return new Scaffold(
        appBar: new AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(''),
              Text('创建标签'),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _createTag();
                },
              )
            ],
          )
        ),
        body: ListView(children: lists,)
      );
  }
}
