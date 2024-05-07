// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/colors_base.dart';
import '../../components/dialog.dart';
import '../../components/toolbar.dart';
import '../../extra/route.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../presenters/workspace.dart';
import 'ws_user_tile.dart';

class WSUsersRoute extends MTRoute {
  static const staticBaseName = 'users';

  WSUsersRoute({super.parent})
      : super(
          baseName: staticBaseName,
          path: staticBaseName,
          builder: (_, state) => _WSUsersDialog(state.pathParamInt('wsId')!),
        );

  @override
  bool isDialog(BuildContext context) => true;

  @override
  String? title(GoRouterState state) => '${wsMainController.ws(state.pathParamInt('wsId')!).code} | ${loc.members_title}';
}

class _WSUsersDialog extends StatelessWidget {
  const _WSUsersDialog(this._wsId);
  final int _wsId;

  Workspace get _ws => wsMainController.ws(_wsId);

  Widget _userBuilder(BuildContext context, int index) => WSUserTile(
        _ws.sortedUsers[index],
        bottomBorder: index < _ws.sortedUsers.length - 1,
      );

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MTDialog(
        topBar: MTAppBar(showCloseButton: true, color: b2Color, middle: _ws.subPageTitle(loc.members_title)),
        body: ListView.builder(
          shrinkWrap: true,
          itemBuilder: _userBuilder,
          itemCount: _ws.users.length,
        ),
      );
    });
  }
}
