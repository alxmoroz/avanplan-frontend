// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_ext_state.dart';
import '../../../L1_domain/entities/task_source.dart';
import '../../../L1_domain/system/errors.dart';
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
    if (loginController.authorized) {
      try {
        selectedAll = true;
        remoteTasks = await importUC.getRootTasks(sourceID);
        remoteTasks.sort((t1, t2) => t1.title.compareTo(t2.title));
      } catch (e) {
        setErrorCode(e is MTException ? e.code : e.toString());
      }
    }
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
  Source? get selectedSource => sourceController.sources.firstWhereOrNull((g) => g.id == selectedSourceId);

  @computed
  bool get canEdit => selectedSource != null;

  /// действия,  роутер

  @action
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

  Future needAddSource(BuildContext context) async {
    Navigator.of(context).pop('NeedAddSourceEvent');
  }

  // старт юзкейса по импорту задач
  Future importTasks(BuildContext context, {bool needAddSource = false}) async {
    if (sourceController.sources.isEmpty || needAddSource) {
      await sourceController.addSource(context);
    }
    // диалог с импортом задач
    // если вернулись из диалога с желанием добавить источник импорта, то опять пытаемся добавить источник импорта
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
        await importUC.importTaskSources(src.id, linkedTSs.map((ts) => TaskSourceImport(code: ts.code)));
      }
    }
    return needUpdate;
  }
}
