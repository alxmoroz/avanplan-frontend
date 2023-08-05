// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/service_settings.dart';
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
  Duration get lowStartThreshold => Duration(days: settings?.lowStartThresholdDays ?? 0);

  @action
  Future fetchSettings() async => settings = await serviceSettingsUC.getSettings();
}
