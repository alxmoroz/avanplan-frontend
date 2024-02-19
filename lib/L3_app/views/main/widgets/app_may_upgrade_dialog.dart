// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../L2_data/repositories/communications_repo.dart';
import '../../../components/button.dart';
import '../../../components/constants.dart';
import '../../../components/dialog.dart';
import '../../../components/images.dart';
import '../../../components/text.dart';
import '../../../extra/services.dart';

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
                launchUrlString(appInstallUrl);
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: P3),
            MTButton(titleText: loc.later, onTap: () => Navigator.of(context).pop()),
          ],
        ),
      ),
    );
  }
}
