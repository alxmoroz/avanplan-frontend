// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/dialog.dart';
import '../../../../components/toolbar.dart';
import '../../../_base/loader_screen.dart';
import '../../../app/services.dart';
import '../../controllers/task_controller.dart';
import 'date_field.dart';
import 'repeat_field.dart';

Future showTaskDatesDialog(TaskController tc) async => await showMTDialog(_DatesDialog(tc));

class _DatesDialog extends StatelessWidget {
  const _DatesDialog(this._tc);
  final TaskController _tc;

  Widget get _dialog {
    final t = _tc.task;
    final canShowRepeat = _tc.canShowRepeatField;
    return MTDialog(
      topBar: MTTopBar(pageTitle: canShowRepeat ? loc.task_dates_repeat : loc.task_dates, parentPageTitle: t.title),
      body: ListView(
        shrinkWrap: true,
        children: [
          if (_tc.canShowStartDateField) TaskDateField(_tc, TaskFCode.startDate),
          if (_tc.canShowDueDateField) TaskDateField(_tc, TaskFCode.dueDate),
          if (canShowRepeat) TaskRepeatField(_tc),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _tc.loading ? LoaderScreen(_tc, isDialog: true) : _dialog,
    );
  }
}
