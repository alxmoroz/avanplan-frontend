// Copyright (c) 2024. Alexandr Moroz

import 'package:intl/intl.dart';

import '../../L1_domain/entities/tariff.dart';
import '../../L2_data/repositories/communications_repo.dart';

extension TariffPresenter on Tariff {
  String get title => Intl.message('tariff_type_${code.toLowerCase()}_title');
  String get detailsUri => tariffsUrlString + (hidden ? '/archive/${code.toLowerCase()}' : '');
}
