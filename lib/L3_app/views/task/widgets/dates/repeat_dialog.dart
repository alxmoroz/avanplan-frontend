// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../../../L1_domain/entities/task_repeat.dart';
import '../../../../../L1_domain/utils/dates.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/grid_button.dart';
import '../../../../components/grid_multiselect_button.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../components/text_field.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/date_repeat.dart';
import '../../../_base/loader_screen.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/dates.dart';
import 'repeat_controller.dart';

Future showTaskRepeatDialog(TaskController taskController) async {
  await showMTDialog(_RepeatDialog(taskController, RepeatController(taskController.task)), maxWidth: SCR_XS_WIDTH);
}

class _RepeatDialog extends StatelessWidget {
  const _RepeatDialog(this._taskController, this._repeatController);
  final TaskController _taskController;
  final RepeatController _repeatController;

  Future _save(BuildContext context) async {
    Navigator.of(context).pop();
    await _taskController.saveRepeat(_repeatController.repeat);
  }

  Future _delete(BuildContext context) async {
    Navigator.of(context).pop();
    await _taskController.deleteRepeat();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _taskController.loading
          ? LoaderScreen(_taskController, isDialog: true)
          : MTDialog(
              topBar: MTTopBar(
                pageTitle: loc.task_repeat_dialog_title,
                parentPageTitle: _taskController.task.title,
                trailing: _taskController.task.repeat != null
                    ? MTButton.icon(const DeleteIcon(), padding: const EdgeInsets.all(P2), onTap: () => _delete(context))
                    : null,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: P3),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: P3),
                    MTGridButton(
                      [
                        for (var pt in TaskRepeat.allPeriodTypes)
                          MTGridButtonItem(
                            pt.name,
                            Intl.message('task_repeat_period_${pt.name.toLowerCase()}'),
                          )
                      ],
                      value: _repeatController.repeat.periodType,
                      onChanged: _repeatController.setPeriodType,
                    ),
                    const SizedBox(height: P3),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: P2),
                            DText(_repeatController.repeat.prefix, color: f2Color),
                            const Spacer(),
                            DText(_repeatController.repeat.suffix, color: f2Color),
                            const SizedBox(width: P2),
                          ],
                        ),
                        MTTextField(
                          controller: _repeatController.teController(0),
                          margin: EdgeInsets.zero,
                          style: const D2('').style(context),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.zero),
                          keyboardType: const TextInputType.numberWithOptions(),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(3),
                            FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
                            TextInputFormatter.withFunction((oldValue, newValue) {
                              if (newValue.text.startsWith(RegExp(r'^0+\d+'))) {
                                newValue = newValue.copyWith(
                                  text: newValue.text.replaceFirst(RegExp(r'0*'), ''),
                                  selection: const TextSelection.collapsed(offset: -1),
                                );
                              }
                              return newValue;
                            }),
                          ],
                          onChanged: _repeatController.setPeriodLength,
                        ),
                      ],
                    ),
                    if (_repeatController.weekly)
                      MTGridMultiselectButton(
                        [for (int wd = 1; wd < 8; wd++) MTGridButtonItem('$wd', DateFormat.E().format(now.add(Duration(days: wd - now.weekday))))],
                        padding: const EdgeInsets.only(top: P3),
                        segmentsInRow: 7,
                        values: _repeatController.weekdays.toList(),
                        onChanged: _repeatController.selectWeekday,
                      )
                    else if (_repeatController.monthly)
                      MTGridMultiselectButton(
                        [
                          for (int d = 1; d < 29; d++) MTGridButtonItem('$d', '$d'),
                          MTGridButtonItem('-1', loc.task_repeat_period_monthly_last_day),
                        ],
                        padding: const EdgeInsets.only(top: P3),
                        segmentsInRow: 7,
                        values: _repeatController.daysOfMonth.toList(),
                        onChanged: _repeatController.selectDayOfMonth,
                      ),
                    MTButton.main(
                      titleText: loc.action_save_title,
                      onTap: _repeatController.canSave ? () => _save(context) : null,
                      margin: const EdgeInsets.symmetric(vertical: P4),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
