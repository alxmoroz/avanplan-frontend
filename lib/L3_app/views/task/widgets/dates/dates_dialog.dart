// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_dates.dart';
import '../../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/dialog.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_actions.dart';
import '../../../_base/loader_screen.dart';
import '../../controllers/task_controller.dart';
import 'due_date_field.dart';
import 'repeat_field.dart';
import 'start_date_field.dart';

Future showTaskDatesDialog(TaskController controller) async => await showMTDialog(_DatesDialog(controller));

class _DatesDialog extends StatelessWidget {
  const _DatesDialog(this._controller);
  final TaskController _controller;

  Task get t => _controller.task;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _controller.loading
          ? LoaderScreen(_controller, isDialog: true)
          : MTDialog(
              topBar: MTAppBar(
                showCloseButton: true,
                color: b2Color,
                pageTitle: loc.task_dates,
                parentPageTitle: t.title,
              ),
              body: ListView(
                shrinkWrap: true,
                children: [
                  if (!t.isInbox) TaskStartDateField(_controller),
                  if (t.hasDueDate || t.canEdit) TaskDueDateField(_controller),
                  if (t.hasRepeat || t.canEdit) TaskRepeatField(_controller),
                ],
              ),
            ),
    );
  }
}
