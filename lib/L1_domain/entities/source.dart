// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

enum SrcState {
  connected,
  error,
  unknown,
}

class Source extends RPersistable {
  Source({
    super.id,
    this.workspaceId = -1,
    required this.type,
    required this.url,
    this.apiKey,
    this.username,
    this.password,
    this.description = '',
    this.state = SrcState.unknown,
  });

  int workspaceId;
  final String type;
  final String url;
  final String? apiKey;
  final String? username;
  final String? password;
  final String description;
  SrcState state;

  @override
  String toString() => description.isEmpty ? type : description;
}
