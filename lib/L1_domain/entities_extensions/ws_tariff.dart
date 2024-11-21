// Copyright (c) 2023. Alexandr Moroz

import 'dart:math';

import '../entities/invoice_detail.dart';
import '../entities/tariff.dart';
import '../entities/tariff_option.dart';
import '../entities/workspace.dart';
import '../utils/dates.dart';

extension WSTariff on Workspace {
  Tariff get tariff => invoice.tariff;

  bool get hasFeatures => tariff.hasFeatures;

  Iterable<InvoiceDetail> get _activeDetails =>
      invoice.details.where((d) => d.startDate.isBefore(now) && (d.endDate == null || d.endDate!.isAfter(now)));
  InvoiceDetail? ad(String code) => _activeDetails.where((d) => d.code == code).firstOrNull;

  num? finalPrice(String code) => ad(code)?.finalPrice;
  DateTime? consumedEndDate(String code) => ad(code)?.endDate;
  num _serviceAmount(String code) => ad(code)?.serviceAmount ?? 0;
  bool hasExpense(String code) => _serviceAmount(code) > 0;

  bool get hfTeam => hasExpense(TOCode.TEAM);
  bool get hfAnalytics => hasExpense(TOCode.ANALYTICS);
  bool get hfFinance => hasExpense(TOCode.FINANCE);

  // TODO: перенести в computed в контроллер
  List<TariffOption> get expensiveOptions => tariff.consumableOptions.where((o) => hasExpense(o.code)).toList();
  List<TariffOption> get expensiveFeatures => tariff.features.where((o) => hasExpense(o.code)).toList();

  num overdraft(String code, Tariff tariff) {
    final diff = max(0, _serviceAmount(code) - tariff.freeLimit(code));
    return (diff / tariff.tariffQuantity(code)).ceil();
  }

  // TODO: deprecated: fallback нужен для записей без инфы о final_price
  num expectedMonthlyCharge(String code, Tariff tariff) => overdraft(code, tariff) * (finalPrice(code) ?? tariff.price(code));

  num overallExpectedMonthlyCharge(Tariff tariff) {
    num sum = 0;
    for (String code in tariff.optionsMap.keys) {
      sum += expectedMonthlyCharge(code, tariff);
    }
    return sum;
  }

  num get expectedDailyCharge => overallExpectedMonthlyCharge(tariff) / DAYS_IN_MONTH;

  Iterable<TariffOption> get subscribedFeatures => tariff.features.where((o) => hasExpense(o.code));

  // TODO: deprecated TASKS_COUNT, FS_VOLUME как только не останется старых тарифов
  num get consumedTasks => _serviceAmount(TOCode.TASKS) + _serviceAmount("TASKS_COUNT");
  num get consumedFileStorage => _serviceAmount(TOCode.FILE_STORAGE) + _serviceAmount('FS_VOLUME');
}
