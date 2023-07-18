// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import '../extra/services.dart';

DateTime get _now => DateTime.now();
DateTime get yesterday => DateTime(_now.year, _now.month, _now.day - 1);
DateTime get today => DateTime(_now.year, _now.month, _now.day);
DateTime get tomorrow => DateTime(_now.year, _now.month, _now.day + 1);
DateTime get nextWeek => DateTime(_now.year, _now.month, _now.day + 7);

extension DateFormatter on DateTime {
  bool get thisYear => year == _now.year;
  String get strShortWTime => (thisYear ? DateFormat.Md() : DateFormat.yMd()).add_Hm().format(this);
  String get strShort => thisYear ? DateFormat.Md().format(this) : DateFormat.yMd().format(this);
  String get strMedium => this == yesterday
      ? loc.yesterday_date_title
      : this == today
          ? loc.today_date_title
          : this == tomorrow
              ? loc.tomorrow_date_title
              : thisYear
                  ? DateFormat.MMMMd().format(this)
                  : DateFormat.yMMMMd().format(this);
}
