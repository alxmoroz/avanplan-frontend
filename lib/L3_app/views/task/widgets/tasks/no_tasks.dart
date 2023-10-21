// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/images.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import '../create/task_create_button.dart';
import '../transfer/local_import_dialog.dart';

class NoTasks extends StatelessWidget {
  const NoTasks(this._controller);
  final TaskController _controller;
  Task get _parent => _controller.task;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          MTImage(ImageName.empty_tasks.name),
          H2(
            loc.task_list_empty_title,
            align: TextAlign.center,
            padding: const EdgeInsets.all(P3),
          ),
          if (_parent.canLocalImport || _parent.canCreate) ...[
            BaseText(
              _parent.canLocalImport ? loc.task_list_empty_local_import_hint : loc.task_list_empty_hint,
              align: TextAlign.center,
              padding: const EdgeInsets.symmetric(horizontal: P6),
            ),
            if (_parent.canLocalImport)
              MTButton.secondary(
                margin: const EdgeInsets.only(top: P3),
                leading: const LocalImportIcon(),
                titleText: loc.task_transfer_import_action_title,
                onTap: () => localImportDialog(_controller),
              ),
            if (_parent.canCreate) ...[
              const SizedBox(height: P3),
              TaskCreateButton(_parent.ws, parentTaskController: _controller, compact: false),
            ],
          ],
          // newSubtaskTitle
        ],
      ),
    );
  }
}
