// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_status.dart';
import '../../controllers/task_controller.dart';

class TaskStatusField extends StatelessWidget {
  const TaskStatusField(this._controller, {super.key});
  final TaskController _controller;

  Task get _task => _controller.task;
  static const _padding = EdgeInsets.symmetric(horizontal: P3);
  static final _margin = const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: MTButton(
        titleColor: _task.canSetStatus ? null : greenColor,
        titleText: _task.canSetStatus ? '${_task.status}' : loc.state_closed,
        type: _task.canSetStatus ? ButtonType.main : ButtonType.card,
        color: _task.closed ? (_task.canSetStatus ? greenColor : greenLightColor) : null,
        constrained: false,
        margin: _margin,
        padding: _padding,
        trailing: _task.canSetStatus
            ? const Padding(
                padding: EdgeInsets.only(left: P_2, top: P_2),
                child: CaretIcon(size: Size(P2 * 0.8, P2 * 0.75), color: mainBtnTitleColor),
              )
            : null,
        loading: _task.loading,
        onTap: _task.canSetStatus ? () => _controller.statusController.selectStatus(context) : null,
      ),
    );
  }
}
