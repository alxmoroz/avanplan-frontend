// Copyright (c) 2024. Alexandr Moroz

import '../../../../L1_domain/entities/tariff_option.dart';
import '../../../../L1_domain/entities_extensions/remote_source.dart';
import '../../../extra/services.dart';
import '../../../presenters/remote_source.dart';
import '../../../presenters/task_tree.dart';
import '../controllers/task_controller.dart';

extension ProjectModulesUC on TaskController {
  bool hasProjectModuleChecked(String code) {
    final pmChecks = projectModulesController.checks;
    for (int index = 0; index < pmChecks.length; index++) {
      if (projectModulesController.enabledProjectOptions.elementAt(index).code == code && pmChecks[index]) {
        return true;
      }
    }
    return false;
  }

  Future setupProjectModules() async {
    final fIndex = TaskFCode.projectModules.index;
    final pmChecks = projectModulesController.checks;
    final p = task;
    updateField(fIndex, loading: true);
    final toCodes = <String>[];
    for (int index = 0; index < pmChecks.length; index++) {
      if (pmChecks[index]) {
        toCodes.add(projectModulesController.enabledProjectOptions.elementAt(index).code);
      }
    }
    p.projectModules = await projectModulesUC.setup(p.wsId, p.id!, toCodes);
    updateField(fIndex, loading: false);
  }

  Function(bool?)? onChanged(int index) {
    bool disabled = loading == true;
    final p = task;
    if (!disabled) {
      final f = projectModulesController.enabledProjectOptions.elementAt(index);
      final checked = projectModulesController.checks[index];

      if (f.code == TOCode.TEAM) {
        disabled = checked && p.members.length > 1;
      } else if (f.code == TOCode.GOALS) {
        // не можем включить для трелло и не можем выключить, если есть уже цели или задачи в корне проекта
        final isTrello = p.ws.remoteSourceForId(p.taskSource?.sourceId)?.type.isTrello == true;
        disabled = isTrello || p.hasSubtasks;
      }
    }
    return disabled ? null : (bool? value) => projectModulesController.selectModule(index, value);
  }
}
