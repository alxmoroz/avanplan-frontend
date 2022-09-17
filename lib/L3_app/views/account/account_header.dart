// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';

class AccountHeader extends StatelessWidget {
  const AccountHeader({this.expanded = false});
  final bool expanded;

  User get user => accountController.user!;

  Widget userIcon(BuildContext context) {
    return CircleAvatar(radius: onePadding * (expanded ? 2 : 1), backgroundColor: lightGreyColor.resolve(context));
  }

  String get titleString => '$user';
  String get subtitleString => user.email;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      userIcon(context),
      SizedBox(width: onePadding / 2),
      Column(children: [
        MediumText(titleString, color: darkGreyColor),
        if (expanded && subtitleString != titleString) LightText(subtitleString),
      ]),
    ]);
  }
}
