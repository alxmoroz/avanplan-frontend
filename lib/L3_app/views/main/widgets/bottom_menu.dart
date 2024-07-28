// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../components/circle.dart';
import '../../../components/colors.dart';
import '../../../components/colors_base.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/list_tile.dart';
import '../../../components/toolbar.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import 'inbox_add_task_button.dart';

class BottomMenu extends StatelessWidget implements PreferredSizeWidget {
  const BottomMenu({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(P8);

  static const _btnPadding = EdgeInsets.only(top: P2);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          MTAppBar(
            isBottom: true,
            color: b2Color,
            middle: Row(
              children: [
                Flexible(
                  child: MTListTile(
                    middle: const InboxIcon(color: mainColor, size: P6),
                    color: Colors.transparent,
                    padding: _btnPadding,
                    bottomDivider: false,
                    onTap: () => router.goTaskView(tasksMainController.inbox!, direct: true),
                  ),
                ),
                const Spacer(),
                Flexible(
                  child: MTListTile(
                    middle: const ProjectsIcon(color: mainColor, size: P6),
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
              color: b2Color,
              child: UnconstrainedBox(child: InboxAddTaskButton()),
            ),
          ),
        ],
      ),
    );
  }
}
