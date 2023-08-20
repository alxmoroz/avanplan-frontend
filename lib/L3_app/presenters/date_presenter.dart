// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import '../../L1_domain/utils/dates.dart';
import '../extra/services.dart';

extension DateFormatter on DateTime {
  DateTime get date => DateTime(year, month, day);

  bool get thisYear => year == now.year;
  String get strTime => DateFormat.Hm().format(this);
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
