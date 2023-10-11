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
  List<Workspace> workspaces = [];

  @computed
  Iterable<Workspace> get myWSs => workspaces.where((ws) => ws.isMine);

  @computed
  bool get multiWS => workspaces.length > 1;

  Workspace wsForId(int wsId) => workspaces.firstWhere((ws) => ws.id == wsId);

  @action
  // TODO: нужен способ дергать обсервер без этих хаков
  void touchWorkspaces() => workspaces = [...workspaces];

  @action
  Future getWorkspaces() async {
    if (iapController.waitingPayment) {
      loader.set(imageName: 'purchase', titleText: loc.loader_purchasing_title);
    } else {
      loader.setLoading();
    }

    workspaces = (await myUC.getWorkspaces()).sorted((w1, w2) => compareNatural(w1.title, w2.title));
  }

  @action
  Future getData() async {
    await getWorkspaces();
  }

  @action
  void clearData() {
    workspaces = [];
  }
}
