// Copyright (c) 2022. Alexandr Moroz

import '../base_entity.dart';

class RemoteTrackerType extends Titleable {
  RemoteTrackerType({required int id, required String title}) : super(id: id, title: title);
}

class RemoteTracker extends Titleable {
  RemoteTracker({
    required this.type,
    required this.url,
    required this.loginKey,
    required int id,
    required String title,
  }) : super(id: id, title: title);

  final RemoteTrackerType type;
  final String url;
  final String loginKey;
}
