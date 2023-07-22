// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/note.dart';
import '../../../components/constants.dart';
import '../../../components/mt_dialog.dart';
import '../../../components/mt_text_field.dart';
import '../../../components/mt_toolbar.dart';
import '../../../extra/services.dart';

class TaskNoteDialog extends StatelessWidget {
  const TaskNoteDialog(this.note, this.teController);
  final TextEditingController teController;
  final Note note;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(titleText: loc.task_note_title),
      body: ListView(
        shrinkWrap: true,
        children: [
          MTTextField(
            controller: teController,
            margin: const EdgeInsets.symmetric(horizontal: P),
          ),

          // MTButton.main(
          //   titleText: loc.save_action_title,
          //   onTap: teController.text.trim().isNotEmpty ? () => Navigator.of(context).pop(teController.text) : null,
          // ),
          const SizedBox(height: P),
        ],
      ),
    );
  }
}
