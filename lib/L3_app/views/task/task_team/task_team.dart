// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_members.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_button.dart';
import '../../../extra/services.dart';
import '../task_ext_actions.dart';
import '../task_related_widgets/member_list_tile.dart';
import 'task_team_controller.dart';

class TaskTeam extends StatelessWidget {
  const TaskTeam(this.controller);
  final TaskTeamController controller;

  Task get task => controller.task;

  Widget _itemBuilder(BuildContext context, int index) => MemberListTile(task.sortedMembers[index]);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Observer(
        builder: (_) => Column(
              children: [
                if (task.canEditMembers)
                  MTButton.outlined(
                    leading: const PlusIcon(),
                    titleText: loc.member_title,
                    margin: const EdgeInsets.symmetric(horizontal: P_2).copyWith(top: P2),
                    onTap: () async => await controller.addMember(),
                  ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: padding.add(EdgeInsets.only(bottom: padding.bottom > 0 ? 0 : P, top: P_2)),
                    itemBuilder: _itemBuilder,
                    itemCount: task.sortedMembers.length,
                  ),
                ),
              ],
            ));
  }
}
