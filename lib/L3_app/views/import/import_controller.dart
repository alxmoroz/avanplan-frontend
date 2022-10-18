// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_source.dart';
import '../../../L1_domain/system/errors.dart';
import '../../../L1_domain/usecases/task_ext_actions.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';
import 'import_view.dart';

part 'import_controller.g.dart';

class ImportController extends _ImportControllerBase with _$ImportController {}

abstract class _ImportControllerBase extends EditController with Store {
  @observable
  List<TaskImport> remoteTasks = [];

  @computed
  Iterable<TaskImport> get selectedTasks => remoteTasks.where((t) => t.selected);

  @override
  bool get validated => selectedTasks.isNotEmpty;

  @action
  Future fetchTasks(int sourceID) async {
    startLoading();
    final _remoteTasks = <TaskImport>[];
    if (authController.authorized) {
      try {
        selectedAll = true;
        _remoteTasks.addAll((await importUC.getRootTasks(sourceID)).sorted((t1, t2) => compareNatural(t1.title, t2.title)));
      } catch (e) {
        setErrorCode(e is MTException ? e.code : e.toString());
      }
    }
    remoteTasks = _remoteTasks;
    stopLoading();
  }

  @action
  void clearData() => remoteTasks = [];

  @observable
  bool selectedAll = true;

  @action
  void toggleSelectedAll(bool? value) {
    selectedAll = !selectedAll;
    remoteTasks.forEach((t) => t.selected = selectedAll);
  }

  @action
  void selectTask(TaskImport task, bool selected) {
    task.selected = selected;
    remoteTasks = remoteTasks;
  }

  @override
  bool get isLoading => super.isLoading || mainController.isLoading;

  /// выбранный источник импорта, трекер

  @observable
  int? selectedSourceId;

  @action
  Future selectSource(Source? src) async {
    selectedSourceId = src?.id;
    if (selectedSourceId != null) {
      await fetchTasks(selectedSourceId!);
    }
  }

  @computed
  Source? get selectedSource {
    final sources = sourceController.sources;
    return sources.length == 1 ? sources.first : sources.firstWhereOrNull((s) => s.id == selectedSourceId);
  }

  @computed
  bool get canEdit => selectedSource != null;

  /// действия,  роутер

  Future startImport(BuildContext context) async {
    startLoading();
    final taskSources = selectedTasks.map((t) => t.taskSource!);
    final done = await importUC.importTaskSources(selectedSource?.id, taskSources);
    if (done) {
      await mainController.fetchData();
      Navigator.of(context).pop();
    }
    stopLoading();
  }

  void needAddSourceEvent(BuildContext context) {
    Navigator.of(context).pop('NeedAddSourceEvent');
  }

  // старт сценария по импорту задач
  Future importTasks(BuildContext context, {bool needAddSource = false, SourceType? sType}) async {
    // проверяем наличие выбранного типа источника импорта
    Source? preselectedSource = sType != null ? sourceController.sources.firstWhereOrNull((s) => s.type.id == sType.id) : selectedSource;
    // переходим к созданию источника, если нет источников, либо явный запрос на создание, либо источник выбранного типа отсутствует
    if (sourceController.sources.isEmpty || needAddSource || (sType != null && preselectedSource == null)) {
      preselectedSource = await sourceController.addSource(context, sType: sType);
      // выходим из сценария, если отказались создавать или не получилось
      if (preselectedSource == null) {
        return;
      }
    }

    // выбираем источник импорта заранее из созданного только что или существующий выбранного типа
    if (preselectedSource != null) {
      await selectSource(preselectedSource);
    }

    // если вернулись из диалога с желанием добавить источник импорта, то опять пытаемся добавить источник импорта
    // диалог с импортом задач
    final needSource = await showImportDialog(context) == 'NeedAddSourceEvent';
    if (needSource) {
      await importTasks(context, needAddSource: needSource);
    }
  }

  Future<bool> updateLinkedTasks() async {
    bool needUpdate = false;
    for (Source src in sourceController.sources) {
      final linkedTSs = mainController.rootTask.tasks.where((t) => t.hasLink && t.taskSource?.source.id == src.id).map((t) => t.taskSource!);
      needUpdate = linkedTSs.isNotEmpty;
      if (needUpdate) {
        await importUC.importTaskSources(src.id, linkedTSs.map((ts) => TaskSourceImport(code: ts.code, rootCode: ts.rootCode)));
      }
    }
    return needUpdate;
  }
}
