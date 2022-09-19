// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  bool get thisYear => year == DateTime.now().year;
  String get strShort => thisYear ? DateFormat.Md().format(this) : DateFormat.yMd().format(this);
  String get strLong => DateFormat.yMMMMd().format(this);
}
