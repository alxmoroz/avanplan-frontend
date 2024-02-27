// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../components/adaptive.dart';
import '../../../components/button.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../extra/services.dart';
import '../../../usecases/task_tree.dart';
import '../../../usecases/ws_tasks.dart';
import '../../task/controllers/task_controller.dart';

class FastAddTaskButton extends StatelessWidget {
  const FastAddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    final big = isBigScreen(context);
    final size = big ? P12 : P11;
    return MTButton.main(
      middle: const PlusIcon(color: mainBtnTitleColor, size: P6),
      constrained: false,
      minSize: Size(size, size),
      onTap: () async {
        final parent = tasksMainController.inbox;
        final newTask = await parent.ws.createTask(parent);
        if (newTask != null) {
          await TaskController(newTask, isNew: true).showTask();
        }
      },
    );
  }
}
