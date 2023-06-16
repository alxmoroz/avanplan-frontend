// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_dialog.dart';
import '../../components/mt_text_field.dart';
import '../../components/mt_toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/task_level_presenter.dart';
import '../../presenters/ws_presenter.dart';
import 'task_edit_controller.dart';
import 'task_view_controller.dart';

class EditTaskResult {
  const EditTaskResult(this.task, [this.proceed]);
  final Task task;
  final bool? proceed;
}

Future<EditTaskResult?> editTaskDialog(TaskEditController controller) async => await showMTDialog<EditTaskResult?>(TaskEditView(controller));

class TaskEditView extends StatefulWidget {
  const TaskEditView(this.controller);

  final TaskEditController controller;

  @override
  _TaskEditViewState createState() => _TaskEditViewState();
}

class _TaskEditViewState extends State<TaskEditView> {
  TaskEditController get controller => widget.controller;

  /// общий виджет - форма с полями для задач и целей

  Widget form(BuildContext context) {
    final fd = controller.fData(TaskFCode.title.index);
    return ListView(
      shrinkWrap: true,
      children: [
        MTTextField(
          controller: controller.teController(TaskFCode.title.index),
          label: fd.label,
          error: fd.errorText,
          margin: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P_2),
        ),
        const SizedBox(height: P2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MTButton(
              constrained: !controller.isNew,
              titleText: loc.save_action_title,
              onTap: controller.validated ? controller.save : null,
              padding: const EdgeInsets.symmetric(horizontal: P2),
              type: controller.isNew ? ButtonType.secondary : ButtonType.main,
            ),
            if (controller.isNew)
              MTButton.main(
                constrained: false,
                titleText: controller.saveAndGoBtnTitle,
                onTap: controller.validated ? () => controller.save(proceed: true) : null,
                margin: const EdgeInsets.only(left: P),
                padding: const EdgeInsets.symmetric(horizontal: P2),
              ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTTopBar(
          middle: controller.isNew ? controller.ws.subPageTitle(controller.parent.newSubtaskTitle) : null,
          trailing: !controller.isNew
              ? MTButton.icon(
                  const DeleteIcon(),
                  controller.delete,
                  margin: const EdgeInsets.only(right: P),
                )
              : null,
        ),
        body: form(context),
      ),
    );
  }
}
