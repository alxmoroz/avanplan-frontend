// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/workspace.dart';
import '../../../navigation/router.dart';
import '../../../usecases/ws_actions.dart';
import '../../app/services.dart';
import '../../import/import_dialog.dart';
import '../../task/widgets/create/create_task_dialog.dart';
import '../../template/template_selector_dialog.dart';
import '../../workspace/ws_selector_dialog.dart';

part 'ws_main_controller.g.dart';

class WSMainController extends _WSMainControllerBase with _$WSMainController {}

abstract class _WSMainControllerBase with Store {
  @observable
  ObservableList<Workspace> workspaces = ObservableList();

  @computed
  bool get multiWS => workspaces.length > 1;

  @computed
  Workspace get myWS => workspaces.firstWhereOrNull((ws) => ws.isMine) ?? Workspace.dummy;

  Workspace? ws(int? wsId) => workspaces.firstWhereOrNull((ws) => ws.id == wsId);

  @action
  Future reload() async {
    final wss = (await wsUC.getAll()).sorted((w1, w2) => w1.compareTo(w2));
    for (var ws in wss) {
      ws.filled = true;
    }
    workspaces = ObservableList.of(wss);
  }

  @action
  void refreshUI() => workspaces = ObservableList.of(workspaces);

  @action
  void setWS(Workspace ews) {
    final index = workspaces.indexWhere((ws) => ws.id == ews.id);
    if (index > -1) {
      workspaces[index] = ews;
    } else {
      workspaces.add(ews);
    }
    workspaces.sort();
  }

  @computed
  bool get _canSelectWS => workspaces.where((ws) => ws.hpProjectCreate).length > 1;

  Future startCreateProject(TaskCreationMethod method) async {
    final ws = _canSelectWS ? await selectWS() : myWS;
    if (ws != null) {
      switch (method) {
        case TaskCreationMethod.BOARD:
        case TaskCreationMethod.LIST:
        case TaskCreationMethod.PROJECT:
          final newTC = await createTask(ws, type: TType.PROJECT, creationMethod: method);
          if (newTC != null) router.goTask(newTC.taskDescriptor);
          break;
        case TaskCreationMethod.TEMPLATE:
          await createFromTemplate(ws);
          break;
        case TaskCreationMethod.IMPORT:
          await importTasks(ws);
          break;
      }
    }
  }

  @action
  void clear() => workspaces.clear();
}
