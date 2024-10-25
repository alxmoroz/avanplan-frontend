// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/text.dart';
import '../../../../presenters/date.dart';
import '../../controllers/notes_controller.dart';
import '../../controllers/task_controller.dart';
import 'note.dart';

class Notes extends StatelessWidget {
  Notes(this._tc) : super(key: _tc.notesWidgetGlobalKey);

  final TaskController _tc;
  NotesController get _notesController => _tc.notesController;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P3),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _notesController.sortedNotesDates.length,
          itemBuilder: (_, index) {
            final gDate = _notesController.sortedNotesDates[index];
            final ng = _notesController.notesGroups[gDate]!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SmallText('${gDate.strMedium}, ${DateFormat.EEEE().format(gDate)}', color: f2Color, align: TextAlign.center),
                const SizedBox(height: P2),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ng.length,
                  itemBuilder: (_, index) => NoteCard(_tc, ng[index]),
                ),
              ],
            );
          },
        ),
      );
    });
  }
}
