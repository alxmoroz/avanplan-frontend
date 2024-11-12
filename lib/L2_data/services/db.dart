// Copyright (c) 2022. Alexandr Moroz

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../models/app_local_settings.dart';
import '../models/local_auth.dart';
import '../models/task_local_settings.dart';
import '../services/platform.dart';

class HType {
  static const APP_LOCAL_SETTINGS = 1;
  static const LOCAL_AUTH = 2;
  static const TASK_LOCAL_SETTINGS = 3;
  static const TASK_VIEW_FILTER = 4;
}

class HiveStorage {
  Future<HiveStorage> init() async {
    if (!isWeb) {
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
    } else {
      // TODO: убрать после фикса Hive 2.2
      Hive.init('');
    }

    Hive.registerAdapter(AppLocalSettingsHOAdapter());
    Hive.registerAdapter(LocalAuthHOAdapter());
    Hive.registerAdapter(TaskViewFilterHOAdapter());
    Hive.registerAdapter(TaskLocalSettingsHOAdapter());

    return this;
  }
}
