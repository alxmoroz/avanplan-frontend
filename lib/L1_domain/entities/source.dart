// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

enum SrcState {
  connected,
  error,
  unknown,
  checking,
}

class Source extends RPersistable {
  Source({
    super.id,
    required this.typeCode,
    required this.url,
    this.apiKey,
    this.username,
    this.password,
    this.description = '',
    this.state = SrcState.unknown,
  });

  final String typeCode;
  final String url;
  final String? apiKey;
  final String? username;
  final String? password;
  final String description;
  SrcState state;

  @override
  String toString() {
    final host = Uri.tryParse(url)?.host;
    return description.isNotEmpty ? description : host ?? url;
  }
}
