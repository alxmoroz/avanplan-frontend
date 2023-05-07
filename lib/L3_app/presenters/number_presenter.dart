// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import '../extra/services.dart';

extension NumberFormatter on num {
  String get percents => '${NumberFormat("#").format(this * 100)}%';
  String get currency => NumberFormat('#,###.#').format(this);

  num get _thousands => this / 1000;
  num get _millions => this / 1000000;
  String get humanValueStr => _millions > 1
      ? loc.millions_count_short(_millions.round())
      : _thousands > 1
          ? loc.thousands_count_short(_thousands.round())
          : '$this';
}
