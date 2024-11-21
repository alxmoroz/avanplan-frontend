// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/images.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_actions.dart';
import '../../../../presenters/task_type.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/edit.dart';
import '../transfer/local_import_dialog.dart';

class NoTasks extends StatelessWidget {
  const NoTasks(this._tc, {super.key});
  final TaskController _tc;

  Widget _addBtn({bool goal = false, double leftMargin = 0}) {
    return MTButton.main(
      leading: const PlusIcon(color: mainBtnTitleColor),
      margin: EdgeInsets.only(left: leftMargin, top: P3),
      titleText: goal
          ? loc.goal_title
          : leftMargin > 0
              ? loc.task_title
              : addTaskActionTitle(),
      constrained: false,
      onTap: () => _tc.addSubtask(type: goal ? TType.GOAL : TType.TASK),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final t = _tc.task;
      final canCreate = _tc.canCreate;
      return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(height: P3),
          MTImage(ImageName.empty_tasks.name),
          H2(loc.task_list_empty_title, align: TextAlign.center, padding: const EdgeInsets.all(P3)),
          if (canCreate) ...[
            BaseText(
              t.isProject ? loc.task_list_empty_in_project_hint : loc.task_list_empty_hint,
              align: TextAlign.center,
              padding: const EdgeInsets.symmetric(horizontal: P6),
            ),
            if (t.canLocalImport)
              MTButton.secondary(
                margin: const EdgeInsets.only(top: P3),
                leading: const LocalImportIcon(),
                titleText: loc.action_transfer_import_tasks_title,
                onTap: () => localImportDialog(_tc),
              ),
            MTAdaptive.xxs(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (t.isProject) Expanded(child: _addBtn(goal: true)),
                  Expanded(child: _addBtn(leftMargin: t.isProject ? P2 : 0)),
                ],
              ),
            )
          ],
        ],
      );
    });
  }
}
