// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_stats.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/empty_data_widget.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/task_overview_presenter.dart';
import '../task/task_overview_stats.dart';

class MainDashboardView extends StatefulWidget {
  static String get routeName => 'main_dashboard';

  @override
  _MainDashboardViewState createState() => _MainDashboardViewState();
}

class _MainDashboardViewState extends State<MainDashboardView> {
  // TODO: добавлять рутовую задачу и делать расчёты через неё

  Task get task => taskViewController.rootTask;

  final double _iconSize = onePadding * 15;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: mainController.isLoading,
        navBar: tasksFilterController.hasOpened ? navBar(context, title: loc.appTitle) : null,
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 1,
              colors: [(stateBgColor(task.state) ?? backgroundColor).resolve(context), backgroundColor.resolve(context)],
            ),
          ),
          child: SafeArea(
            top: false,
            bottom: false,
            child: !tasksFilterController.hasOpened
                ? EmptyDataWidget(
                    // TODO: здесь не про то, что целей вообще нет, а что нет открытых целей
                    title: loc.task_list_empty_title,
                    addTitle: loc.task_title_new,
                    onAdd: () => taskViewController.addTask(context),
                  )
                : ListView(
                    shrinkWrap: true,
                    children: [
                      /// статус и комментарий
                      stateIcon(context, task, size: _iconSize),
                      H3(
                        stateTextTitle(task),
                        align: TextAlign.center,
                        padding: EdgeInsets.symmetric(horizontal: onePadding),
                        color: stateColor(task.state) ?? darkGreyColor,
                      ),
                      SizedBox(height: onePadding),

                      /// статистика по статусу всех задач
                      TaskOverviewStats(taskViewController.rootTask),
                      SizedBox(height: onePadding),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
