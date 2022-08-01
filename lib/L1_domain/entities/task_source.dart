// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'source.dart';

class TaskSource extends RPersistable {
  TaskSource({
    required int id,
    required this.code,
    required this.source,
    required this.keepConnection,
  }) : super(id: id);

  final String code;
  final Source source;
  final bool keepConnection;
}
