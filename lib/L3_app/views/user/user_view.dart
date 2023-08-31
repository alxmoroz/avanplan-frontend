// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/constants.dart';
import '../../components/list_tile.dart';
import '../../components/navbar.dart';
import '../../components/page.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../presenters/person.dart';
import '../../presenters/workspace.dart';

class UserView extends StatelessWidget {
  const UserView(this.user);

  static String get routeName => '/user';
  final User user;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          middle: mainController.wsForId(user.wsId).subPageTitle(loc.user_title),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: ListView(
            children: [
              const SizedBox(height: P3),
              user.icon(P10),
              const SizedBox(height: P3),
              H2('$user', align: TextAlign.center),
              BaseText(user.email, align: TextAlign.center),
              if (user.roles.isNotEmpty) ...[
                MTListSection(loc.role_list_title),
                MTListTile(
                  titleText: user.rolesStr,
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
