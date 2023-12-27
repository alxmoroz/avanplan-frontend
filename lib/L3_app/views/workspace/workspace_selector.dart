// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../usecases/ws_actions.dart';
import 'workspace_list_tile.dart';

Future<int?> selectWS({bool canCreate = false}) async => await showMTDialog<int?>(WorkspaceSelector(canCreate));

class WorkspaceSelector extends StatelessWidget {
  const WorkspaceSelector(this._canCreate);
  final bool _canCreate;
  List<Workspace> get _wss => wsMainController.workspaces;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTAppBar(showCloseButton: true, bgColor: b2Color, title: loc.workspace_selector_title),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: _wss.length + (_canCreate ? 1 : 0),
          itemBuilder: (_, index) {
            if (index == _wss.length) {
              return MTButton.secondary(
                leading: const PlusIcon(),
                margin: const EdgeInsets.only(bottom: P3),
                titleText: loc.workspace_my_title,
                onTap: () => Navigator.of(context).pop(-1),
              );
            } else {
              final ws = _wss[index];
              final canSelect = ws.hpProjectCreate;
              return WorkspaceListTile(
                ws,
                onTap: canSelect ? () => Navigator.of(context).pop(ws.id) : null,
                bottomDivider: index < _wss.length - 1,
              );
            }
          },
        ),
      ),
    );
  }
}
