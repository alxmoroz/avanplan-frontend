// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../presenters/person.dart';
import '../account/account_view.dart';

class AccountListTile extends StatelessWidget {
  User? get user => accountController.user;
  String get _title => '$user';
  String get _subtitle => user?.email ?? '';

  Future _showAccount(BuildContext context) async => await Navigator.of(context).pushNamed(AccountView.routeName);

  @override
  Widget build(BuildContext context) {
    return user != null
        ? MTListTile(
            leading: Padding(
              padding: const EdgeInsets.only(right: P_2),
              child: user!.icon(P3),
            ),
            middle: H3(_title),
            subtitle: _subtitle != _title ? NormalText.f2(_subtitle) : null,
            trailing: const ChevronIcon(),
            bottomDivider: false,
            onTap: () => _showAccount(context),
          )
        : Container();
  }
}
