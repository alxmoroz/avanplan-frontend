// Copyright (c) 2023. Alexandr Moroz

import '../../L1_domain/entities/tariff.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/invoice.dart';
import 'task_tree.dart';

extension ProjectFeaturesUC on Task {
  // TODO: перенести в computed в контроллер
  Iterable<TariffOption> get availableFeatures => ws.invoice.availableFeatures;
  Iterable<TariffOption> get enabledFeatures => availableFeatures.where((af) => project.projectFeatureSets.any((pfs) => pfs.optionId == af.id));

  Iterable<String> get _oCodes => enabledFeatures.map((o) => o.code);

  bool hf(String code) => _oCodes.contains(code);

  bool get hfAnalytics => hf(TOCode.ANALYTICS);
  bool get hfTeam => hf(TOCode.TEAM);
  bool get hfGoals => hf(TOCode.GOALS);
  bool get hfTaskboard => hf(TOCode.TASKBOARD);
}
