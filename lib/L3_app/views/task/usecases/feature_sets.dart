// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import '../../../extra/services.dart';
import '../controllers/task_controller.dart';
import 'edit.dart';

extension FeatureSetsUC on TaskController {
  Future setupFeatureSets(Iterable<int> fsIds) async {
    editWrapper(() async => task.projectFeatureSets = await featureSetUC.setup(task, fsIds));
  }
}
