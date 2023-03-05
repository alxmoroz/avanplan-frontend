// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/workspace.dart';

part 'workspace_view_controller.g.dart';

class WorkspaceViewController extends _MemberViewControllerBase with _$WorkspaceViewController {
  WorkspaceViewController(Workspace _ws) {
    ws = _ws;
  }
}

abstract class _MemberViewControllerBase with Store {
  @observable
  Workspace? ws;

  @computed
  int get wsId => ws?.id ?? 0;

  @computed
  int get balance => ws?.balance.floor() ?? 0;
}
