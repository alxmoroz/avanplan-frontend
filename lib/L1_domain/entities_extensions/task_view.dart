// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';
import '../entities/task_view_settings.dart';
import '../entities/ws_member.dart';
import '../entities_extensions/task_members.dart';

extension TaskViewExt on Task {
  bool get showBoard => viewSettings.showBoard;

  TaskViewFilter? get _assigneeFilter => viewSettings.assigneeFilter;
  Iterable<WSMember> get _filteredAssignees => activeMembers.where((m) => (_assigneeFilter?.values ?? []).contains(m.id));

  bool get hasFilteredAssignees => _assigneeFilter?.isNotEmpty == true && _filteredAssignees.isNotEmpty;
  String get filteredAssigneesStr => _filteredAssignees.map((m) => m.viewableName).join(', ');
}
