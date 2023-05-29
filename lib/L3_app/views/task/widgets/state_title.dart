// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/text_widgets.dart';
import '../../../presenters/task_state_presenter.dart';

enum StateTitlePlace { workspace, taskOverview, groupHeader, card }

class _StateTitle extends StatelessWidget {
  const _StateTitle(this.state, this.text, {this.place});
  final TaskState state;
  final String text;
  final StateTitlePlace? place;

  @override
  Widget build(BuildContext context) {
    final _textWidget = place == StateTitlePlace.workspace
        ? H2(text, align: TextAlign.center)
        : place == StateTitlePlace.taskOverview
            ? H3(text, align: TextAlign.center)
            : place == StateTitlePlace.groupHeader
                ? H4(text)
                : SmallText(text, color: greyColor);

    final _iconSize = place == StateTitlePlace.workspace
        ? MediaQuery.of(context).size.height / 5
        : place == StateTitlePlace.groupHeader
            ? P * 2.5
            : P * 1.5;
    final _icon = iconForState(state, size: _iconSize);
    return place == StateTitlePlace.workspace
        ? Column(children: [_icon, _textWidget])
        : place == StateTitlePlace.taskOverview
            ? _textWidget
            : Row(children: [_icon, const SizedBox(width: P_3), Expanded(child: _textWidget)]);
  }
}

class GroupStateTitle extends StatelessWidget {
  const GroupStateTitle(this.task, this.subtasksState, {this.place});
  @protected
  final Task task;
  @protected
  final TaskState subtasksState;
  @protected
  final StateTitlePlace? place;

  @override
  Widget build(BuildContext context) => _StateTitle(subtasksState, task.groupStateTitle(subtasksState), place: place);
}

class TaskStateTitle extends StatelessWidget {
  const TaskStateTitle(this.task, {this.place});
  @protected
  final Task task;
  @protected
  final StateTitlePlace? place;

  @override
  Widget build(BuildContext context) {
    final state = place == StateTitlePlace.taskOverview ? task.state : task.overallState;
    final text = place == StateTitlePlace.taskOverview ? task.stateTitle : task.overallStateTitle;
    return _StateTitle(state, text, place: place);
  }
}
