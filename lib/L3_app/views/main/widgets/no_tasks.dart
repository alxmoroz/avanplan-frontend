// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../components/adaptive.dart';
import '../../../components/button.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/images.dart';
import '../../../components/list_tile.dart';
import '../../../navigation/router.dart';
import '../../../theme/colors.dart';
import '../../../theme/text.dart';
import '../../app/services.dart';
import '../../projects/create_project_button.dart';
import '../../projects/create_project_controller.dart';
import 'inbox_add_task_button.dart';

class NoTasks extends StatelessWidget {
  const NoTasks(this._controller, {super.key});
  final CreateProjectController _controller;

  bool get _hasOpenedProjects => tasksMainController.hasOpenedProjects;
  bool get _isAllProjectsClosed => tasksMainController.isAllProjectsClosed;
  bool get _freshStart => tasksMainController.freshStart;
  bool get _canPlan => tasksMainController.canPlan;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final big = isBigScreen(context);
        return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const SizedBox(height: P12 + P6),
            MTImage((_freshStart
                    ? ImageName.ok_blue
                    : _isAllProjectsClosed
                        ? ImageName.ok
                        : ImageName.empty_tasks)
                .name),
            MTListText.h2(
              _freshStart ? loc.lets_get_started : loc.task_list_empty_title,
              titleTextAlign: TextAlign.center,
            ),
            MTListText(
              _freshStart ? loc.project_list_empty_hint : loc.task_list_schedule_hint,
              titleTextAlign: TextAlign.center,
              titleTextMaxLines: 5,
            ),
            if (_canPlan)
              MTButton.secondary(
                titleText: loc.task_list_schedule_action_title,
                margin: const EdgeInsets.only(top: P3),
                onTap: router.goProjects,
              ),
            if (!_hasOpenedProjects) ...[
              const SizedBox(height: P3),
              CreateProjectButton(_controller, type: MTButtonType.main),
            ],
            if (_freshStart) ...[
              const SizedBox(height: P7),
              BaseText(loc.my_tasks_add_action_hint, align: TextAlign.center, maxLines: 2),
              const SizedBox(height: P3),
              const ArrowDownIcon(size: P6, color: f2Color),
              if (big) ...[
                const SizedBox(height: P3),
                const Align(child: InboxAddTaskButton(standalone: true)),
              ],
            ]
          ],
        );
      },
    );
  }
}
