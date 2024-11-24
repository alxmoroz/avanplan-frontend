// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/toolbar.dart';
import '../../controllers/task_controller.dart';
import '../notes/note_field.dart';
import 'note_field_toolbar_controller.dart';

class NoteFieldToolbar extends StatelessWidget implements PreferredSizeWidget {
  const NoteFieldToolbar(this._tc, this._tbc, {super.key});
  final TaskController _tc;
  final NFToolbarController _tbc;

  @override
  Size get preferredSize => Size.fromHeight(_tbc.height);

  @override
  Widget build(BuildContext context) {
    return MTBottomBar(
      toolbarController: _tbc,
      ignoreBottomInsets: _tbc.ignoreBottomInsets,
      innerHeight: _tbc.height - _tbc.topPadding,
      topPadding: _tbc.topPadding,
      middle: NoteField(_tc, maxLines: _tbc.maxLines),
      key: const ValueKey('NoteFieldToolbar'),
    );
  }
}
