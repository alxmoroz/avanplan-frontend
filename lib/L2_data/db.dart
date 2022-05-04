// Copyright (c) 2022. Alexandr Moroz

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'models/app_settings.dart';

class HType {
  static const AppSettings = 1;
}

class HiveStorage {
  Future<HiveStorage> init() async {
    const bool kIsWeb = identical(0, 0.0);
    if (!kIsWeb) {
      final _dir = await getApplicationDocumentsDirectory();
      final _dirPath = _dir.path;
      Hive.init(_dirPath);
    }

    Hive.registerAdapter(AppSettingsHOAdapter());

    return this;
  }
}
