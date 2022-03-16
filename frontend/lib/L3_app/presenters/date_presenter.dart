// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String get dateStr => DateFormat.yMMMMd().format(this);
}

String dateToString(DateTime? date) => date != null ? date.dateStr : '';
