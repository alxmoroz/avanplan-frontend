// Copyright (c) 2021. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/app_settings.dart';
import '../../../L1_domain/entities/base.dart';
import '../../../L1_domain/usecases/auth_uc.dart';
import '../../../L3_data/repositories/settings_repository.dart';
import '../../../extra/services.dart';
import '../base/base_controller.dart';

part 'main_controller.g.dart';

class MainController extends _MainControllerBase with _$MainController {
  @override
  Future<MainController> init() async {
    await hStorage.open();
    // загрузка из БД
    //TODO: убрать костыли про авторизацию
    final repo = hStorage.repoForName(ECode.AppSettings) as SettingsRepo;
    final _settings = await repo.getOrCreate();
    setSettings(_settings);
    //TODO: не уверен, что это здесь должно быть. Может, вообще в другом контроллере?
    repo.setApiCredentials(_settings.accessToken);
    return this;
  }
}

abstract class _MainControllerBase extends BaseController with Store {
  /// рутовый объект
  // @observable
  // Main _main = Main();

  /// настройки
  @observable
  AppSettings settings = AppSettings(firstLaunch: true, model: null);

  @action
  void setSettings(AppSettings _settings) => settings = _settings;

  @computed
  bool get isFirstLaunch => settings.firstLaunch;

  //TODO: убрать костыли про авторизацию

  @observable
  bool authorized = false;

  @action
  Future logout() async {
    await settings.logout();
    authorized = false;
  }

  @action
  void setAuthorized(bool auth) {
    authorized = auth;
  }

// Future _getUserInfo() async {
//   final resp = await openAPI.getUsersApi().getMyAccountApiV1UsersMyAccountGet();
//   print(resp);
// }

  /// роутер

  //
  // Future goToCloudView() async {
  //   await Navigator.of(context!).pushNamed(CloudView.routeName);
  //   setMain(_main);
  // }
}
