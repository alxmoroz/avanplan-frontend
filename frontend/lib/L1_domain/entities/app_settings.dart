// Copyright (c) 2021. Alexandr Moroz

import '../entities/base.dart';
import '../repositories/database_repository.dart';

class AppSettings extends BaseEntity {
  AppSettings({
    required this.firstLaunch,
    required DBModel? model,
    this.version = '',
  }) : super('settings', model: model);

  static const defaultPriorityScale = <double>[1 / 9, 1 / 7, 1 / 5, 1 / 3, 1 / 2, 1, 2, 3, 5, 7, 9];

  final bool firstLaunch;
  String version;

  @override
  String get classCode => ECode.AppSettings;
}
