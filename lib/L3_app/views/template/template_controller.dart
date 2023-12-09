// Copyright (c) 2022. Alexandr Moroz

import 'dart:async';

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../extra/services.dart';

part 'template_controller.g.dart';

class TemplateController extends _TemplateControllerBase with _$TemplateController {
  TemplateController(int wsId) {
    _wsId = wsId;
  }
}

abstract class _TemplateControllerBase with Store {
  late final int _wsId;
  // Workspace get ws => wsMainController.ws(_wsId);

  @observable
  Iterable<TaskBase> templates = [];

  @action
  Future getData() async => templates = await projectTransferUC.getProjectTemplates(_wsId);

  Future importTemplate() async {
    // if (await importUC.startImport(ws.id!, selectedSourceId!, selectedProjects)) {
    // await tasksMainController.updateImportingProjects();
    // }
    // Navigator.of(rootKey.currentContext!).pop();
  }
}
