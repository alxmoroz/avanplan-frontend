// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/mt_adaptive.dart';
import '../../../components/mt_divider.dart';
import '../../../components/text_widgets.dart';
import '../../../presenters/task_colors_presenter.dart';
import '../../../presenters/task_level_presenter.dart';
import '../task_view_controller.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader(this.controller);
  final TaskViewController controller;

  Task get _task => controller.task;
  String get _breadcrumbs => _task.parent!.parentsTitles.join(' > ');

  @override
  Widget build(BuildContext context) {
    return MTAdaptive(
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_task.bgColor.resolve(context), backgroundColor.resolve(context)],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: P),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_breadcrumbs.isNotEmpty) ...[
              SmallText(_breadcrumbs),
              const MTDivider(),
            ],
            H2(_task.title),
            const SizedBox(height: P),
          ],
        ),
      ),
      force: true,
    );
  }
}
