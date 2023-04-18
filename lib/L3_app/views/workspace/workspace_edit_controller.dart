// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';

part 'workspace_edit_controller.g.dart';

class WorkspaceEditController extends _WorkspaceEditControllerBase with _$WorkspaceEditController {
  WorkspaceEditController() {
    final ws = mainController.selectedWS!;
    initState(tfaList: [
      TFAnnotation('code', label: loc.code, text: ws.code),
      TFAnnotation('title', label: loc.title, text: ws.title),
      TFAnnotation('description', label: loc.description, text: ws.description, needValidate: false),
    ]);
  }
}

abstract class _WorkspaceEditControllerBase extends EditController with Store {
  int? srcId;

  Workspace get ws => mainController.selectedWS!;

  /// действия

  Future save() async {
    loaderController.start();
    loaderController.setSaving();
    final editedWS = await myUC.updateWorkspace(WorkspaceUpsert(
      id: ws.id,
      code: tfAnnoForCode('code').text,
      title: tfAnnoForCode('title').text,
      description: tfAnnoForCode('description').text,
    ));

    print(editedWS);

    if (editedWS != null) {
      ws.code = editedWS.code;
      ws.title = editedWS.title;
      ws.description = editedWS.description;

      Navigator.of(rootKey.currentContext!).pop(editedWS);
      await loaderController.stop(300);
    }
  }
}
