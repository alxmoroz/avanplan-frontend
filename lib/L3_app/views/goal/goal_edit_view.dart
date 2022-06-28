// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/element_of_work.dart';
import '../../components/close_dialog_button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import 'goal_controller.dart';

//TODO: подумать над унификацией полей. Возможно, получится избавиться от дуэта MTField и TFAnnotation

Future<ElementOfWork?> showEditGoalDialog(BuildContext context) async {
  return await showModalBottomSheet<ElementOfWork?>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (_) => MTBottomSheet(GoalEditView(), context),
  );
}

class GoalEditView extends StatefulWidget {
  static String get routeName => 'goal_edit';

  @override
  _GoalViewState createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalEditView> {
  GoalController get _controller => goalController;
  ElementOfWork? get _goal => ewViewController.selectedGoal;
  bool get _isNew => _goal == null;
  bool get _canSave => _controller.validated;

  @override
  void initState() {
    _controller.initState(tfaList: [
      TFAnnotation('title', label: loc.common_title, text: _goal?.title ?? ''),
      TFAnnotation('description', label: loc.common_description, text: _goal?.description ?? '', needValidate: false),
      TFAnnotation('dueDate', label: loc.ew_due_date_placeholder, noText: true),
    ]);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: _controller.isLoading,
        navBar: navBar(
          context,
          leading: CloseDialogButton(),
          title: _isNew ? loc.goal_title_new : '',
          trailing: MTButton(
            loc.common_save_btn_title,
            _canSave ? () => _controller.save(context) : null,
            titleColor: _canSave ? mainColor : lightGreyColor,
            padding: EdgeInsets.only(right: onePadding),
          ),
        ),
        body: _controller.form(context, _isNew ? _controller.wsDropdown(context) : null),
      ),
    );
  }
}
