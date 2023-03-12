// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'contract.dart';
import 'tariff.dart';

class Invoice extends RPersistable {
  Invoice({
    required super.id,
    required this.tariff,
    required this.contract,
  });

  final Tariff tariff;
  final Contract contract;
}
