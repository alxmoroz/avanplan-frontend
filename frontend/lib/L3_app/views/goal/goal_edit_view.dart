// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/bottom_sheet.dart';
import '../../components/buttons.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/cupertino_page.dart';
import '../../components/icons.dart';
import '../../components/navbar.dart';
import '../../components/splash.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import 'goal_edit_controller.dart';

//TODO: подумать над унификацией полей. Возможно, получится избавиться от дуэта MTField и TFAnnotation

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
  Future<void>? _fetchStatuses;

  @override
  void initState() {
    _controller.initState(tfaList: [
      TFAnnotation('title', label: loc.common_title, text: _goal?.title ?? ''),
      TFAnnotation('description', label: loc.common_description, text: _goal?.description ?? '', needValidate: false),
      TFAnnotation('dueDate', label: loc.common_due_date_placeholder, noText: true),
    ]);

    _fetchStatuses = _controller.fetchStatuses();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchStatuses,
      builder: (_, snapshot) => snapshot.connectionState == ConnectionState.done
          ? Observer(
              builder: (_) => MTCupertinoPage(
                bgColor: darkBackgroundColor,
                navBar: navBar(
                  context,
                  leading: _controller.canEdit
                      ? Button.icon(
                          deleteIcon(context),
                          () => _controller.delete(context),
                          padding: EdgeInsets.only(left: onePadding),
                        )
                      : Container(),
                  title: _goal == null ? loc.goal_title_new : '',
                  trailing: Button(
                    loc.btn_save_title,
                    _controller.validated ? () => _controller.save(context) : null,
                    titleColor: _controller.validated ? mainColor : borderColor,
                    padding: EdgeInsets.only(right: onePadding),
                  ),
                ),
                body: _controller.form(context),
              ),
            )
          : const SplashScreen(),
    );
  }
}
