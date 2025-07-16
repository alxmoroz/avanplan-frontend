// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../presenters/task_create_method.dart';
import '../../theme/text.dart';
import '../app/services.dart';
import 'creation_dialog.dart';

class CreationProjectBigButtons extends StatelessWidget {
  const CreationProjectBigButtons({super.key});

  Widget _btnLayout(Widget icon, String title, String subtitle, Function() onTap) {
    return MTCardButton(
      padding: EdgeInsets.zero,
      middle: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: P5),
          icon,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                H3(title, align: TextAlign.center),
                if (subtitle.isNotEmpty) SmallText(subtitle, align: TextAlign.center),
              ],
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _methodButton(TaskCreationMethod method) {
    return _btnLayout(
      method.btnIcon(size: P7),
      method.actionTitle,
      method.actionDescriptionShort,
      () => wsMainController.startCreateProject(method),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MTAdaptive.s(
      child: GridView(
        padding: const EdgeInsets.symmetric(horizontal: DEF_VP * 2),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: DEF_HP,
          mainAxisSpacing: DEF_HP,
        ),
        children: [
          for (var m in [TaskCreationMethod.BOARD, TaskCreationMethod.LIST, TaskCreationMethod.PROJECT]) _methodButton(m),
          _btnLayout(
            const MenuHorizontalIcon(size: P7),
            loc.create_more_action_title,
            loc.create_more_action_description_short,
            ProjectCreationDialog.startCreateProject,
          )
        ],
      ),
    );
  }
}
