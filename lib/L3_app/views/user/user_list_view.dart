// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/appbar.dart';
import '../../components/page.dart';
import '../../components/shadowed.dart';
import '../../extra/services.dart';
import '../../presenters/workspace.dart';
import 'user_tile.dart';

class UserListView extends StatelessWidget {
  const UserListView(this._ws);
  final Workspace _ws;

  static String get routeName => '/users';
  static String title(Workspace ws) => '$ws - ${loc.user_list_title}';

  Widget _itemBuilder(BuildContext context, int index) => UserTile(
        _ws.sortedUsers[index],
        bottomBorder: index < _ws.sortedUsers.length - 1,
      );

  @override
  Widget build(BuildContext context) {
    return MTPage(
      appBar: MTAppBar(context, middle: _ws.subPageTitle(loc.user_list_title)),
      body: SafeArea(
        top: false,
        bottom: false,
        child: MTShadowed(
          child: ListView.builder(
            itemBuilder: _itemBuilder,
            itemCount: _ws.users.length,
          ),
        ),
      ),
    );
  }
}
