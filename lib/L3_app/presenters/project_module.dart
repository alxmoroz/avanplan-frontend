// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/tariff_option.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/ws_tariff.dart';
import '../presenters/task_tree.dart';

extension ProjectModulePresenter on Task {
  String get localizedModules => selectedProjectOptions.map((fs) => fs.title).join(', ');

  // TODO: перенести в computed в контроллер
  Iterable<TariffOption> get selectedProjectOptions =>
      ws.enabledProjectModulesOptions.where((o) => project.projectModules.any((pm) => pm.toCode == o.code));

  Iterable<String> get _selectedCodes => selectedProjectOptions.map((o) => o.code);

  // TODO: заменить на проверку наличия подключенной функции
  bool hm(String code) => _selectedCodes.contains(code);

  bool get hmTeam => hm(TOCode.TEAM);
  bool get hmAnalytics => hm(TOCode.ANALYTICS);
  bool get hmFinance => hm(TOCode.FINANCE);
}
