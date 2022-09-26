// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_divider.dart';
import '../../components/mt_list_tile.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../source/source_list_view.dart';
import 'settings_controller.dart';
import 'user_list_tile.dart';

class SettingsView extends StatelessWidget {
  static String get routeName => 'settings';

  SettingsController get _controller => settingsController;

  Future _showSources(BuildContext context) async => await Navigator.of(context).pushNamed(SourceListView.routeName);
  User? get _user => accountController.user;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: _controller.isLoading,
        navBar: navBar(context),
        body: SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      if (_user != null) UserListTile(_user!),
                      MTListTile(
                        leading: importIcon(context, color: darkGreyColor),
                        titleText: loc.source_list_title,
                        trailing: chevronIcon(context),
                        onTap: () => _showSources(context),
                      ),
                    ],
                  ),
                ),

                /// версия
                MTDivider(height: onePadding),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  LightText(loc.appTitle),
                  SizedBox(width: onePadding / 4),
                  NormalText(_controller.appVersion),
                ]),
              ],
            )),
      ),
    );
  }
}
