// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:openapi/openapi.dart';

import '../../../L1_domain/entities/app_settings.dart';
import '../../extra/services.dart';
import '../auth/login_view.dart';
import '../base/base_controller.dart';

part 'main_controller.g.dart';

class MainController extends _MainControllerBase with _$MainController {
  @override
  Future<MainController> init() async {
    await settingsUC.updateVersion(packageInfo.version);
    await authUC.setApiCredentialsFromSettings();
    settings = await settingsUC.getSettings();

    return this;
  }
}

abstract class _MainControllerBase extends BaseController with Store {
  // этот параметр не меняется после запуска
  String get appName => packageInfo.appName;

  /// настройки
  @observable
  AppSettings? settings;

  @action
  void setSettings(AppSettings _settings) => settings = _settings;

  @computed
  bool get authorized => settings?.accessToken.isNotEmpty ?? false;

  @computed
  bool get isFirstLaunch => settings?.firstLaunch ?? true;

  @computed
  String get appVersion => settings?.version ?? '';

  @action
  Future login() async {
    await Navigator.of(context!).pushNamed(LoginView.routeName);
    settings = await settingsUC.getSettings();
  }

  @action
  Future logout() async {
    await authUC.logout();
    settings = await settingsUC.getSettings();
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
