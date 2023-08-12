// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/workspace.dart';
import '../../../../extra/services.dart';

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
  void selectImportMode() => importMode = true;

  @computed
  bool get mustSelectST => ws != null && ws!.sources.isEmpty;

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
}
