// Copyright (c) 2022. Alexandr Moroz

import 'base_upsert.dart';

class SourceUpsert extends BaseUpsert {
  SourceUpsert({
    required int? id,
    required this.workspaceId,
    required this.typeId,
    required this.url,
    this.apiKey,
    this.login,
    this.password,
    this.description,
  }) : super(id: id);

  final int typeId;
  final String url;
  final String? apiKey;
  final String? login;
  final String? password;
  final String? description;

  final int workspaceId;
}
