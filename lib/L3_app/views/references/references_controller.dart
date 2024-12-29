// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/remote_source_type.dart';
import '../app/services.dart';

part 'references_controller.g.dart';

class ReferencesController extends _ReferencesControllerBase with _$ReferencesController {}

abstract class _ReferencesControllerBase with Store {
  /// тип источника импорта
  @observable
  List<RemoteSourceType> sourceTypes = [];

  @action
  Future reload() async {
    sourceTypes = [
      for (final st in ['Trello', 'Jira', 'GitLab', 'Redmine']) RemoteSourceType(id: -1, title: st, code: st.toLowerCase()),
      for (final st in ['Notion', 'GitHub', 'Asana', 'WEEEK']) RemoteSourceType(id: -1, title: st, code: st.toLowerCase(), active: false),
      // SourceType(id: -1, title: 'Trello JSON', code: 'trello_json'),
      // SourceType(id: -1, title: 'WEEEK JSON', code: 'weeek_json'),
      RemoteSourceType(id: -1, title: 'Яндекс.Трекер', code: 'yandex_tracker', active: false),
      RemoteSourceType(id: -1, title: loc.source_type_custom_title, description: loc.source_type_custom_description, code: 'custom', active: false),
    ];
  }

  @action
  void clear() {
    sourceTypes = [];
  }

  RemoteSourceType typeForCode(String code) => sourceTypes.firstWhere((st) => st.code == code);
}
