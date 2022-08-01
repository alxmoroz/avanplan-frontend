// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class SourceType extends Titleable {
  SourceType({required int id, required String title}) : super(id: id, title: title);
}

class Source extends RPersistable {
  Source({
    required int id,
    required this.workspaceId,
    required this.type,
    required this.url,
    this.apiKey,
    this.login,
    this.password,
    this.description,
    this.connected = false,
  }) : super(id: id);

  final int workspaceId;
  final SourceType type;
  final String url;
  final String? apiKey;
  final String? login;
  final String? password;
  final String? description;
  final bool connected;

  Source copyWithConnected(bool _connected) => Source(
        id: id,
        type: type,
        url: url,
        apiKey: apiKey,
        login: login,
        password: password,
        description: description,
        workspaceId: workspaceId,
        connected: _connected,
      );
}
