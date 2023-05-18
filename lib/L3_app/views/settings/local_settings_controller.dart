// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/local_settings.dart';
import '../../../L2_data/services/platform.dart';
import '../../extra/services.dart';

part 'local_settings_controller.g.dart';

class LocalSettingsController extends _LocalSettingsControllerBase with _$LocalSettingsController {
  Future<LocalSettingsController> init() async {
    await dotenv.load(fileName: 'assets/.env');

    settings = await localSettingsUC.settings();
    oldVersion = settings.version;
    settings = await localSettingsUC.updateSettingsFromLaunch(packageInfo.version);

    return this;
  }
}

abstract class _LocalSettingsControllerBase with Store {
  @observable
  LocalSettings settings = LocalSettings(flags: {});

  @observable
  String oldVersion = '';

  @computed
  bool get isFirstLaunch => oldVersion.isEmpty;

  @action
  void clearData() {
    oldVersion = '';
  }
}
