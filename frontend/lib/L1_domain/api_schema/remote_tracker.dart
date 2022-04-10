// Copyright (c) 2022. Alexandr Moroz

import 'base_upsert_schema.dart';

class RemoteTrackerUpsert extends TitleableUpsert {
  RemoteTrackerUpsert({
    required String title,
    required int? id,
    required this.typeId,
    required this.url,
    required this.loginKey,
    required this.password,
  }) : super(id: id, title: title);

  final int typeId;
  final String url;
  final String loginKey;
  final String password;
}
