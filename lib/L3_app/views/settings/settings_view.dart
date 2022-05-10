// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/constants.dart';
import '../../components/mt_button.dart';
import '../../components/mt_divider.dart';
import '../../components/mt_page.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';

class SettingsView extends StatefulWidget {
  static String get routeName => 'settings';

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  Future importGoals() async {
    await mainController.importGoals(context);
  }

  Future showTrackers() async {
    await mainController.showTrackers(context);
  }

  Future logout() async {
    await loginController.logout(context);
  }

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
              MTButton(loc.goal_import, importGoals),
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
