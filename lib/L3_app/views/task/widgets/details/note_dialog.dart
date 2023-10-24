// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/field_data.dart';
import '../../../../components/icons.dart';
import '../../../../components/text_field.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../controllers/task_controller.dart';

class NoteDialog extends StatelessWidget {
  const NoteDialog(this._controller);
  final TaskController _controller;

  MTFieldData get _fd => _controller.fData(TaskFCode.note.index);
  TextEditingController get _tc => _controller.teController(TaskFCode.note.index)!;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(titleText: loc.task_note_title),
      body: Observer(
        builder: (ctx) => Padding(
          padding: MediaQuery.paddingOf(ctx),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(width: P2),
              Expanded(
                child: MTTextField(
                  controller: _tc,
                  margin: EdgeInsets.zero,
                  maxLines: 10,
                ),
              ),
              MTButton.main(
                constrained: false,
                middle: const SubmitIcon(color: mainBtnTitleColor),
                margin: const EdgeInsets.only(left: P, right: P2, bottom: P),
                onTap: _fd.text.trim().isNotEmpty ? () => Navigator.of(context).pop(true) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
