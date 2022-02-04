// Copyright (c) 2021. Alexandr Moroz

import 'package:hive/hive.dart';

import '../../L1_domain/entities/app_settings.dart';
import '../../L1_domain/entities/base.dart';
import '../../L3_data/models/base.dart';
import '../repositories/hive_storage.dart';

part 'app_settings.g.dart';

@HiveType(typeId: HType.AppSettings)
class AppSettingsHO extends BaseModel {
  @HiveField(0)
  String version = '';

  @HiveField(1, defaultValue: AppSettings.defaultPriorityScale)
  List<double> priorityScale = AppSettings.defaultPriorityScale;

  @override
  AppSettings toEntity([dynamic _]) => AppSettings(
        version: version,
        firstLaunch: false,
        model: this,
      );

  @override
  Future<AppSettingsHO> fromEntity(BaseEntity entity) async {
    final settings = entity as AppSettings;
    id = settings.id;
    version = settings.version;

    await save();

    return this;
  }
}
