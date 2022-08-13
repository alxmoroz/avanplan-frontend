// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/app_settings.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';
import '../source/source_list_view.dart';

part 'settings_controller.g.dart';

class SettingsController extends _SettingsControllerBase with _$SettingsController {}

abstract class _SettingsControllerBase extends BaseController with Store {
  // этот параметр не меняется после запуска
  String get appName => packageInfo.appName;

  @observable
  AppSettings? settings;

  @computed
  bool get isFirstLaunch => settings?.firstLaunch ?? true;

  @computed
  String get appVersion => settings?.version ?? '';

  @action
  Future fetchData() async {
    await settingsUC.updateVersion(packageInfo.version);
    settings = await settingsUC.getSettings();
  }

  @action
  void clearData() => settings = null;

  @override
  bool get isLoading => super.isLoading || mainController.isLoading;

  Future showSources(BuildContext context) async {
    await Navigator.of(context).pushNamed(SourceListView.routeName);
  }
}
