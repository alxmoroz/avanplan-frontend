// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/ws_ext.dart';
import '../../extra/services.dart';
import '../../usecases/source_ext.dart';
import '../../usecases/ws_ext_actions.dart';
import '../_base/edit_controller.dart';
import '../source/source_edit_view.dart';
import '../tariff/tariff_select_view.dart';

part 'import_controller.g.dart';

class ImportController extends _ImportControllerBase with _$ImportController {
  Future<ImportController> init(bool needAddSource, String? sType) async {
    selectedSourceId = ws.sources.length == 1 ? ws.sources.first.id : null;
    // проверяем наличие выбранного типа источника импорта
    Source? preselectedSource = sType != null ? ws.sourceForType(sType) : selectedSource;
    // переходим к созданию источника, если нет источников, либо явный запрос на создание, либо источник выбранного типа отсутствует
    if (ws.sources.isEmpty || needAddSource || (sType != null && preselectedSource == null)) {
      preselectedSource = await addSource(sType: sType);
      // выходим из сценария, если отказались создавать или не получилось
      // if (preselectedSource == null) {
      //   return;
      // }
    }

    // выбираем источник импорта заранее из созданного только что или существующий выбранного типа
    if (preselectedSource != null) {
      await selectSource(preselectedSource);
    }
    return this;
  }
}

abstract class _ImportControllerBase extends EditController with Store {
  Workspace get ws => mainController.selectedWS!;

  @observable
  List<TaskRemote> projects = [];

  @computed
  Iterable<TaskRemote> get selectedProjects => projects.where((t) => t.selected);

  @computed
  num get selectableCount => ws.availableProjectsCount - selectedProjects.length;

  @override
  bool get validated => selectedProjects.isNotEmpty;

  @observable
  String? errorCode;

  @action
  void _setErrorCode(String? eCode) => errorCode = eCode;

  @action
  void clearData() {
    projects = [];
    selectedAll = false;
  }

  @observable
  bool selectedAll = false;

  @action
  void toggleSelectedAll(bool? value) {
    selectedAll = !selectedAll;
    projects.forEach((t) => t.selected = selectedAll);
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
  Future selectSource(Source? src) async {
    selectedSourceId = src?.id;
    clearData();

    if (src != null) {
      final loaderDescription = '$selectedSource';
      loaderController.start();
      bool connected = selectedSource?.state == SrcState.connected;
      if (!connected) {
        loaderController.setCheckConnection(loaderDescription);
        connected = await src.checkConnection();
      }
      if (connected) {
        loaderController.setSourceListing(loaderDescription);
        projects = ObservableList.of((await importUC.getRootTasks(selectedSource!)).sorted((p1, p2) => compareNatural(p1.title, p2.title)));
      } else {
        _setErrorCode('error_import_connection');
      }
      await loaderController.stop();
    }
  }

  @computed
  Source? get selectedSource => ws.sourceForId(selectedSourceId);

  @computed
  bool get canEdit => selectedSource != null;

  /// действия,  роутер

  Future startImport(BuildContext context) async {
    if (selectableCount >= 0) {
      loaderController.start();
      loaderController.setImporting('$selectedSource');
      final taskSources = selectedProjects.map((t) => t.taskSource!);
      await importUC.importTaskSources(selectedSource!, taskSources);
      Navigator.of(context).pop();
      await mainController.fetchData();
      await loaderController.stop();
    } else {
      await changeTariff(
        ws,
        reason: loc.tariff_change_limit_projects_reason_title,
      );
    }
  }

  void needAddSourceEvent(BuildContext context, String st) => Navigator.of(context).pop(st);
}
