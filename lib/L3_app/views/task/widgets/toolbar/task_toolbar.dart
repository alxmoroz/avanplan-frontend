// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../main.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/toolbar.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import '../create/create_task_button.dart';
import '../local_transfer/local_import_dialog.dart';

class TaskToolbar extends StatelessWidget {
  const TaskToolbar(this._controller);
  final TaskController _controller;

  Task get _task => _controller.task!;

  Widget _switchPart(Widget icon, bool active) => Container(
        decoration: active
            ? BoxDecoration(
                shape: BoxShape.circle,
                color: b3Color.resolve(rootKey.currentContext!),
              )
            : null,
        width: P8,
        height: MIN_BTN_HEIGHT,
        child: icon,
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTAppBar(
        isBottom: true,
        bgColor: b2Color,
        middle: Row(
          children: [
            const SizedBox(width: P2),
            if (_task.canShowBoard)
              MTButton.secondary(
                color: b1Color,
                middle: Row(children: [
                  _switchPart(ListIcon(active: !_controller.showBoard), !_controller.showBoard),
                  _switchPart(BoardIcon(active: _controller.showBoard), _controller.showBoard),
                ]),
                onTap: _controller.toggleMode,
                constrained: false,
              ),
            const Spacer(),
            if (_task.canLocalImport)
              MTButton.secondary(
                middle: const LocalImportIcon(),
                constrained: false,
                onTap: () => localImportDialog(_controller),
              ),
            if (_task.canCreate) ...[
              const SizedBox(width: P2),
              CreateTaskButton(_controller, compact: true),
            ],
            const SizedBox(width: P2),
          ],
        ),
      ),
    );
  }
}
