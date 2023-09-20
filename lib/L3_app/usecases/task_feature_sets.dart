// Copyright (c) 2023. Alexandr Moroz

import 'package:dio/dio.dart';

import '../../L1_domain/entities/errors.dart';
import '../../L1_domain/entities/feature_set.dart';
import '../../L1_domain/entities/task.dart';
import '../../L2_data/services/api.dart';
import '../extra/services.dart';
import '../presenters/task_tree.dart';

extension FeatureSetsUC on Task {
  Set<FeatureSet> get featureSets => project!.projectFeatureSets.map((pfs) => refsController.featureSetsMap[pfs.featureSetId]!).toSet();

  Set<String> get _fsCodes => featureSets.map((fs) => fs.code).toSet();

  bool hfs(String code) => _fsCodes.contains(code);

  bool get hfsAnalytics => hfs(FSCode.ANALYTICS);
  bool get hfsTeam => hfs(FSCode.TEAM);
  bool get hfsGoals => hfs(FSCode.GOALS);
  bool get hfsTaskboard => hfs(FSCode.TASKBOARD);
  bool get hfsEstimates => hfs(FSCode.ESTIMATES);

  Future setupFeatureSets(Iterable<int> fsIds) async {
    loading = true;
    mainController.refresh();
    try {
      projectFeatureSets = await featureSetUC.setup(this, fsIds);
    } on DioException catch (e) {
      error = MTError(loader.titleText ?? '', description: loader.descriptionText, detail: e.detail);
    }
    loading = false;
    mainController.refresh();
  }
}
