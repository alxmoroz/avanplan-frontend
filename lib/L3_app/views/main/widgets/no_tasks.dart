// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/images.dart';
import '../../../components/list_tile.dart';
import '../../../theme/colors.dart';
import '../../app/services.dart';
import '../../projects/creation_big_buttons.dart';
import 'inbox_add_task_button.dart';

class NoTasks extends StatelessWidget {
  const NoTasks({this.hintArrowText = '', super.key});
  final String hintArrowText;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final hasOpenedProjects = tasksMainController.hasOpenedProjects;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (hasOpenedProjects) ...[
              MTImage(ImageName.empty_tasks.name),
              MTListText.h2(loc.task_list_empty_title, titleTextAlign: TextAlign.center),
            ] else ...[
              MTListText.h2(
                loc.lets_get_started,
                titleTextAlign: TextAlign.center,
                titleTextColor: f2Color,
              ),
              const SizedBox(height: DEF_VP * 3),
              const CreationProjectBigButtons(),
              if (hintArrowText.isNotEmpty) ...[
                const SizedBox(height: DEF_VP * 3),
                MTListText(
                  hintArrowText,
                  titleTextAlign: TextAlign.center,
                  titleTextMaxLines: 2,
                ),
                const SizedBox(height: DEF_VP),
                const ArrowDownIcon(size: P6, color: f2Color),
                const SizedBox(height: DEF_VP),
                const Align(child: InboxAddTaskButton(standalone: true)),
              ] else
                const SizedBox(height: DEF_BAR_HEIGHT),
            ],
          ],
        );
      },
    );
  }
}
