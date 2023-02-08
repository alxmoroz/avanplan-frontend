// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../entities/task.dart';
import '../entities/user.dart';
import '../entities/workspace.dart';
import 'task_ext_members.dart';

extension UserExtension on User {
  Iterable<String> _wsPermissions(Workspace ws) => ws.users.firstWhereOrNull((u) => u.id == id)?.permissions ?? [];
  bool canEditProjects(Workspace ws) => _wsPermissions(ws).contains('PROJECTS_EDIT');

  Iterable<String> _taskPermissions(Task task) => task.projectMembers.firstWhereOrNull((m) => m.userId == id)?.permissions ?? [];
  bool canEditTask(Task task) => _taskPermissions(task).contains('TASKS_EDIT');
}
