// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';
import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart';

import '../../L2_data/services/platform.dart';
import '../extra/services.dart';

const CURRENCY_SYMBOL_ROUBLE = '₽';

class NumberSeparators {
  final NumberSymbols? _numberFormatSymbols = numberFormatSymbols[languageCode];

  String get decimalSep => RegExp.escape(_numberFormatSymbols?.DECIMAL_SEP ?? ',');
  String get groupSep => RegExp.escape(_numberFormatSymbols?.GROUP_SEP ?? ' ');
}

extension NumberFormatterPresenter on num {
  String get percents => NumberFormat("#%").format(this);
  String get currency => NumberFormat('#,###').format(this);
  String get currencyRouble => '$currency$CURRENCY_SYMBOL_ROUBLE';
  String get currencySharp => NumberFormat('#,###.##').format(this);
  String get financeTransaction => NumberFormat('+#,###.00;-#,###.00').format(this);

  num get _thousands => this / 1000;
  num get _millions => this / 1000000;

  String get humanSuffix {
    return _millions >= 1
        ? loc.millions_short
        : _thousands >= 1
            ? loc.thousands_short
            : '';
  }

  String _hNumberFormat(num n) => NumberFormat('#,###.#').format(n);
  String get humanValueStr => this != 0
      ? _millions >= 1
          ? '${_hNumberFormat(_millions)} ${loc.millions_short}'
          : _thousands >= 1
              ? '${_hNumberFormat(_thousands)} ${loc.thousands_short}'
              : _hNumberFormat(this)
      : '0';
}
