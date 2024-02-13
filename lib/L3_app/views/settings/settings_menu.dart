// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../../L2_data/repositories/communications_repo.dart';
import '../../../L2_data/services/platform.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../usecases/communications.dart';
import '../workspace/workspace_dialog.dart';
import '../workspace/workspace_list_tile.dart';
import 'account_button.dart';
import 'app_version.dart';
import 'notifications_button.dart';

Future settingsMenu() async => await showMTDialog<void>(const _SettingsDialog());

class _SettingsDialog extends StatelessWidget {
  const _SettingsDialog();

  List<Workspace> get _wss => wsMainController.workspaces;

  void _toWS(BuildContext context, int wsId) {
    Navigator.of(context).pop();
    MTRouter.navigate(WorkspaceRouter, context, args: wsId);
  }

  Widget _workspaces(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MTListSection(titleText: loc.workspaces_title),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _wss.length,
            itemBuilder: (_, index) {
              final ws = _wss[index];
              return WorkspaceListTile(
                ws,
                bottomDivider: index < _wss.length - 1,
                onTap: () async => _toWS(context, ws.id!),
              );
            },
          ),
        ],
      );

  Widget get _about => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MTListSection(titleText: loc.about_service_title),
          MTListTile(
            leading: const MailIcon(),
            titleText: loc.contact_us_title,
            bottomDivider: !isIOS,
            onTap: mailUs,
          ),
          if (!isIOS)
            MTListTile(
              leading: const DocumentIcon(),
              titleText: loc.legal_rules_title,
              onTap: () => launchUrlString(legalRulesPath),
            ),
          if (!isIOS)
            MTListTile(
              leading: const PrivacyIcon(),
              titleText: loc.legal_privacy_policy_title,
              bottomDivider: false,
              onTap: () => launchUrlString(legalConfidentialPath),
            ),
        ],
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

            /// версия
            const SizedBox(height: P3),
            const AppVersion(),
            if (MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P3),
          ],
        ),
      );
    });
  }
}
