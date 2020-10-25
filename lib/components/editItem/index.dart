import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';

import '../../utils/request/index.dart';

import '../../config.dart';


class EditItem extends StatefulWidget {
  EditItem({
    Key key,
    this.label,
    this.value,
    this.taskId,
    this.valueKey,
    this.callback,
  }) : super(key: key);

  final int taskId;
  final String label;
  final String value;
  final String valueKey;
  final callback;
  @override
  _EditItem createState() => _EditItem();
}


class _EditItem extends State<EditItem> {
  bool editing = false;

  String newValue = '';

  @override
  void initState() {
    super.initState();
    newValue = widget.value;
  }


  _updateTask(String _value) async {
    final key = widget.valueKey;
    final value = _value;
    final params = {key: value, 'taskId': widget.taskId};
    final result = await Request.post(Urls.env + '/task/edit', params);
    if (result != null && result['success'] == true) {
      widget.callback();
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Offstage(
            offstage: editing,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(widget.label + ':' + widget.value),
                ),
                Container(
                  child: CupertinoButton(
                    onPressed: () {
                      setState(() {
                        editing = true;
                      });
                    },
                    child: Text('编辑'),
                  ),
                )
              ],
            ),
          ),
          Offstage(
            offstage: !editing,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 30,
                    constraints: BoxConstraints(maxWidth: 160),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none),
                      ),
                      onChanged: (value) {
                        this.newValue = value;
                      },
                      controller: TextEditingController.fromValue(
                          TextEditingValue(
                              text:
                                  '${this.newValue == null ? "" : this.newValue}', //判断keyword是否为空
                              // 保持光标在最后
                              selection: TextSelection.fromPosition(
                                  TextPosition(
                                      affinity: TextAffinity.downstream,
                                      offset: '${this.newValue}'
                                          .length)))),
                    ),
                  ),
                ),
                Container(
                    child: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      editing = false;
                      _updateTask(newValue);
                    });
                  },
                  child: Text('保存'),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}