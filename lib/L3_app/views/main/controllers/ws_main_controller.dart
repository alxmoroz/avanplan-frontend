// Copyright (c) 2023. Alexandr Moroz

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
  Iterable<Workspace> get myWSs => workspaces.where((ws) => ws.isMine);

  @computed
  bool get multiWS => workspaces.length > 1;

  Workspace wsForId(int wsId) => workspaces.firstWhere((ws) => ws.id == wsId);

  @action
  Future getData() async {
    workspaces = ObservableList.of((await workspaceUC.getAll()).sorted((w1, w2) => compareNatural(w1.title, w2.title)));
  }

  @action
  // TODO: нужен способ дергать обсервер без этих хаков
  void refreshWorkspaces() => workspaces = ObservableList.of(workspaces);

  @action
  void setWS(Workspace ews) {
    final index = workspaces.indexWhere((ws) => ws.id == ews.id);
    if (index > -1) {
      workspaces[index] = ews;
    } else {
      workspaces.add(ews);
    }
    workspaces.sort((w1, w2) => compareNatural(w1.title, w2.title));
  }

  Future reloadWS(int wsId) async {
    final ws = await workspaceUC.getOne(wsId);
    if (ws != null) {
      setWS(ws);
    }
  }

  Future<Workspace?> createMyWS() async {
    final newWS = await workspaceUC.create();
    if (newWS != null) {
      setWS(newWS);
    }
    return newWS;
  }

  @action
  void clearData() {
    workspaces.clear();
  }
}
