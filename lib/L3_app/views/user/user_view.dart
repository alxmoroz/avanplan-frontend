// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/appbar.dart';
import '../../components/constants.dart';
import '../../components/list_tile.dart';
import '../../components/page.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../presenters/person.dart';
import '../../presenters/workspace.dart';

class UserView extends StatelessWidget {
  const UserView(this._user);
  final User _user;

  static String get routeName => '/user';
  static String title(User user) => '$user';

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        appBar: MTAppBar(
          context,
          middle: wsMainController.wsForId(_user.wsId).subPageTitle(loc.user_title),
          trailing: const SizedBox(width: P8),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: ListView(
            children: [
              const SizedBox(height: P3),
              _user.icon(P10),
              const SizedBox(height: P3),
              H2('$_user', align: TextAlign.center),
              BaseText(_user.email, align: TextAlign.center),
              if (_user.roles.isNotEmpty) ...[
                MTListSection(titleText: loc.role_list_title),
                MTListTile(
                  titleText: _user.rolesStr,
                  // trailing: ws.canEditUsers ? MTButton.icon(const EditIcon(), () => controller.editUser(context)) : null,
                  bottomDivider: false,
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
