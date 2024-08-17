// Copyright (c) 2023. Alexandr Moroz

import '../entities/task.dart';

extension TaskParamsExtension on Task {
  bool get hasEstimate => estimate != null;
  bool get didImported => taskSource != null;

  bool get hasDescription => description.isNotEmpty;
  bool get hasStatus => projectStatusId != null;
  bool get hasAssignee => assigneeId != null;
  bool get hasAuthor => authorId != null;
}
