// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

enum TaskSourceState {
  UNKNOWN,
  IMPORTING,
  OK,
  ERROR,
}

class TaskSource extends RPersistable {
  TaskSource({
    required super.id,
    required this.sourceId,
    required this.code,
    required this.rootCode,
    required this.urlString,
    required this.updatedOn,
    this.keepConnection = false,
    this.state,
    this.stateDetails,
  });

  final int sourceId;
  final String code;
  final String rootCode;
  final String urlString;
  final DateTime? updatedOn;
  bool keepConnection;

  final TaskSourceState? state;
  final String? stateDetails;
}

class TaskSourceRemote {
  TaskSourceRemote({
    required this.sourceId,
    required this.code,
    required this.rootCode,
    required this.urlString,
    required this.updatedOn,
    this.keepConnection = false,
  });

  final int sourceId;
  final String code;
  final String rootCode;
  final String urlString;
  final DateTime? updatedOn;
  bool keepConnection;
}
