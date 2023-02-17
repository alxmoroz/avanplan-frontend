// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

part 'references_controller.g.dart';

class ReferencesController extends _ReferencesControllerBase with _$ReferencesController {}

abstract class _ReferencesControllerBase with Store {
  /// тип источника импорта
  @observable
  List<String> sourceTypes = [];

  String? _sourceType(String typeTitle) => sourceTypes.firstWhereOrNull((st) => st.toLowerCase() == typeTitle);

  @computed
  String? get stJira => _sourceType('jira');

  @computed
  bool get hasStJira => stJira != null;

  @computed
  String? get stGitlab => _sourceType('gitlab');

  @computed
  bool get hasStGitlab => stGitlab != null;

  @computed
  String? get stRedmine => _sourceType('redmine');

  @computed
  bool get hasStRedmine => stRedmine != null;

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
