// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/service_settings.dart';
import '../../../L2_data/services/platform.dart';
import '../../extra/services.dart';

part 'service_settings_controller.g.dart';

class ServiceSettingsController extends _ServiceSettingsControllerBase with _$ServiceSettingsController {
  Future<ServiceSettingsController> init() async {
    await fetchSettings();
    return this;
  }
}

abstract class _ServiceSettingsControllerBase with Store {
  @observable
  ServiceSettings? settings;

  @computed
  String get frontendFlags => settings?.frontendFlags ?? '';

  @action
  Future fetchSettings() async => settings = await serviceSettingsUC.getSettings();

  @computed
  bool get passAppleCheat => !isIOS || !frontendFlags.contains('ios_hide_ws');
  // bool get passAppleCheat => !isIOS || !frontendFlags.contains('ios_hide_ws') || !kReleaseMode;
}
