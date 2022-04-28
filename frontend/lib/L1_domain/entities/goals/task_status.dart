// Copyright (c) 2022. Alexandr Moroz

import '../auth/workspace.dart';
import '../base_entity.dart';

class TaskStatus extends Statusable {
  TaskStatus({
    required int id,
    required String title,
    required bool closed,
    required this.workspace,
  }) : super(id: id, title: title, closed: closed);

  final Workspace workspace;
}
