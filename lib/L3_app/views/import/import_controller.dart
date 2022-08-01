// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/task_import.dart';
import '../../../L1_domain/entities/task_stats.dart';
import '../../../L1_domain/system/errors.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';
import 'import_view.dart';

part 'import_controller.g.dart';

class ImportController extends _ImportControllerBase with _$ImportController {}

abstract class _ImportControllerBase extends EditController with Store {
  @observable
  ObservableList<TaskImport> remoteTasks = ObservableList();

  @computed
  List<String> get selectedTasksIds => remoteTasks.where((t) => t.selected).map((t) => t.code).toList();

  @override
  bool get validated => selectedTasksIds.isNotEmpty;

  @action
  Future fetchTasks(int sourceID) async {
    startLoading();
    clearData();
    if (loginController.authorized) {
      try {
        remoteTasks = ObservableList.of(await importUC.getRootTasks(sourceID));
        remoteTasks.sort((t1, t2) => t1.title.compareTo(t2.title));
      } catch (e) {
        setErrorCode(e is MTException ? e.code : e.toString());
      }
    }
    stopLoading();
  }

  @action
  void clearData() => remoteTasks.clear();

  @action
  void selectTask(TaskImport task, bool selected) {
    final index = remoteTasks.indexWhere((t) => t.code == task.code);
    if (index >= 0) {
      remoteTasks[index] = task.copyWithSelected(selected);
    }
  }

  @override
  bool get isLoading => super.isLoading || mainController.isLoading;

  /// выбранный источник импорта, трекер

  @observable
  int? selectedSourceId;

  @action
  Future selectSource(Source? _rt) async {
    selectedSourceId = _rt?.id;
    if (_rt != null) {
      await fetchTasks(_rt.id);
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
    final done = await importUC.importTasks(selectedSource!, selectedTasksIds);
    if (done) {
      await mainController.fetchData();
      Navigator.of(context).pop();
    }
    stopLoading();
  }

  Future addSource(BuildContext context) async {
    Navigator.of(context).pop('Add source');
  }

  Future importTasks(BuildContext context) async {
    if (sourceController.sources.isEmpty) {
      await sourceController.addSource(context);
    }
    final res = await showImportDialog(context);
    if (res == 'Add source') {
      await importTasks(context);
    }
  }

  Future updateLinkedTasks() async {
    final linkedTasksSources = taskViewController.rootTask.tasks.where((t) => t.hasLink).map((t) => t.taskSource!);
    final Set srcIDs = linkedTasksSources.map((ts) => ts.source.id).toSet();
    for (int srcID in srcIDs) {
      final Set<String> codes = (linkedTasksSources.where((ts) => ts.source.id == srcID)).map((t) => t.code).toSet();
      final src = sourceController.sourcesMap[srcID];
      await importUC.importTasks(src!, codes.toList());
    }
  }
}
