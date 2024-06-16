// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../usecases/project_features.dart';

extension ProjectFeatureSetPresenter on Task {
  String get localizedFeatureSets => enabledFeatures.map((fs) => fs.title).join(', ');
}
