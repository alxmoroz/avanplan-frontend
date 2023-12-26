// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../extra/services.dart';
import '../../presenters/person.dart';
import 'settings_menu.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton();

  @override
  Widget build(BuildContext context) {
    return MTButton.icon(
      accountController.user!.icon(P3, borderColor: mainColor),
      onTap: showSettingsMenu,
    );
  }
}
