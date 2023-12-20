// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/text.dart';
import '../../../../components/text_field.dart';
import '../../../../presenters/task_state.dart';
import '../../../../presenters/task_view.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../analytics/analytics_dialog.dart';
import '../analytics/timing_chart.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader(this._controller);
  final TaskController _controller;

  Task get _task => _controller.task!;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Название родителя
          if (_task.parent != null)
            MTField(
              _controller.fData(TaskFCode.parent.index),
              value: BaseText(_task.parent!.title, maxLines: 1),
              padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: kIsWeb ? P : 0),
              color: Colors.transparent,
              minHeight: P4,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),

          /// Название
          MTField(
            _controller.fData(TaskFCode.title.index),
            value: MTTextField(
              controller: _controller.teController(TaskFCode.title.index),
              readOnly: !_task.canEdit,
              autofocus: _controller.creating,
              margin: EdgeInsets.zero,
              maxLines: 5,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: _controller.titleController.titlePlaceholder,
                hintStyle: const H1('', color: f3Color).style(context),
              ),
              style: const H1('').style(context),
              onChanged: _controller.titleController.editTitle,
            ),
            padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: kIsWeb ? P : 0),
            color: Colors.transparent,
          ),

          /// Дашборд (аналитика, команда)
          if (_task.hasAnalytics || _task.hasTeam)
            Container(
              constraints: const BoxConstraints(maxHeight: 150),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: P3),

                  /// Аналитика
                  if (_task.hasAnalytics)
                    MTAdaptive.xxs(
                      child: MTCardButton(
                        padding: const EdgeInsets.all(P2),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BaseText.f2(_task.overallStateTitle, align: TextAlign.center, maxLines: 2, padding: const EdgeInsets.only(bottom: P2)),
                            TimingChart(_task, showDueLabel: false),
                          ],
                        ),
                        onTap: () => showAnalyticsDialog(_task),
                      ),
                    ),
                  const SizedBox(width: P3),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
