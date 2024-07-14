// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import '../extra/services.dart';

extension NumberFormatterPresenter on num {
  String get percents => '${NumberFormat("#").format(this * 100)}%';
  String get currency => NumberFormat('#,###').format(this);
  String get currencySharp => NumberFormat('#,###.##').format(this);

  num get _thousands => this / 1000;
  num get _millions => this / 1000000;

  String get humanSuffix {
    return _millions >= 1
        ? loc.millions_short
        : _thousands >= 1
            ? loc.thousands_short
            : '';
  }

  String _hNumberFormat(num n) => NumberFormat('#.#').format(n);
  String get humanValueStr => this != 0
      ? _millions >= 1
          ? '${_hNumberFormat(_millions)} ${loc.millions_short}'
          : _thousands >= 1
              ? '${_hNumberFormat(_thousands)} ${loc.thousands_short}'
              : _hNumberFormat(this)
      : '0';
}
