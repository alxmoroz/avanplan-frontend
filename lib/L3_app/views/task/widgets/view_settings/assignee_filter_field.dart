// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_view.dart';
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

  Task get _task => _vsController.task;

  @override
  Widget build(BuildContext context) {
    return MTField(
      MTFieldData(-1, label: loc.task_assignee_label, placeholder: loc.task_assignee_label),
      leading: const PersonIcon(),
      value: _task.hasFilteredAssignees ? BaseText(_task.filteredAssigneesStr, maxLines: 1) : null,
      onTap: () => showTaskAssigneeFilterDialog(_vsController),
    );
  }
}
