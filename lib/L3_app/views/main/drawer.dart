// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/buttons.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/divider.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';

class MTDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future importGoals() async {
      Navigator.of(context).pop();
      await mainController.importGoals(context);
    }

    Future showTrackers() async {
      Navigator.of(context).pop();
      await mainController.showTrackers(context);
    }

    Future logout() async {
      Navigator.of(context).pop();
      await loginController.logout(context);
    }

    return Drawer(
      child: Container(
        color: backgroundColor.resolve(context),
        child: SafeArea(
          child: Observer(
            builder: (_) => Column(
              children: [
                SizedBox(height: onePadding),
                const Spacer(),
                const MTDivider(),
                SmallText(loc.integration),
                SizedBox(height: onePadding),
                Button(loc.goal_import, importGoals),
                Button(loc.tracker_list_title, showTrackers),
                const MTDivider(),
                if (loginController.authorized) Button('Выйти', logout),
                SizedBox(height: onePadding),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  LightText(settingsController.appName),
                  NormalText(settingsController.appVersion, padding: const EdgeInsets.only(left: 6)),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
