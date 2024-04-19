// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';

abstract class AbstractProjectTransferRepo {
  Future<Iterable<Project>> projectTemplates(int wsId) async => throw UnimplementedError();
  Future<TasksChanges?> createFromTemplate(int srcWsId, int srcProjectId, int dstWsId) async => throw UnimplementedError();
}
