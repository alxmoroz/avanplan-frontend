// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'source.dart';

class TaskSource extends RPersistable {
  TaskSource({
    required super.id,
    required this.code,
    required this.rootCode,
    required this.source,
    required this.keepConnection,
    required this.urlString,
  });

  final String code;
  final String rootCode;
  final Source source;
  final String urlString;
  bool keepConnection;
}

class TaskSourceImport {
  TaskSourceImport({
    required this.code,
    required this.rootCode,
    this.keepConnection = true,
  });

  final String code;
  final String rootCode;
  bool keepConnection;
}
