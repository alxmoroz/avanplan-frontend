// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/colors_base.dart';
import '../../components/dialog.dart';
import '../../components/toolbar.dart';
import '../../usecases/task_actions.dart';
import 'controllers/task_controller.dart';
import 'widgets/actions/note_toolbar.dart';
import 'widgets/actions/right_toolbar.dart';
import 'widgets/actions/right_toolbar_controller.dart';

class TaskDialog extends StatefulWidget {
  const TaskDialog(this._controller, this._title, this._body, {this.scrollHeaderOffset});
  final TaskController _controller;
  final Widget? _title;
  final Widget _body;
  final double? scrollHeaderOffset;

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  bool _hasScrolled = false;

  Task get _task => widget._controller.task!;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(showCloseButton: true, bgColor: b2Color, middle: _hasScrolled ? widget._title : null),
      body: widget._body,
      rightBar: TaskRightToolbar(TaskRightToolbarController(widget._controller)),
      bottomBar: _task.canComment ? NoteToolbar(widget._controller) : null,
      scrollOffsetTop: widget.scrollHeaderOffset,
      onScrolled: (scrolled) => setState(() => _hasScrolled = scrolled),
    );
  }
}
