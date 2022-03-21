// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/bottom_sheet.dart';
import '../../components/buttons.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/text_field.dart';
import '../../components/text_field_annotation.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'goal_edit_controller.dart';

Future<Goal?> showEditGoalDialog(BuildContext context) async {
  return await showModalBottomSheet<Goal?>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (context) => MTBottomSheet(GoalEditView()),
  );
}

class GoalEditView extends StatefulWidget {
  static String get routeName => 'goal_edit';

  @override
  _GoalViewState createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalEditView> {
  GoalEditController get _controller => goalEditController;
  Goal? get _goal => _controller.goal;

  @override
  void initState() {
    _controller.initState(tfaList: [
      TFAnnotation('title', label: loc.common_title, text: _goal?.title ?? ''),
      TFAnnotation('description', label: loc.common_description, text: _goal?.description ?? '', needValidate: false),
      TFAnnotation('dueDate', label: loc.common_due_date_placeholder, isDate: true),
    ]);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget textFieldForCode(String code, {VoidCallback? onTap}) {
    final ta = _controller.tfAnnoForCode(code);
    return ta.isDate
        ? MTTextField.date(
            controller: _controller.controllers[code],
            label: ta.label,
            error: ta.errorText,
            onTap: onTap,
            suffixIcon: calendarIcon(context),
          )
        : MTTextField(
            controller: _controller.controllers[code],
            label: ta.label,
            error: ta.errorText,
            onTap: onTap,
          );
  }

  Future inputDateTime() async {
    final firstDate =
        _controller.selectedDueDate != null && DateTime.now().isAfter(_controller.selectedDueDate!) ? _controller.selectedDueDate! : DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: _controller.selectedDueDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: DateTime.now().add(const Duration(days: 36500)),
    );
    if (date != null) {
      _controller.setDueDate(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    // TODO: CupertinoPageScaffold и в заголовок кнопки
    return SafeArea(
      child: Observer(
        builder: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                H3(_goal == null ? loc.goal_title_new : '', align: TextAlign.center),
                Row(
                  children: [
                    if (_controller.canEdit)
                      Button.icon(
                        deleteIcon(context),
                        () => _controller.deleteGoal(context),
                        padding: EdgeInsets.only(left: onePadding),
                      ),
                    const Spacer(),
                    Button(
                      loc.btn_save_title,
                      _controller.validated ? () => _controller.saveGoal(context) : null,
                      titleColor: _controller.validated ? mainColor : borderColor,
                      padding: EdgeInsets.only(right: onePadding),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              constraints: BoxConstraints(maxHeight: mq.size.height - mq.viewInsets.bottom - mq.viewPadding.bottom - 150),
              child: Scrollbar(
                isAlwaysShown: true,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      textFieldForCode('title'),
                      textFieldForCode('dueDate', onTap: inputDateTime),
                      textFieldForCode('description'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
