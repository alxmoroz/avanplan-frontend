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
    settings = await localSettingsUC.settingsFromLaunch(packageInfo.version);
    return this;
  }
}

abstract class _LocalSettingsControllerBase with Store {
  @observable
  LocalSettings settings = LocalSettings(flags: {});

  @action
  Future setExplainUpdateDetailsShown() async => settings = await localSettingsUC.setFlag(LocalSettings.EXPLAIN_UPDATE_DETAILS_SHOWN, true);
  @computed
  bool get explainUpdateDetailsShown => settings.getFlag(LocalSettings.EXPLAIN_UPDATE_DETAILS_SHOWN);

  @action
  Future setWelcomeGiftInfoShown() async => settings = await localSettingsUC.setFlag(LocalSettings.WELCOME_GIFT_INFO_SHOWN, true);
  @computed
  bool get welcomeGiftInfoShown => settings.getFlag(LocalSettings.WELCOME_GIFT_INFO_SHOWN);
}
