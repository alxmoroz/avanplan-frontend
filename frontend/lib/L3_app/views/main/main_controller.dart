// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:openapi/openapi.dart';

import '../../../L1_domain/entities/app_settings.dart';
import '../../../L2_data/repositories/settings_repo.dart';
import '../../../L3_app/views/auth/login_view.dart';
import '../../extra/services.dart';
import '../base/base_controller.dart';

part 'main_controller.g.dart';

class MainController extends _MainControllerBase with _$MainController {
  @override
  Future<MainController> init() async {
    // TODO: тут должен быть соотв. юзкейс! спрятать все репы от контроллеров. Юзкейсы инициализировать в сервисах
    settings = await SettingsRepo().setup();

    // TODO: не уверен, что это здесь должно быть. Может, вообще в другом контроллере или в инициализации в сервисах?
    await authUC.updateApiCredentialsFromSettings();

    return this;
  }
}

abstract class _MainControllerBase extends BaseController with Store {
  /// настройки
  @observable
  AppSettings? settings;

  @action
  void setSettings(AppSettings _settings) => settings = _settings;

  @computed
  bool get isFirstLaunch => settings?.firstLaunch ?? true;

  @computed
  bool get authorized => settings?.accessToken.isNotEmpty ?? false;

  @action
  Future login() async {
    await Navigator.of(context!).pushNamed(LoginView.routeName);
    settings = await SettingsRepo().getOne();
  }

  @action
  Future logout() async {
    await authUC.logout();
    settings = await SettingsRepo().getOne();
  }

  //TODO: для тестирования метод пока что тут. Нужен отдельный юзкейс и репы
  Future redmine() async {
    final builder = BodyTasksApiV1ImportRedmineTasksPostBuilder()
      ..apiKey = '101b62ea94b4132625a3d079451ea13fed3f4b87'
      ..host = 'https://redmine.moroz.team';

    await openAPI.getImportRedmineApi().tasksApiV1ImportRedmineTasksPost(
          bodyTasksApiV1ImportRedmineTasksPost: builder.build(),
        );
  }

  /// роутер

  //
  // Future goToCloudView() async {
  //   await Navigator.of(context!).pushNamed(CloudView.routeName);
  //   setMain(_main);
  // }
}
