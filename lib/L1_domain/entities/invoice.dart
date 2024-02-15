// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import '../utils/dates.dart';
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

  num overdraft(String code, Tariff tariff) {
    final diff = max(0, consumed(code) - tariff.freeLimit(code));
    return (diff / tariff.billingQuantity(code)).ceil();
  }

  bool hasOverdraft(Tariff tariff) {
    for (final code in tariff.optionsMap.keys) {
      if (overdraft(code, tariff) > 0 && code != TOCode.BASE_PRICE) {
        return true;
      }
    }
    return false;
  }

  num expensesPerMonth(String code, Tariff tariff) => overdraft(code, tariff) * tariff.price(code);

  num overallExpensesPerMonth(Tariff tariff) {
    num sum = 0;
    for (String code in tariff.optionsMap.keys) {
      sum += expensesPerMonth(code, tariff);
    }
    return sum;
  }

  num get currentExpensesPerDay => overallExpensesPerMonth(tariff) / DAYS_IN_MONTH;
}
