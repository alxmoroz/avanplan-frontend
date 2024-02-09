// Copyright (c) 2023. Alexandr Moroz

import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/text_field.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../controllers/task_controller.dart';
import '../attachments/upload_dialog.dart';

class NoteToolbar extends StatelessWidget implements PreferredSizeWidget {
  const NoteToolbar(this._controller, {super.key});
  final TaskController _controller;

  TextEditingController get _tcNote => _controller.teController(TaskFCode.note.index)!;

  double get _detailsHeight => _selectedFiles.isNotEmpty ? P3 : 0;
  List<XFile> get _selectedFiles => _controller.attachmentsController.selectedFiles;

  @override
  Size get preferredSize => Size.fromHeight(P8 + P4 + _detailsHeight);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTAppBar(
        isBottom: true,
        color: b2Color,
        innerHeight: P8 + _detailsHeight,
        padding: EdgeInsets.only(top: P2, bottom: isBigScreen(context) ? P2 : 0),
        middle: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            UploadButton(_controller.attachmentsController),
            Expanded(
              child: MTTextField(
                autofocus: false,
                readOnly: true,
                controller: _tcNote,
                hint: loc.task_note_placeholder,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.symmetric(horizontal: P2, vertical: P2 * (kIsWeb ? 1.35 : 1)),
                maxLines: 1,
                onTap: () => _controller.notesController.create(),
              ),
            ),
            const MTButton.main(
              elevation: 0,
              constrained: false,
              minSize: Size(P6, P6),
              middle: SubmitIcon(color: mainBtnTitleColor),
              margin: EdgeInsets.only(left: P2, right: P2, bottom: P),
            ),
          ],
        ),
        bottom: _selectedFiles.isNotEmpty ? UploadDetails(_controller.attachmentsController) : null,
      ),
    );
  }
}
