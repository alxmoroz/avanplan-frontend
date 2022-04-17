// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

extension StringFormatter on String {
  String cut(int length) => substring(0, min(length, this.length));
}
