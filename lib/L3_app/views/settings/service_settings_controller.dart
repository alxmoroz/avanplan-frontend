// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/service_settings.dart';
import '../../extra/services.dart';

part 'service_settings_controller.g.dart';

class ServiceSettingsController extends _ServiceSettingsControllerBase with _$ServiceSettingsController {
  Future<ServiceSettingsController> init() async {
    await getSettings();
    return this;
  }
}

abstract class _ServiceSettingsControllerBase with Store {
  @observable
  ServiceSettings? settings;

  @action
  Future getSettings() async => settings = await serviceSettingsUC.getSettings();

  @computed
  Duration get lowStartThreshold => Duration(days: settings?.lowStartThresholdDays ?? 0);

  @computed
  int get _buildNumber => int.parse((settings?.frontendVersion ?? '1.0').split('.').last);

  @computed
  int get _ltsBuildNumber => int.parse((settings?.frontendLtsVersion ?? '1.0').split('.').last);

  @computed
  bool get mayUpgrade => localSettingsController.buildNumber < _buildNumber;

  @computed
  bool get mustUpgrade => localSettingsController.buildNumber < _ltsBuildNumber;
}
