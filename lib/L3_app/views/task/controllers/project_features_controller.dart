// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/tariff.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/ws_sources.dart';
import '../../../extra/services.dart';
import '../../../presenters/source.dart';
import '../../../usecases/project_features.dart';
import '../../../usecases/task_tree.dart';
import 'task_controller.dart';

part 'project_features_controller.g.dart';

class ProjectFeaturesController extends _ProjectFeaturesControllerBase with _$ProjectFeaturesController {
  ProjectFeaturesController(TaskController taskController) {
    _taskController = taskController;
  }
}

abstract class _ProjectFeaturesControllerBase with Store {
  late final TaskController _taskController;

  Task get project => _taskController.task;
  Iterable<TariffOption> get _availableFeatures => project.availableFeatures;

  @observable
  ObservableList<bool> checks = ObservableList();

  @action
  void reload() => checks = ObservableList.of([for (var to in _availableFeatures) project.hf(to.code)]);

  bool hasChecked(String code) {
    for (int index = 0; index < checks.length; index++) {
      if (_availableFeatures.elementAt(index).code == code && checks[index]) {
        return true;
      }
    }
    return false;
  }

  @action
  void selectFeature(int index, bool? selected) => checks[index] = selected == true;

  Function(bool?)? onChanged(int index) {
    bool disabled = _taskController.loading == true;

    if (!disabled) {
      final f = _availableFeatures.elementAt(index);
      final checked = checks[index];

      if (f.code == TOCode.TEAM) {
        disabled = checked && project.members.length > 1;
      } else if (f.code == TOCode.GOALS) {
        // не можем включить для трелло и не можем выключить, если есть уже цели или задачи в корне проекта
        final isTrello = project.ws.sourceForId(project.taskSource?.sourceId)?.type.isTrello == true;
        disabled = isTrello || project.hasSubtasks;
      } else if (f.code == TOCode.ESTIMATES) {
        // TODO: можно проверить наличие оценок в задачах проекта
        bool hasEstimate(Task task) {
          if (task.estimate != null) {
            return true;
          }
          for (var t in task.subtasks) {
            return hasEstimate(t);
          }
          return false;
        }

        disabled = hasEstimate(project);
      }
    }
    return disabled ? null : (bool? value) => selectFeature(index, value);
  }

  Future setup() async {
    final fIndex = TaskFCode.features.index;
    _taskController.updateField(fIndex, loading: true);
    final fsIds = <int>[];
    for (int index = 0; index < checks.length; index++) {
      if (checks[index]) {
        fsIds.add(_availableFeatures.elementAt(index).id!);
      }
    }
    project.projectFeatureSets = await featureSetUC.setup(project, fsIds);
    _taskController.updateField(fIndex, loading: false);
  }
}
