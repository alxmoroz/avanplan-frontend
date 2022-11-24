// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/usecases/task_ext_state.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../account/user_icon.dart';
import '../settings/settings_view.dart';
import '../task/task_related_widgets/task_add_action_widget.dart';
import '../task/task_view.dart';
import '../task/task_view_controller.dart';
import '../task/task_view_widgets/task_navbar.dart';
import '../task/task_view_widgets/task_overview.dart';
import 'import_projects_actions.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async => await mainController.updateAll());
    super.initState();
  }

  @override
  void dispose() {
    mainController.clearData();
    super.dispose();
  }

  TaskViewController get _taskController => TaskViewController(null);
  Task get _task => _taskController.task;

  Future _gotoSettings(BuildContext context) async => await Navigator.of(context).pushNamed(SettingsView.routeName);
  Future _gotoProjects(BuildContext context) async => await Navigator.of(context).pushNamed(TaskView.routeName);

  Widget _bottomBar(BuildContext context) => _task.hasSubtasks
      ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: MTButton.outlined(
                titleText: loc.project_list_title,
                margin: const EdgeInsets.symmetric(horizontal: P),
                onTap: () => _gotoProjects(context),
              ),
            ),
            if (mainController.canEditAnyWS) TaskFloatingPlusButton(_taskController),
          ],
        )
      : TaskAddActionWidget(_taskController);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          leading: accountController.user != null
              ? MTButton.icon(
                  UserIcon(accountController.user!, radius: 20, borderSide: const BorderSide(color: mainColor)),
                  () => _gotoSettings(context),
                  margin: const EdgeInsets.only(left: P),
                )
              : null,
          middle: H2(loc.app_title),
          trailing: MTButton.icon(
            const RefreshIcon(size: 32),
            mainController.updateAll,
            margin: const EdgeInsets.only(right: P),
          ),
          border: const Border(),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Center(
            child: !_task.hasOpenedSubtasks ? ImportProjectsActions(_task) : TaskOverview(_task),
          ),
        ),
        bottomBar: _bottomBar(context),
      ),
    );
  }
}
