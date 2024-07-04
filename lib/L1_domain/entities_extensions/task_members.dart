// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities_extensions/ws_members.dart';
import '../../L3_app/usecases/task_tree.dart';
import '../entities/member.dart';
import '../entities/task.dart';

extension TaskMembersExtension on Task {
  TaskMember? memberForId(int? id) => projectMembers.firstWhereOrNull((m) => m.id == id);

  Iterable<TaskMember> get projectMembers => project.members;
  List<TaskMember> get sortedMembers => projectMembers.sorted((m1, m2) => compareNatural('$m1', '$m2'));
  WSMember? get author => ws.memberForId(authorId);
  WSMember? get assignee => ws.memberForId(assigneeId);
  List<TaskMember> get activeMembers => sortedMembers.where((m) => m.isActive).toList();
}
