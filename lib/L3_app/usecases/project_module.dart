// Copyright (c) 2023. Alexandr Moroz

import '../../L1_domain/entities/tariff.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/ws_tariff.dart';
import 'task_tree.dart';

extension ProjectModuleUC on Task {
  // TODO: перенести в computed в контроллер
  Iterable<TariffOption> get selectedProjectOptions => ws.enabledProjectOptions.where((o) => project.projectModules.any((pm) => pm.optionId == o.id));

  Iterable<String> get _oCodes => selectedProjectOptions.map((o) => o.code);

  bool hm(String code) => _oCodes.contains(code);

  bool get hmAnalytics => hm(TOCode.ANALYTICS);
  bool get hmTeam => hm(TOCode.TEAM);
  bool get hmGoals => hm(TOCode.GOALS);
  bool get hmTaskboard => hm(TOCode.TASKBOARD);
}
