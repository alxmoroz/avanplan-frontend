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

  @override
  Widget build(BuildContext context) {
    final _textWidget = style == TaskStateTitleStyle.L
        ? H2(text, align: TextAlign.center)
        : style == TaskStateTitleStyle.M
            ? H3(text, align: TextAlign.center)
            : style == TaskStateTitleStyle.S
                ? H4(text)
                : SmallText(text, color: darkGreyColor);

    final _iconSize = style == TaskStateTitleStyle.L
        ? MediaQuery.of(context).size.height / 5
        : style == TaskStateTitleStyle.S
            ? P * 2.5
            : P * 1.5;
    final _icon = iconForState(state, size: _iconSize);
    return style == TaskStateTitleStyle.L
        ? Column(children: [_icon, _textWidget])
        : style == TaskStateTitleStyle.M
            ? _textWidget
            : Row(children: [_icon, const SizedBox(width: P_3), Expanded(child: _textWidget)]);
  }
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
