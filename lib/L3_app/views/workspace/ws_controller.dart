// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/invoice.dart';
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
  WSController({Workspace? wsIn}) {
    if (wsIn != null) initWithWS(wsIn);
  }

  final notesWidgetGlobalKey = GlobalKey();

  void initWithWS(Workspace wsIn) {
    wsDescriptor = wsIn;

    setupFields();

    if (wsDescriptor.filled) {
      stopLoading();
    }

    setLoaderScreenLoading();
  }

  void init(int wsId) {
    initWithWS(
      wsMainController.ws(wsId) ??
          Workspace(
            id: wsId,
            title: '',
            description: '',
            code: '',
            users: [],
            members: [],
            roles: [],
            invoice: Invoice.dummy,
            balance: 0,
            settings: null,
            estimateValues: [],
            sources: [],
          ),
    );
  }

  void setupFields() => initState(fds: [
        MTFieldData(WSFCode.code.index, label: loc.code, text: ws.code, validate: true),
        MTFieldData(WSFCode.title.index, label: loc.title, text: ws.title, validate: true),
        MTFieldData(WSFCode.description.index, label: loc.description, text: ws.description),
      ]);

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

abstract class _WSControllerBase extends EditController with Store, Loadable {
  late Workspace wsDescriptor;

  Workspace get ws => wsMainController.ws(wsDescriptor.id) ?? wsDescriptor;

  Widget tf(WSFCode code) {
    final fd = fData(code.index);

    return MTTextField(
      controller: teController(code.index),
      label: fd.label,
      margin: tfPadding.copyWith(top: code == WSFCode.code ? P : tfPadding.top),
    );
  }
}
