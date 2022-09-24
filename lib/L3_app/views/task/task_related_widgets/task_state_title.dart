// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/text_widgets.dart';
import '../../../presenters/task_state_presenter.dart';

enum TaskStateTitleStyle { L, M, S }

class TaskStateTitle extends StatelessWidget {
  const TaskStateTitle(this.task, {this.style, this.forSubtasks = false});
  @protected
  final Task task;
  @protected
  final TaskStateTitleStyle? style;
  @protected
  final bool forSubtasks;

  String get _text => forSubtasks ? task.subtasksStateTitle : task.stateTitle;

  Widget get _textWidget => style == TaskStateTitleStyle.L
      ? H3(_text, align: TextAlign.center)
      : style == TaskStateTitleStyle.M
          ? NormalText(_text)
          : SmallText(_text, color: darkGreyColor);

  double get _iconSize =>
      onePadding *
      (style == TaskStateTitleStyle.L
          ? 12
          : style == TaskStateTitleStyle.M
              ? 3
              : 1.7);

  // forSubtasks
  Widget _icon(BuildContext context) => forSubtasks ? task.subtasksStateIcon(context, size: _iconSize) : task.stateIcon(context, size: _iconSize);

  @override
  Widget build(BuildContext context) => style != TaskStateTitleStyle.L
      ? Row(
          children: [
            _icon(context),
            SizedBox(width: onePadding / 3),
            _textWidget,
          ],
        )
      : Column(
          children: [
            _icon(context),
            _textWidget,
          ],
        );
}
