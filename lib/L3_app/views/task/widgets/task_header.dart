// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/mt_adaptive.dart';
import '../../../components/mt_divider.dart';
import '../../../components/mt_field.dart';
import '../../../components/mt_text_field.dart';
import '../../../components/text_widgets.dart';
import '../../../presenters/task_colors_presenter.dart';
import '../../../presenters/task_level_presenter.dart';
import '../../../usecases/task_ext_actions.dart';
import '../task_view_controller.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader(this.controller);
  final TaskViewController controller;

  Task get _task => controller.task;

  @override
  Widget build(BuildContext context) {
    final _breadcrumbs = _task.parent!.parentsTitles.join(' > ');
    final _titlePlaceholder = controller.titlePlaceholder;
    return Observer(
      builder: (_) => MTAdaptive(
        force: true,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [_task.bgColor.resolve(context), backgroundColor.resolve(context)],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: P),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_breadcrumbs.isNotEmpty) ...[
                SmallText(_breadcrumbs),
                const MTDivider(),
              ],
              MTField(
                controller.fData(TaskFCode.title.index),
                value: MTTextField(
                  controller: controller.teController(TaskFCode.title.index),
                  readOnly: !_task.canUpdate,
                  autofocus: controller.isNew,
                  margin: EdgeInsets.zero,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    hintText: _titlePlaceholder,
                    hintStyle: const H1('', color: lightGreyColor).style(context),
                  ),
                  style: const H1('').style(context),
                  onChanged: controller.editTitle,
                ),
                padding: EdgeInsets.zero,
                color: backgroundColor,
              ),
              const SizedBox(height: P_2),
            ],
          ),
        ),
      ),
    );
  }
}
