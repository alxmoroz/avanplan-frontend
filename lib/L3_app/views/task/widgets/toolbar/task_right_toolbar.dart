// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/list_tile.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import '../details/task_details.dart';
import 'action_item.dart';

class TaskRightToolbar extends StatelessWidget {
  const TaskRightToolbar(this._controller);
  final TaskController _controller;

  Task get _task => _controller.task!;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Container(
        width: 300,
        color: b3Color.resolve(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              TaskDetails(_controller),
              const Spacer(),
              // TODO: в целях и проектах вместо попапа можно раскрывать в высоту просто. После нажатия скрывать обратно
              for (final at in _task.actionTypes)
                MTListTile(
                  middle: TaskActionItem(at),
                  bottomDivider: false,
                  onTap: () => _controller.taskAction(at),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
