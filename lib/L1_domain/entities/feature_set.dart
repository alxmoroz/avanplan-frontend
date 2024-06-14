// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import 'base_entity.dart';

// TODO: deprecated

class FSCode {
  static const TASKS = 'TASKS';
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

  String get title => Intl.message('tariff_option_${code.toLowerCase()}_title');
  String get subtitle => Intl.message('tariff_option_${code.toLowerCase()}_subtitle');
}

class ProjectFeatureSet extends RPersistable {
  ProjectFeatureSet({
    required super.id,
    required this.featureSetId,
  });

  final int featureSetId;
}
