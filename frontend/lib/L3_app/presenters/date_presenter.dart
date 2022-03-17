// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String get strShort => DateFormat.yMd().format(this);
  String get strLong => DateFormat.yMMMMd().format(this);
}
