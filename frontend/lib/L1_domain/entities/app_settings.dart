// Copyright (c) 2022. Alexandr Moroz

import '../entities/base.dart';
import '../repositories/database_repository.dart';

class AppSettings extends BaseEntity {
  AppSettings({
    required this.firstLaunch,
    this.version = '',
    this.accessToken = '',
    required DBModel? model,
  }) : super('settings', model: model);

  final bool firstLaunch;
  String version;
  String accessToken;

  @override
  String get classCode => ECode.AppSettings;
}
