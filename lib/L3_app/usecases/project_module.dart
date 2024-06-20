// Copyright (c) 2023. Alexandr Moroz

import '../../L1_domain/entities/tariff.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/invoice.dart';
import 'task_tree.dart';

extension ProjectModuleUC on Task {
  // TODO: перенести в computed в контроллер
  Iterable<TariffOption> get enabledProjectOptions => ws.invoice.enabledProjectOptions;
  Iterable<TariffOption> get selectedProjectOptions => enabledProjectOptions.where((o) => project.projectModules.any((pm) => pm.optionId == o.id));

  bool get allProjectOptionsUsed => enabledProjectOptions.length == ws.invoice.availableProjectOptions.length;

  Iterable<String> get _oCodes => selectedProjectOptions.map((o) => o.code);

  bool hm(String code) => _oCodes.contains(code);

  bool get hmAnalytics => hm(TOCode.ANALYTICS);
  bool get hmTeam => hm(TOCode.TEAM);
  bool get hmGoals => hm(TOCode.GOALS);
  bool get hmTaskboard => hm(TOCode.TASKBOARD);
}
