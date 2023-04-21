// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import '../../presenters/ws_presenter.dart';
import 'user_list_tile.dart';

class UserListView extends StatelessWidget {
  const UserListView(this.ws);
  final Workspace ws;
  static String get routeName => '/users';

  Widget _itemBuilder(BuildContext context, int index) => UserListTile(ws.sortedUsers[index]);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(context, middle: ws.subPageTitle(loc.user_list_title)),
        body: SafeArea(
          top: false,
          bottom: false,
          child: ListView.builder(
            itemBuilder: _itemBuilder,
            itemCount: ws.users.length,
          ),
        ),
      ),
    );
  }
}
