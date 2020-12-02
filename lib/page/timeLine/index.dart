// 历史时间轴

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../utils/request/index.dart';
import '../../config.dart';
import '../../theme/colorsSetting.dart';



class TimeLine extends StatefulWidget {

  _Timeline createState() => _Timeline();
}


class _Timeline extends State<TimeLine> {

  String _selectedDate;

  List showList;

  List allList;
  
  
  @override
  void initState() {
    _selectedDate = transformDate(DateTime.now());
    super.initState();
    _getTimeLine(transformDate(DateTime.now()));
  }

  String transformDate(DateTime value) {
    String year = value.year.toString();
    String month = value.month > 9 ? value.month.toString() : '0' + value.month.toString();
    String day = value.day > 9 ? value.day.toString() : '0' + value.day.toString();
    return year + '-' + month + '-' + day;
  }

  _getTimeLine(String time) async {
    final result = await Request.post(Urls.env + '/log/getTimeLine', {
      'time': time
    });
    print(result);
    if (result != null && result['success'] == true) {
      
    }
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    String a = transformDate(args.value);
    _getTimeLine(a);
    setState(() {
      _selectedDate = a;
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('时间轴')
      ),
      body: Column(
        children: [
          Container(
            height: 240,
            child: SfDateRangePicker(
              initialSelectedDate: DateTime.now(),
              maxDate: DateTime.now(),
              onSelectionChanged: _onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.single
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Row(
                children: [
                  Container(
                    width: 70,
                    child: ListView.builder(
                      itemCount: statusList.length,
                      itemBuilder: (BuildContext context,int index) {
                        return Container(
                          width: 70,
                          height: 70,
                          color: statusList[index]['color'],
                          child: Center(
                            child: Text(statusList[index]['name']),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: ListView.builder(
                        itemCount: statusList.length,
                        itemBuilder: (BuildContext context,int index) {
                          return Container(
                            width: 70,
                            height: 70,
                            color: statusList[index]['color'],
                            child: Center(
                              child: Text(statusList[index]['name']),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ]
      )
    );
  }
}