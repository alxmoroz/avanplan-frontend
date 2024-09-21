// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class RemoteSourceType extends Titleable {
  RemoteSourceType({
    super.id,
    required super.title,
    required this.code,
    super.description,
    this.active = true,
  });

  final String code;
  final bool active;

  bool get isJira => code == 'jira';
  bool get isTrello => code == 'trello';
  bool get isTrelloJson => code == 'trello_json';
  bool get isJson => code.endsWith('json');
  bool get hasApiKey => !isJson;
  bool get custom => code == 'custom';
}
