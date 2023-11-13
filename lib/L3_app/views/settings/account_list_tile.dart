// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../presenters/person.dart';
import '../account/account_view.dart';

class AccountListTile extends StatelessWidget {
  User? get user => accountController.user;

  @override
  Widget build(BuildContext context) {
    final _name = '$user';
    final _mail = user?.email ?? '';
    return MTListTile(
      leading: user?.icon(P6, borderColor: mainColor),
      middle: H3(_name, maxLines: 2),
      subtitle: _mail != _name ? BaseText.f2(_mail, maxLines: 1) : null,
      trailing: const ChevronIcon(),
      bottomDivider: false,
      onTap: () async => AccountViewRouter().navigate(context),
    );
  }
}
