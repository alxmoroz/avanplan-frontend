// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/source_type.dart';
import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/ws_ext.dart';
import '../../../main.dart';
import '../../extra/services.dart';
import '../../usecases/source_ext.dart';
import '../../usecases/ws_ext_actions.dart';
import '../source/source_edit_view.dart';
import '../tariff/tariff_select_view.dart';

part 'import_controller.g.dart';

class ImportController extends _ImportControllerBase with _$ImportController {
  Future<ImportController> init(int _wsId, SourceType? sType) async {
    wsId = _wsId;
    selectedSourceId = ws.sources.length == 1 ? ws.sources.first.id : null;
    // проверяем наличие источника импорта выбранного типа
    Source? preselectedSource = sType != null ? ws.sourceForType(sType) : selectedSource;
    // переходим к созданию источника, если нет источников, либо источник выбранного типа отсутствует
    if (ws.sources.isEmpty || (sType != null && preselectedSource == null)) {
      preselectedSource = await addSource(ws, sType: sType!);
      // выходим из сценария, если отказались создавать или не получилось
      // if (preselectedSource == null) {
      //   return;
      // }
    }

    // выбираем источник импорта заранее из созданного только что или существующий выбранного типа
    if (preselectedSource != null) {
      await selectSourceId(preselectedSource.id);
    }
    return this;
  }
}

abstract class _ImportControllerBase with Store {
  late final int wsId;
  Workspace get ws => mainController.wsForId(wsId);
  int get availableCount => ws.availableProjectsCount;

  @observable
  List<TaskRemote> projects = [];

  @computed
  Iterable<TaskRemote> get selectedProjects => projects.where((t) => t.selected);

  @computed
  int get selectableCount => ws.availableProjectsCount - selectedProjects.length;

  @computed
  bool get validated => selectedProjects.isNotEmpty;

  @observable
  String? errorCode;

  @action
  void clearData() {
    errorCode = null;
    projects = [];
  }

  @computed
  bool get selectedAll => projects.every((p) => p.selected);

  @action
  void toggleSelectedAll(bool? value) {
    projects.forEach((p) => p.selected = value == true);
    projects = [...projects];
  }

  @action
  void selectProject(TaskRemote task, bool? selected) {
    task.selected = selected == true;
    projects = [...projects];
  }

  /// выбранный источник импорта, трекер

  @observable
  int? selectedSourceId;

  @action
  Future selectSourceId(int? id) async {
    selectedSourceId = id;
    clearData();
    if (selectedSource != null) {
      final loaderDescription = '$selectedSource';
      loader.start();
      bool connected = selectedSource?.state == SrcState.connected;
      if (!connected) {
        loader.setCheckConnection(loaderDescription);
        connected = await selectedSource!.checkConnection(ws);
      }
      if (connected) {
        loader.setSourceListing(loaderDescription);
        projects = (await importUC.getRootTasks(ws, selectedSource!)).sorted((p1, p2) => compareNatural(p1.title, p2.title));
      } else {
        errorCode = 'error_import_connection';
      }
      mainController.touchWorkspaces();
      await loader.stop();
    }
  }

  @computed
  Source? get selectedSource => ws.sourceForId(selectedSourceId);

  @computed
  bool get canEdit => selectedSource != null;

  /// действия,  роутер

  Future startImport() async {
    if (selectableCount >= 0) {
      loader.start();
      loader.setImporting('$selectedSource');
      final taskSources = selectedProjects.map((t) => t.taskSource!);
      await importUC.importTaskSources(ws, selectedSource!, taskSources);
      Navigator.of(rootKey.currentContext!).pop();
      await mainController.fetchWorkspaces();
      await mainController.fetchTasks();
      await loader.stop();
    } else {
      await changeTariff(
        ws,
        reason: loc.tariff_change_limit_projects_reason_title,
      );
    }
  }
}
