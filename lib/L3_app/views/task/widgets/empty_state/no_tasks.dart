// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/images.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../controllers/task_controller.dart';
import '../create/create_task_button.dart';

class NoTasks extends StatelessWidget {
  const NoTasks(this._tc, {super.key});
  final TaskController _tc;

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
            if (t.isProject)
              CreateTaskButton(
                _tc,
                type: TType.GOAL,
                compact: false,
                buttonType: ButtonType.secondary,
                margin: const EdgeInsets.only(top: P3),
              ),
            CreateTaskButton(
              _tc,
              compact: false,
              buttonType: ButtonType.main,
              margin: const EdgeInsets.only(top: P3),
            ),
          ],
        ],
      );
    });
  }
}
