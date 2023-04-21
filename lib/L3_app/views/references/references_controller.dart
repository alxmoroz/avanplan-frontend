// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

part 'references_controller.g.dart';

class ReferencesController extends _ReferencesControllerBase with _$ReferencesController {}

abstract class _ReferencesControllerBase with Store {
  /// тип источника импорта
  @observable
  List<String> sourceTypes = [];

  /// тип задачи
  // @observable
  // List<TaskType> taskTypes = [];

  @action
  Future fetchData() async {
    sourceTypes = ['Jira', 'GitLab', 'Redmine'];
    // ObservableList.of((await sourceTypesUC.getAll()).sorted((s1, s2) => compareNatural(s1.code, s2.code)));
    // taskTypes = ObservableList.of(await taskTypesUC.getAll());
  }

  @action
  void clearData() {
    sourceTypes = [];
    // taskTypes = [];
  }
}
