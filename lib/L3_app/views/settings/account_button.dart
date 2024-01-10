// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../presenters/person.dart';
import '../account/account_dialog.dart';

class AccountButton extends StatelessWidget {
  const AccountButton({super.key});

  User? get user => accountController.user;

  void _toUser(BuildContext context) {
    Navigator.of(context).pop();
    MTRouter.navigate(AccountRouter, context);
  }

  @override
  Widget build(BuildContext context) {
    final name = '$user';
    final mail = user?.email ?? '';
    return MTListTile(
      leading: user?.icon(P6, borderColor: mainColor),
      middle: H3(name, maxLines: 2),
      subtitle: mail != name ? BaseText.f2(mail, maxLines: 1) : null,
      trailing: const ChevronIcon(),
      bottomDivider: false,
      onTap: () => _toUser(context),
    );
  }
}
