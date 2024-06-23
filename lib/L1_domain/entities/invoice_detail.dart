// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class InvoiceDetail extends Codable {
  InvoiceDetail({
    required super.id,
    required super.code,
    required this.startDate,
    this.endDate,
    required this.serviceAmount,
    required this.promoActionCode,
    required this.finalPrice,
  });

  final DateTime startDate;
  final DateTime? endDate;
  final num serviceAmount;
  final String? promoActionCode;
  final num? finalPrice;
}
