// Copyright (c) 2022. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/remote_source.dart';
import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/remote_source.dart';
import '../../components/images.dart';
import '../../presenters/remote_source.dart';
import '../../usecases/source.dart';
import '../../usecases/ws_actions.dart';
import '../_base/loadable.dart';
import '../app/services.dart';
import '../source/source_edit_dialog.dart';
import '../source/source_type_selector.dart';

part 'import_controller.g.dart';

class ImportController extends _ImportControllerBase with _$ImportController {
  Future<ImportController> init(Workspace wsIn) async {
    ws = wsIn;
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
  late final Workspace ws;

  bool isImporting(RemoteProject rp) {
    final rts = rp.taskSource!;
    return tasksMainController.importingTSs.where((ts) => ts.code == rts.code && ts.sourceId == rts.sourceId).isNotEmpty;
  }

  @observable
  List<RemoteProject> projects = [];

  @computed
  Iterable<RemoteProject> get selectableProjects => projects.where((p) => !isImporting(p));

  @computed
  Iterable<RemoteProject> get selectedProjects => projects.where((p) => p.selected);

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
    for (RemoteProject p in selectableProjects) {
      p.selected = value == true;
    }
    projects = [...projects];
  }

  @action
  void selectProject(RemoteProject p, bool? selected) {
    p.selected = selected == true;
    projects = [...projects];
  }

  /// выбранный источник импорта, трекер

  @observable
  int? selectedSourceId;

  @computed
  RemoteSource? get selectedSource => ws.remoteSourceForId(selectedSourceId);

  @action
  Future selectSource(int? id) async {
    if (id != null) {
      clear();
      selectedSourceId = id;
      final loaderDescription = '$selectedSource';
      startLoading();
      bool connected = selectedSource?.connected == true;
      if (!connected) {
        setLoaderScreen(
          imageName: ImageName.sync.name,
          titleText: loc.loader_check_connection_title,
          descriptionText: loaderDescription,
        );
        connected = await selectedSource!.checkConnection();
      }

      if (connected) {
        if (await ws.checkBalance(loc.import_action_title)) {
          setLoaderScreen(
            titleText: loc.loader_source_listing,
            descriptionText: loaderDescription,
            imageName: ImageName.import.name,
          );
          try {
            projects = (await remoteSourcesUC.getProjectsList(ws.id!, selectedSourceId!)).sorted((p1, p2) => p1.compareTo(p2));
          } on Exception catch (e) {
            parseError(e);
          }
        }
      } else {
        errorCode = 'error_import_connection';
      }
      wsMainController.refreshUI();
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
        await remoteSourcesUC.startImport(ws.id!, selectedSourceId!, selectedProjects);
        tasksMainController.updateImportingProjects();
        if (context.mounted) Navigator.of(context).pop();
      } on Exception catch (e) {
        parseError(e);
      }
    }
  }
}
