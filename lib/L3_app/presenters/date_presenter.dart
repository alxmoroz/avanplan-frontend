// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  bool get thisYear => year == DateTime.now().year;
  String get strShortWTime => (thisYear ? DateFormat.Md() : DateFormat.yMd()).add_Hm().format(this);
  String get strShort => thisYear ? DateFormat.Md().format(this) : DateFormat.yMd().format(this);
  String get strMedium => thisYear ? DateFormat.MMMMd().format(this) : strLong;
  String get strLong => DateFormat.yMMMMd().format(this);
}
