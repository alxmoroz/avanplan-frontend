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
import '../../presenters/task_overview_presenter.dart';
import '../task/task_view_controller.dart';
import '../task/task_view_widgets/task_overview_advices.dart';
import '../task/task_view_widgets/task_overview_warnings.dart';
import 'project_empty_list_actions_widget.dart';

class MainDashboardView extends StatefulWidget {
  static String get routeName => 'main_dashboard';

  @override
  _MainDashboardViewState createState() => _MainDashboardViewState();
}

class _MainDashboardViewState extends State<MainDashboardView> {
  Task get rootTask => mainController.rootTask;

  final double _iconSize = onePadding * 15;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: mainController.isLoading,
        navBar: navBar(context,
            leading: Row(children: [
              SizedBox(width: onePadding),
              MTButton.icon(refreshIcon(context), mainController.updateAll),
            ]),
            title: loc.appTitle,
            trailing: Row(mainAxisAlignment: MainAxisAlignment.end, mainAxisSize: MainAxisSize.min, children: [
              MTButton.icon(importIcon(context), () => importController.importTasks(context)),
              SizedBox(width: onePadding),
            ])),
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 1,
              colors: [(rootTask.stateBgColor ?? backgroundColor).resolve(context), backgroundColor.resolve(context)],
            ),
          ),
          child: SafeArea(
            top: false,
            bottom: false,
            child: !rootTask.hasOpenedSubtasks
                ? ProjectEmptyListActionsWidget(taskController: TaskViewController(), parentContext: context)
                : ListView(
                    shrinkWrap: true,
                    children: [
                      /// статус и комментарий
                      rootTask.stateIcon(context, size: _iconSize),
                      H3(
                        rootTask.stateTextTitle,
                        align: TextAlign.center,
                        padding: EdgeInsets.symmetric(horizontal: onePadding),
                        color: rootTask.stateColor ?? darkGreyColor,
                      ),
                      SizedBox(height: onePadding),

                      /// статистика по статусу всех задач
                      if (rootTask.hasOverdueTasks || rootTask.hasRiskTasks) TaskOverviewWarnings(rootTask) else TaskOverviewAdvices(rootTask),
                      SizedBox(height: onePadding),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
