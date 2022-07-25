// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class RemoteTrackerType extends Titleable {
  RemoteTrackerType({required int id, required String title}) : super(id: id, title: title);
}

class RemoteTracker extends RPersistable {
  RemoteTracker({
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
  final RemoteTrackerType type;
  final String url;
  final String? apiKey;
  final String? login;
  final String? password;
  final String? description;
  final bool connected;

  RemoteTracker copyWithConnected(bool _connected) => RemoteTracker(
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
