// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_list_tile.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/communications_presenter.dart';
import '../source/source_list_view.dart';
import '../workspace/workspace_list_view.dart';
import 'settings_controller.dart';
import 'user_list_tile.dart';

class SettingsView extends StatelessWidget {
  static String get routeName => 'settings';

  SettingsController get _controller => settingsController;

  Future _showSources(BuildContext context) async {
    sourceController.checkSources();
    await Navigator.of(context).pushNamed(SourceListView.routeName);
  }

  Future _showWorkspaces(BuildContext context) async => await Navigator.of(context).pushNamed(WorkspaceListView.routeName);
  User? get _user => accountController.user;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(context),
        body: SafeArea(
          top: false,
          bottom: false,
          child: ListView(
            children: [
              const SizedBox(height: P_2),
              if (_user != null) UserListTile(_user!),
              const SizedBox(height: P_2),
              MTListTile(
                leading: const ImportIcon(color: darkGreyColor),
                titleText: loc.source_list_title,
                trailing: const ChevronIcon(),
                onTap: () => _showSources(context),
              ),
              if (mainController.workspaces.length > 1)
                MTListTile(
                  leading: const WSIcon(),
                  titleText: loc.workspaces_title,
                  trailing: const ChevronIcon(),
                  onTap: () => _showWorkspaces(context),
                ),
              H4(
                loc.about_service_title,
                padding: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P2),
                color: lightGreyColor,
              ),
              MTListTile(
                leading: const MailIcon(),
                titleText: loc.contact_us_title,
                trailing: const LinkOutIcon(),
                onTap: () => launchUrlString(contactUsMailSample),
              ),
              MTListTile(
                leading: const PrivacyIcon(),
                titleText: loc.privacy_policy_title,
                trailing: const LinkOutIcon(),
                onTap: () => launchUrlString('$docsUrlPath/privacy'),
              ),
            ],
          ),
        ),

        /// версия
        bottomBar: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          LightText(loc.app_title),
          const SizedBox(width: P / 4),
          NormalText(_controller.appVersion),
        ]),
      ),
    );
  }
}
