// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/adaptive.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/page.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../app/app_title.dart';
import '../projects/create_project_controller.dart';
import '../task/controllers/task_controller.dart';
import '../task/widgets/tasks/tasks_list_view.dart';
import 'widgets/bottom_menu.dart';
import 'widgets/fast_add_task_button.dart';
import 'widgets/left_menu.dart';
import 'widgets/no_tasks.dart';

class MainRouter extends MTRouter {
  @override
  Widget get page => const MainView();
}

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<StatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with WidgetsBindingObserver {
  bool get _showTasks => tasksMainController.myTasks.isNotEmpty;

  void _startupActions() => WidgetsBinding.instance.addPostFrameCallback((_) async {
        leftMenuController.setCompact(!isBigScreen(context));
        await mainController.startupActions();
      });

  @override
  void initState() {
    _startupActions();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startupActions();
    }
  }

  @override
  void dispose() {
    mainController.clearData();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final big = isBigScreen(context);
      return loader.loading
          ? Container()
          : MTPage(
              appBar: _showTasks
                  ? MTAppBar(
                      leading: const SizedBox(height: P8),
                      color: big ? b2Color : null,
                      middle: H3(loc.my_tasks_upcoming_title, maxLines: 1),
                    )
                  : big
                      ? null
                      : const MTAppBar(middle: AppTitle()),
              body: SafeArea(
                top: false,
                bottom: false,
                child: _showTasks
                    ? Stack(
                        children: [
                          TasksListView(
                            tasksMainController.myTasksGroups,
                            filters: const {TasksFilter.my},
                          ),
                          if (big)
                            const Positioned(
                              bottom: P5,
                              right: P5,
                              child: FastAddTaskButton(),
                            ),
                        ],
                      )
                    : NoTasks(CreateProjectController()),
              ),
              leftBar: canShowVerticalBars(context) ? const LeftMenu() : null,
              bottomBar: canShowVerticalBars(context) ? null : const BottomMenu(),
            );
    });
  }
}
