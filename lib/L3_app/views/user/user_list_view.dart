// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/appbar.dart';
import '../../components/constants.dart';
import '../../components/page.dart';
import '../../components/shadowed.dart';
import '../../extra/services.dart';
import '../../presenters/workspace.dart';
import 'user_tile.dart';

class UserListView extends StatelessWidget {
  const UserListView(this._wsId);
  final int _wsId;

  static String get routeName => '/users';
  static String title(int _wsId) => '${wsMainController.wsForId(_wsId)} - ${loc.user_list_title}';

  Workspace get ws => wsMainController.wsForId(_wsId);

  Widget _userBuilder(BuildContext context, int index) => UserTile(
        ws.sortedUsers[index],
        bottomBorder: index < ws.sortedUsers.length - 1,
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        appBar: MTAppBar(
          context,
          middle: ws.subPageTitle(loc.user_list_title),
          trailing: const SizedBox(width: P8),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: MTShadowed(
            child: ListView.builder(
              itemBuilder: _userBuilder,
              itemCount: ws.users.length,
            ),
          ),
        ),
      ),
    );
  }
}
