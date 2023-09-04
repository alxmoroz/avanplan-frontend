// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../main.dart';
import '../../../extra/services.dart';
import '../../../usecases/task_feature_sets.dart';
import 'task_controller.dart';

part 'feature_sets_controller.g.dart';

class FeatureSetsController extends _FeatureSetsControllerBase with _$FeatureSetsController {
  FeatureSetsController(TaskController _taskController) {
    taskController = _taskController;
  }
}

abstract class _FeatureSetsControllerBase with Store {
  late final TaskController taskController;

  Task get project => taskController.task;

  @observable
  List<bool> checks = [];

  @action
  void setChecks() => checks = [for (var fs in refsController.featureSets) project.hfs(fs.code)];

  @computed
  bool get validated => checks.contains(true);

  @action
  void selectFeatureSet(int index, bool? selected) {
    checks[index] = selected == true;
    checks = [...checks];
  }

  Future setupFeatureSets() async {
    Navigator.of(rootKey.currentContext!).pop();

    final fIndex = TaskFCode.features.index;
    taskController.updateField(fIndex, loading: true);
    final fsIds = <int>[];
    for (int index = 0; index < checks.length; index++) {
      if (checks[index]) {
        fsIds.add(refsController.featureSets.elementAt(index).id!);
      }
    }
    project.projectFeatureSets = await featureSetUC.setup(project, fsIds);
    taskController.updateField(fIndex, loading: false);

    mainController.refresh();
  }
}
