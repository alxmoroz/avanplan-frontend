// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/goals/task.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import '../element_of_work/ew_dashboard.dart';
import '../element_of_work/ew_view_controller.dart';

class TaskView extends StatelessWidget {
  static String get routeName => 'task';

  EWViewController get _controller => ewViewController;
  Task? get _task => _controller.task;

  String breadcrumbs() {
    const sepStr = ' ⟩ ';
    String _breadcrumbs = '';
    final titles = _controller.navStackTasks.take(_controller.navStackTasks.length - 1).map((pt) => pt.title).toList();
    titles.insert(0, _controller.goal.title);
    _breadcrumbs = titles.join(sepStr);
    return _breadcrumbs;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _task != null
          ? MTPage(
              isLoading: _controller.isLoading,
              navBar: navBar(
                context,
                title: '${loc.task_title} #${_task!.id}',
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MTButton.icon(plusIcon(context), () => ewViewController.addTask(context)),
                    SizedBox(width: onePadding * 2),
                    MTButton.icon(editIcon(context), () => _controller.editTask(context)),
                    SizedBox(width: onePadding),
                  ],
                ),
              ),
              body: SafeArea(
                top: false,
                bottom: false,
                child: EWDashboard(_task!, breadcrumbs: breadcrumbs()),
              ),
            )
          : Container(),
    );
  }
}
