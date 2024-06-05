// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/constants.dart';
import '../../components/field_data.dart';
import '../../components/text_field.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';
import '../_base/loadable.dart';

part 'ws_controller.g.dart';

enum WSFCode { code, title, description }

class WSController extends _WSControllerBase with _$WSController {
  WSController(Workspace ws) {
    _ws = ws;
    initState(fds: [
      MTFieldData(WSFCode.code.index, label: loc.code, text: ws.code, validate: true),
      MTFieldData(WSFCode.title.index, label: loc.title, text: ws.title, validate: true),
      MTFieldData(WSFCode.description.index, label: loc.description, text: ws.description),
    ]);
    stopLoading();
  }
}

abstract class _WSControllerBase extends EditController with Store, Loadable {
  late final Workspace _ws;

  /// действия

  Future save(BuildContext context) async {
    setLoaderScreenSaving();
    Navigator.of(context).pop();

    await load(() async {
      final editedWS = await wsUC.save(WorkspaceUpsert(
        id: _ws.id,
        code: fData(WSFCode.code.index).text,
        title: fData(WSFCode.title.index).text,
        description: fData(WSFCode.description.index).text,
      ));

      if (editedWS != null) {
        wsMainController.setWS(editedWS);
      }
    });
  }

  Widget tf(WSFCode code) {
    final fd = fData(code.index);

    return MTTextField(
      controller: teController(code.index),
      label: fd.label,
      margin: tfPadding.copyWith(top: code == WSFCode.code ? P : tfPadding.top),
    );
  }
}
