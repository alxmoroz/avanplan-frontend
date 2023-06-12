// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/mt_field_data.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';

part 'workspace_edit_controller.g.dart';

class WorkspaceEditController extends _WorkspaceEditControllerBase with _$WorkspaceEditController {
  WorkspaceEditController(Workspace _ws) {
    ws = _ws;
    initState(fds: [
      MTFieldData('code', label: loc.code, text: ws.code),
      MTFieldData('title', label: loc.title, text: ws.title),
      MTFieldData('description', label: loc.description, text: ws.description, needValidate: false),
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
      code: fData('code').text,
      title: fData('title').text,
      description: fData('description').text,
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
