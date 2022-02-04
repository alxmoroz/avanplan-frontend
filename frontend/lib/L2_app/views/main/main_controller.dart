// Copyright (c) 2021. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/app_settings.dart';
import '../../../L1_domain/entities/base.dart';
import '../../../L1_domain/entities/main.dart';
import '../../../L3_data/repositories/settings_repository.dart';
import '../../../extra/services.dart';
import '../base/base_controller.dart';

part 'main_controller.g.dart';

class MainController extends _MainControllerBase with _$MainController {
  @override
  Future<MainController> init() async {
    await hStorage.open();
    // загрузка из БД

    setSettings(await (hStorage.repoForName(ECode.AppSettings) as SettingsRepository).getOrCreate());
    return this;
  }
}

abstract class _MainControllerBase extends BaseController with Store {
  /// рутовый объект
  @observable
  Main _main = Main();

  @action
  void setMain(Main _m) => _main = _m;

  /// настройки
  @observable
  AppSettings settings = AppSettings(firstLaunch: true, model: null);

  @action
  void setSettings(AppSettings _settings) => settings = _settings;

  @computed
  bool get isFirstLaunch => settings.firstLaunch;

  /// UI
  bool get isTablet => iosInfo.model == 'iPad';

  /// роутер
  //
  // Future goToCloudView() async {
  //   await Navigator.of(context!).pushNamed(CloudView.routeName);
  //   setMain(_main);
  // }
}
