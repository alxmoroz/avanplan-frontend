// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/project_status.dart';

part 'statuses_controller.g.dart';

class StatusesController extends _StatusesControllerBase with _$StatusesController {}

//TODO: переделать, как с заметками

abstract class _StatusesControllerBase with Store {
  @observable
  ObservableList<ProjectStatus> statuses = ObservableList();

  @computed
  Map<int, ProjectStatus> get _stMap => {for (var st in statuses) st.id!: st};

  ProjectStatus? status(int? id) => _stMap[id];

  void _sort() => statuses.sort((st1, st2) => st1.position.compareTo(st2.position));

  @action
  void addStatuses(Iterable<ProjectStatus> sts) {
    statuses.addAll(sts);
    _sort();
  }

  @action
  void setStatus(ProjectStatus est) {
    final index = statuses.indexWhere((st) => st.id == est.id);
    if (index > -1) {
      statuses[index] = est;
    } else {
      statuses.add(est);
    }
    _sort();
  }

  @action
  void removeStatus(ProjectStatus st) => statuses.remove(st);

  @action
  void refresh() => statuses = ObservableList.of(statuses);

  @action
  Future getData() async {
    final _statuses = <ProjectStatus>[];
    print('STATUSES GETDATA');
    statuses = ObservableList.of(_statuses);
  }

  @action
  void clearData() => statuses.clear();
}
