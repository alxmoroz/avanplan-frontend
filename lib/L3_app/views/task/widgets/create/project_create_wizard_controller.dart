// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/source_type.dart';
import '../../../../../L1_domain/entities/workspace.dart';
import '../../../../../main.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/ws_actions.dart';
import '../../../../usecases/ws_tariff.dart';
import '../../../import/import_view.dart';

part 'project_create_wizard_controller.g.dart';

class ProjectCreateWizardController extends _ProjectCreateWizardControllerBase with _$ProjectCreateWizardController {}

List<Workspace> get _wss => mainController.workspaces;

abstract class _ProjectCreateWizardControllerBase with Store {
  @observable
  int? selectedWSId = _wss.length == 1 ? _wss.first.id : null;
  @action
  void selectWS(int? _wsId) => selectedWSId = _wsId;

  bool get noMyWss => mainController.myWSs.isEmpty;

  @computed
  Workspace? get ws => selectedWSId != null ? mainController.wsForId(selectedWSId!) : null;
  @computed
  bool get mustSelectWS => selectedWSId == null && (_wss.isNotEmpty && _wss.length > 1) || noMyWss;

  @observable
  bool importMode = false;
  @action
  void _selectImportMode() => importMode = true;

  @computed
  bool get _mustSelectST => ws != null && ws!.sources.isEmpty;

  Future createMyWS() async {
    loader.start();
    loader.setSaving();
    final newWS = await myUC.createWorkspace();
    await mainController.fetchWorkspaces();
    if (newWS != null) {
      selectWS(newWS.id);
    }
    await loader.stop();
  }

  Future startImport(SourceType? sourceType) async {
    if (ws!.plProjects) {
      if (_mustSelectST && sourceType == null) {
        _selectImportMode();
      } else {
        Navigator.of(rootKey.currentContext!).pop();
        await importTasks(selectedWSId!, sType: sourceType);
      }
    } else {
      Navigator.of(rootKey.currentContext!).pop();
      await ws!.changeTariff(
        reason: loc.tariff_change_limit_projects_reason_title,
      );
    }
  }
}
