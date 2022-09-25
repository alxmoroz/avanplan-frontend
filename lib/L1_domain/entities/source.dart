// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class SourceType extends Titleable {
  SourceType({required super.id, required super.title});
}

enum SrcState {
  connected,
  error,
  unknown,
}

class Source extends RPersistable {
  Source({
    super.id,
    required this.workspaceId,
    required this.type,
    required this.url,
    this.apiKey,
    this.login,
    this.password,
    this.description = '',
    this.state = SrcState.unknown,
  });

  final int workspaceId;
  final SourceType type;
  final String url;
  final String? apiKey;
  final String? login;
  final String? password;
  final String description;
  SrcState state;
}
