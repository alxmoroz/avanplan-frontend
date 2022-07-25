// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/app_settings.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';
import '../import/import_view.dart';
import '../remote_tracker/tracker_list_view.dart';

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
    startLoading();
    clearData();
    await settingsUC.updateVersion(packageInfo.version);
    settings = await settingsUC.getSettings();
    stopLoading();
  }

  @action
  void clearData() => settings = null;

  Future showTrackers(BuildContext context) async {
    await Navigator.of(context).pushNamed(TrackerListView.routeName);
  }

  Future importTasks(BuildContext context) async {
    if (trackerController.trackers.isEmpty) {
      await trackerController.addTracker(context);
    }
    final res = await showImportDialog(context);
    if (res == 'Add tracker') {
      await importTasks(context);
    }
  }
}
