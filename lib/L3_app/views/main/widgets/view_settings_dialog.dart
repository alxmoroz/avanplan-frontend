// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/button.dart';
import '../../../components/colors_base.dart';
import '../../../components/constants.dart';
import '../../../components/dialog.dart';
import '../../../components/toolbar.dart';

Future showViewSettingsDialog() async => await showMTDialog<void>(const _ViewSettingsDialog());

class _ViewSettingsDialog extends StatelessWidget {
  const _ViewSettingsDialog();

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(showCloseButton: true, color: b2Color, title: 'НАСТРОЙКИ ВИДА'),
      body: ListView(
        shrinkWrap: true,
        children: [
          // MTListSection(titleText: 'КАЛЕНДАРИ'),
          Align(
            child: MTButton.main(
              titleText: 'ПОДКЛЮЧИТЬ КАЛЕНДАРЬ GOOGLE',
              padding: EdgeInsets.symmetric(horizontal: P3),
              constrained: false,
            ),
          ),
          if (MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P3),
        ],
      ),
    );
  }
}
