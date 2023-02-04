// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/task.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';
import 'import_view.dart';

part 'import_controller.g.dart';

class ImportController extends _ImportControllerBase with _$ImportController {}

abstract class _ImportControllerBase extends EditController with Store {
  @observable
  List<TaskRemote> projects = [];

  @computed
  Iterable<TaskRemote> get selectedProjects => projects.where((t) => t.selected);

  @override
  bool get validated => selectedProjects.isNotEmpty;

  @observable
  String? errorCode;

  @action
  void _setErrorCode(String? eCode) => errorCode = eCode;

  @action
  void clearData() {
    projects = [];
    selectedAll = true;
  }

  @observable
  bool selectedAll = true;

  @action
  void toggleSelectedAll(bool? value) {
    selectedAll = !selectedAll;
    projects.forEach((t) => t.selected = selectedAll);
  }

  @action
  void selectProject(TaskRemote task, bool? selected) {
    task.selected = selected == true;
    projects = projects;
  }

  /// выбранный источник импорта, трекер

  @observable
  int? selectedSourceId = sourceController.sources.length == 1 ? sourceController.sources.first.id : null;

  @action
  Future selectSource(Source? src) async {
    selectedSourceId = src?.id;
    clearData();

    if (selectedSourceId != null) {
      final loaderDescription = '$selectedSource\n${selectedSource?.url}';
      loaderController.start();
      bool connected = selectedSource?.state == SrcState.connected;
      if (!connected) {
        loaderController.setCheckConnection(loaderDescription);
        connected = await sourceController.checkSourceConnection(selectedSourceId);
      }
      if (connected) {
        loaderController.setSourceListing(loaderDescription);
        projects = ObservableList.of((await importUC.getRootTasks(selectedSource!)).sorted((p1, p2) => compareNatural(p1.title, p2.title)));
      } else {
        _setErrorCode('import_connection_error');
      }
      await loaderController.stop();
    }
  }

  @computed
  Source? get selectedSource => sourceController.sources.firstWhereOrNull((s) => s.id == selectedSourceId);

  @computed
  bool get canEdit => selectedSource != null;

  /// действия,  роутер

  Future startImport(BuildContext context) async {
    loaderController.start();
    loaderController.setImporting('$selectedSource\n${selectedSource?.url}');
    final taskSources = selectedProjects.map((t) => t.taskSource!);
    await importUC.importTaskSources(selectedSource!, taskSources);
    Navigator.of(context).pop();
    await mainController.fetchData();
    await loaderController.stop();
  }

  void needAddSourceEvent(BuildContext context, String st) => Navigator.of(context).pop(st);

  // старт сценария по импорту задач
  Future importTasks({bool needAddSource = false, String? sType}) async {
    // проверяем наличие выбранного типа источника импорта
    Source? preselectedSource = sType != null ? sourceController.sources.firstWhereOrNull((s) => s.type == sType) : selectedSource;
    // переходим к созданию источника, если нет источников, либо явный запрос на создание, либо источник выбранного типа отсутствует
    if (sourceController.sources.isEmpty || needAddSource || (sType != null && preselectedSource == null)) {
      preselectedSource = await sourceController.addSource(sType: sType);
      // выходим из сценария, если отказались создавать или не получилось
      // if (preselectedSource == null) {
      //   return;
      // }
    }

    // выбираем источник импорта заранее из созданного только что или существующий выбранного типа
    if (preselectedSource != null) {
      await selectSource(preselectedSource);
    }

    // если вернулись из диалога с желанием добавить источник импорта, то опять пытаемся добавить источник импорта
    // диалог с импортом задач
    final st = await showImportDialog();
    if (st != null) {
      await importTasks(needAddSource: true, sType: st);
    }
  }
}
