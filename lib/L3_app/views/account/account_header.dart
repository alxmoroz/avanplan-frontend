// Copyright (c) 2022. Alexandr Moroz

import 'dart:convert';

import 'package:crypto/crypto.dart';
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
    final r = onePadding * (expanded ? 2.5 : 1);
    final hash = md5.convert(utf8.encode(user.email)).toString();
    return CircleAvatar(
      radius: r,
      backgroundColor: lightGreyColor.resolve(context),
      backgroundImage: NetworkImage('https://www.gravatar.com/avatar/$hash?s=${r * 2}&d=identicon'),
    );
  }

  String get title => '$user';
  String get subtitle => user.email;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      userIcon(context),
      SizedBox(width: onePadding / 2),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          expanded ? H4(title) : MediumText(title, color: darkGreyColor),
          if (expanded && subtitle != title) ...[SizedBox(height: onePadding / 3), LightText(subtitle)]
        ]),
      ),
    ]);
  }
}
