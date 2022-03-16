// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/buttons.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/cupertino_page.dart';
import '../../components/icons.dart';
import '../../components/navbar.dart';
import '../../components/text_field.dart';
import '../../components/text_field_annotation.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/date_presenter.dart';
import 'goal_controller.dart';

class GoalView extends StatefulWidget {
  static String get routeName => 'goal';

  @override
  _GoalViewState createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
  GoalController get _controller => goalController;

  @override
  void initState() {
    _controller.initState(context, tfaList: [
      TFAnnotation('title', label: loc.common_title, text: _controller.goal?.title ?? ''),
      TFAnnotation('description', label: loc.common_description, text: _controller.goal?.description ?? '', needValidate: false),
      TFAnnotation('dueDate', label: loc.common_due_date, isDate: true),
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
    final date = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: _controller.selectedDueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 36500)),
    );
    if (date != null) {
      _controller.setDueDate(date);
    }
  }

  List<Widget> editModeElements() {
    return [
      textFieldForCode('title'),
      textFieldForCode('description'),
      textFieldForCode('dueDate', onTap: inputDateTime),
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
      // SmallText(goalController.goal?.description ?? ''),
      if (_controller.goal?.etaDate != null) H3(dateToString(_controller.goal?.etaDate)),
      Expanded(
        child: ListView.builder(
          itemBuilder: taskBuilder,
          itemCount: _controller.goal!.tasks.length,
        ),
      ),
      SizedBox(height: onePadding),
    ];
  }

  Widget taskBuilder(BuildContext context, int index) {
    final task = goalController.goal!.tasks.elementAt(index);
    return ListTile(
      title: NormalText(task.title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTCupertinoPage(
        navBar: navBar(
          context,
          title: _controller.goal?.title ?? loc.goal_new_title,
          bgColor: cardBackgroundColor,
          trailing: Button.icon(editIcon(context), () => _controller.setEditMode(true)),
        ),
        children: [
          // SizedBox(height: onePadding),
          if (_controller.editMode) ...editModeElements(),
          if (!_controller.editMode) ...viewModeElements(),
        ],
      ),
    );
  }
}
