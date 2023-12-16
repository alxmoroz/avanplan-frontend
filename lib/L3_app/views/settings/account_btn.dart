// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/button.dart';
import '../../components/colors.dart';
import '../../extra/services.dart';
import '../../presenters/person.dart';

class AccountButton extends StatelessWidget {
  const AccountButton(this.onTap);
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return MTButton.icon(
      accountController.user!.icon(21, borderColor: mainColor),
      onTap: onTap,
      // padding: const EdgeInsets.only(left: P3),
    );
  }
}
