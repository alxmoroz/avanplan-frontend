// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/button.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/images.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../navigation/router.dart';
import '../../usecases/communications.dart';

Future showAppMayUpgradeDialog() async => await showMTDialog(const _AppMayUpgradeDialog());

class _AppMayUpgradeDialog extends StatelessWidget {
  const _AppMayUpgradeDialog();

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: P3, horizontal: P8),
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: P3),
            MTImage(ImageName.upgrade.name),
            const SizedBox(height: P3),
            H2(loc.app_may_upgrade_title, align: TextAlign.center),
            const SizedBox(height: P3),
            BaseText(loc.app_may_upgrade_description, align: TextAlign.center),
            const SizedBox(height: P5),
            MTButton.main(
              titleText: loc.app_install_action_title,
              onTap: () {
                go2AppInstall();
                Navigator.of(context).pop();
              },
            ),
            MTButton(
              titleText: loc.later,
              margin: EdgeInsets.only(top: P3, bottom: MediaQuery.paddingOf(context).bottom == 0 ? P3 : 0),
              onTap: router.pop,
            ),
          ],
        ),
      ),
    );
  }
}
