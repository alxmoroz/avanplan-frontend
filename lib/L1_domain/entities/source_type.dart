// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class SourceType extends Titleable {
  SourceType({
    super.id,
    required super.title,
    required this.code,
    this.active = true,
  });

  final String code;
  final bool active;

  bool get isJira => code == 'jira';
  bool get isTrello => code == 'trello';
}
