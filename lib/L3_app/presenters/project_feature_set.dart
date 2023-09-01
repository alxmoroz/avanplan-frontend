// Copyright (c) 2023. Alexandr Moroz

import '../../L1_domain/entities/feature_set.dart';
import '../../L1_domain/entities/task.dart';
import '../extra/services.dart';
import 'task_tree.dart';

extension ProjectFeatureSet on Task {
  List<FeatureSet> get featureSets {
    List<FeatureSet> res = [];

    final pFeatureSets = project?.projectFeatureSets ?? [];
    if (pFeatureSets.isNotEmpty) {
      res = pFeatureSets.map((pfs) => refsController.featureSets.firstWhere((fs) => fs.id == pfs.featureSetId)).toList();
    }

    return res;
  }

  // FeatureSet? featureSetForId(int? id) => featureSets.firstWhereOrNull((fs) => fs.id == id);
}
