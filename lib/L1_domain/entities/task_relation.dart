// Copyright (c) 2024. Alexandr Moroz

import 'base_entity.dart';

class TaskRelation extends WSBounded {
  TaskRelation({
    super.id,
    super.wsId = -1,
    this.srcId = -1,
    this.dstId = -1,
    this.type = "PLAIN",
  });

  final int srcId;
  final int dstId;
  final String type;
}
