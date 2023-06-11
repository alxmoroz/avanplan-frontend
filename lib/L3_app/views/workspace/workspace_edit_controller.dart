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
  WorkspaceEditController(Workspace _ws) {
    ws = _ws;
    initState(tfaList: [
      TFAnnotation('code', label: loc.code, text: ws.code),
      TFAnnotation('title', label: loc.title, text: ws.title),
      TFAnnotation('description', label: loc.description, text: ws.description, needValidate: false),
    ]);
  }
}

abstract class _WorkspaceEditControllerBase extends EditController with Store {
  late Workspace ws;

  /// действия

  Future save() async {
    loader.start();
    loader.setSaving();
    final editedWS = await myUC.updateWorkspace(WorkspaceUpsert(
      id: ws.id,
      code: tfa('code').text,
      title: tfa('title').text,
      description: tfa('description').text,
    ));

    if (editedWS != null) {
      ws.code = editedWS.code;
      ws.title = editedWS.title;
      ws.description = editedWS.description;
      ws.balance = editedWS.balance;

      Navigator.of(rootKey.currentContext!).pop(editedWS);
      await loader.stop(300);
    }
  }
}
