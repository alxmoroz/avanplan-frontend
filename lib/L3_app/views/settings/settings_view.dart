// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/constants.dart';
import '../../components/mt_button.dart';
import '../../components/mt_divider.dart';
import '../../components/mt_page.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'settings_controller.dart';

class SettingsView extends StatelessWidget {
  static String get routeName => 'settings';

  SettingsController get _controller => settingsController;

  Future importTasks(BuildContext context) async {
    await _controller.importTasks(context);
  }

  Future showTrackers(BuildContext context) async => await _controller.showTrackers(context);
  Future logout() async => await loginController.logout();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: _controller.isLoading || userController.isLoading,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: onePadding),
              NormalText('${userController.currentUser}'),
              SizedBox(height: onePadding / 4),
              MTButton(loc.auth_log_out_button_title, logout),
              SizedBox(height: onePadding / 4),
              const MTDivider(),
              SizedBox(height: onePadding / 2),
              SmallText(loc.integration),
              SizedBox(height: onePadding),
              MTButton(loc.task_import_title, () => importTasks(context)),
              SizedBox(height: onePadding),
              MTButton(loc.tracker_list_title, () => showTrackers(context)),
              const Spacer(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                LightText(_controller.appName),
                SizedBox(width: onePadding / 4),
                MediumText(_controller.appVersion),
              ]),
              SizedBox(height: onePadding),
            ],
          ),
        ),
      ),
    );
  }
}
