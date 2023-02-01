// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

enum SrcState {
  connected,
  error,
  unknown,
}

class Source extends WSBounded {
  Source({
    super.id,
    required super.wsId,
    required this.type,
    required this.url,
    this.apiKey,
    this.username,
    this.password,
    this.description = '',
    this.state = SrcState.unknown,
  });

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
