// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';

import '../entities/tariff.dart';
import '../entities/workspace.dart';

extension WSTariffsExtension on Workspace {
  List<WSTariff> get activeTariffs => tariffs
      .where((t) => t.expiresOn == null || t.expiresOn!.isAfter(DateTime.now()))
      .sorted((t1, t2) => compareNatural('${t1.tariff}', '${t2.tariff}'));
}
