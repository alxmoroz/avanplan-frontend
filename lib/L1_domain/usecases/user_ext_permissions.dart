// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../entities/task.dart';
import '../entities/user.dart';
import '../entities/workspace.dart';
import 'task_ext_members.dart';

extension UserExtension on User {
  Iterable<String> _wP(Workspace? ws) => ws?.users.firstWhereOrNull((u) => u.id == id)?.permissions ?? [];
  bool canEditProjects(Workspace? ws) => _wP(ws).contains('PROJECTS_EDIT');
  bool canEditSources(Workspace? ws) => _wP(ws).contains('SOURCES_EDIT');

  Iterable<String> _tP(Task task) => task.projectMembers.firstWhereOrNull((m) => m.userId == id)?.permissions ?? [];
  bool canEditTasks(Task task, Workspace? ws) => _tP(task).contains('TASKS_EDIT') || canEditProjects(ws);
}
