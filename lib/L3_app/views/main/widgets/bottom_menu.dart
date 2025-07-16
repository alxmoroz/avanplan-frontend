// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../components/circle.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/list_tile.dart';
import '../../../components/toolbar.dart';
import '../../../navigation/router.dart';
import '../../../theme/colors.dart';
import '../../app/services.dart';
import 'inbox_add_task_button.dart';

class BottomMenu extends StatelessWidget implements PreferredSizeWidget {
  const BottomMenu({this.hintArrowText = '', this.full = true, super.key});
  final String hintArrowText;
  final bool full;

  @override
  Size get preferredSize => Size.fromHeight(full ? P8 : 0);

  static const _btnPadding = EdgeInsets.only(top: P2);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        if (full)
          MTBottomBar(
            key: const ValueKey('BottomMenu'),
            color: b3Color,
            topPadding: 0,
            middle: Row(
              children: [
                Flexible(
                  child: MTListTile(
                    middle: const InboxIcon(size: P6),
                    padding: _btnPadding,
                    onTap: () => router.goTask(tasksMainController.inbox!, direct: true),
                  ),
                ),
                const Spacer(),
                Flexible(
                  child: MTListTile(
                    middle: const ProjectsIcon(size: P6),
                    padding: _btnPadding,
                    onTap: router.goProjects,
                  ),
                ),
              ],
            ),
          ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hintArrowText.isNotEmpty) ...[
              MTListText(
                hintArrowText,
                titleTextAlign: TextAlign.center,
                titleTextMaxLines: 2,
              ),
              const SizedBox(height: DEF_VP),
              const ArrowDownIcon(size: P6, color: f2Color),
              const SizedBox(height: DEF_VP),
            ],
            SafeArea(
              top: false,
              bottom: false,
              minimum: EdgeInsets.only(bottom: P4 + (full ? 0 : P)),
              child: full
                  ? const MTCircle(
                      size: P12 + P,
                      color: b3Color,
                      child: UnconstrainedBox(child: InboxAddTaskButton()),
                    )
                  : const InboxAddTaskButton(),
            ),
          ],
        ),
      ],
    );
  }
}
