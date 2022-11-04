// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_state.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/text_widgets.dart';
import '../../../presenters/state_presenter.dart';

enum TaskStateTitleStyle { L, M, S, XS }

class _StateTitle extends StatelessWidget {
  const _StateTitle(this.state, this.text, {this.style});
  final TaskState state;
  final String text;
  final TaskStateTitleStyle? style;

  Widget get _textWidget => style == TaskStateTitleStyle.L
      ? H2(text, align: TextAlign.center)
      : style == TaskStateTitleStyle.M
          ? H3(text, align: TextAlign.center)
          : style == TaskStateTitleStyle.S
              ? H4(text)
              : SmallText(text, color: darkGreyColor);

  double get _iconSize =>
      onePadding *
      (style == TaskStateTitleStyle.L
          ? 12
          : style == TaskStateTitleStyle.S
              ? 2.5
              : 1.5);

  Widget get _icon => iconForState(state, size: _iconSize);

  @override
  Widget build(BuildContext context) => style == TaskStateTitleStyle.L
      ? Column(children: [_icon, _textWidget])
      : style == TaskStateTitleStyle.M
          ? _textWidget
          : Row(children: [_icon, SizedBox(width: onePadding / 3), Expanded(child: _textWidget)]);
}

class SubtasksStateTitle extends StatelessWidget {
  const SubtasksStateTitle(this.task, this.subtasksState, {this.style});
  @protected
  final Task task;
  @protected
  final TaskState subtasksState;
  @protected
  final TaskStateTitleStyle? style;

  @override
  Widget build(BuildContext context) => _StateTitle(subtasksState, task.groupStateTitle(subtasksState), style: style);
}

class TaskStateTitle extends StatelessWidget {
  const TaskStateTitle(this.task, {this.style});
  @protected
  final Task task;
  @protected
  final TaskStateTitleStyle? style;

  @override
  Widget build(BuildContext context) => _StateTitle(task.state, task.stateTitle, style: style);
}
