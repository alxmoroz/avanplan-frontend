// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../presenters/task_state.dart';

enum StateTitlePlace { groupHeader, card }

class StateTitle extends StatelessWidget {
  const StateTitle(this.state, this.text, {this.place, super.key});
  final TaskState state;
  final String text;
  final StateTitlePlace? place;

  @override
  Widget build(BuildContext context) {
    return place == StateTitlePlace.groupHeader
        ? MTListGroupTitle(
            leading: Padding(padding: const EdgeInsets.only(top: P2), child: stateIconGroup(context, state)),
            middle: SmallText(text, maxLines: 1, weight: FontWeight.w500, color: f3Color),
            padding: EdgeInsets.zero,
          )
        : SmallText(text);
  }
}

class GroupStateTitle extends StatelessWidget {
  const GroupStateTitle(this.groupState, {super.key, this.place});
  final TaskState groupState;
  final StateTitlePlace? place;

  @override
  Widget build(BuildContext context) => Padding(
        padding: (place == StateTitlePlace.groupHeader ? const EdgeInsets.symmetric(horizontal: P2) : EdgeInsets.zero),
        child: StateTitle(groupState, groupStateTitle(groupState), place: place),
      );
}
