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
  InvoiceDetail? _ad(String code) => _activeDetails.where((d) => d.code == code).firstOrNull;

  num? finalPrice(String code) => _ad(code)?.finalPrice;
  DateTime? consumedEndDate(String code) => _ad(code)?.endDate;
  num consumed(String code) => _ad(code)?.serviceAmount ?? 0;
  bool subscribed(String code) => consumed(code) > 0;

  // TODO: перенести в computed в контроллер
  Iterable<TariffOption> get availableProjectModulesOptions => tariff.projectModulesOptions;
  Iterable<TariffOption> get enabledProjectModulesOptions => availableProjectModulesOptions.where((o) => !o.userManageable || subscribed(o.code));

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

  bool get allProjectOptionsUsed => enabledProjectModulesOptions.length == availableProjectModulesOptions.length;

  Iterable<TariffOption> get subscribedFeatures => tariff.features.where((o) => subscribed(o.code));

  // TODO: deprecated TASKS_COUNT, FS_VOLUME как только не останется старых тарифов
  num get consumedTasks => consumed(TOCode.TASKS) + consumed("TASKS_COUNT");
  num get consumedFileStorage => consumed(TOCode.FILE_STORAGE) + consumed('FS_VOLUME');
}
