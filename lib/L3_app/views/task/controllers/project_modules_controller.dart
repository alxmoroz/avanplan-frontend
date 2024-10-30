// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/tariff_option.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/ws_tariff.dart';
import '../../../presenters/project_module.dart';
import '../../../presenters/task_tree.dart';
import 'task_controller.dart';

part 'project_modules_controller.g.dart';

class ProjectModulesController extends _ProjectModulesControllerBase with _$ProjectModulesController {
  ProjectModulesController(TaskController tc) {
    _tc = tc;
  }
}

abstract class _ProjectModulesControllerBase with Store {
  late final TaskController _tc;

  Task get project => _tc.task;

  @observable
  ObservableList<bool> checks = ObservableList();

  @observable
  ObservableList<TariffOption> enabledProjectOptions = ObservableList();

  @action
  void reload() {
    enabledProjectOptions = ObservableList.of(project.ws.enabledProjectModulesOptions);
    checks = ObservableList.of([for (var to in enabledProjectOptions) project.hm(to.code)]);
  }

  @action
  void selectModule(int index, bool? selected) => checks[index] = selected == true;
}
