// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../import/import_dialog.dart';
import '../task/widgets/create/create_task_dialog.dart';
import '../template/template_selector_dialog.dart';
import '../workspace/ws_selector_dialog.dart';
import 'creation_method_selector.dart';

part 'create_project_controller.g.dart';

class CreateProjectController extends _CreateProjectControllerBase with _$CreateProjectController {}

List<Workspace> get _wss => wsMainController.workspaces;

abstract class _CreateProjectControllerBase with Store {
  @observable
  int? _selectedWSId = _wss.length == 1 ? _wss.first.id : null;
  @action
  void _setWS(int? wsId) => _selectedWSId = wsId;

  @computed
  Workspace? get _ws => _selectedWSId != null ? wsMainController.ws(_selectedWSId!) : null;

  @computed
  bool get _mustSelectWS => _selectedWSId == null && wsMainController.canSelectWS;

  @observable
  bool showClosed = false;
  @action
  void setShowClosed() => showClosed = true;

  Future _selectWS() async {
    if (_mustSelectWS) {
      final wsId = await selectWS();
      if (wsId != null) {
        _setWS(wsId);
      }
    }
  }

  Future _dispose() async {
    if (wsMainController.canSelectWS) {
      _setWS(null);
    }
  }

  Future _create() async {
    final newP = await createTask(_ws!, null);
    if (newP != null) router.goTaskView(newP);
  }

  Future startCreate(BuildContext context) async {
    final methodCode = await selectCreationMethod();
    if (methodCode != null) {
      await _selectWS();

      if (_ws != null) {
        switch (methodCode) {
          case CreationMethod.create:
            await _create();
            break;
          case CreationMethod.template:
            await createFromTemplate(_ws!);
            break;
          case CreationMethod.import:
            await importTasks(_ws!);
            break;
        }
        await _dispose();
      }
    }
  }
}
