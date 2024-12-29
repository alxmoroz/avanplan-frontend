// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/note.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../app/services.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/note.dart';

void noteMenuDialog(TaskController taskController, Note note) => showMTDialog(_NoteMenuDialog(taskController, note));

class _NoteMenuDialog extends StatelessWidget {
  const _NoteMenuDialog(this._tc, this._note);
  final TaskController _tc;
  final Note _note;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(pageTitle: loc.task_note_title, parentPageTitle: _tc.task.title),
      body: ListView(
        shrinkWrap: true,
        children: [
          MTListTile(
            leading: const EditIcon(),
            middle: BaseText(loc.edit_action_title, color: mainColor, maxLines: 1),
            dividerIndent: P4 + P5,
            onTap: () {
              Navigator.of(context).pop();
              _tc.editNote(_note);
            },
          ),
          MTListTile(
            leading: const DeleteIcon(),
            middle: BaseText(loc.action_delete_title, color: dangerColor, maxLines: 1),
            bottomDivider: false,
            onTap: () async {
              Navigator.of(context).pop();
              _tc.deleteNote(_note);
            },
          ),
        ],
      ),
    );
  }
}
