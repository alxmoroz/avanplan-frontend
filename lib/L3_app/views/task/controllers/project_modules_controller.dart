// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/tariff_option.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/remote_source.dart';
import '../../../../L1_domain/entities_extensions/ws_tariff.dart';
import '../../../extra/services.dart';
import '../../../presenters/project_module.dart';
import '../../../presenters/remote_source.dart';
import '../../../presenters/task_tree.dart';
import 'task_controller.dart';

part 'project_modules_controller.g.dart';

class ProjectModulesController extends _ProjectModulesControllerBase with _$ProjectModulesController {
  ProjectModulesController(TaskController taskController) {
    _taskController = taskController;
  }
}

abstract class _ProjectModulesControllerBase with Store {
  late final TaskController _taskController;

  Task get project => _taskController.task;

  @observable
  ObservableList<bool> checks = ObservableList();

  @observable
  ObservableList<TariffOption> enabledProjectOptions = ObservableList();

  @action
  void reload() {
    enabledProjectOptions = ObservableList.of(project.ws.enabledProjectModulesOptions);
    checks = ObservableList.of([for (var to in enabledProjectOptions) project.hm(to.code)]);
  }

  bool hasChecked(String code) {
    for (int index = 0; index < checks.length; index++) {
      if (enabledProjectOptions.elementAt(index).code == code && checks[index]) {
        return true;
      }
    }
    return false;
  }

  @action
  void selectModule(int index, bool? selected) => checks[index] = selected == true;

  Function(bool?)? onChanged(int index) {
    bool disabled = _taskController.loading == true;

    if (!disabled) {
      final f = enabledProjectOptions.elementAt(index);
      final checked = checks[index];

      if (f.code == TOCode.TEAM) {
        disabled = checked && project.members.length > 1;
      } else if (f.code == TOCode.GOALS) {
        // не можем включить для трелло и не можем выключить, если есть уже цели или задачи в корне проекта
        final isTrello = project.ws.remoteSourceForId(project.taskSource?.sourceId)?.type.isTrello == true;
        disabled = isTrello || project.hasSubtasks;
      }
    }
    return disabled ? null : (bool? value) => selectModule(index, value);
  }

  Future setup() async {
    final fIndex = TaskFCode.projectModules.index;
    _taskController.updateField(fIndex, loading: true);
    final toCodes = <String>[];
    for (int index = 0; index < checks.length; index++) {
      if (checks[index]) {
        toCodes.add(enabledProjectOptions.elementAt(index).code);
      }
    }
    project.projectModules = await projectModulesUC.setup(project.wsId, project.id!, toCodes);
    _taskController.updateField(fIndex, loading: false);
  }
}
