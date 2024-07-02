// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/local_settings.dart';
import '../../../L1_domain/utils/dates.dart';
import '../../../L2_data/services/platform.dart';
import '../../extra/services.dart';

part 'local_settings_controller.g.dart';

class LocalSettingsController extends _LocalSettingsControllerBase with _$LocalSettingsController {
  Future<LocalSettingsController> init() async {
    await dotenv.load(fileName: kReleaseMode ? 'assets/.env' : 'assets/.debug.env');

    settings = await localSettingsUC.settings();
    oldVersion = settings.version;
    settings = await localSettingsUC.updateSettingsFromLaunch(packageInfo.version);

    return this;
  }
}

abstract class _LocalSettingsControllerBase with Store {
  @observable
  LocalSettings settings = LocalSettings();

  @observable
  String oldVersion = '';
  @action
  void resetOldVersionFlag() => oldVersion = '';

  @computed
  bool get isNewVersion => oldVersion.isNotEmpty && oldVersion != settings.version;

  @computed
  int get buildNumber => int.parse(settings.version.split('.').lastOrNull ?? '0');

  /// Дата предложения обновиться (неделя), если не обновился ещё
  @computed
  DateTime? get _appUpgradeProposalDate => settings.getDate(LSDateCode.APP_UPGRADE_PROPOSAL);
  @computed
  bool get canProposeAppUpgrade => _appUpgradeProposalDate == null || _appUpgradeProposalDate!.isBefore(lastWeek);

  @action
  Future setAppUpgradeProposalDate() async => settings = await localSettingsUC.setDate(LSDateCode.APP_UPGRADE_PROPOSAL, now);

  @action
  Future resetAppUpgradeProposalDate() async => settings = await localSettingsUC.setDate(LSDateCode.APP_UPGRADE_PROPOSAL, null);

  /// Обработка диплинков
  @action
  Future parseQueryParameter(Uri uri, String key, String settingsCode) async {
    final params = uri.queryParameters;
    if (params.containsKey(key)) {
      settings = await localSettingsUC.setString(settingsCode, params[key]);
    }
  }

  /// Токен приглашения в проект
  @computed
  String? get invitationToken => settings.getString(LSStringCode.INVITATION_TOKEN);
  @computed
  bool get hasInvitation => invitationToken != null && invitationToken!.isNotEmpty;
  @action
  Future deleteInvitationToken() async => settings = await localSettingsUC.setString(LSStringCode.INVITATION_TOKEN, null);

  /// Токен регистрации
  @computed
  String? get registrationToken => settings.getString(LSStringCode.REGISTRATION_TOKEN);
  @computed
  bool get hasRegistration => registrationToken != null && registrationToken!.isNotEmpty;
  @action
  Future deleteRegistrationToken() async => settings = await localSettingsUC.setString(LSStringCode.REGISTRATION_TOKEN, null);
}
