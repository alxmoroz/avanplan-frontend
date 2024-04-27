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
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_type.dart';
import '../../../usecases/task_tree.dart';
import '../../../usecases/ws_tasks.dart';

class InboxAddTaskButton extends StatelessWidget {
  const InboxAddTaskButton({super.key, this.standalone = false, this.compact = true});

  final bool standalone;
  final bool compact;

  Task? get _inbox => tasksMainController.inbox;

  Future _onTap() async {
    if (_inbox != null) {
      final newTask = await _inbox!.ws.createTask(_inbox!);
      if (newTask != null) {
        goRouter.goLocalTask(newTask, extra: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isBigScreen(context) && !standalone
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
            minSize: const Size(P11, P11),
            onTap: _onTap,
          );
  }
}
