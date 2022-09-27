// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_ext_state.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/mt_rounded_container.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../account/user_icon.dart';
import '../settings/settings_view.dart';
import '../task/task_related_widgets/task_overview.dart';
import '../task/task_view.dart';
import '../task/task_view_controller.dart';
import 'project_empty_list_actions_widget.dart';

class MainDashboardView extends StatelessWidget {
  TaskViewController get _taskController => TaskViewController(null);
  Task get _task => _taskController.task;

  Future _gotoSettings(BuildContext context) async => await Navigator.of(context).pushNamed(SettingsView.routeName);
  Future _gotoProjects(BuildContext context) async => await Navigator.of(context).pushNamed(TaskView.routeName);
  Future _addProject(BuildContext context) async => await _taskController.addSubtask(context);

  Widget _bottomAppbarContent(BuildContext context) => Row(
        children: [
          Expanded(
            child: MTButton(
              '',
              () => _gotoProjects(context),
              padding: EdgeInsets.symmetric(horizontal: onePadding),
              child: MTRoundedContainer(
                padding: EdgeInsets.all(onePadding / 2),
                borderRadius: onePadding * 2,
                border: Border.all(color: mainColor.resolve(context), width: 2.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // expandIcon(context, size: onePadding * 2.2),
                    // SizedBox(width: onePadding / 2),
                    H4(loc.project_list_title, color: mainColor),
                  ],
                ),
              ),
            ),
          ),
          MTButton.icon(plusIcon(context, size: onePadding * 4.2), () => _addProject(context), padding: EdgeInsets.only(right: onePadding)),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: mainController.isLoading,
        navBar: navBar(
          context,
          leading: MTButton(
            '',
            () => _gotoSettings(context),
            child: UserIcon(accountController.user!, radius: 20, borderSide: const BorderSide(color: mainColor)),
            padding: EdgeInsets.only(left: onePadding),
          ),
          middle: H2(loc.appTitle),
          trailing: MTButton.icon(refreshIcon(context, size: 32), mainController.updateAll, padding: EdgeInsets.only(right: onePadding)),
          border: const Border(),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Center(
            child: !_task.hasOpenedSubtasks
                ? ProjectEmptyListActionsWidget(taskController: _taskController, parentContext: context)
                : TaskOverview(_taskController),
          ),
        ),
        bottomBar: _task.hasOpenedSubtasks ? _bottomAppbarContent(context) : null,
      ),
    );
  }
}
