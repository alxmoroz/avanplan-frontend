// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/workspace.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/ws_actions.dart';

Future<int?> selectWS({bool canCreate = false}) async => await showMTDialog<int?>(WSSelector(canCreate));

class WSSelector extends StatelessWidget {
  const WSSelector(this._canCreate);
  final bool _canCreate;
  List<Workspace> get _wss => wsMainController.workspaces;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTTopBar(titleText: loc.workspace_selector_title),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: _wss.length + (_canCreate ? 1 : 0),
          itemBuilder: (_, index) {
            if (index == _wss.length) {
              return MTListTile(
                leading: const PlusIcon(),
                middle: BaseText.medium(loc.workspace_my_title, color: mainColor),
                bottomDivider: false,
                onTap: () => Navigator.of(context).pop(-1),
                padding: const EdgeInsets.all(P).copyWith(right: P3),
              );
            } else {
              final ws = _wss[index];
              final canSelect = ws.hpProjectCreate;
              return MTListTile(
                middle: BaseText.medium(ws.title, color: canSelect ? null : f2Color),
                trailing: canSelect ? const ChevronIcon() : const PrivacyIcon(),
                bottomDivider: index < _wss.length - 1,
                onTap: canSelect ? () => Navigator.of(context).pop(ws.id) : null,
                padding: const EdgeInsets.all(P2).copyWith(right: canSelect ? P3 : P2),
              );
            }
          },
        ),
      ),
    );
  }
}
