// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../entities/member.dart';
import '../entities/task.dart';
import '../usecases/task_ext_level.dart';

extension TaskMembersExtension on Task {
  List<Member> get projectMembers => project?.members ?? [];
  List<Member> get sortedMembers => projectMembers.sorted((m1, m2) => compareNatural('$m1', '$m2'));

  Member? get author => projectMembers.firstWhereOrNull((m) => m.id == authorId);
  Member? get assignee => projectMembers.firstWhereOrNull((m) => m.id == authorId);
  List<Member> get activeMembers => sortedMembers.where((m) => m.isActive).toList();
}
