// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Attachment extends Titleable {
  Attachment({
    super.id,
    required super.title,
    super.description,
    required this.taskId,
    required this.wsId,
    required this.type,
    required this.bytes,
    required this.updatedOn,
  });

  final int taskId;
  final int wsId;
  final String type;
  final int bytes;
  final DateTime updatedOn;
}
