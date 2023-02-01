// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../entities/member.dart';
import '../entities/task.dart';
import '../usecases/task_ext_level.dart';

extension TaskMembersExtension on Task {
  Member? get author => project?.members.firstWhereOrNull((m) => m.id == authorId);
  Member? get assignee => project?.members.firstWhereOrNull((m) => m.id == authorId);
}
