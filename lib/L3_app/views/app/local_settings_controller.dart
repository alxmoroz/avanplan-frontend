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

  @computed
  DateTime? get _appUpgradeProposalDate => settings.getDate(LSDateCode.APP_UPGRADE_PROPOSAL);
  @computed
  bool get canAppUpgradeProposal => _appUpgradeProposalDate == null || _appUpgradeProposalDate!.isBefore(lastWeek);

  @action
  Future setAppUpgradeProposalDate() async => settings = await localSettingsUC.setAppUpgradeProposalDate(now);

  @action
  Future resetAppUpgradeProposalDate() async => settings = await localSettingsUC.setAppUpgradeProposalDate(null);
}
