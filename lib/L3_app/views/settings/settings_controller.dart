// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/app_settings.dart';
import '../../../L2_data/services/platform.dart';
import '../../extra/services.dart';

part 'settings_controller.g.dart';

class SettingsController extends _SettingsControllerBase with _$SettingsController {
  Future<SettingsController> init() async {
    await fetchData();
    return this;
  }
}

abstract class _SettingsControllerBase with Store {
  @observable
  AppSettings? settings;

  @computed
  bool get isFirstLaunch => settings?.firstLaunch ?? true;

  @computed
  String get appVersion => settings?.version ?? '';

  @action
  Future fetchData() async {
    await appSettingsUC.updateVersion(packageInfo.version);
    settings = await appSettingsUC.getSettings();
  }

  @action
  void clearData() => settings = null;
}
