// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/service_settings.dart';
import '../../../L2_data/services/platform.dart';
import '../../components/button.dart';
import '../../components/images.dart';
import '../../extra/services.dart';
import '../../usecases/communications.dart';
import '../_base/loadable.dart';
import 'app_may_upgrade_dialog.dart';
import 'release_notes_dialog.dart';

part 'app_controller.g.dart';

class AppController extends _AppControllerBase with _$AppController {}

abstract class _AppControllerBase with Store, Loadable {
  @observable
  ServiceSettings? settings;

  @action
  Future _getSettings() async {
    try {
      settings = await serviceSettingsUC.getSettings();
    } on Exception catch (e) {
      parseError(e);
    }
  }

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

  Future startup() async {
    setLoaderScreenLoading();
    startLoading();

    await _getSettings();

    // если нужно обязательно обновить приложение, заставляем обновиться
    if (!isWeb && mustUpgrade) {
      // TODO: проверить
      setLoaderScreen(
        titleText: loc.app_must_upgrade_title,
        descriptionText: loc.app_must_upgrade_description,
        imageName: ImageName.privacy.name,
        action: MTButton.main(titleText: loc.app_install_action_title, onTap: go2AppInstall),
      );
    } else {
      // если можно обновить приложение, предлагаем обновиться
      if (!isWeb && mayUpgrade && localSettingsController.canProposeAppUpgrade) {
        await showAppMayUpgradeDialog();
        localSettingsController.setAppUpgradeProposalDate();
      }

      // действия после обновления версии
      if (localSettingsController.isNewVersion) {
        try {
          final releaseNotes = (await releaseNoteUC.getReleaseNotes(localSettingsController.oldVersion))
              .sorted((rn1, rn2) => compareNatural(rn2.version, rn1.version));
          if (releaseNotes.isNotEmpty) {
            showReleaseNotesDialog(releaseNotes);
          }

          localSettingsController.resetAppUpgradeProposalDate();
          localSettingsController.resetOldVersionFlag();
        } catch (e) {
          if (kDebugMode) print('getReleaseNotes $e');
        }
      }
      stopLoading();
    }
  }
}
