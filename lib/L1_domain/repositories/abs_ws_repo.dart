// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';
import '../entities/workspace.dart';
import 'abs_api_repo.dart';

abstract class AbstractWSRepo extends AbstractApiRepo<Workspace, WorkspaceUpsert> {
  Future<Iterable<Task>> myProjects(int wsId, {bool? closed, bool? imported}) async => throw UnimplementedError();
  Future<Iterable<Task>> myTasks(int wsId, {int? projectId}) async => throw UnimplementedError();
  Future<Iterable<Task>> memberAssignedTasks(int wsId, int memberId) async => throw UnimplementedError();
  Future<Iterable<Project>> projectTemplates(int wsId) async => throw UnimplementedError();
  Future<TasksChanges?> createFromTemplate(int srcWsId, int srcProjectId, int dstWsId) async => throw UnimplementedError();
  Future<Iterable<Task>> sourcesForMove(int wsId) => throw UnimplementedError();
  Future<Iterable<Task>> destinationsForMove(int wsId, String taskType) => throw UnimplementedError();
}
