class DateMoment {
  static int getDayDifference (String a, String b) {
    DateTime aDate = DateTime.parse(a.split(' ')[0]);
    DateTime bDate = DateTime.parse(b.split(' ')[0]);
    return bDate.difference(aDate).inDays;
  }

  static String getDay(String a) {
    var date = a.split(' ');
    return date[0];
  }
  static String getDate(String a) {
    var date = a.split('.');
    return date[0];
  }

}