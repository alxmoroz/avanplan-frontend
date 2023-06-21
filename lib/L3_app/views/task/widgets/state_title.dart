// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/text_widgets.dart';
import '../../../presenters/task_state_presenter.dart';

enum StateTitlePlace { taskOverview, groupHeader, card }

class _StateTitle extends StatelessWidget {
  const _StateTitle(this.state, this.text, {this.place});
  final TaskState state;
  final String text;
  final StateTitlePlace? place;

  @override
  Widget build(BuildContext context) {
    return place == StateTitlePlace.groupHeader
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              stateIconGroup(state),
              const SizedBox(width: P),
              Expanded(
                child: NormalText(
                  text,
                  padding: const EdgeInsets.only(bottom: P_2),
                ),
              ),
            ],
          )
        : place == StateTitlePlace.taskOverview
            ? H3(text, align: TextAlign.center)
            : SmallText(text, color: greyColor);
  }
}

class GroupStateTitle extends StatelessWidget {
  const GroupStateTitle(this.task, this.groupState, {this.place});
  final Task task;
  final TaskState groupState;
  final StateTitlePlace? place;

  @override
  Widget build(BuildContext context) => Padding(
        padding: (place == StateTitlePlace.groupHeader ? const EdgeInsets.symmetric(horizontal: P).copyWith(top: P) : EdgeInsets.zero),
        child: _StateTitle(groupState, task.groupStateTitle(groupState), place: place),
      );
}

class TaskStateTitle extends StatelessWidget {
  const TaskStateTitle(this.task, {this.place});
  final Task task;
  final StateTitlePlace? place;

  @override
  Widget build(BuildContext context) {
    final state = place == StateTitlePlace.taskOverview ? task.state : task.overallState;
    final text = place == StateTitlePlace.taskOverview ? task.stateTitle : task.overallStateTitle;
    return _StateTitle(state, text, place: place);
  }
}
