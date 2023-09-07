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
    checks = [for (var fs in refsController.featureSets) project.hfs(fs.code)];
  }
}

abstract class _FeatureSetsControllerBase with Store {
  late final TaskController taskController;

  Task get project => taskController.task;

  @observable
  List<bool> checks = [];

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
  void selectFeatureSet(int index, bool? selected) {
    checks[index] = selected == true;
    checks = [...checks];
  }

  Future setup() async {
    final fsIds = <int>[];
    for (int index = 0; index < checks.length; index++) {
      if (checks[index]) {
        fsIds.add(refsController.featureSets.elementAt(index).id!);
      }
    }
    await project.setupFeatureSets(fsIds);
  }

  Future save() async {
    Navigator.of(rootKey.currentContext!).pop();

    final fIndex = TaskFCode.features.index;
    taskController.updateField(fIndex, loading: true);
    await setup();
    taskController.updateField(fIndex, loading: false);
  }
}
