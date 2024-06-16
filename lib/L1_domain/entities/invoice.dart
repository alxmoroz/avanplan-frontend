// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'contract.dart';
import 'invoice_detail.dart';
import 'tariff.dart';

class Invoice extends RPersistable {
  Invoice({
    required super.id,
    required this.tariff,
    required this.contract,
    required this.details,
  });

  final Tariff tariff;
  final Contract contract;
  final Iterable<InvoiceDetail> details;

  static Invoice get dummy => Invoice(id: -1, tariff: Tariff.dummy, contract: Contract.dummy, details: []);
}
