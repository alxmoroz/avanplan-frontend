// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/auth/workspace.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';

part 'workspace_controller.g.dart';

class WorkspaceController extends _WorkspaceControllerBase with _$WorkspaceController {}

abstract class _WorkspaceControllerBase extends BaseController with Store {
  /// рабочие пространства
  @observable
  ObservableList<Workspace> workspaces = ObservableList();

  @action
  void _sortWS() => workspaces.sort((s1, s2) => s1.title.compareTo(s2.title));

  @override
  Future fetchData() async {
    if (loginController.authorized) {
      startLoading();

      workspaces = ObservableList.of(await workspacesUC.getAll());
      _sortWS();

      stopLoading();
    }
  }
}
