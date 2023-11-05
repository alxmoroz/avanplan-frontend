// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/status.dart';
import '../../../../L1_domain/entities/workspace.dart';
import '../../../extra/services.dart';

part 'statuses_controller.g.dart';

class StatusesController extends _StatusesControllerBase with _$StatusesController {}

abstract class _StatusesControllerBase with Store {
  @observable
  ObservableList<Status> _allStatuses = ObservableList();

  Iterable<Status> statuses(int wsId) => _allStatuses.where((st) => st.wsId == wsId);

  @computed
  Map<int, Map<int, Status>> get _stMap => {
        for (var ws in wsMainController.workspaces) ws.id!: {for (var t in statuses(ws.id!)) t.id!: t}
      };

  Status? status(int wsId, int? id) => _stMap[wsId]![id];

  @action
  void addStatuses(Iterable<Status> sts) {
    _allStatuses.addAll(sts);
    // statuses.sortBy<num>((st) => st.id!);
  }

  @action
  void setStatus(Status est) {
    final index = _allStatuses.indexWhere((t) => t.wsId == est.wsId && t.id == est.id);
    if (index > -1) {
      _allStatuses[index] = est;
    } else {
      _allStatuses.add(est);
    }
    // statuses.sortBy<num>((st) => st.id!);
  }

  @action
  void removeStatus(Status st) => _allStatuses.remove(st);

  @action
  void refresh() => _allStatuses = ObservableList.of(_allStatuses);

  @action
  Future getData() async {
    final _statuses = <Status>[];
    for (Workspace ws in wsMainController.workspaces) {
      _statuses.addAll(await statusUC.getAll(ws.id!));
    }
    _allStatuses = ObservableList.of(_statuses);
  }

  @action
  void clearData() => _allStatuses.clear();
}
