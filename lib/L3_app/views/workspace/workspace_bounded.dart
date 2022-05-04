// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/auth/workspace.dart';
import '../../components/constants.dart';
import '../../components/dropdown.dart';
import '../../extra/services.dart';

/// Рабочие пространства
mixin WorkspaceBounded {
  @observable
  int? _selectedWSId;

  @action
  void selectWS(int? _wsId) => _selectedWSId = _wsId;

  @computed
  Workspace? get selectedWS {
    final workspaces = workspaceController.workspaces;
    return workspaces.length == 1 ? workspaces.first : workspaces.firstWhereOrNull((s) => s.id == _selectedWSId);
  }

  List<Widget> wsDropdown(BuildContext context) {
    final mq = MediaQuery.of(context);
    final items = <Widget>[];
    if (workspaceController.workspaces.length > 1) {
      items.add(MTDropdown<Workspace>(
        width: mq.size.width - onePadding * 2,
        onChanged: (ws) => selectWS(ws?.id),
        value: selectedWS,
        items: workspaceController.workspaces,
        label: loc.workspace_placeholder,
      ));
    }
    return items;
  }
}
