// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../navigation/router.dart';
import '../../usecases/ws_actions.dart';
import '../app/services.dart';
import '../import/import_dialog.dart';
import '../task/widgets/create/create_task_dialog.dart';
import '../template/template_selector_dialog.dart';
import '../workspace/ws_selector_dialog.dart';
import 'creation_method_selector.dart';

part 'create_project_controller.g.dart';

class CreateProjectController extends _CreateProjectControllerBase with _$CreateProjectController {}

abstract class _CreateProjectControllerBase with Store {
  bool get _canSelectWS => wsMainController.workspaces.where((ws) => ws.hpProjectCreate).length > 1;

  @observable
  bool showClosedProjects = false;

  @action
  void setShowClosedProjects() => showClosedProjects = true;

  Future _selectWS() async => _canSelectWS ? await selectWS() : wsMainController.myWS;

  Future startCreate() async {
    final methodCode = await selectProjectCreationMethod();
    if (methodCode != null) {
      final ws = await _selectWS();
      if (ws != null) {
        switch (methodCode) {
          case CreationMethod.create:
            final newTC = await createTask(ws!, type: TType.PROJECT);
            if (newTC != null) router.goTask(newTC.taskDescriptor);
            break;
          case CreationMethod.template:
            await createFromTemplate(ws!);
            break;
          case CreationMethod.import:
            await importTasks(ws!);
            break;
        }
      }
    }
  }
}
