// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task_view_settings.dart';
import '../../../../../L1_domain/entities/ws_member.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../components/field.dart';
import '../../../../components/field_data.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import 'assignee_filter_dialog.dart';
import 'view_settings_controller.dart';

class TasksAssigneeFilterField extends StatelessWidget {
  const TasksAssigneeFilterField(this._vsController, {super.key});
  final TaskViewSettingsController _vsController;

  TaskViewFilter? get _assigneeFilter => _vsController.filters.firstWhereOrNull((f) => f.isAssignee);
  Iterable<WSMember> get _filteredAssignees => _vsController.task.activeMembers.where((m) => (_assigneeFilter?.values ?? []).contains(m.id));
  String get _filteredAssigneesStr => _filteredAssignees.map((m) => m.fullName).join(', ');

  @override
  Widget build(BuildContext context) {
    return MTField(
      MTFieldData(-1, label: loc.task_assignee_label, placeholder: loc.task_assignee_label),
      leading: const PersonIcon(),
      value: _filteredAssignees.isNotEmpty ? BaseText(_filteredAssigneesStr, maxLines: 1) : null,
      onTap: () => showTaskAssigneeFilterDialog(_vsController),
    );
  }
}
