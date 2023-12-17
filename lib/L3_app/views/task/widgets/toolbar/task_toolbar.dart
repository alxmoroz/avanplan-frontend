// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../main.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field_data.dart';
import '../../../../components/icons.dart';
import '../../../../components/text_field.dart';
import '../../../../components/toolbar.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import '../create/create_task_button.dart';
import '../local_transfer/local_import_dialog.dart';

class TaskToolbar extends StatelessWidget {
  const TaskToolbar(this._controller);

  final TaskController _controller;
  Task get _task => _controller.task!;

  MTFieldData get _fdNote => _controller.fData(TaskFCode.note.index);
  TextEditingController get _tcNote => _controller.teController(TaskFCode.note.index)!;

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
        middle: _task.canComment
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(width: P2),
                  Expanded(
                    child: MTTextField(
                      controller: _tcNote,
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.symmetric(horizontal: P2, vertical: P2 * (kIsWeb ? 1.35 : 1)),
                      maxLines: 1,
                    ),
                  ),
                  MTButton.main(
                    elevation: 0,
                    constrained: false,
                    minSize: const Size(P6, P6),
                    middle: const SubmitIcon(color: mainBtnTitleColor),
                    margin: const EdgeInsets.only(left: P2, right: P2, bottom: P),
                    onTap: _fdNote.text.trim().isNotEmpty ? () => Navigator.of(context).pop(true) : null,
                  ),
                ],
              )
            : Row(
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
