// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/errors.dart';
import '../../../../L1_domain/entities/project_status.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L2_data/services/api.dart';
import '../../../extra/services.dart';
import '../widgets/project_statuses/project_status_edit_dialog.dart';
import 'task_controller.dart';

part 'project_statuses_controller.g.dart';

class ProjectStatusesController extends _ProjectStatusesControllerBase with _$ProjectStatusesController {
  ProjectStatusesController(TaskController taskController) {
    _taskController = taskController;
    _setStatuses(_taskController.task!.projectStatuses);
  }

  Future edit(ProjectStatus status) async => await projectStatusEditDialog(status, this);

  Future create() async => await edit(
        ProjectStatus(
          title: loc.status_code_placeholder,
          closed: false,
          position: sortedStatuses.length,
          wsId: project.wsId,
          projectId: project.id!,
        ),
      );
}

//TODO: переделать, как с заметками

abstract class _ProjectStatusesControllerBase with Store {
  late final TaskController _taskController;

  Task get project => _taskController.task!;

  @observable
  ObservableList<ProjectStatus> _statuses = ObservableList();

  @action
  void _setStatuses(Iterable<ProjectStatus> sts) => _statuses = ObservableList.of(sts);

  void refresh() => _setStatuses(project.projectStatuses);

  @computed
  List<ProjectStatus> get sortedStatuses => _statuses.sorted((s1, s2) => s1.position.compareTo(s2.position));

  @computed
  String get statusesStr => sortedStatuses.map((s) => s.title).join(', ');

  Iterable<String> siblingsTitles(int? sId) => _statuses.where((s) => s.id != sId).map((s) => s.title.trim().toLowerCase());

  Future<ProjectStatus?> _editStatus(ProjectStatus status, Future<ProjectStatus?> Function() function) async {
    status.loading = true;
    refresh();
    ProjectStatus? es;
    try {
      es = await function();
    } on DioException catch (e) {
      status.error = MTError(loader.titleText ?? '', description: loader.descriptionText, detail: e.detail);
    }
    status.loading = false;
    refresh();

    return es;
  }

  Future<ProjectStatus?> saveStatus(ProjectStatus status) async => await _editStatus(status, () async {
        final es = await projectStatusUC.save(status);
        if (es != null) {
          if (status.isNew) {
            project.projectStatuses.add(es);
          } else {
            final index = project.projectStatuses.indexWhere((s) => es.id == s.id);
            if (index > -1) {
              project.projectStatuses[index] = es;
            }
          }
          return es;
        }
        return null;
      });

  Future deleteStatus(ProjectStatus status) async => await _editStatus(status, () async {
        if (await projectStatusUC.delete(status) != null) {
          project.projectStatuses.remove(status);
        }
        return null;
      });
}
