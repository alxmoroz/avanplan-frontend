// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'models/app_settings.dart';
import 'models/local_auth.dart';

class HType {
  static const AppSettings = 1;
  static const LocalAuth = 2;
}

class HiveStorage {
  Future<HiveStorage> init() async {
    if (!kIsWeb) {
      final _dir = await getApplicationDocumentsDirectory();
      final _dirPath = _dir.path;
      Hive.init(_dirPath);
    }

    Hive.registerAdapter(AppSettingsHOAdapter());
    Hive.registerAdapter(LocalAuthHOAdapter());

    return this;
  }
}
