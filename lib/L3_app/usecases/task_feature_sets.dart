// Copyright (c) 2023. Alexandr Moroz

import '../../L1_domain/entities/feature_set.dart';
import '../../L1_domain/entities/task.dart';
import '../extra/services.dart';
import '../presenters/task_tree.dart';

extension TaskFeatureSetsExt on Task {
  Set<FeatureSet> get featureSets => project!.projectFeatureSets.map((pfs) => refsController.featureSetsMap[pfs.featureSetId]!).toSet();

  Set<String> get _fsCodes => featureSets.map((fs) => fs.code).toSet();

  bool _hfs(String code) => _fsCodes.contains(code);

  bool get hfsAnalytics => _hfs('ANALYTICS');
  bool get hfsTeam => _hfs('TEAM');
  // bool get hfsGoals => _hfs('GOALS');
  bool get hfsTaskboard => _hfs('TASKBOARD');
  bool get hfsEstimates => _hfs('ESTIMATES');
}
