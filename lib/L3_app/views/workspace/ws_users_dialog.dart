// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/colors_base.dart';
import '../../components/dialog.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../navigation/route.dart';
import '../../presenters/workspace.dart';
import 'ws_controller.dart';
import 'ws_user_tile.dart';

class WSUsersRoute extends MTRoute {
  static const staticBaseName = 'users';

  WSUsersRoute({super.parent})
      : super(
          baseName: staticBaseName,
          path: staticBaseName,
        );

  @override
  bool isDialog(BuildContext context) => true;

  @override
  String title(GoRouterState state) => '${_wsController.ws.code} | ${loc.workspace_members_title}';

  WSController get _wsController => parent!.controller as WSController;

  @override
  GoRouterWidgetBuilder? get builder => (_, __) => _WSUsersDialog(_wsController);
}

class _WSUsersDialog extends StatelessWidget {
  const _WSUsersDialog(this._wsController);
  final WSController _wsController;

  Workspace get _ws => _wsController.ws;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MTDialog(
        topBar: MTAppBar(
          showCloseButton: true,
          color: b2Color,
          pageTitle: loc.workspace_members_title,
          parentPageTitle: _ws.title,
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (_, int index) => WSUserTile(
            _ws,
            _ws.sortedUsers[index],
            bottomBorder: index < _ws.sortedUsers.length - 1,
          ),
          itemCount: _ws.users.length,
        ),
      );
    });
  }
}
