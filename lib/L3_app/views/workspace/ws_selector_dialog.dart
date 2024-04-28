// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/colors_base.dart';
import '../../components/dialog.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../usecases/ws_actions.dart';
import 'ws_list_tile.dart';

Future<int?> selectWS() async => await showMTDialog<int?>(const _WSSelectDialog());

class _WSSelectDialog extends StatelessWidget {
  const _WSSelectDialog();
  List<Workspace> get _wss => wsMainController.workspaces;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTAppBar(showCloseButton: true, color: b2Color, title: loc.workspace_selector_title),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: _wss.length,
          itemBuilder: (_, index) {
            final ws = _wss[index];
            final canSelect = ws.hpProjectCreate;
            return WSListTile(
              ws,
              bottomDivider: index < _wss.length - 1,
              onTap: canSelect ? () => router.pop(ws.id) : null,
            );
          },
        ),
      ),
    );
  }
}
