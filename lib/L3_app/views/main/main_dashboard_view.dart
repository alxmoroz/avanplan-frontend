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
import '../task/task_view_controller.dart';
import '../task/task_view_widgets/task_overview_advices.dart';
import '../task/task_view_widgets/task_overview_warnings.dart';
import '../task/task_view_widgets/task_state_indicator.dart';
import 'project_empty_list_actions_widget.dart';

class MainDashboardView extends StatefulWidget {
  static String get routeName => 'main_dashboard';

  @override
  _MainDashboardViewState createState() => _MainDashboardViewState();
}

class _MainDashboardViewState extends State<MainDashboardView> {
  Task get rootTask => mainController.rootTask;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: mainController.isLoading,
        navBar: navBar(
          context,
          leading: const SizedBox(width: 0),
          middle: Row(children: [
            SizedBox(width: onePadding),
            MTButton.icon(refreshIcon(context, size: 30), mainController.updateAll),
            Expanded(child: H2(loc.appTitle, align: TextAlign.center)),
            SizedBox(width: 30 + onePadding),
          ]),
          bgColor: transparentAppbarBgColor,
          border: const Border(),
        ),
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
                ? ProjectEmptyListActionsWidget(taskController: TaskViewController(null), parentContext: context)
                : ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(height: onePadding),

                      /// статус и комментарий
                      TaskStateIndicator(rootTask, placement: IndicatorPlacement.workspace),

                      /// статистика по статусу всех задач
                      SizedBox(height: onePadding / 2),
                      if (rootTask.overdueSubtasks.isNotEmpty || rootTask.riskySubtasks.isNotEmpty)
                        TaskOverviewWarnings(rootTask)
                      else
                        TaskOverviewAdvices(rootTask),

                      SizedBox(height: onePadding),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
