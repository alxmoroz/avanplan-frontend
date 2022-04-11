// Copyright (c) 2022. Alexandr Moroz

import 'base_upsert_schema.dart';

class RemoteTrackerUpsert extends BaseUpsert {
  RemoteTrackerUpsert({
    required int? id,
    required this.typeId,
    required this.url,
    required this.loginKey,
    required this.password,
    required this.description,
  }) : super(id: id);

  final int typeId;
  final String url;
  final String loginKey;
  final String password;
  final String? description;
}
