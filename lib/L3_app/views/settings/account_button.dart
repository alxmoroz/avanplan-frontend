// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../presenters/user.dart';

class AccountButton extends StatelessWidget {
  const AccountButton({super.key});

  User? get me => accountController.me;

  @override
  Widget build(BuildContext context) {
    final name = '$me';
    final mail = me?.email ?? '';
    return MTListTile(
      leading: me?.icon(P5),
      middle: H3(name, maxLines: 2),
      subtitle: mail != name ? BaseText.f2(mail, maxLines: 1) : null,
      trailing: const ChevronIcon(),
      bottomDivider: false,
      onTap: () {
        Navigator.of(context).pop();
        router.goAccount();
      },
    );
  }
}
