// Copyright (c) 2023. Alexandr Moroz

import 'package:avanplan/main.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../usecases/ws_tasks.dart';
import '../import/import_dialog.dart';
import '../task/controllers/task_controller.dart';
import '../task/widgets/create/create_task_quiz_view.dart';
import '../template/template_selector_dialog.dart';
import '../workspace/ws_selector_dialog.dart';
import 'create_project_quiz_controller.dart';
import 'creation_method_selector.dart';

part 'create_project_controller.g.dart';

class CreateProjectController extends _CreateProjectControllerBase with _$CreateProjectController {}

List<Workspace> get _wss => wsMainController.workspaces;

abstract class _CreateProjectControllerBase with Store {
  @observable
  int? _selectedWSId = _wss.length == 1 ? _wss.first.id : null;
  @action
  void _setWS(int? wsId) => _selectedWSId = wsId;

  bool get _noMyWss => wsMainController.myWSs.isEmpty;

  @computed
  Workspace? get _ws => _selectedWSId != null ? wsMainController.ws(_selectedWSId!) : null;

  @computed
  bool get _mustSelectWS => _selectedWSId == null && wsMainController.canSelectWS;

  Future _selectWS() async {
    if (_mustSelectWS) {
      int? wsId = await selectWS(canCreate: _noMyWss);
      if (wsId != null) {
        if (wsId == -1) {
          loader.setSaving();
          loader.start();
          wsId = (await wsMainController.createMyWS())?.id;
          await loader.stop();
        }
        if (wsId != null && wsId > -1) {
          _setWS(wsId);
        }
      }
    }
  }

  Future _dispose() async {
    if (wsMainController.canSelectWS) {
      _setWS(null);
    }
  }

  Future _create() async {
    final newP = await _ws!.createTask(null);
    if (newP != null) {
      //TODO: нужно ли в этом месте создавать контроллеры, может, тут достаточно отправить айдишники или задачу?
      final tc = TaskController(newP, isNew: true);
      // rootKey тут, потому что если добавлять с главной, то кнопка добавления пропадает оттуда
      await MTRouter.navigate(CreateProjectQuizRouter, rootKey.currentContext!, args: CreateTaskQuizArgs(tc, CreateProjectQuizController(tc)));
    }
  }

  Future startCreate() async {
    final methodCode = await selectCreationMethod();
    if (methodCode != null) {
      await _selectWS();

      if (_ws != null) {
        switch (methodCode) {
          case CreationMethod.create:
            await _create();
            break;
          case CreationMethod.template:
            await importTemplate(_ws!);
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
