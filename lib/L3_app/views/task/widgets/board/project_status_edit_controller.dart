// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/project_status.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/constants.dart';
import '../../../../components/field_data.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_status.dart';
import '../../../../usecases/task_tree.dart';
import '../../../_base/edit_controller.dart';
import '../../../_base/loadable.dart';
import '../../controllers/project_statuses_controller.dart';

part 'project_status_edit_controller.g.dart';

enum StatusFCode { title, description, position, closed }

class ProjectStatusEditController extends _ProjectStatusEditControllerBase with _$ProjectStatusEditController {
  ProjectStatusEditController(ProjectStatusesController psc) {
    _psController = psc;
    stopLoading();
  }
}

abstract class _ProjectStatusEditControllerBase extends EditController with Store, Loadable {
  late final ProjectStatusesController _psController;

  Task get _project => _psController.project;

  @observable
  ProjectStatus? _status;

  @computed
  ProjectStatus get status => _project.statusForId(_status!.id) ?? _status!;

  @observable
  int tasksWithStatusCount = 0;

  @computed
  bool get usedInTasks => tasksWithStatusCount > 0;

  @action
  Future init(ProjectStatus statusIn) async {
    initState(fds: [
      MTFieldData(StatusFCode.title.index, text: statusIn.isNew ? '' : statusIn.title),
      MTFieldData(StatusFCode.description.index, text: statusIn.isNew ? '' : statusIn.description),
      MTFieldData(StatusFCode.position.index),
      MTFieldData(StatusFCode.closed.index),
    ]);

    _status = statusIn;
    if (_status!.isNew) {
      if (_checkDup(_status!.title)) {
        await saveField(StatusFCode.title);
      }
    } else {
      // количество задач, в которых используется
      if (!status.closed) {
        tasksWithStatusCount = tasksMainController.allTasks
            .where(
              (t) => t.project.id == _project.id && status.id != null && t.projectStatusId == status.id && t.wsId == status.wsId,
            )
            .length;
      }

      if (tasksWithStatusCount == 0) {
        await load(() async => tasksWithStatusCount = await projectStatusUC.statusTasksCount(status.wsId, status.projectId, status.id!));
      }
    }
  }

  @action
  Future<bool> saveField(StatusFCode fCode) async {
    updateField(fCode.index, loading: true);

    final es = await _psController.saveStatus(status);
    final saved = es != null;
    if (saved) {
      _status = es;
    }
    updateField(fCode.index, loading: false);

    return saved;
  }

  @observable
  String? codeError;

  @computed
  Iterable<String> get _siblingsTitles => _psController.siblingsTitles(status.id);

  String _processedInput(String str) => str.trim().isEmpty ? codePlaceholder : str;

  @action
  bool _checkDup(String str) {
    codeError = null;
    if (_siblingsTitles.contains(str.trim().toLowerCase())) {
      codeError = loc.status_error_validate_dup;
    }
    return codeError == null;
  }

  String get codePlaceholder => loc.status_code_placeholder;

  Future _setTitle(String str) async {
    final oldValue = status.title;
    if (oldValue != str) {
      str = _processedInput(str);
      status.title = str;
      if (!(await saveField(StatusFCode.title))) {
        status.title = oldValue;
      }
    }
  }

  Timer? _titleEditTimer;

  @action
  Future editTitle(String str) async {
    if (_titleEditTimer != null) {
      _titleEditTimer!.cancel();
    }
    str = _processedInput(str);
    if (_checkDup(str)) {
      _titleEditTimer = Timer(TEXT_SAVE_DELAY_DURATION, () async => await _setTitle(str));
    }
  }

  Future toggleClosed() async {
    final oldValue = status.closed;
    status.closed = !status.closed;
    if (!(await saveField(StatusFCode.closed))) {
      status.closed = oldValue;
    }
  }

  Future _swapPosition(ProjectStatus swapStatus) async {
    final pos = status.position;
    final swapPos = swapStatus.position;

    status.position = swapPos;
    swapStatus.position = pos;
    if (!(await saveField(StatusFCode.position)) || (await _psController.saveStatus(swapStatus) == null)) {
      status.position = pos;
      swapStatus.position = swapPos;
    }
  }

  @computed
  ProjectStatus? get leftStatus => _psController.leftStatus(status);
  @computed
  bool get canMoveLeft => leftStatus != null;

  @computed
  ProjectStatus? get rightStatus => _psController.rightStatus(status);
  @computed
  bool get canMoveRight => rightStatus != null;

  Future moveLeft() async {
    if (canMoveLeft) {
      await _swapPosition(leftStatus!);
    }
  }

  Future moveRight() async {
    if (canMoveRight) {
      await _swapPosition(rightStatus!);
    }
  }

  Future delete(BuildContext context) async {
    Navigator.of(context).pop();
    _psController.deleteStatus(status);
  }
}
