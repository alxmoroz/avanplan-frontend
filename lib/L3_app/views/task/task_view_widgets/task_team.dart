// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_members.dart';
import '../../../components/constants.dart';
import '../task_related_widgets/member_list_tile.dart';
import '../task_view_controller.dart';

class TaskTeam extends StatelessWidget {
  const TaskTeam(this.controller);
  final TaskViewController controller;

  Task get task => controller.task;

  Widget _itemBuilder(BuildContext context, int index) => MemberListTile(task.sortedMembers[index]);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Observer(
      builder: (_) => ListView.builder(
        padding: padding.add(EdgeInsets.only(bottom: padding.bottom > 0 ? 0 : P, top: P_2)),
        itemBuilder: _itemBuilder,
        itemCount: task.sortedMembers.length,
      ),
    );
  }
}
