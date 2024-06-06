// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/toolbar.dart';
import '../../extra/route.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../presenters/source.dart';
import '../../presenters/workspace.dart';
import '../../usecases/ws_actions.dart';
import 'no_sources.dart';
import 'source_edit_dialog.dart';

class WSSourcesRoute extends MTRoute {
  static const staticBaseName = 'sources';

  WSSourcesRoute({super.parent})
      : super(
          baseName: staticBaseName,
          path: staticBaseName,
          builder: (_, state) => _SourcesDialog(state.pathParamInt('wsId')!),
        );

  @override
  bool isDialog(BuildContext context) => true;

  @override
  String? title(GoRouterState state) => '${wsMainController.ws(state.pathParamInt('wsId')!).code} | ${loc.source_list_title}';
}

class _SourcesDialog extends StatelessWidget {
  const _SourcesDialog(this._wsId);
  final int _wsId;

  Workspace get _ws => wsMainController.ws(_wsId);

  Widget _sourceBuilder(BuildContext _, int index) {
    final s = _ws.sortedSources[index];
    return s.listTile(
      iconSize: P6,
      bottomBorder: index < _ws.sortedSources.length - 1,
      onTap: () => editSource(_ws, src: s),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MTDialog(
        topBar: MTAppBar(
          showCloseButton: true,
          color: b2Color,
          middle: _ws.subPageTitle(loc.source_list_title),
          trailing: _ws.sources.isNotEmpty && _ws.hpSourceCreate
              ? MTButton.icon(
                  const PlusIcon(circled: true, size: P5),
                  padding: const EdgeInsets.symmetric(horizontal: P2, vertical: P),
                  onTap: () => startAddSource(_ws),
                )
              : null,
        ),
        body: _ws.sources.isEmpty
            ? NoSources(_ws)
            : ListView.builder(
                shrinkWrap: true,
                itemBuilder: _sourceBuilder,
                itemCount: _ws.sources.length,
              ),
      );
    });
  }
}
