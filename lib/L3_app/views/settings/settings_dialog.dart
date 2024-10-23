// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../extra/services.dart';
import '../../navigation/router.dart';
import '../app/about_dialog.dart';
import '../workspace/ws_list_tile.dart';
import 'account_button.dart';
import 'notifications_button.dart';

Future settingsDialog() async => await showMTDialog(const _SettingsDialog());

class _SettingsDialog extends StatelessWidget {
  const _SettingsDialog();

  List<Workspace> get _wss => wsMainController.workspaces;

  Widget _workspaces(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MTListGroupTitle(titleText: loc.workspaces_title),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _wss.length,
            itemBuilder: (_, index) {
              final ws = _wss[index];
              return WSListTile(
                ws,
                bottomDivider: index < _wss.length - 1,
                onTap: () {
                  Navigator.of(context).pop();
                  router.goWS(ws.id!);
                },
              );
            },
          ),
        ],
      );

  Widget get _about => MTListTile(
        leading: const QuestionIcon(),
        titleText: loc.about_service_title,
        margin: const EdgeInsets.only(top: P3),
        trailing: const ChevronIcon(),
        bottomDivider: false,
        onTap: () => showAboutServiceDialog(),
      );

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MTDialog(
        body: ListView(
          shrinkWrap: true,
          children: [
            const AccountButton(),
            const SizedBox(height: P3),
            const NotificationsButton(),
            if (_wss.isNotEmpty) _workspaces(context),
            _about,
          ],
        ),
      );
    });
  }
}
