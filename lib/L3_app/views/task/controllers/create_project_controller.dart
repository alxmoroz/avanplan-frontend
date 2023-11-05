// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/workspace.dart';
import '../../../extra/services.dart';
import '../../../usecases/ws_actions.dart';
import '../../../usecases/ws_tariff.dart';
import '../../../usecases/ws_tasks.dart';
import '../../import/import_dialog.dart';
import '../../workspace/workspace_selector.dart';
import '../widgets/create/create_task_quiz_view.dart';
import 'create_project_quiz_controller.dart';
import 'task_controller.dart';

part 'create_project_controller.g.dart';

class CreateProjectController extends _CreateProjectControllerBase with _$CreateProjectController {}

List<Workspace> get _wss => wsMainController.workspaces;

abstract class _CreateProjectControllerBase with Store {
  @observable
  int? _selectedWSId = _wss.length == 1 ? _wss.first.id : null;
  @action
  void _setWS(int? _wsId) => _selectedWSId = _wsId;

  bool get _noMyWss => wsMainController.myWSs.isEmpty;

  @computed
  Workspace? get _ws => _selectedWSId != null ? wsMainController.wsForId(_selectedWSId!) : null;

  @computed
  bool get _mustSelectWS => _selectedWSId == null && wsMainController.canSelectWS;

  @computed
  bool get showPayBadge => !wsMainController.canSelectWS && _ws != null && !_ws!.plCreate(null);

  Future _selectWS() async {
    if (_mustSelectWS) {
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

  Future _dispose() async {
    if (wsMainController.canSelectWS) {
      _setWS(null);
    }
  }

  Future createProject(BuildContext context) async {
    await _selectWS();
    if (_ws != null) {
      final newP = await _ws!.createTask(null);
      if (newP != null) {
        final tc = TaskController(newP);
        await tc.showCreateTaskQuiz(CreateTaskQuizView.routeNameProject, context, CreateProjectQuizController(tc));
      }
    }
    await _dispose();
  }

  Future startImport() async {
    await _selectWS();
    if (_ws != null) {
      if (!_ws!.plCreate(null)) {
        await _ws!.changeTariff(reason: loc.tariff_change_limit_projects_reason_title);
      }
      if (_ws!.plCreate(null)) {
        await importTasks(_ws!);
      }
    }
    await _dispose();
  }
}
