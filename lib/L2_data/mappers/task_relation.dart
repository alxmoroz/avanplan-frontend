// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/task_relation.dart';

extension TaskRelationMapper on o_api.TaskRelationGet {
  TaskRelation relation(int wsId) => TaskRelation(
        id: id,
        wsId: wsId,
        srcId: srcId,
        dstId: dstId,
        type: type,
      );
}
