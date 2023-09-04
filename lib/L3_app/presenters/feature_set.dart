// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/feature_set.dart';
import '../../L1_domain/entities/task.dart';
import '../usecases/task_feature_sets.dart';

extension ProjectFeatureSetPresenter on Task {
  String get localizedFeatureSets => [...featureSets, FeatureSet(code: 'TASKLIST', id: null)].map((fs) => fs.title).join(', ');
}
