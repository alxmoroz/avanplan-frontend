// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/service_settings.dart';
import '../../../L2_data/services/platform.dart';
import '../../extra/services.dart';
import 'app_may_upgrade_dialog.dart';
import 'release_notes_dialog.dart';

part 'app_controller.g.dart';

typedef _FutureFunction = Future Function();

class AppController extends _AppControllerBase with _$AppController {}

abstract class _AppControllerBase with Store {
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

  @observable
  bool _init = false;

  @action
  Future initState({_FutureFunction? authorizedActions}) async {
    if (!_init) {
      print('AppController initState');

      _init = true;

      await getSettings();

      // если нужно обязательно обновить приложение, заставляем обновиться
      if (!isWeb && mustUpgrade) {
        loader.setMustUpgrade();
      } else {
        // если можно обновить приложение, предлагаем обновиться
        if (!isWeb && mayUpgrade && localSettingsController.canProposeAppUpgrade) {
          await showAppMayUpgradeDialog();
          await localSettingsController.setAppUpgradeProposalDate();
        }

        // действия после обновления версии
        if (localSettingsController.isNewVersion) {
          final releaseNotes = (await releaseNoteUC.getReleaseNotes(localSettingsController.oldVersion))
              .sorted((rn1, rn2) => compareNatural(rn2.version, rn1.version));
          if (releaseNotes.isNotEmpty) {
            showReleaseNotesDialog(releaseNotes);
          }

          await localSettingsController.resetAppUpgradeProposalDate();
          localSettingsController.resetOldVersionFlag();
        }

        await authController.checkLocalAuth();
        if (authController.authorized && authorizedActions != null) {
          await authorizedActions();
        }

        loader.stopInit();

        _init = false;
      }
    }
  }
}
