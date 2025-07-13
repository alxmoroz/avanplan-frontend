// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text.dart';
import '../../../app/services.dart';
import '../../controllers/task_controller.dart';

class TaskAssigneeFilterChip extends StatelessWidget {
  const TaskAssigneeFilterChip(this._tc, {super.key});
  final TaskController _tc;

  @override
  Widget build(BuildContext context) {
    final content = Align(
      alignment: Alignment.centerLeft,
      child: MTButton(
        type: MTButtonType.card,
        color: b1Color,
        minSize: const Size(0, P5),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: P),
            const FilterIcon(color: f2Color),
            const SizedBox(width: P_2),
            SmallText('${loc.task_assignee_label.toLowerCase()}: ', maxLines: 1),
            Flexible(child: SmallText.medium(_tc.settingsController.filteredAssigneesStr, maxLines: 1)),
            const SizedBox(width: P),
            const CloseIcon(color: f2Color, size: P3),
            const SizedBox(width: P_2),
          ],
        ),
        onTap: _tc.settingsController.resetAssigneesFilter,
      ),
    );

    final padding = const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P3);

    return _tc.settingsController.viewMode.isBoard
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
