// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L3_app/usecases/task_tree.dart';
import '../entities/member.dart';
import '../entities/task.dart';

extension TaskMembersExtension on Task {
  Member? memberForId(int? id) => projectMembers.firstWhereOrNull((m) => m.id == id);

  Iterable<Member> get projectMembers => project?.members ?? [];
  List<Member> get sortedMembers => projectMembers.sorted((m1, m2) => compareNatural('$m1', '$m2'));
  Member? get author => memberForId(authorId);
  Member? get assignee => memberForId(assigneeId);
  List<Member> get activeMembers => sortedMembers.where((m) => m.isActive).toList();
}
