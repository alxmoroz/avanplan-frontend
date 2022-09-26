// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_ext_state.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/task_state_presenter.dart';
import '../account/user_icon.dart';
import '../settings/settings_view.dart';
import '../task/task_related_widgets/task_overview.dart';
import '../task/task_related_widgets/task_state_title.dart';
import '../task/task_view.dart';
import '../task/task_view_controller.dart';
import 'project_empty_list_actions_widget.dart';

class MainDashboardView extends StatelessWidget {
  TaskViewController get _taskController => TaskViewController(null);
  Task get _task => _taskController.task;

  Future _gotoSettings(BuildContext context) async => await Navigator.of(context).pushNamed(SettingsView.routeName);
  Future _gotoProjects(BuildContext context) async => await Navigator.of(context).pushNamed(TaskView.routeName);
  Future _addProject(BuildContext context) async => await _taskController.addSubtask(context);

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
          bgColor: transparentAppbarBgColor,
          border: const Border(),
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              const Spacer(),
              !_task.hasOpenedSubtasks
                  ? ProjectEmptyListActionsWidget(taskController: _taskController, parentContext: context)
                  : ListView(
                      shrinkWrap: true,
                      children: [
                        if (_task.showState) TaskStateTitle(_task, style: TaskStateTitleStyle.L),
                        TaskOverview(_taskController),
                      ],
                    ),
              const Spacer(),
              if (_task.hasOpenedSubtasks)
                Row(
                  children: [
                    Expanded(
                      child: MTButton(
                        '',
                        () => _gotoProjects(context),
                        padding: EdgeInsets.symmetric(horizontal: onePadding),
                        child: Container(
                          padding: EdgeInsets.all(onePadding / 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(onePadding * 2),
                            border: Border.all(color: mainColor.resolve(context), width: 2.5),
                          ),
                          child: Row(
                            children: [
                              const Spacer(),
                              expandIcon(context, size: onePadding * 2.5),
                              SizedBox(width: onePadding / 2),
                              H4(loc.project_list_title, color: mainColor),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    MTButton.icon(
                      plusIcon(context, size: onePadding * 4.5),
                      () => _addProject(context),
                      padding: EdgeInsets.only(right: onePadding),
                    ),
                  ],
                ),
              SizedBox(height: onePadding / 2),
            ],
          ),
        ),
      ),
    );
  }
}
