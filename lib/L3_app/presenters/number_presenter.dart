// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

extension NumberFormatter on num {
  String get inPercents => '${NumberFormat("#").format(this * 100)}%';
}
