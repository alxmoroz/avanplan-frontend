// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/note.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../components/button.dart';
import '../../../../components/circle.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field_data.dart';
import '../../../../components/icons.dart';
import '../../../../components/text_field.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/attachments.dart';
import '../../usecases/note.dart';
import '../attachments/upload_dialog.dart';

class NoteField extends StatelessWidget {
  const NoteField(this._controller, {super.key, this.note, this.standalone = false, this.maxLines});
  final TaskController _controller;
  final Note? note;
  final bool standalone;
  final int? maxLines;

  int get fIndex => TaskFCode.note.index;
  MTFieldData get _fd => _controller.fData(fIndex);
  FocusNode? get _fn => _controller.focusNode(fIndex);
  TextEditingController get _tc => _controller.teController(fIndex)!;

  bool get _isNewNote => note == null || note!.isNew;
  bool get _hasFiles => _isNewNote && _controller.attachmentsController.selectedFiles.isNotEmpty;
  bool get _canSubmit => _fd.text.trim().isNotEmpty || _hasFiles;

  Future _submit(BuildContext context) async {
    if (standalone) {
      await _controller.createNote();
    } else {
      Navigator.of(context).pop(true);
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
                    onTap: () => _controller.attachmentsController.startUpload(),
                  )
                else
                  const SizedBox(width: P2),
                Expanded(
                  child: MTTextField(
                    focusNode: _fn,
                    controller: _tc,
                    margin: EdgeInsets.zero,
                    autofocus: !standalone,
                    padding: EdgeInsets.symmetric(horizontal: P2, vertical: P2 * (isWeb ? 1.35 : 1)),
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
            if (_hasFiles) UploadDetails(_controller.attachmentsController),
          ],
        );
      },
    );
  }
}
