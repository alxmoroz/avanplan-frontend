// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/workspace.dart';
import '../../../extra/services.dart';

part 'project_add_wizard_controller.g.dart';

class ProjectAddWizardController extends _ProjectAddWizardControllerBase with _$ProjectAddWizardController {}

List<Workspace> get _wss => mainController.workspaces;

abstract class _ProjectAddWizardControllerBase with Store {
  @observable
  int? selectedWSId = _wss.length == 1 ? _wss.first.id : null;
  @action
  void selectWS(int? _wsId) => selectedWSId = _wsId;

  @computed
  Workspace? get ws => selectedWSId != null ? mainController.wsForId(selectedWSId!) : null;
  @computed
  bool get mustSelectWS => selectedWSId == null && (_wss.isNotEmpty && _wss.length > 1) || mainController.myWSs.isEmpty;

  @observable
  bool importMode = false;
  @action
  void selectImportMode() => importMode = true;

  @computed
  bool get mustSelectST => ws != null && ws!.sources.isEmpty;

  // Future<Workspace?> createWS() async => await myUC.createWS();
}
