// Copyright (c) 2022. Alexandr Moroz

import 'package:hive/hive.dart';

import '../../L1_domain/entities/app_settings.dart';
import '../repositories/db.dart';
import 'base.dart';

part 'app_settings.g.dart';

@HiveType(typeId: HType.AppSettings)
class AppSettingsHO extends BaseModel<AppSettings> {
  @HiveField(3, defaultValue: '')
  String version = '';

  @override
  AppSettings toEntity() => AppSettings(
        version: version,
        firstLaunch: false,
      );

  @override
  Future update(AppSettings entity) async {
    id = entity.id;
    version = entity.version;
    await save();
  }
}
