// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/colors_base.dart';
import '../../components/dialog.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../presenters/workspace.dart';
import 'user_tile.dart';

class UsersRouter extends MTRouter {
  static const _wsPrefix = '/settings/workspaces';
  static const _suffix = 'users';

  @override
  bool get isDialog => true;

  @override
  RegExp get pathRe => RegExp('^$_wsPrefix/(\\d+)/$_suffix\$');
  int get _id => int.parse(pathRe.firstMatch(rs!.uri.path)?.group(1) ?? '-1');

  @override
  Widget get page => UserListDialog(_id);

  @override
  String get title => '${wsMainController.ws(_id).code} | ${loc.user_list_title}';

  @override
  Future pushNamed(BuildContext context, {Object? args}) async => await Navigator.of(context).pushNamed('$_wsPrefix/${args as int}/$_suffix');
}

class UserListDialog extends StatelessWidget {
  const UserListDialog(this._wsId, {super.key});
  final int _wsId;

  Workspace get _ws => wsMainController.ws(_wsId);

  Widget _userBuilder(BuildContext context, int index) => UserTile(
        _ws.sortedUsers[index],
        bottomBorder: index < _ws.sortedUsers.length - 1,
      );

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MTDialog(
        topBar: MTAppBar(showCloseButton: true, color: b2Color, middle: _ws.subPageTitle(loc.user_list_title)),
        body: ListView.builder(
          shrinkWrap: true,
          itemBuilder: _userBuilder,
          itemCount: _ws.users.length,
        ),
      );
    });
  }
}
