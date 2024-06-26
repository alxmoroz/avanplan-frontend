// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/invoice.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../components/field_data.dart';
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
            fsVolume: 0,
            tasksCount: 0,
          ),
    );
  }

  void setupFields() => initState(fds: [
        MTFieldData(WSFCode.code.index, label: loc.code, text: ws.code, validate: true),
        MTFieldData(WSFCode.title.index, label: loc.title, text: ws.title, validate: true),
        MTFieldData(WSFCode.description.index, label: loc.description, text: ws.description),
      ]);
}

abstract class _WSControllerBase extends EditController with Store, Loadable {
  late Workspace wsDescriptor;

  Workspace get ws => wsMainController.ws(wsDescriptor.id) ?? wsDescriptor;
}
