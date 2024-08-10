// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/note.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/dialog.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_type.dart';
import '../../controllers/task_controller.dart';
import 'note_field.dart';

class NoteEditDialog extends StatelessWidget {
  const NoteEditDialog(this._controller, {super.key, this.note});
  final TaskController _controller;
  final Note? note;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(showCloseButton: true, color: b2Color, middle: _controller.task.subPageTitle(loc.task_note_title)),
      body: NoteField(_controller, note: note),
    );
  }
}
