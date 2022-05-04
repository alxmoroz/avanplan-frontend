// Copyright (c) 2022. Alexandr Moroz

import 'base_upsert.dart';

class RemoteTrackerUpsert extends BaseUpsert {
  RemoteTrackerUpsert({
    required int? id,
    required this.typeId,
    required this.url,
    required this.loginKey,
    required this.password,
    required this.description,
    required this.workspaceId,
  }) : super(id: id);

  final int typeId;
  final String url;
  final String loginKey;
  final String password;
  final String? description;

  final int workspaceId;
}
