// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

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

  num consumed(String code) => details.where((d) => d.code == code && d.endDate == null).firstOrNull?.serviceAmount ?? 0;

  num _tariffQuantity(String code) => tariff.tariffQuantity(code);
  num _freeLimit(String code) => tariff.freeLimit(code);
  num _overdraft(String code) {
    final diff = max(0, consumed(code) - _freeLimit(code));
    return (diff / _tariffQuantity(code)).ceil();
  }

  num chargePerMonth(String code) => _overdraft(code) * tariff.pricePerMonth(code);

  num get overallChargePerMonth {
    num charge = 0;
    for (String code in tariff.optionsMap.keys) {
      charge += chargePerMonth(code);
    }
    return charge;
  }
}
