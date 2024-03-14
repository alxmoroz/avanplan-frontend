// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/button.dart';
import '../../../components/colors_base.dart';
import '../../../components/constants.dart';
import '../../../components/dialog.dart';
import '../../../components/toolbar.dart';
import '../../../extra/services.dart';

Future showViewSettingsDialog() async => await showMTDialog<void>(const _ViewSettingsDialog());

class _ViewSettingsDialog extends StatelessWidget {
  const _ViewSettingsDialog();

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(showCloseButton: true, color: b2Color, title: loc.my_tasks_view_settings_title),
      body: ListView(
        shrinkWrap: true,
        children: [
          // MTListSection(titleText: 'КАЛЕНДАРИ'),
          Align(
            child: MTButton.main(
              titleText: loc.calendar_connect_action_google_title,
              padding: const EdgeInsets.symmetric(horizontal: P5),
              constrained: false,
            ),
          ),
          if (MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P3),
        ],
      ),
    );
  }
}
