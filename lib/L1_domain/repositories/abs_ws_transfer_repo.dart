// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';

abstract class AbstractWSTransferRepo {
  Future<Iterable<Project>> projectTemplates(int wsId);
  Future<TasksChanges?> createFromTemplate(int srcWsId, int srcProjectId, int dstWsId);
  Future<Iterable<Task>> sourcesForMove(int wsId);
  Future<Iterable<Task>> destinationsForMove(int wsId, String taskType);
}
