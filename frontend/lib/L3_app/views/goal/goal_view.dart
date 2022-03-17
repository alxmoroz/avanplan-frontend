// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/buttons.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/cupertino_page.dart';
import '../../components/date_string_widget.dart';
import '../../components/icons.dart';
import '../../components/navbar.dart';
import '../../components/text_field.dart';
import '../../components/text_field_annotation.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'goal_controller.dart';
import 'goal_progress_widget.dart';

class GoalView extends StatefulWidget {
  static String get routeName => 'goal';

  @override
  _GoalViewState createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
  GoalController get _controller => goalController;
  Goal? get _goal => _controller.goal;

  @override
  void initState() {
    _controller.initState(context, tfaList: [
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

  List<Widget> editModeElements() {
    return [
      Expanded(
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
      SizedBox(height: onePadding * 2),
      Button(
        loc.btn_save_title,
        _controller.validated ? _controller.saveGoal : null,
        titleColor: _controller.validated ? mainColor : borderColor,
      ),
      SizedBox(height: onePadding),
      // TODO: подтверждение удаления
      Button(
        loc.btn_delete_title,
        _controller.canDelete ? _controller.deleteGoal : null,
        titleColor: _controller.canDelete ? warningColor : borderColor,
      ),
    ];
  }

  List<Widget> viewModeElements() {
    return [
      Padding(
        padding: EdgeInsets.all(onePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            H2(_goal!.title),
            if (_goal!.description.isNotEmpty) LightText(_goal!.description),
            SizedBox(height: onePadding),
            H3(loc.tasks_title),
            GoalProgressWidget(
              goal: _goal!,
              height: 110,
              header: H2('${_goal?.closedTasksCount} / ${_goal?.tasksCount}', padding: EdgeInsets.only(bottom: onePadding), color: darkGreyColor),
              leading: DateStringWidget(_goal!.dueDate, titleString: loc.common_due_date_label),
              trailing: DateStringWidget(_goal!.etaDate, titleString: loc.common_eta_date_label),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTCupertinoPage(
        navBar: navBar(
          context,
          title: _goal != null ? loc.goal_title : loc.goal_title_new,
          bgColor: cardBackgroundColor,
          trailing: Button.icon(editIcon(context), () => _controller.setEditMode(true)),
        ),
        children: [
          if (_controller.editMode) ...editModeElements(),
          if (!_controller.editMode) ...viewModeElements(),
        ],
      ),
    );
  }
}
