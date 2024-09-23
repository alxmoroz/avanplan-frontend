// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_view.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_actions.dart';
import '../../controllers/task_controller.dart';
import 'view_settings_controller.dart';

class TaskAssigneeFilterChip extends StatelessWidget {
  const TaskAssigneeFilterChip(this._controller, {super.key});
  final TaskController _controller;

  Task get _task => _controller.task;

  @override
  Widget build(BuildContext context) {
    final content = Align(
      alignment: Alignment.centerLeft,
      child: MTButton(
        type: ButtonType.card,
        color: b1Color,
        minSize: const Size(0, P5),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: P),
            const FilterIcon(color: f2Color),
            const SizedBox(width: P_2),
            SmallText('${loc.task_assignee_label.toLowerCase()}: ', maxLines: 1),
            Flexible(child: SmallText(_task.filteredAssigneesStr, maxLines: 1, weight: FontWeight.w500)),
            const SizedBox(width: P),
            const CloseIcon(color: f2Color, size: P3),
            const SizedBox(width: P_2),
          ],
        ),
        onTap: TaskViewSettingsController(_controller).resetAssigneesFilter,
      ),
    );

    final padding = const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P3);

    return _task.canShowBoard && _task.showBoard
        ? Padding(
            padding: padding,
            child: content,
          )
        : MTAdaptive(
            padding: padding,
            child: content,
          );
  }
}
