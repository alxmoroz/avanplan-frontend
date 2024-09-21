// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

enum RemoteSourceConnectionState {
  connected,
  error,
  unknown,
  checking,
}

class RemoteSource extends WSBounded {
  RemoteSource({
    super.id,
    required super.wsId,
    required this.typeCode,
    required this.url,
    this.apiKey,
    this.username,
    this.password,
    this.description = '',
    this.connectionState = RemoteSourceConnectionState.unknown,
  });

  final String typeCode;
  final String url;
  final String? apiKey;
  final String? username;
  final String? password;
  final String description;

  RemoteSourceConnectionState connectionState;

  @override
  String toString() {
    final host = Uri.tryParse(url)?.host;
    return description.isNotEmpty ? description : host ?? url;
  }
}
