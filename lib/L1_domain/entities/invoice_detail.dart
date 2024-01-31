// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class InvoiceDetail extends Codable {
  InvoiceDetail({
    required super.id,
    required super.code,
    required this.startDate,
    this.endDate,
    required this.serviceAmount,
  });

  final DateTime startDate;
  final DateTime? endDate;
  final num serviceAmount;
}
