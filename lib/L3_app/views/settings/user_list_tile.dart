// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_list_tile.dart';
import '../../components/text_widgets.dart';
import '../../presenters/person_presenter.dart';
import '../account/account_view.dart';

class UserListTile extends StatelessWidget {
  const UserListTile(this.user);
  final User user;

  String get _title => '$user';
  String get _subtitle => user.email;

  Future _showAccount(BuildContext context) async => await Navigator.of(context).pushNamed(AccountView.routeName);

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      leading: Padding(
        padding: const EdgeInsets.only(right: P_2),
        child: user.icon(P * 3),
      ),
      middle: H3(_title),
      subtitle: _subtitle != _title ? LightText(_subtitle) : null,
      trailing: const ChevronIcon(),
      bottomBorder: false,
      onTap: () => _showAccount(context),
    );
  }
}
