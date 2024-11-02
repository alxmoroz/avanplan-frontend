// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/dialog.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../_base/loader_screen.dart';
import '../../controllers/task_controller.dart';
import 'due_date_field.dart';
import 'repeat_field.dart';
import 'start_date_field.dart';

Future showTaskDatesDialog(TaskController controller) async => await showMTDialog(_DatesDialog(controller));

class _DatesDialog extends StatelessWidget {
  const _DatesDialog(this._tc);
  final TaskController _tc;

  Task get _t => _tc.task;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _tc.loading
          ? LoaderScreen(_tc, isDialog: true)
          : MTDialog(
              topBar: MTTopBar(pageTitle: loc.task_dates, parentPageTitle: _t.title),
              body: ListView(
                shrinkWrap: true,
                children: [
                  if (_tc.canShowStartDateField) TaskStartDateField(_tc),
                  if (_tc.canShowDueDateField) TaskDueDateField(_tc),
                  if (_tc.canShowRepeatField) TaskRepeatField(_tc),
                ],
              ),
            ),
    );
  }
}
