// Copyright (c) 2022. Alexandr Moroz

import 'package:hive/hive.dart';

import '../../L1_domain/entities/local_settings.dart';
import '../services/db.dart';
import 'base.dart';

part 'local_settings.g.dart';

@HiveType(typeId: HType.LOCAL_SETTINGS)
class LocalSettingsHO extends BaseModel<LocalSettings> {
  @HiveField(3, defaultValue: '')
  String version = '';

  @HiveField(4, defaultValue: 0)
  int launchCount = 0;

  @HiveField(5)
  Map<String, bool>? flags = {};

  @HiveField(6)
  Map<String, DateTime>? dates = {};

  @override
  LocalSettings toEntity() => LocalSettings(
        version: version,
        launchCount: launchCount,
        flags: flags,
        dates: dates,
      );

  @override
  Future update(LocalSettings entity) async {
    id = entity.id;
    version = entity.version;
    launchCount = entity.launchCount;
    flags = entity.flags;
    dates = entity.dates;
    await save();
  }
}
