// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/feature_set.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/ws_sources.dart';
import '../../../extra/services.dart';
import '../../../presenters/source.dart';
import '../../../usecases/task_feature_sets.dart';
import '../../../usecases/task_tree.dart';
import 'task_controller.dart';

part 'feature_sets_controller.g.dart';

class FeatureSetsController extends _FeatureSetsControllerBase with _$FeatureSetsController {
  FeatureSetsController(TaskController taskController) {
    _taskController = taskController;
  }
}

abstract class _FeatureSetsControllerBase with Store {
  late final TaskController _taskController;

  Task get project => _taskController.task;

  @observable
  ObservableList<bool> checks = ObservableList();

  @action
  void reload() => checks = ObservableList.of([for (var fs in refsController.featureSets) project.hfs(fs.code)]);

  @computed
  bool get validated => checks.contains(true);

  bool hasChecked(String code) {
    for (int index = 0; index < checks.length; index++) {
      if (refsController.featureSets.elementAt(index).code == code && checks[index]) {
        return true;
      }
    }
    return false;
  }

  @action
  void selectFeatureSet(int index, bool? selected) => checks[index] = selected == true;

  Function(bool?)? onChanged(int index) {
    bool disabled = _taskController.loading == true;

    if (!disabled) {
      final fs = refsController.featureSets.elementAt(index);
      final checked = checks[index];

      if (fs.code == FSCode.TEAM) {
        disabled = checked && project.members.length > 1;
      } else if (fs.code == FSCode.GOALS) {
        // не можем включить для трелло и не можем выключить, если есть уже цели или задачи в корне проекта
        final isTrello = project.ws.sourceForId(project.taskSource?.sourceId)?.type.isTrello == true;
        disabled = isTrello || project.hasSubtasks;
      } else if (fs.code == FSCode.ESTIMATES) {
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
    return disabled ? null : (bool? value) => selectFeatureSet(index, value);
  }

  Future setup() async {
    final fIndex = TaskFCode.features.index;
    _taskController.updateField(fIndex, loading: true);
    final fsIds = <int>[];
    for (int index = 0; index < checks.length; index++) {
      if (checks[index]) {
        fsIds.add(refsController.featureSets.elementAt(index).id!);
      }
    }
    project.projectFeatureSets = await featureSetUC.setup(project, fsIds);
    _taskController.updateField(fIndex, loading: false);
  }
}
