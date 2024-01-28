// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class InvoiceDetail extends RPersistable {
  InvoiceDetail({
    required super.id,
    required this.startDate,
    this.endDate,
    required this.optionCode,
    required this.serviceAmount,
  });

  final DateTime startDate;
  final DateTime? endDate;
  final String optionCode;
  final num serviceAmount;
}
