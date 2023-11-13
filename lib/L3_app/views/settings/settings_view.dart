// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../../L2_data/repositories/communications_repo.dart';
import '../../../L2_data/services/platform.dart';
import '../../../main.dart';
import '../../components/adaptive.dart';
import '../../components/appbar.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/page.dart';
import '../../components/shadowed.dart';
import '../../components/text.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../usecases/communications.dart';
import '../notification/notification_list_view.dart';
import '../workspace/workspace_list_tile.dart';
import '../workspace/workspace_view.dart';
import 'account_list_tile.dart';
import 'app_version.dart';

class SettingsViewRouter extends MTRouter {
  @override
  String get path => '/settings';

  @override
  Widget get page => SettingsView();
}

class SettingsView extends StatelessWidget {
  List<Workspace> get _wss => wsMainController.workspaces;

  Widget get _notifications => MTListTile(
        leading: BellIcon(hasUnread: notificationController.hasUnread),
        titleText: loc.notification_list_title,
        trailing: Row(children: [
          if (notificationController.hasUnread)
            BaseText(
              '${notificationController.unreadCount}',
              padding: const EdgeInsets.only(right: P),
            ),
          const ChevronIcon(),
        ]),
        bottomDivider: false,
        onTap: () async => await NotificationListViewRouter().navigate(rootKey.currentContext!),
      );

  Widget get _workspaces => Column(
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
                onTap: () async => await WorkspaceViewRouter().navigate(rootKey.currentContext!, args: ws.id!),
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
            trailing: const LinkOutIcon(),
            bottomDivider: !isIOS,
            onTap: mailUs,
          ),
          if (!isIOS)
            MTListTile(
              leading: const RulesIcon(),
              titleText: loc.legal_rules_title,
              trailing: const LinkOutIcon(),
              onTap: () => launchUrlString(legalRulesPath),
            ),
          if (!isIOS)
            MTListTile(
              leading: const PrivacyIcon(),
              titleText: loc.legal_privacy_policy_title,
              trailing: const LinkOutIcon(),
              bottomDivider: false,
              onTap: () => launchUrlString(legalConfidentialPath),
            ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      // WidgetsBinding.instance.addPostFrameCallback((_) => setWebpageTitle(''));
      return MTPage(
        appBar: MTAppBar(context),
        body: SafeArea(
          top: false,
          bottom: false,
          child: MTShadowed(
            topPaddingIndent: P,
            child: MTAdaptive(
              child: ListView(
                children: [
                  AccountListTile(),
                  const SizedBox(height: P3),
                  _notifications,
                  if (_wss.isNotEmpty) _workspaces,
                  _about,

                  /// версия
                  const SizedBox(height: P3),
                  const AppVersion(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
