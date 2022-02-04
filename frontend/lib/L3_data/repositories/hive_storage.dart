// Copyright (c) 2021. Alexandr Moroz

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../L1_domain/entities/base.dart';
import '../models/app_settings.dart';
import '../models/base.dart';
import 'hive_repository.dart';
import 'settings_repository.dart';

class HType {
  static const AppSettings = 7;
}

class HStorage {
  late Map<String, HiveRepo> _repos;

  Future<HStorage> init() async {
    const bool kIsWeb = identical(0, 0.0);
    if (!kIsWeb) {
      final _dir = await getApplicationDocumentsDirectory();
      final _dirPath = _dir.path;
      Hive.init(_dirPath);
    }

    Hive.registerAdapter(AppSettingsHOAdapter());

    _repos = {
      for (var r in [
        // HiveRepo<Comparison, ComparisonHO>(ECode.Comparison, () => ComparisonHO()),
        SettingsRepository(),
      ])
        r.boxName: r
    };

    return this;
  }

  HiveRepo<BaseEntity, BaseModel>? repoForName(String name) => _repos[name];

  Iterable<Box> get allBoxes => _repos.values.map((r) => r.box);

  Future open() async {
    for (var r in _repos.values) {
      await r.open();
    }
  }
}
