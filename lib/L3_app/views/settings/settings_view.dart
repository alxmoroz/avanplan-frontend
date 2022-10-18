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

  Future _showSources(BuildContext context) async => await Navigator.of(context).pushNamed(SourceListView.routeName);
  Future _showWorkspaces(BuildContext context) async => await Navigator.of(context).pushNamed(WorkspaceListView.routeName);
  User? get _user => accountController.user;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: _controller.isLoading,
        navBar: navBar(context),
        body: SafeArea(
          top: false,
          bottom: false,
          child: ListView(
            children: [
              SizedBox(height: onePadding / 2),
              if (_user != null) UserListTile(_user!),
              SizedBox(height: onePadding / 2),
              MTListTile(
                leading: importIcon(context, color: darkGreyColor),
                titleText: loc.source_list_title,
                trailing: chevronIcon(context),
                onTap: () => _showSources(context),
              ),
              if (mainController.workspaces.length > 1)
                MTListTile(
                  leading: wsIcon(context),
                  titleText: loc.workspaces_title,
                  trailing: chevronIcon(context),
                  onTap: () => _showWorkspaces(context),
                ),
              H4(
                loc.about_service_title,
                padding: EdgeInsets.symmetric(horizontal: onePadding).copyWith(top: onePadding * 2),
                color: lightGreyColor,
              ),
              MTListTile(
                leading: mailIcon(context),
                titleText: loc.contact_us_title,
                trailing: linkOutIcon(context),
                onTap: () => launchUrlString(contactUsMailSample),
              ),
              MTListTile(
                leading: privacyIcon(context),
                titleText: loc.privacy_policy_title,
                trailing: linkOutIcon(context),
                onTap: () => launchUrlString('$docsUrlPath/privacy'),
              ),
            ],
          ),
        ),

        /// версия
        bottomBar: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          LightText(loc.app_title),
          SizedBox(width: onePadding / 4),
          NormalText(_controller.appVersion),
        ]),
      ),
    );
  }
}
