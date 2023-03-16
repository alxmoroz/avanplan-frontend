// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/app_settings.dart';
import '../../../L1_domain/entities/local_settings.dart';
import '../../../L2_data/services/platform.dart';
import '../../extra/services.dart';

part 'settings_controller.g.dart';

class SettingsController extends _SettingsControllerBase with _$SettingsController {
  Future<SettingsController> init() async {
    settings = await localSettingsUC.settingsFromLaunch(packageInfo.version);
    return this;
  }
}

abstract class _SettingsControllerBase with Store {
  @observable
  LocalSettings settings = LocalSettings();

  @observable
  AppSettings? appSettings;

  @computed
  String get frontendFlags => appSettings?.frontendFlags ?? '';

  @action
  Future fetchAppsettings() async {
    appSettings = await appSettingsUC.getSettings();
  }
}
