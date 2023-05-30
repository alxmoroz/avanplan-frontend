// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_list_tile.dart';
import '../../components/text_widgets.dart';
import '../../presenters/person_presenter.dart';
import 'user_view.dart';

class UserListTile extends StatelessWidget {
  const UserListTile(this.user, {required this.bottomBorder});
  final User user;
  final bool bottomBorder;

  Future _showUser(BuildContext context) async => Navigator.of(context).pushNamed(
        UserView.routeName,
        arguments: user,
      );

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      leading: Padding(
        padding: const EdgeInsets.only(right: P_2),
        child: user.icon(P2),
      ),
      middle: NormalText('$user'),
      subtitle: SmallText(user.rolesStr, color: greyColor),
      trailing: const ChevronIcon(),
      bottomBorder: bottomBorder,
      onTap: () => _showUser(context),
    );
  }
}
