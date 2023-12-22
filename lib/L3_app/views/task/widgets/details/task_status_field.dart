// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/field_data.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_status.dart';
import '../../controllers/task_controller.dart';

class TaskStatusField extends StatelessWidget {
  const TaskStatusField(this._controller);
  final TaskController _controller;

  Task get _task => _controller.task!;
  MTFieldData get _statusFD => _controller.fData(TaskFCode.status.index);

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      bottomDivider: false,
      color: Colors.transparent,
      leading: _task.canShowStatus
          ? MTButton.main(
              titleText: '${_task.status}',
              color: _task.closed ? greenColor : null,
              constrained: false,
              padding: const EdgeInsets.symmetric(horizontal: P3),
              trailing: _task.canSetStatus
                  ? const Padding(
                      padding: EdgeInsets.only(left: P_2, top: P_2),
                      child: CaretIcon(size: Size(P2 * 0.8, P2 * 0.75), color: mainBtnTitleColor),
                    )
                  : null,
              loading: _statusFD.loading,
              onTap: _task.canSetStatus ? _controller.statusController.selectStatus : null,
            )
          : _task.canClose
              ? MTButton.main(
                  titleText: loc.close_action_title,
                  leading: const DoneIcon(true, color: mainBtnTitleColor),
                  constrained: false,
                  color: greenColor,
                  padding: const EdgeInsets.symmetric(horizontal: P3),
                  onTap: () => _controller.statusController.setStatus(_task, close: true),
                  loading: _statusFD.loading,
                )
              : MTButton(
                  titleText: loc.state_closed,
                  type: ButtonType.card,
                  color: greenLightColor,
                  titleColor: greenColor,
                  padding: const EdgeInsets.symmetric(horizontal: P3),
                ),
    );
  }
}
