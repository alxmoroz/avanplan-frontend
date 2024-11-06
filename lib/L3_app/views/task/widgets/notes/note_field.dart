// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/note.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../components/button.dart';
import '../../../../components/circle.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/field_data.dart';
import '../../../../components/icons.dart';
import '../../../../components/text_field.dart';
import '../../../../extra/services.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/attachments.dart';
import '../../usecases/note.dart';
import '../attachments/upload_dialog.dart';

class NoteField extends StatelessWidget {
  const NoteField(this._tc, {super.key, this.maxLines});
  final TaskController _tc;
  final int? maxLines;

  Note? get _note => _tc.notesController.currentNote;
  bool get _hasNote => _note != null;

  int get _fIndex => TaskFCode.note.index;
  MTFieldData get _fd => _tc.fData(_fIndex);
  FocusNode? get _fn => _tc.focusNode(_fIndex);
  TextEditingController get _tec => _tc.teController(_fIndex)!;

  bool get _isNewNote => _note == null || _note!.isNew;
  bool get _hasFiles => _isNewNote && _tc.attachmentsController.selectedFiles.isNotEmpty;
  bool get _canSubmit => _fd.text.trim().isNotEmpty || _hasFiles;

  Future _submit(BuildContext context) async {
    if (_note == null) {
      await _tc.createNote();
    } else {
      await _tc.saveNote(_note!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (_isNewNote)
                  MTButton.icon(
                    const AttachmentIcon(),
                    padding: const EdgeInsets.only(left: P2, right: P, bottom: P),
                    onTap: _tc.attachmentsController.startUpload,
                  )
                else
                  MTButton.icon(
                    const CloseIcon(),
                    padding: const EdgeInsets.all(P2),
                    onTap: _tc.resetNoteEdit,
                  ),
                Expanded(
                  child: MTTextField(
                    hint: loc.task_note_title,
                    focusNode: _fn,
                    controller: _tec,
                    margin: EdgeInsets.zero,
                    autofocus: _hasNote,
                    contentPadding: EdgeInsets.symmetric(horizontal: P2, vertical: P2 * (isWeb ? 1.35 : 1)),
                    maxLines: maxLines,
                  ),
                ),
                MTButton.icon(
                  MTCircle(
                    color: _canSubmit ? mainColor : b1Color,
                    size: P6,
                    child: const SubmitIcon(color: mainBtnTitleColor),
                  ),
                  margin: const EdgeInsets.only(left: P2, right: P2, bottom: P),
                  onTap: _canSubmit ? () => _submit(context) : null,
                ),
              ],
            ),
            if (_hasFiles) UploadDetails(_tc.attachmentsController),
          ],
        );
      },
    );
  }
}
