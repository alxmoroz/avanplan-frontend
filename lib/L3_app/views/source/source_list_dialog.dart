// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../presenters/source.dart';
import '../../presenters/workspace.dart';
import '../../usecases/ws_actions.dart';
import 'no_sources.dart';
import 'source_edit_dialog.dart';

class SourcesRouter extends MTRouter {
  static const _wsPrefix = '/settings/workspaces';
  static const _suffix = 'sources';

  @override
  bool get isDialog => true;

  @override
  RegExp get pathRe => RegExp('^$_wsPrefix/(\\d+)/$_suffix\$');
  int get _id => int.parse(pathRe.firstMatch(rs!.uri.path)?.group(1) ?? '-1');

  @override
  Widget get page => SourceListDialog(_id);

  @override
  String get title => '${wsMainController.ws(_id).code} | ${loc.source_list_title}';

  @override
  Future pushNamed(BuildContext context, {Object? args}) async => await Navigator.of(context).pushNamed('$_wsPrefix/${args as int}/$_suffix');
}

class SourceListDialog extends StatelessWidget {
  const SourceListDialog(this._wsId);
  final int _wsId;
  Workspace get _ws => wsMainController.ws(_wsId);

  Widget _sourceBuilder(BuildContext _, int index) {
    final s = _ws.sortedSources[index];
    return s.listTile(
      iconSize: P5,
      bottomBorder: index < _ws.sortedSources.length - 1,
      onTap: () => editSource(_ws, src: s),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MTDialog(
        topBar: MTToolBar(middle: _ws.subPageTitle(loc.source_list_title)),
        body: _ws.sources.isEmpty
            ? Center(child: NoSources(_ws))
            : ListView.builder(
                shrinkWrap: true,
                itemBuilder: _sourceBuilder,
                itemCount: _ws.sources.length,
              ),
        bottomBar: _ws.sources.isNotEmpty && _ws.hpSourceCreate
            ? MTAppBar(
                isBottom: true,
                bgColor: b2Color,
                trailing: MTPlusButton(() => startAddSource(_ws)),
              )
            : null,
      );
    });
  }
}
