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

  @override
  Widget build(BuildContext context) {
    Future importGoals() async {
      await mainController.importGoals(context);
    }

    Future showTrackers() async {
      await mainController.showTrackers(context);
    }

    Future logout() async {
      await loginController.logout();
    }

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
              MTButton(loc.goal_import, importGoals),
              SizedBox(height: onePadding),
              MTButton(loc.tracker_list_title, showTrackers),
              const Spacer(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                LightText(settingsController.appName),
                NormalText(settingsController.appVersion, padding: const EdgeInsets.only(left: 6)),
              ]),
              SizedBox(height: onePadding),
            ],
          ),
        ),
      ),
    );
  }
}
