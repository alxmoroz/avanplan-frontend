// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/feature_set.dart';
import '../../../L1_domain/entities/source_type.dart';
import '../../extra/services.dart';

part 'references_controller.g.dart';

class ReferencesController extends _ReferencesControllerBase with _$ReferencesController {}

abstract class _ReferencesControllerBase with Store {
  // TODO: deprecated
  /// настройки наборов функций (модулей) проектов
  @observable
  Iterable<FeatureSet> featureSets = [];

  @computed
  Map<int, FeatureSet> get featureSetsMap => {for (var fs in featureSets) fs.id!: fs};

  /// тип источника импорта
  @observable
  List<SourceType> sourceTypes = [];

  @action
  Future reload() async {
    sourceTypes = [
      for (final st in ['Trello', 'Jira', 'GitLab', 'Redmine']) SourceType(id: -1, title: st, code: st.toLowerCase()),
      for (final st in ['Notion', 'GitHub', 'asana', 'WEEEK']) SourceType(id: -1, title: st, code: st.toLowerCase(), active: false),
      // SourceType(id: -1, title: 'Trello JSON', code: 'trello_json'),
      // SourceType(id: -1, title: 'WEEEK JSON', code: 'weeek_json'),
      SourceType(id: -1, title: 'Яндекс.Трекер', code: 'yandex_tracker', active: false),
      SourceType(id: -1, title: loc.source_type_custom_title, description: loc.source_type_custom_description, code: 'custom', active: false),
    ];

    // TODO: deprecated
    featureSets = await featureSetUC.getAll();
  }

  @action
  void clear() {
    sourceTypes = [];
    featureSets = [];
  }

  SourceType typeForCode(String code) => sourceTypes.firstWhere((st) => st.code == code);
}
