// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../presenters/person.dart';
import 'user_view.dart';

class UserTile extends StatelessWidget {
  const UserTile(this.user, {required this.bottomBorder});
  final User user;
  final bool bottomBorder;

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      leading: user.icon(P4, borderColor: mainColor),
      middle: BaseText('$user'),
      subtitle: SmallText(user.rolesStr),
      trailing: const ChevronIcon(),
      bottomDivider: bottomBorder,
      onTap: () async => await Navigator.of(context).pushNamed(
        UserView.routeName,
        arguments: user,
      ),
    );
  }
}
