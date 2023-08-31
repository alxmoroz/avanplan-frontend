// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/navbar.dart';
import '../../components/page.dart';
import '../../components/shadowed.dart';
import '../../extra/services.dart';
import '../../presenters/workspace.dart';
import 'user_tile.dart';

class UserListView extends StatelessWidget {
  const UserListView(this.ws);
  final Workspace ws;
  static String get routeName => '/users';

  Widget _itemBuilder(BuildContext context, int index) => UserTile(
        ws.sortedUsers[index],
        bottomBorder: index < ws.sortedUsers.length - 1,
      );

  @override
  Widget build(BuildContext context) {
    return MTPage(
      navBar: navBar(context, middle: ws.subPageTitle(loc.user_list_title)),
      body: SafeArea(
        top: false,
        bottom: false,
        child: MTShadowed(
          child: ListView.builder(
            itemBuilder: _itemBuilder,
            itemCount: ws.users.length,
          ),
        ),
      ),
    );
  }
}
