// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/source_type.dart';

part 'references_controller.g.dart';

class ReferencesController extends _ReferencesControllerBase with _$ReferencesController {}

abstract class _ReferencesControllerBase with Store {
  /// тип источника импорта
  @observable
  List<SourceType> sourceTypes = [];

  @action
  Future fetchData() async {
    sourceTypes = [
      for (final st in ['Jira', 'GitLab', 'Redmine']) SourceType(title: st, code: st.toLowerCase()),
      for (final st in ['Trello', 'Notion', 'GitHub']) SourceType(title: st, code: st.toLowerCase(), active: false),
      SourceType(title: 'Яндекс.Трекер', code: 'yandex_tracker', active: false),
    ];
  }

  @action
  void clearData() {
    sourceTypes = [];
  }
}
