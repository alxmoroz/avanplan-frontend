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
}
