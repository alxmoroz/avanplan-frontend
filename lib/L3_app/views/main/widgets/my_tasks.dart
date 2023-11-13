// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../main.dart';
import '../../../components/adaptive.dart';
import '../../../components/button.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/shadowed.dart';
import '../../../components/text.dart';
import '../../../extra/services.dart';
import '../../my_tasks/my_tasks_view.dart';
import '../../task/widgets/tasks/tasks_group.dart';

class MyTasks extends StatelessWidget {
  const MyTasks({this.compact = true});
  final bool compact;

  Future _goToTasks() async => await MyTasksViewViewRouter().navigate(rootKey.currentContext!);

  Widget _mainInfo(BuildContext context) => SizedBox(
        height: defaultImageHeight(context),
        child: Center(
          child: D1(
            '${tasksMainController.myUpcomingTasksCount}',
            color: mainColor,
          ),
        ),
      );

  Widget _contents(BuildContext context) => MTCardButton(
        child: Column(
          children: [
            BaseText.f2(loc.my_tasks_title, align: TextAlign.center),
            compact ? Expanded(child: _mainInfo(context)) : _mainInfo(context),
            H2(tasksMainController.myUpcomingTasksTitle, align: TextAlign.center),
            const SizedBox(height: P),
          ],
        ),
        onTap: _goToTasks,
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => compact
          ? _contents(context)
          : ListView(
              children: [
                _contents(context),
                const SizedBox(height: P_2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: P + P_2),
                  child: MTShadowed(child: TasksGroup(tasksMainController.myTasksGroups.first.value, isMine: true)),
                ),
              ],
            ),
    );
  }
}
