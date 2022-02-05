// Copyright (c) 2021. Alexandr Moroz

import 'package:hive/hive.dart';

import '../../L1_domain/entities/app_settings.dart';
import '../../L1_domain/entities/base.dart';
import '../../L3_data/models/base.dart';
import '../repositories/hive_storage.dart';

part 'app_settings.g.dart';

@HiveType(typeId: HType.AppSettings)
class AppSettingsHO extends BaseModel {
  @HiveField(3, defaultValue: '')
  String version = '';

  @HiveField(4, defaultValue: '')
  String authToken = '';

  @override
  AppSettings toEntity([dynamic _]) => AppSettings(
        version: version,
        firstLaunch: false,
        authToken: authToken,
        model: this,
      );

  @override
  Future<AppSettingsHO> fromEntity(BaseEntity entity) async {
    final settings = entity as AppSettings;
    id = settings.id;
    version = settings.version;
    authToken = settings.authToken;

    await save();

    return this;
  }
}
