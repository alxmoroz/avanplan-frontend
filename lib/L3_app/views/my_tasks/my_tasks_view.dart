// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/adaptive.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/page.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../main/widgets/left_menu.dart';
import '../task/controllers/task_controller.dart';
import '../task/widgets/tasks/tasks_list_view.dart';

class MyTasksRouter extends MTRouter {
  @override
  String get path => '/my_tasks';

  @override
  String get title => loc.my_tasks_title;

  @override
  Widget get page => const MyTasksView();
}

class MyTasksView extends StatelessWidget {
  const MyTasksView();

  Widget get _title => Align(
        alignment: Alignment.centerLeft,
        child: H1(
          loc.my_tasks_title,
          padding: const EdgeInsets.symmetric(horizontal: P3),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MTPage(
      scrollOffsetTop: P8,
      appBar: MTAppBar(
        bgColor: isBigScreen ? b2Color : null,
        leading: isBigScreen ? const SizedBox() : null,
        middle: isBigScreen ? _title : BaseText.medium(loc.my_tasks_title),
      ),
      leftBar: const LeftMenu(),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Observer(
          builder: (_) => ListView(children: [
            _title,
            const SizedBox(height: P3),
            TasksListView(
              tasksMainController.myTasksGroups,
              filters: const {TasksFilter.my},
              scrollable: false,
            ),
          ]),
        ),
      ),
    );
  }
}
