// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../app/about_dialog.dart';
import '../workspace/ws_list_tile.dart';
import 'account_button.dart';
import 'notifications_button.dart';

Future settingsMenu() async => await showMTDialog<void>(const _SettingsDialog());

class _SettingsDialog extends StatelessWidget {
  const _SettingsDialog();

  List<Workspace> get _wss => wsMainController.workspaces;

  void _toWS(BuildContext context, int wsId) {
    context.pop();
    context.goWS(wsId);
  }

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
                onTap: () async => _toWS(context, ws.id!),
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
        topBar: const MTAppBar(showCloseButton: true, color: b2Color),
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
