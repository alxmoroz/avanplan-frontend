// Copyright (c) 2023. Alexandr Moroz

import 'dart:math';

import 'package:collection/collection.dart';

import '../entities/invoice.dart';
import '../entities/tariff.dart';
import '../utils/dates.dart';

extension InvoiceParameters on Invoice {
  num consumed(String code) => details.where((d) => d.code == code && d.endDate == null).firstOrNull?.serviceAmount ?? 0;
  bool subscribed(String code) => consumed(code) > 0;

  Iterable<TariffOption> get availableProjectOptions => tariff.projectOptions;
  Iterable<TariffOption> get enabledProjectOptions => availableProjectOptions.where((o) => !o.userManageable || subscribed(o.code));

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
