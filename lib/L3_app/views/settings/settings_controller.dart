// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/app_settings.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';

part 'settings_controller.g.dart';

class SettingsController extends _SettingsControllerBase with _$SettingsController {
  Future<SettingsController> init() async {
    settings = await settingsUC.getSettings();
    await settingsUC.updateVersion(packageInfo.version);
    return this;
  }
}

abstract class _SettingsControllerBase extends BaseController with Store {
  // этот параметр не меняется после запуска
  String get appName => packageInfo.appName;

  @observable
  AppSettings? settings;

  @computed
  bool get isFirstLaunch => settings?.firstLaunch ?? true;

  @computed
  String get appVersion => settings?.version ?? '';
}
