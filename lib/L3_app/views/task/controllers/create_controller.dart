// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/workspace.dart';
import '../../../extra/services.dart';
import '../../../usecases/ws_tasks.dart';
import '../../import/import_view.dart';
import '../task_onboarding_view.dart';
import '../widgets/create/ws_selector.dart';
import 'onboarding_controller.dart';
import 'task_controller.dart';

part 'create_controller.g.dart';

class CreateController extends _CreateControllerBase with _$CreateController {}

List<Workspace> get _wss => wsMainController.workspaces;

abstract class _CreateControllerBase with Store {
  @observable
  int? _selectedWSId = _wss.length == 1 ? _wss.first.id : null;
  @action
  void _setWS(int? _wsId) => _selectedWSId = _wsId;

  bool get _noMyWss => wsMainController.myWSs.isEmpty;

  @computed
  Workspace? get ws => _selectedWSId != null ? wsMainController.wsForId(_selectedWSId!) : null;
  @computed
  bool get mustSelectWS => _selectedWSId == null && (_wss.length > 1) || _noMyWss;

  Future _selectWS() async {
    if (mustSelectWS) {
      int? _wsId = await selectWS(canCreate: _noMyWss);
      if (_wsId != null) {
        if (_wsId == -1) {
          loader.start();
          loader.setSaving();
          _wsId = (await wsMainController.createMyWS())?.id;
          await loader.stop();
        }
        if (_wsId != null && _wsId > -1) {
          _setWS(_wsId);
        }
      }
    }
  }

  Future createProject(BuildContext context) async {
    await _selectWS();
    if (ws != null) {
      final newP = await ws!.createTask(null);
      if (newP != null) {
        final tc = TaskController(newP);
        await tc.showOnboardingTask(TaskOnboardingView.routeNameProject, context, OnboardingController(tc));
      }
    }
    _setWS(null);
  }

  Future startImport() async {
    await _selectWS();
    if (ws != null) {
      await importTasks(_selectedWSId!);
    }
    _setWS(null);
  }
}
