// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/workspace.dart';
import '../../../extra/services.dart';
import '../ws_controller.dart';

extension WSEditUC on WSController {
  Future _editWrapper(Function() function) async {
    ws.loading = true;
    wsMainController.refreshUI();

    await load(function);

    ws.loading = false;
    wsMainController.refreshUI();
  }

  Future reload() async {
    ws.filled = false;

    await _editWrapper(() async {
      setLoaderScreenLoading();
      final freshWS = await wsUC.getOne(wsDescriptor.id!);
      if (freshWS != null) {
        freshWS.filled = true;
        wsMainController.setWS(freshWS);
        wsDescriptor = freshWS;

        setupFields();
      }
    });
  }

  Future save(BuildContext context) async {
    setLoaderScreenSaving();
    Navigator.of(context).pop();

    await load(() async {
      final editedWS = await wsUC.save(WorkspaceUpsert(
        id: wsDescriptor.id,
        code: fData(WSFCode.code.index).text,
        title: fData(WSFCode.title.index).text,
        description: fData(WSFCode.description.index).text,
      ));

      if (editedWS != null) {
        wsMainController.setWS(editedWS);
      }
    });
  }
}
