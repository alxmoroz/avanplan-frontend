// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/mt_dropdown.dart';
import '../../components/mt_text_field.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';

part 'workspace_bounded.g.dart';

class WorkspaceBounded = _WorkspaceBoundedBase with _$WorkspaceBounded;

abstract class _WorkspaceBoundedBase extends EditController with Store {
  @observable
  int? _selectedWSId;

  @action
  void selectWS(int? _wsId) => _selectedWSId = _wsId;

  @computed
  Workspace? get selectedWS {
    final workspaces = mainController.editableWSs;
    return workspaces.length == 1 ? workspaces.first : workspaces.firstWhereOrNull((s) => s.id == _selectedWSId);
  }

  // TODO: в текущей реализации возможность выбора РП не предусмотрена!
  Widget wsDropdown(BuildContext context) {
    return mainController.workspaces.length > 1
        ? MTDropdown<Workspace>(
            onChanged: (ws) => selectWS(ws?.id),
            value: selectedWS,
            items: mainController.editableWSs,
            label: loc.workspace_title,
            margin: tfPadding,
          )
        : Container();
  }
}
