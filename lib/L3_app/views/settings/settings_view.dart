// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L2_data/repositories/communications_repo.dart';
import '../../../L2_data/services/platform.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_list_tile.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/communications_presenter.dart';
import '../notification/notification_list_view.dart';
import '../workspace/workspace_list_tile.dart';
import 'account_list_tile.dart';
import 'app_version.dart';

class SettingsView extends StatelessWidget {
  static String get routeName => '/settings';

  Widget _notifications(BuildContext context) => MTListTile(
        leading: BellIcon(color: greyColor, hasUnread: notificationController.hasUnread),
        titleText: loc.notification_list_title,
        trailing: Row(children: [
          if (notificationController.hasUnread)
            NormalText(
              notificationController.unreadCount.toString(),
              padding: const EdgeInsets.only(right: P_2),
            ),
          const ChevronIcon(),
        ]),
        onTap: () async => await Navigator.of(context).pushNamed(NotificationListView.routeName),
      );

  Widget get _workspaces => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          H4(
            loc.workspaces_title,
            padding: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P2),
            color: lightGreyColor,
          ),
          for (final ws in mainController.workspaces) WorkspaceListTile(ws)
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
                const SizedBox(height: P_2),
                _notifications(context),
                if (mainController.workspaces.isNotEmpty) _workspaces,
                H4(
                  loc.about_service_title,
                  padding: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P2),
                  color: lightGreyColor,
                ),
                MTListTile(
                  leading: const MailIcon(),
                  titleText: loc.contact_us_title,
                  trailing: const LinkOutIcon(),
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
                    onTap: () => launchUrlString(legalConfidentialPath),
                  ),
              ],
            ),
          ),

          /// версия
          bottomBar: const AppVersion(),
        ),
      );
}
