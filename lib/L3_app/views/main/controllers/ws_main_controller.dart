// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/workspace.dart';
import '../../../extra/services.dart';
import '../../../usecases/ws_actions.dart';

part 'ws_main_controller.g.dart';

class WSMainController extends _WSMainControllerBase with _$WSMainController {}

abstract class _WSMainControllerBase with Store {
  @observable
  ObservableList<Workspace> workspaces = ObservableList();

  @computed
  bool get multiWS => workspaces.length > 1;

  @computed
  Workspace get myWS => workspaces.firstWhere((ws) => ws.isMine);

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

  @action
  void clear() => workspaces.clear();
}
