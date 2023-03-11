// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import '../../L1_domain/entities/tariff.dart';

extension TariffPresenter on Tariff {
  String get title => Intl.message('tariff_${code.toLowerCase()}_title');
  String get limitsDescription => Intl.message('tariff_${code.toLowerCase()}_limits_description');
  String get optionsDescription => Intl.message('tariff_${code.toLowerCase()}_options_description');
}
