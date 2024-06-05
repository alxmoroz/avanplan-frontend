// Copyright (c) 2022. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/ws_sources.dart';
import '../../components/images.dart';
import '../../extra/services.dart';
import '../../usecases/source.dart';
import '../../usecases/ws_actions.dart';
import '../_base/loadable.dart';
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

abstract class _ImportControllerBase with Store, Loadable {
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
  bool get validated => selectedProjects.isNotEmpty;

  @observable
  String? errorCode;

  @action
  void clear() {
    errorCode = null;
    projects = [];
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
      clear();
      selectedSourceId = id;
      final loaderDescription = '$selectedSource';
      startLoading();
      bool connected = selectedSource?.state == SrcState.connected;
      if (!connected) {
        setLoaderScreen(
          imageName: ImageName.sync.name,
          titleText: loc.loader_check_connection_title,
          descriptionText: loaderDescription,
        );
        connected = await selectedSource!.checkConnection();
      }

      if (connected) {
        setLoaderScreen(
          titleText: loc.loader_source_listing,
          descriptionText: loaderDescription,
          imageName: ImageName.import.name,
        );
        try {
          projects = (await importUC.getProjectsList(wsId, selectedSourceId!)).sorted((p1, p2) => p1.compareTo(p2));
        } on Exception catch (e) {
          parseError(e);
        }
      } else {
        errorCode = 'error_import_connection';
      }
      wsMainController.refreshWorkspaces();
      stopLoading();
    }
  }

  @action
  Future startImport(BuildContext context) async {
    if (await ws.checkBalance(loc.import_action_title)) {
      setLoaderScreen(
        titleText: loc.loader_importing_title,
        imageName: ImageName.import.name,
      );
      startLoading();
      try {
        await importUC.startImport(ws.id!, selectedSourceId!, selectedProjects);
        tasksMainController.updateImportingProjects();
        if (context.mounted) Navigator.of(context).pop();
      } on Exception catch (e) {
        parseError(e);
      }
    }
  }
}
