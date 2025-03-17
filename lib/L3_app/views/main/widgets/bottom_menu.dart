// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../components/circle.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/list_tile.dart';
import '../../../components/toolbar.dart';
import '../../../navigation/router.dart';
import '../../app/services.dart';
import 'inbox_add_task_button.dart';

class BottomMenu extends StatelessWidget implements PreferredSizeWidget {
  const BottomMenu({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(P8);

  static const _btnPadding = EdgeInsets.only(top: P2);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        MTBottomBar(
          key: const ValueKey('BottomMenu'),
          color: b3Color,
          topPadding: 0,
          middle: Row(
            children: [
              Flexible(
                child: MTListTile(
                  middle: const InboxIcon(size: P6),
                  color: Colors.transparent,
                  padding: _btnPadding,
                  bottomDivider: false,
                  onTap: () => router.goTask(tasksMainController.inbox!, direct: true),
                ),
              ),
              const Spacer(),
              Flexible(
                child: MTListTile(
                  middle: const ProjectsIcon(size: P6),
                  color: Colors.transparent,
                  padding: _btnPadding,
                  bottomDivider: false,
                  onTap: router.goProjects,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: P12 + P7,
          child: MTCircle(
            size: P12 + P,
            color: b3Color,
            child: UnconstrainedBox(child: InboxAddTaskButton()),
          ),
        ),
      ],
    );
  }
}
