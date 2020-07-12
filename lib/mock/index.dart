

class DetailMock {
  String title = '工作目标1';
  int dateCreated = 1;
  int allDays = 10;
  int currentDay = 2;
  int holidayDays = 2;
  int dayofftaken = 1;
  bool currentCheckStatus = false;
  String target = '为了赚更多的钱';
  List<Map<String, dynamic>> supervisor = [
    {
      'nid': '122121',
      'nickName': 'sara',
      'commissionRate': 0.2,
      'startTime': '2020-03-09'
    }
  ];
  
  static List<Map<String, dynamic>> checklogs = [
    {
      'checkTime': '2020-07-08 12:30',
      'remark': '今天又是元气满满的一天',
      'isVacation': false,
      'imgs': [],
      'commet': [
        {
          'nid': '122121',
          'nickName': 'sara',
          'time': '2020-07-08 13:30',
          'commet': '元气满满'
        }
      ]
    },
    {
      'checkTime': '2020-07-06 12:30',
      'remark': '今天又是元气满满的一天',
      'isVacation': false,
      'imgs': [],
      'commet': [
        {
          'nid': '122121',
          'nickName': 'sara',
          'time': '2020-07-08 13:30',
          'commet': '元气满满'
        }
      ]
    },
    {
      'checkTime': '2020-07-05 12:30',
      'remark': '',
      'isVacation': true,
      'imgs': [],
      'commet': [
        {
          'nid': '122121',
          'nickName': 'sara',
          'time': '2020-07-08 13:30',
          'commet': '元气满满'
        }
      ]
    }
  ];
}


final List<Map<String, dynamic>> tasks = [
  {
    'title': '工作目标1',
    'dateCreated': 1,
    'allDays': 10,
    'currentDay': 2,
    'holidayDays': 2,
    'dayofftaken': 1,
    'currentCheckStatus': false,
    'target': '为了赚更多的钱',
    'checklogs': []
  },
  {
    'title': '工作目标2',
    'dateCreated': 1,
    'allDays': 10,
    'currentDay': 5,
    'holidayDays': 2,
    'dayofftaken': 1,
    'currentCheckStatus': false,
    'target': '为了赚更多的钱',
    'Checklogs': []
  },
  {
    'title': '工作目标3',
    'dateCreated': 1,
    'allDays': 10,
    'currentDay': 9,
    'holidayDays': 2,
    'dayofftaken': 1,
    'currentCheckStatus': false,
    'Checklogs': []
  },
  {
    'title': '工作目标4',
    'dateCreated': 1,
    'allDays': 10,
    'currentDay': 2,
    'holidayDays': 2,
    'dayofftaken': 1,
    'currentCheckStatus': false,
    'Checklogs': []
  },
  {
    'title': '工作目标5',
    'dateCreated': 1,
    'allDays': 10,
    'currentDay': 3,
    'holidayDays': 2,
    'dayofftaken': 1,
    'currentCheckStatus': false,
    'Checklogs': []
  },
  {
    'title': '工作目标6',
    'dateCreated': 1,
    'allDays': 10,
    'currentDay': 1,
    'holidayDays': 2,
    'dayofftaken': 1,
    'currentCheckStatus': false,
    'Checklogs': []
  },
  {
    'title': '工作目标7',
    'dateCreated': 1,
    'allDays': 10,
    'currentDay': 1,
    'holidayDays': 2,
    'dayofftaken': 1,
    'currentCheckStatus': false,
    'Checklogs': []
  },
  {
    'title': '工作目标8',
    'dateCreated': 1,
    'allDays': 10,
    'currentDay': 1,
    'holidayDays': 2,
    'dayofftaken': 1,
    'currentCheckStatus': false,
    'Checklogs': []
  },
  {
    'title': '工作目标5',
    'dateCreated': 1,
    'allDays': 10,
    'currentDay': 1,
    'holidayDays': 2,
    'dayofftaken': 1,
    'currentCheckStatus': false,
    'Checklogs': []
  },
  {
    'title': '工作目标6',
    'dateCreated': 1,
    'allDays': 10,
    'currentDay': 1,
    'holidayDays': 2,
    'dayofftaken': 1,
    'currentCheckStatus': false,
    'Checklogs': []
  },
  {
    'title': '工作目标7',
    'dateCreated': 1,
    'allDays': 10,
    'currentDay': 1,
    'holidayDays': 2,
    'dayofftaken': 1,
    'currentCheckStatus': false,
    'Checklogs': []
  },
  {
    'title': '工作目标8',
    'dateCreated': 1,
    'allDays': 10,
    'currentDay': 1,
    'holidayDays': 2,
    'dayofftaken': 1,
    'currentCheckStatus': false,
    'Checklogs': []
  }
];

