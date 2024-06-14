// Copyright (c) 2023. Alexandr Moroz

import '../../L1_domain/entities/feature_set.dart';
import '../../L1_domain/entities/task.dart';
import '../extra/services.dart';
import 'task_tree.dart';

// TODO: deprecated переделать

extension FeatureSetsUC on Task {
  Set<FeatureSet> get featureSets => project.projectFeatureSets.map((pfs) => refsController.featureSetsMap[pfs.featureSetId]!).toSet();

  Set<String> get _fsCodes => featureSets.map((fs) => fs.code).toSet();

  bool hfs(String code) => _fsCodes.contains(code);

  bool get hfAnalytics => hfs(FSCode.ANALYTICS);
  bool get hfTeam => hfs(FSCode.TEAM);
  bool get hfGoals => hfs(FSCode.GOALS);
  bool get hfTaskboard => hfs(FSCode.TASKBOARD);
  bool get hfEstimates => hfs(FSCode.ESTIMATES);
}
