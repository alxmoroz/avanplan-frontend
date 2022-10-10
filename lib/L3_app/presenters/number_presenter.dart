// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

extension NumberFormatter on double {
  String get inPercents => '${NumberFormat("#").format(this * 100)}%';
}
