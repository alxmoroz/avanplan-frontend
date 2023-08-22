// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L2_data/repositories/communications_repo.dart';
import '../../../L2_data/services/platform.dart';
import '../../../main.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_list_tile.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/communications.dart';
import '../notification/notification_list_view.dart';
import '../workspace/workspace_list_tile.dart';
import 'account_list_tile.dart';
import 'app_version.dart';

class SettingsView extends StatelessWidget {
  static String get routeName => '/settings';

  Widget get _notifications => MTListTile(
        leading: BellIcon(color: fgL4Color, hasUnread: notificationController.hasUnread),
        titleText: loc.notification_list_title,
        trailing: Row(children: [
          if (notificationController.hasUnread)
            NormalText(
              notificationController.unreadCount.toString(),
              padding: const EdgeInsets.only(right: P_2),
            ),
          const ChevronIcon(),
        ]),
        bottomDivider: false,
        onTap: () async => await Navigator.of(rootKey.currentContext!).pushNamed(NotificationListView.routeName),
      );

  Widget get _workspaces => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MTListSection(loc.workspaces_title),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: mainController.workspaces.length,
            itemBuilder: (_, index) {
              final ws = mainController.workspaces[index];
              return WorkspaceListTile(ws, bottomBorder: index < mainController.workspaces.length - 1);
            },
          ),
        ],
      );

  Widget get _about => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MTListSection(loc.about_service_title),
          MTListTile(
            leading: const MailIcon(),
            titleText: loc.contact_us_title,
            trailing: const LinkOutIcon(),
            bottomDivider: !isIOS,
            onTap: () => sendMail(loc.contact_us_mail_subject, appTitle, accountController.user?.id),
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
  Widget build(BuildContext context) => Observer(
        builder: (_) => MTPage(
          navBar: navBar(context),
          body: SafeArea(
            top: false,
            bottom: false,
            child: ListView(
              children: [
                const SizedBox(height: P_2),
                AccountListTile(),
                const SizedBox(height: P2),
                _notifications,
                if (mainController.workspaces.isNotEmpty) _workspaces,
                _about,
                MTButton.secondary(
                  margin: const EdgeInsets.only(top: P3, bottom: P2),
                  titleText: loc.auth_sign_out_btn_title,
                  titleColor: warningColor,
                  onTap: authController.signOut,
                ),
              ],
            ),
          ),

          /// версия
          bottomBar: const AppVersion(),
        ),
      );
}
