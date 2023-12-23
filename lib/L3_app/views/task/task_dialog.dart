// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/toolbar.dart';
import '../../usecases/task_actions.dart';
import 'controllers/task_controller.dart';
import 'widgets/toolbar/note_toolbar.dart';
import 'widgets/toolbar/task_right_toolbar.dart';

class TaskDialog extends StatelessWidget {
  const TaskDialog(this._controller, this._scrollController, this._title, this._body);
  final TaskController _controller;
  final ScrollController _scrollController;
  final Widget? _title;
  final Widget _body;

  Task get _task => _controller.task!;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      scrollController: _scrollController,
      topBar: MTToolBar(middle: _title),
      body: _body,
      rightBar: MediaQuery(
        data: MediaQuery.of(context).copyWith(padding: const EdgeInsets.symmetric(vertical: P2)),
        child: TaskRightToolbar(_controller),
      ),
      bottomBar: _task.canComment ? NoteToolbar(_controller) : null,
    );
  }
}
