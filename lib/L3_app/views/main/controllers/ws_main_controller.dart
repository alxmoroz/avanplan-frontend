// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/workspace.dart';
import '../../../extra/services.dart';

part 'ws_main_controller.g.dart';

class WSMainController extends _WSMainControllerBase with _$WSMainController {}

abstract class _WSMainControllerBase with Store {
  @observable
  ObservableList<Workspace> workspaces = ObservableList();

  @computed
  bool get multiWS => workspaces.length > 1;

  @computed
  bool get canSelectWS => multiWS;

  Workspace ws(int wsId) => workspaces.firstWhereOrNull((ws) => ws.id == wsId) ?? Workspace.dummy;

  @action
  Future getData() async => workspaces = ObservableList.of((await workspaceUC.getAll()).sorted((w1, w2) => w1.compareTo(w2)));

  @action
  // TODO: после переноса логики источников импорта на подобие статусов и задач — этот метод можно будет убрать
  void refreshWorkspaces() => workspaces = ObservableList.of(workspaces);

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

  Future<Workspace?> reloadWS(int wsId) async {
    final ws = await workspaceUC.getOne(wsId);
    if (ws != null) {
      setWS(ws);
    }
    return ws;
  }

  @action
  void clearData() {
    workspaces.clear();
  }
}
