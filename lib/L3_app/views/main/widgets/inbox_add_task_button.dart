// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/adaptive.dart';
import '../../../components/button.dart';
import '../../../components/circle.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/list_tile.dart';
import '../../../components/text.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_type.dart';
import '../../../usecases/task_tree.dart';
import '../../../usecases/ws_tasks.dart';
import '../../task/controllers/task_controller.dart';

class InboxAddTaskButton extends StatelessWidget {
  const InboxAddTaskButton({super.key, this.standalone = false, this.compact = true});

  final bool standalone;
  final bool compact;

  Task get _inbox => tasksMainController.inbox;

  Future _onTap() async {
    final parent = _inbox;
    final newTask = await parent.ws.createTask(parent);
    if (newTask != null) {
      await TaskController(newTask, isNew: true).showTask();
    }
  }

  @override
  Widget build(BuildContext context) {
    final big = isBigScreen(context);
    final size = big ? P12 : P11;
    return big && !standalone
        ? MTListTile(
            leading: const MTCircle(
              size: P6,
              color: mainColor,
              child: InboxAddIcon(size: P4, color: mainBtnTitleColor),
            ),
            middle: compact ? null : BaseText(addSubtaskActionTitle(_inbox), color: mainColor, maxLines: 1),
            bottomDivider: false,
            onTap: _onTap,
          )
        : MTButton.main(
            middle: const InboxAddIcon(color: mainBtnTitleColor, size: P6),
            constrained: false,
            minSize: Size(size, size),
            onTap: _onTap,
          );
  }
}
