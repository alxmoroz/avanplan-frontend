// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/adaptive.dart';
import '../../components/appbar.dart';
import '../../components/constants.dart';
import '../../components/page.dart';
import '../../components/shadowed.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../presenters/workspace.dart';
import 'user_tile.dart';

class UserListViewRouter extends MTRouter {
  static const _wsPrefix = '/settings/workspaces';
  static const _suffix = 'users';

  @override
  RegExp get pathRe => RegExp('^$_wsPrefix/(\\d+)/$_suffix\$');
  int get _id => int.parse(pathRe.firstMatch(rs!.uri.path)?.group(1) ?? '-1');

  @override
  Widget get page => UserListView(_id);

  @override
  String get title => '${wsMainController.ws(_id).code} | ${loc.user_list_title}';

  @override
  Future navigate(BuildContext context, {Object? args}) async => await Navigator.of(context).pushNamed('$_wsPrefix/${args as int}/$_suffix');
}

class UserListView extends StatelessWidget {
  const UserListView(this._wsId);
  final int _wsId;

  Workspace get _ws => wsMainController.ws(_wsId);

  Widget _userBuilder(BuildContext context, int index) => UserTile(
        _ws.sortedUsers[index],
        bottomBorder: index < _ws.sortedUsers.length - 1,
      );

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      // WidgetsBinding.instance.addPostFrameCallback((_) => setWebpageTitle('${_ws.code} | ${loc.user_list_title}'));
      return MTPage(
        appBar: MTAppBar(
          context,
          middle: _ws.subPageTitle(loc.user_list_title),
          trailing: const SizedBox(width: P8),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: MTShadowed(
            topPaddingIndent: P,
            child: MTAdaptive(
              child: ListView.builder(
                itemBuilder: _userBuilder,
                itemCount: _ws.users.length,
              ),
            ),
          ),
        ),
      );
    });
  }
}
