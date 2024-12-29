// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/field.dart';
import '../../../../components/field_data.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../app/services.dart';
import '../../controllers/task_settings_controller.dart';
import 'assignee_filter_dialog.dart';

class TasksAssigneeFilterField extends StatelessWidget {
  const TasksAssigneeFilterField(this._tsc, {super.key});
  final TaskSettingsController _tsc;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTField(
        MTFieldData(-1, label: loc.task_assignee_label, placeholder: loc.task_assignee_label),
        leading: const PersonIcon(),
        value: _tsc.hasFilteredAssignees ? BaseText(_tsc.filteredAssigneesStr, maxLines: 1) : null,
        onTap: () => showTaskAssigneeFilterDialog(_tsc),
      ),
    );
  }
}
