// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/note.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../controllers/task_controller.dart';
import 'note_field.dart';

class NoteEditDialog extends StatelessWidget {
  const NoteEditDialog(this._controller, {super.key, this.note});
  final TaskController _controller;
  final Note? note;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(pageTitle: loc.task_note_title, parentPageTitle: _controller.task.title),
      body: SafeArea(
        minimum: const EdgeInsets.only(bottom: P3),
        child: NoteField(_controller, note: note),
      ),
    );
  }
}
