// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/workspace.dart';
import '../task_view_controller.dart';

part 'project_add_dialog_controller.g.dart';

class ProjectAddDialogController extends _ProjectAddDialogControllerBase with _$ProjectAddDialogController {
  ProjectAddDialogController() {}
}

abstract class _ProjectAddDialogControllerBase with Store {
  @observable
  TaskViewController? taskController;

  @observable
  Workspace? selectedWS;

  @action
  void selectWS(Workspace? _ws) {
    selectedWS = _ws;
  }

  // Future<Workspace?> createWS() async => await myUC.createWS();
}
