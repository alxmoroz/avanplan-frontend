// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/task_type.dart';
import '../../extra/services.dart';

part 'references_controller.g.dart';

class ReferencesController extends _ReferencesControllerBase with _$ReferencesController {}

abstract class _ReferencesControllerBase with Store {
  /// тип источника импорта
  @observable
  ObservableList<SourceType> sourceTypes = ObservableList();

  SourceType? _sourceType(String typeTitle) => sourceTypes.firstWhereOrNull((st) => st.title.toLowerCase() == typeTitle);

  @computed
  SourceType? get stJira => _sourceType('jira');

  @computed
  bool get hasStJira => stJira != null;

  @computed
  SourceType? get stGitlab => _sourceType('gitlab');

  @computed
  bool get hasStGitlab => stGitlab != null;

  @computed
  SourceType? get stRedmine => _sourceType('redmine');

  @computed
  bool get hasStRedmine => stRedmine != null;

  /// тип задачи
  @observable
  ObservableList<TaskType> taskTypes = ObservableList();

  @action
  Future fetchData() async {
    sourceTypes = ObservableList.of((await sourceTypesUC.getAll()).sorted((s1, s2) => compareNatural(s1.title, s2.title)));
    taskTypes = ObservableList.of(await taskTypesUC.getAll());
  }

  @action
  void clearData() {
    sourceTypes.clear();
    taskTypes.clear();
  }
}
