// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/constants.dart';
import '../../components/mt_list_tile.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/person_presenter.dart';
import '../../presenters/ws_presenter.dart';

class UserView extends StatelessWidget {
  const UserView(this.user);

  static String get routeName => '/user';
  final User user;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(context, middle: mainController.wsForId(user.wsId).subPageTitle(loc.user_title)),
        body: SafeArea(
          top: false,
          bottom: false,
          child: ListView(
            children: [
              const SizedBox(height: P),
              user.icon(P3),
              const SizedBox(height: P_2),
              H3('$user', align: TextAlign.center),
              const SizedBox(height: P_2),
              NormalText(user.email, align: TextAlign.center),
              if (user.roles.isNotEmpty) ...[
                const SizedBox(height: P2),
                MediumText(loc.role_list_title, align: TextAlign.center),
                MTListTile(
                  middle: NormalText(user.rolesStr),
                  // trailing: ws.canEditUsers ? MTButton.icon(const EditIcon(), () => controller.editUser(context)) : null,
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
