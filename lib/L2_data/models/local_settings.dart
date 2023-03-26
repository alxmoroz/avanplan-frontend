// Copyright (c) 2022. Alexandr Moroz

import 'package:hive/hive.dart';

import '../../L1_domain/entities/local_settings.dart';
import '../services/db.dart';
import 'base.dart';

part 'local_settings.g.dart';

@HiveType(typeId: HType.LocalSettings)
class LocalSettingsHO extends BaseModel<LocalSettings> {
  @HiveField(3, defaultValue: '')
  String version = '';

  @HiveField(4, defaultValue: 0)
  int launchCount = 0;

  @HiveField(5)
  Map<String, bool>? flags = {};

  @override
  LocalSettings toEntity() => LocalSettings(
        version: version,
        launchCount: launchCount,
        flags: flags,
      );

  @override
  Future update(LocalSettings entity) async {
    id = entity.id;
    version = entity.version;
    launchCount = entity.launchCount;
    flags = entity.flags;
    await save();
  }
}
