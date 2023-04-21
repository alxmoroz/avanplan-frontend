// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/workspace.dart';
import '../../../extra/services.dart';

part 'project_add_wizard_controller.g.dart';

class ProjectAddWizardController extends _ProjectAddWizardControllerBase with _$ProjectAddWizardController {}

abstract class _ProjectAddWizardControllerBase with Store {
  @observable
  int? selectedWSId = mainController.workspaces.firstOrNull?.id;
  @action
  void selectWS(int? _wsId) => selectedWSId = _wsId;

  @computed
  Workspace? get ws => selectedWSId != null ? mainController.wsForId(selectedWSId!) : null;

  @observable
  bool importMode = false;
  @action
  void selectImportMode() => importMode = true;

  @computed
  bool get mustSelectST => ws != null && ws!.sources.isEmpty;

  bool get mustSelectWS => (mainController.workspaces.isNotEmpty && mainController.workspaces.length > 1) || mainController.myWSs.isEmpty;

  // Future<Workspace?> createWS() async => await myUC.createWS();
}
