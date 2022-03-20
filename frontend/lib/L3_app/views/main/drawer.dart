// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/buttons.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';

class MTDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: backgroundColor.resolve(context),
        child: SafeArea(
          child: Observer(
            builder: (_) => Column(
              children: [
                SizedBox(height: onePadding),
                const Spacer(),
                Button('Импорт задач из Redmine', mainController.redmine),
                if (mainController.authorized) Button('Выйти', () => mainController.logout(context)),
                SizedBox(height: onePadding),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  LightText(mainController.appName),
                  NormalText(mainController.appVersion, padding: const EdgeInsets.only(left: 6)),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
