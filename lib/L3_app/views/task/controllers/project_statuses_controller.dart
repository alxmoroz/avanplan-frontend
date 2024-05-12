// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/project_status.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../extra/services.dart';
import '../../../usecases/task_tree.dart';
import '../../_base/loadable.dart';
import '../widgets/board/project_status_edit_dialog.dart';
import 'task_controller.dart';

part 'project_statuses_controller.g.dart';

class ProjectStatusesController extends _ProjectStatusesControllerBase with _$ProjectStatusesController {
  ProjectStatusesController(TaskController tcIn) {
    _taskController = tcIn;
  }

  Future edit(ProjectStatus status) async => await projectStatusEditDialog(status, this);

  Future create() async => await edit(
        ProjectStatus(
          title: loc.status_code_placeholder,
          closed: false,
          position: (sortedStatuses.lastOrNull?.position ?? 0) + 1,
          wsId: project.wsId,
          projectId: project.id!,
        ),
      );
}

//TODO: переделать, как с заметками

abstract class _ProjectStatusesControllerBase with Store, Loadable {
  late final TaskController _taskController;

  Task get project => _taskController.task.project;

  @observable
  ObservableList<ProjectStatus> _statuses = ObservableList();

  @computed
  Iterable<int> get _closedStatusIds => _statuses.where((s) => s.closed == true).map((s) => s.id!);
  @computed
  int? get firstClosedStatusId => _closedStatusIds.firstOrNull;
  @computed
  Iterable<int> get _openedStatusIds => _statuses.where((s) => s.closed == false).map((s) => s.id!);
  @computed
  int? get firstOpenedStatusId => _openedStatusIds.firstOrNull;

  @action
  void _setStatuses(Iterable<ProjectStatus> sts) => _statuses = ObservableList.of(sts);

  ProjectStatus? leftStatus(ProjectStatus status) => sortedStatuses.lastWhereOrNull((s) => s.position < status.position);
  ProjectStatus? rightStatus(ProjectStatus status) => sortedStatuses.firstWhereOrNull((s) => s.position > status.position);

  void reload() => _setStatuses(project.projectStatuses);

  @computed
  List<ProjectStatus> get sortedStatuses => _statuses.sorted((s1, s2) => s1.position.compareTo(s2.position));

  Iterable<String> siblingsTitles(int? sId) => _statuses.where((s) => s.id != sId).map((s) => s.title.trim().toLowerCase());

  Future _editWrapper(ProjectStatus status, Function() function) async {
    status.loading = true;
    reload();

    setLoaderScreenSaving();
    await load(function);

    status.loading = false;
    reload();
  }

  Future<ProjectStatus?> saveStatus(ProjectStatus status) async {
    ProjectStatus? es;

    await _editWrapper(status, () async {
      es = await projectStatusUC.save(status);
      if (es != null) {
        if (status.isNew) {
          project.projectStatuses.add(es!);
        } else {
          final index = project.projectStatuses.indexWhere((s) => es!.id == s.id);
          if (index > -1) {
            project.projectStatuses[index] = es!;
          }
        }
      }
    });

    return es;
  }

  Future deleteStatus(ProjectStatus status) async => await _editWrapper(status, () async {
        if (await projectStatusUC.delete(status) != null) {
          project.projectStatuses.remove(status);
        }
      });
}
