// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';

abstract class AbstractProjectTransferRepo {
  Future<Iterable<Project>> getProjectTemplates(int wsId) async => throw UnimplementedError();
  Future<TasksChanges?> transfer(int srcWsId, int srcProjectId, int dstWsId) async => throw UnimplementedError();
}
