// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field_data.dart';
import '../../../../components/icons.dart';
import '../../../../components/text_field.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../controllers/task_controller.dart';

class NoteToolbar extends StatelessWidget implements PreferredSizeWidget {
  const NoteToolbar(this._controller);
  final TaskController _controller;

  MTFieldData get _fdNote => _controller.fData(TaskFCode.note.index);
  TextEditingController get _tcNote => _controller.teController(TaskFCode.note.index)!;

  @override
  Size get preferredSize => const Size.fromHeight(P10);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTAppBar(
        isBottom: true,
        color: b2Color,
        padding: const EdgeInsets.only(top: P2),
        middle: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(width: P2),
            Expanded(
              child: MTTextField(
                autofocus: false,
                controller: _tcNote,
                hint: loc.task_note_placeholder,
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
              onTap: _fdNote.text.trim().isNotEmpty ? () => _controller.notesController.create() : null,
            ),
          ],
        ),
      ),
    );
  }
}
