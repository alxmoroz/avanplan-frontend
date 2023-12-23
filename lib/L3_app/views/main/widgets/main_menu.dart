// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../main.dart';
import '../../../components/button.dart';
import '../../../components/colors.dart';
import '../../../components/colors_base.dart';
import '../../../components/constants.dart';
import '../../../components/divider.dart';
import '../../../components/icons.dart';
import '../../../components/icons_workspace.dart';
import '../../../components/images.dart';
import '../../../extra/services.dart';
import '../../my_tasks/my_tasks_view.dart';
import '../../projects/projects_view.dart';
import '../../settings/account_btn.dart';
import '../../settings/settings_view.dart';

class MainMenu extends StatelessWidget {
  BuildContext get _navContext => rootKey.currentContext!;
  void _popTop() => Navigator.of(_navContext).popUntil((r) => r.navigator?.canPop() != true);

  Future _goToSettings() async {
    _popTop();
    await SettingsRouter().navigate(_navContext);
  }

  Future _goToProjects() async {
    _popTop();
    await ProjectsRouter().navigate(_navContext);
  }

  Future _goToTasks() async {
    _popTop();
    await MyTasksRouter().navigate(_navContext);
  }

  Widget get _divider => const MTDivider(verticalIndent: P2);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Container(
        color: b2Color.resolve(context),
        width: P10,
        child: MTCardButton(
          // elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: P),
          child: SafeArea(
            child: Column(
              children: [
                MTButton.icon(MTImage(ImageName.app_icon.name, height: P6, width: P6), onTap: _popTop),
                if (tasksMainController.projects.isNotEmpty) ...[
                  _divider,
                  MTButton.icon(const ProjectsIcon(size: P6, color: mainColor), onTap: _goToProjects),
                ],
                if (tasksMainController.myTasks.isNotEmpty) ...[
                  _divider,
                  MTButton.icon(const TasksIcon(size: P6, color: mainColor), onTap: _goToTasks),
                ],
                const Spacer(),
                AccountButton(_goToSettings),
              ],
            ),
          ),
          // onTap: () {},
        ),
      ),
    );
  }
}
