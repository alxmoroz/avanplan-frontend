// Copyright (c) 2022. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/ws_sources.dart';
import '../../../main.dart';
import '../../extra/services.dart';
import '../../usecases/source.dart';
import '../../usecases/ws_tariff.dart';
import '../source/source_edit_dialog.dart';
import '../source/source_type_selector.dart';

part 'import_controller.g.dart';

class ImportController extends _ImportControllerBase with _$ImportController {
  Future<ImportController> init(Workspace ws) async {
    wsId = ws.id!;
    selectedSourceId = ws.sources.isNotEmpty ? ws.sources.first.id : null;

    // переходим к созданию источника, если нет источников
    if (ws.sources.isEmpty) {
      final sType = await selectSourceType();
      if (sType != null) {
        selectedSourceId = (await addSource(ws, sType: sType))?.id;
      }
    }

    // выбираем источник импорта заранее из созданного только что или существующий выбранного типа
    await selectSource(selectedSourceId);
    return this;
  }
}

abstract class _ImportControllerBase with Store {
  late final int wsId;
  Workspace get ws => wsMainController.ws(wsId);

  bool isImporting(ProjectRemote rp) {
    final rts = rp.taskSource!;
    return tasksMainController.importingTSs.where((ts) => ts.code == rts.code && ts.sourceId == rts.sourceId).isNotEmpty;
  }

  @observable
  List<ProjectRemote> projects = [];

  @computed
  Iterable<ProjectRemote> get selectableProjects => projects.where((p) => !isImporting(p));

  @computed
  Iterable<ProjectRemote> get selectedProjects => projects.where((p) => p.selected);

  @computed
  bool get validated => selectedProjects.isNotEmpty && !_sendingRequest;

  @observable
  String? errorCode;

  @observable
  bool _sendingRequest = false;

  @action
  void clearData() {
    errorCode = null;
    projects = [];
    _sendingRequest = false;
  }

  @computed
  bool get selectedAll => selectableProjects.every((p) => p.selected);

  @action
  void toggleSelectedAll(bool? value) {
    for (ProjectRemote p in selectableProjects) {
      p.selected = value == true;
    }
    projects = [...projects];
  }

  @action
  void selectProject(ProjectRemote task, bool? selected) {
    task.selected = selected == true;
    projects = [...projects];
  }

  /// выбранный источник импорта, трекер

  @observable
  int? selectedSourceId;

  @computed
  Source? get selectedSource => ws.sourceForId(selectedSourceId);

  @action
  Future selectSource(int? id) async {
    if (id != null) {
      clearData();
      selectedSourceId = id;
      final loaderDescription = '$selectedSource';
      loader.start();
      bool connected = selectedSource?.state == SrcState.connected;
      if (!connected) {
        loader.setCheckConnection(loaderDescription);
        connected = await selectedSource!.checkConnection();
      }
      if (connected) {
        loader.setSourceListing(loaderDescription);
        projects = (await importUC.getProjectsList(wsId, selectedSourceId!)).sorted((p1, p2) => p1.compareTo(p2));
      } else {
        errorCode = 'error_import_connection';
      }
      wsMainController.refreshWorkspaces();
      await loader.stop();
    }
  }

  @action
  Future startImport() async {
    if (await ws.checkBalance(loc.import_action_title)) {
      _sendingRequest = true;
      if (await importUC.startImport(ws.id!, selectedSourceId!, selectedProjects)) {
        await tasksMainController.updateImportingProjects();
      }
      Navigator.of(rootKey.currentContext!).pop();
    }
  }
}
