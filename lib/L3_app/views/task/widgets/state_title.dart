// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/constants.dart';
import '../../../components/text.dart';
import '../../../presenters/task_state.dart';

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
              stateIconGroup(context, state),
              const SizedBox(width: P2),
              Expanded(
                child: NormalText(
                  text,
                  padding: const EdgeInsets.only(bottom: P),
                ),
              ),
            ],
          )
        : place == StateTitlePlace.taskOverview
            ? H3(text, align: TextAlign.center)
            : SmallText(text);
  }
}

class GroupStateTitle extends StatelessWidget {
  const GroupStateTitle(this.groupState, {this.place});
  final TaskState groupState;
  final StateTitlePlace? place;

  @override
  Widget build(BuildContext context) => Padding(
        padding: (place == StateTitlePlace.groupHeader ? const EdgeInsets.symmetric(horizontal: P2).copyWith(top: P2) : EdgeInsets.zero),
        child: _StateTitle(groupState, groupStateTitle(groupState), place: place),
      );
}

class TaskStateTitle extends StatelessWidget {
  const TaskStateTitle(this.task, {this.place});
  final Task task;
  final StateTitlePlace? place;

  @override
  Widget build(BuildContext context) {
    return _StateTitle(task.overallState, place == StateTitlePlace.card ? task.overallStateTitle : task.stateTitle, place: place);
  }
}
