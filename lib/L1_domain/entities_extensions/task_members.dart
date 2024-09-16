// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L3_app/presenters/task_tree.dart';
import '../entities/task.dart';
import '../entities/ws_member.dart';
import 'ws_users.dart';

extension TaskMembersExtension on Task {
  List<WSMember> get activeMembers => project.members
      .where((m) => m.userId != null && ws.userForId(m.userId!) != null)
      .map((m) {
        m.isTaskMember = true;
        return m;
      })
      .sorted((m1, m2) => compareNatural('$m1', '$m2'))
      .toList();

  // выставляем флаг, что этот участник есть в проекте, либо без этого
  WSMember? taskMemberForId(int? id) => activeMembers.firstWhereOrNull((m) => m.id == id) ?? ws.members.firstWhereOrNull((m) => m.id == id);
  WSMember? get author => taskMemberForId(authorId);
  WSMember? get assignee => taskMemberForId(assigneeId);
}
