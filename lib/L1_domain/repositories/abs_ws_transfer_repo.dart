// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';

abstract class AbstractWSTransferRepo {
  Future<Iterable<Project>> projectTemplates(int wsId) async => throw UnimplementedError();
  Future<TasksChanges?> createFromTemplate(int srcWsId, int srcProjectId, int dstWsId) async => throw UnimplementedError();
  Future<Iterable<Task>> sourcesForMove(int wsId) => throw UnimplementedError();
  Future<Iterable<Task>> destinationsForMove(int wsId, String taskType) => throw UnimplementedError();
}
