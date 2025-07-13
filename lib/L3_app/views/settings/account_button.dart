// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../navigation/router.dart';
import '../../presenters/user.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import '../app/services.dart';

class AccountButton extends StatelessWidget {
  const AccountButton({super.key});

  User? get me => myAccountController.me;

  @override
  Widget build(BuildContext context) {
    final name = '$me';
    final mail = me?.email ?? '';
    return MTListTile(
      color: b3Color,
      leading: me?.icon(kIsWeb ? P4 + P_2 : P5),
      middle: H3(name, maxLines: 2),
      subtitle: mail != name ? BaseText.f2(mail, maxLines: 1) : null,
      trailing: kIsWeb ? null : const ChevronIcon(),
      onTap: () {
        Navigator.of(context).pop();
        router.goAccount();
      },
    );
  }
}
