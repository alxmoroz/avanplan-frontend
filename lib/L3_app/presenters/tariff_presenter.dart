// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import '../../L1_domain/entities/tariff.dart';

extension TariffPresenter on Tariff {
  String get title => Intl.message('tariff_title_${code.toLowerCase()}');
  String get description => Intl.message('tariff_description_${code.toLowerCase()}');
}
