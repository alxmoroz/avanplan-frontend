// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/feature_set.dart';
import '../../../L1_domain/entities/source_type.dart';
import '../../extra/services.dart';

part 'references_controller.g.dart';

class ReferencesController extends _ReferencesControllerBase with _$ReferencesController {}

abstract class _ReferencesControllerBase with Store {
  /// настройки наборов функций (модулей) проектов
  @observable
  Iterable<FeatureSet> featureSets = [];

  @computed
  Map<int, FeatureSet> get featureSetsMap => {for (var fs in featureSets) fs.id!: fs};

  /// тип источника импорта
  @observable
  List<SourceType> sourceTypes = [];

  @action
  Future fetchData() async {
    sourceTypes = [
      for (final st in ['Trello', 'Jira', 'GitLab', 'Redmine']) SourceType(title: st, code: st.toLowerCase()),
      for (final st in ['Notion', 'GitHub']) SourceType(title: st, code: st.toLowerCase(), active: false),
      SourceType(title: 'Яндекс.Трекер', code: 'yandex_tracker', active: false),
    ];

    featureSets = await featureSetUC.getAll();
  }

  @action
  void clearData() {
    sourceTypes = [];
    featureSets = [];
  }

  SourceType typeForCode(String code) => sourceTypes.firstWhere((st) => st.code == code);
}
