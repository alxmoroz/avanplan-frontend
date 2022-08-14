// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'source.dart';

class TaskSource extends RPersistable {
  TaskSource({
    required int id,
    required this.code,
    required this.source,
    required this.keepConnection,
    required this.uri,
  }) : super(id: id);

  final String code;
  final Source source;
  final Uri uri;
  bool keepConnection;
}

class TaskSourceImport {
  TaskSourceImport({
    required this.code,
    this.keepConnection = true,
  });

  final String code;
  bool keepConnection;
}
