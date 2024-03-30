// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/colors_base.dart';
import '../../components/dialog.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../presenters/workspace.dart';
import 'ws_user_tile.dart';

class WSUsersRouter extends MTRouter {
  static const _wsPrefix = '/ws';
  static const _suffix = 'users';

  @override
  String path({Object? args}) => '$_wsPrefix/${args as int}/$_suffix';

  @override
  bool get isDialog => true;

  @override
  RegExp get pathRe => RegExp('^$_wsPrefix/(\\d+)/$_suffix\$');
  int get _id => int.parse(pathRe.firstMatch(rs!.uri.path)?.group(1) ?? '-1');

  @override
  Widget get page => _WSUsersDialog(_id);

  @override
  String get title => '${wsMainController.ws(_id).code} | ${loc.members_title}';
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
