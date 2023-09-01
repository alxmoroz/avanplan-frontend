// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/feature_set.dart';

extension FeatureSetMapper on FeatureSetGet {
  FeatureSet get featureSet => FeatureSet(
        id: id,
        code: code,
      );
}
