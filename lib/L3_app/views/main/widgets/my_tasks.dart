// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../main.dart';
import '../../../components/adaptive.dart';
import '../../../components/button.dart';
import '../../../components/colors.dart';
import '../../../components/colors_base.dart';
import '../../../components/constants.dart';
import '../../../components/images.dart';
import '../../../components/shadowed.dart';
import '../../../components/text.dart';
import '../../../extra/services.dart';
import '../../my_tasks/my_tasks_view.dart';
import '../../task/widgets/tasks/tasks_group.dart';

class MyTasks extends StatelessWidget {
  const MyTasks({this.compact = true});
  final bool compact;

  int get _myTasksCount => mainController.myUpcomingTasksCount;

  Future _goToTasks() async => await Navigator.of(rootKey.currentContext!).pushNamed(MyTasksView.routeName);

  Widget _mainInfo(BuildContext context) => _myTasksCount > 0
      ? SizedBox(height: dashboardImageHeight(context), child: Center(child: D1('$_myTasksCount', color: mainColor)))
      : MTImage(ImageNames.emptyTasks.toString());

  Widget _contents(BuildContext context) => MTCardButton(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BaseText(loc.my_tasks_title, align: TextAlign.center, color: f2Color),
            const SizedBox(height: P3),
            compact ? Expanded(child: _mainInfo(context)) : _mainInfo(context),
            H2(_myTasksCount > 0 ? mainController.myUpcomingTasksTitle : loc.task_list_empty_title, align: TextAlign.center),
            const SizedBox(height: P3),
          ],
        ),
        onTap: _goToTasks,
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => compact
          ? _contents(context)
          : Column(
              children: [
                _contents(context),
                const SizedBox(height: P3),
                _myTasksCount > 0
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: P),
                          child: MTShadowed(child: TasksGroup(mainController.myTasksGroups.first.value, isMine: true)),
                        ),
                      )
                    : H3(loc.my_tasks_empty_hint, align: TextAlign.center),
              ],
            ),
    );
  }
}
