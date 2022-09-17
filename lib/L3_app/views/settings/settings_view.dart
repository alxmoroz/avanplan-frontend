// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_divider.dart';
import '../../components/mt_page.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../account/account_header.dart';
import '../account/account_view.dart';
import '../source/source_list_view.dart';
import 'settings_controller.dart';

class SettingsView extends StatelessWidget {
  static String get routeName => 'settings';

  SettingsController get _controller => settingsController;

  Future showAccount(BuildContext context) async => await Navigator.of(context).pushNamed(AccountView.routeName);
  Future showSources(BuildContext context) async => await Navigator.of(context).pushNamed(SourceListView.routeName);

  Widget menuItem(BuildContext context, {Widget? prefix, Widget? middle, String? title, VoidCallback? onTap}) {
    return MTRichButton.flat(
      prefix: prefix,
      middle: middle,
      titleString: title,
      suffix: chevronIcon(context),
      expanded: true,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: _controller.isLoading,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: onePadding),
              menuItem(context, middle: const AccountHeader(), onTap: () => showAccount(context)),
              const MTDivider(),
              menuItem(context, prefix: importIcon(context), title: loc.source_list_title, onTap: () => showSources(context)),
              const Spacer(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                LightText(_controller.appName),
                SizedBox(width: onePadding / 4),
                MediumText(_controller.appVersion),
              ]),
              SizedBox(height: onePadding),
            ],
          ),
        ),
      ),
    );
  }
}
