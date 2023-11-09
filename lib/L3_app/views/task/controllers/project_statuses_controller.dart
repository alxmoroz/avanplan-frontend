// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/project_status.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../extra/services.dart';
import '../../../usecases/status_edit.dart';
import '../widgets/project_statuses/project_status_edit_dialog.dart';
import 'task_controller.dart';

part 'project_statuses_controller.g.dart';

class ProjectStatusesController extends _ProjectStatusesControllerBase with _$ProjectStatusesController {
  ProjectStatusesController(TaskController taskController) {
    _taskController = taskController;
    _setStatuses(_taskController.task.projectStatuses);
  }

  Future edit(ProjectStatus status) async => await showProjectStatusEditDialog(status, this);

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

  Task get project => _taskController.task;

  @observable
  ObservableList<ProjectStatus> _statuses = ObservableList();

  @action
  void _setStatuses(Iterable<ProjectStatus> sts) => _statuses = ObservableList.of(sts);

  void refresh() => _setStatuses(project.projectStatuses);

  @computed
  List<ProjectStatus> get sortedStatuses => _statuses.sorted((s1, s2) => s1.position.compareTo(s2.position));

  @computed
  String get statusesStr => sortedStatuses.map((s) => s.title).join(', ');

  Iterable<String> siblingsTitles(int sId) => _statuses.where((s) => s.id != sId).map((s) => s.title.trim().toLowerCase());

  Future createDefaults() async {
    final pId = project.id!;
    final wsId = project.wsId;
    for (final dfSt in [
      ProjectStatus(title: loc.status_default_ready_title, position: 0, closed: false, wsId: wsId, projectId: pId),
      ProjectStatus(title: loc.status_default_in_progress_title, position: 1, closed: false, wsId: wsId, projectId: pId),
      ProjectStatus(title: loc.status_default_in_review_title, position: 2, closed: false, wsId: wsId, projectId: pId),
      ProjectStatus(title: loc.status_default_done_title, position: 3, closed: true, wsId: wsId, projectId: pId),
    ]) {
      await dfSt.save(project);
    }
  }

  Future delete(ProjectStatus status) async {
    await status.delete(project);
    refresh();
  }
}
