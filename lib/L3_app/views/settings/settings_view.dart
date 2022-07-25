// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/constants.dart';
import '../../components/mt_button.dart';
import '../../components/mt_divider.dart';
import '../../components/mt_page.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';

class SettingsView extends StatelessWidget {
  static String get routeName => 'settings';

  Future importTasks(BuildContext context) async => await mainController.importTasks(context);
  Future showTrackers(BuildContext context) async => await mainController.showTrackers(context);
  Future logout() async => await loginController.logout();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: settingsController.isLoading,
        body: SafeArea(
          child: Column(
            children: [
              const MTDivider(),
              SizedBox(height: onePadding),
              MTButton(loc.auth_log_out_button_title, logout),
              const MTDivider(),
              SizedBox(height: onePadding),
              SmallText(loc.integration),
              SizedBox(height: onePadding),
              MTButton(loc.task_import_title, () => importTasks(context)),
              SizedBox(height: onePadding),
              MTButton(loc.tracker_list_title, () => showTrackers(context)),
              const Spacer(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                LightText(settingsController.appName),
                SizedBox(width: onePadding / 4),
                MediumText(settingsController.appVersion),
              ]),
              SizedBox(height: onePadding),
            ],
          ),
        ),
      ),
    );
  }
}
