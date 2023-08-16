// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class TaskSource extends RPersistable {
  TaskSource({
    required super.id,
    required this.code,
    required this.rootCode,
    required this.sourceId,
    required this.keepConnection,
    required this.urlString,
    required this.updatedOn,
  });

  final String code;
  final String rootCode;
  final int sourceId;
  final String urlString;
  final DateTime? updatedOn;
  bool keepConnection;
}

class TaskSourceImport {
  TaskSourceImport({
    required this.code,
    required this.rootCode,
    required this.updatedOn,
    this.keepConnection = false,
  });

  final String code;
  final String rootCode;
  bool keepConnection;
  final DateTime? updatedOn;
}
