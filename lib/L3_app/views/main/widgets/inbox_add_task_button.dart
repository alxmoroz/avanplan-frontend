// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../components/adaptive.dart';
import '../../../components/button.dart';
import '../../../components/circle.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/list_tile.dart';
import '../../../components/text.dart';
import '../../../navigation/router.dart';
import '../../../presenters/task_tree.dart';
import '../../../presenters/task_type.dart';
import '../../app/services.dart';
import '../../task/widgets/create/create_task_dialog.dart';

class InboxAddTaskButton extends StatelessWidget {
  const InboxAddTaskButton({super.key, this.standalone = false, this.compact = true});

  final bool standalone;
  final bool compact;

  Future _onTap() async {
    final inbox = tasksMainController.inbox;
    if (inbox != null) {
      final newTC = await createTask(inbox.ws, parent: inbox);
      if (newTC != null) router.goTask(newTC.taskDescriptor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isBigScreen(context) && !standalone
        ? MTListTile(
            leading: const MTCircle(
              size: DEF_TAPPABLE_ICON_SIZE,
              color: mainColor,
              child: InboxAddIcon(size: DEF_TAPPABLE_ICON_SIZE - P2, color: mainBtnTitleColor),
            ),
            middle: compact ? null : BaseText(addTaskActionTitle(), color: mainColor, maxLines: 1),
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
