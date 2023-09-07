// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import 'base_entity.dart';

class FSCode {
  static const ANALYTICS = 'ANALYTICS';
  static const TEAM = 'TEAM';
  static const GOALS = 'GOALS';
  static const TASKBOARD = 'TASKBOARD';
  static const ESTIMATES = 'ESTIMATES';
}

class FeatureSet extends Codable {
  FeatureSet({
    required super.id,
    required super.code,
  });

  String get title => Intl.message('feature_set_${code.toLowerCase()}_title');
  String get description => Intl.message('feature_set_${code.toLowerCase()}_description');
}

class ProjectFeatureSet extends RPersistable {
  ProjectFeatureSet({
    required super.id,
    required this.featureSetId,
  });

  final int featureSetId;
}
