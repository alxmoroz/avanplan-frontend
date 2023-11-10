// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/project_status.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/field_data.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_status.dart';
import '../../../../usecases/task_tree.dart';
import '../../../_base/edit_controller.dart';
import '../../controllers/project_statuses_controller.dart';

part 'project_status_edit_controller.g.dart';

enum StatusFCode { title, description, closed }

class ProjectStatusEditController extends _ProjectStatusEditControllerBase with _$ProjectStatusEditController {
  ProjectStatusEditController(ProjectStatus stIn, ProjectStatusesController statusesController) {
    _statusesController = statusesController;
    initState(fds: [
      MTFieldData(StatusFCode.title.index, text: stIn.isNew ? '' : stIn.title),
      MTFieldData(StatusFCode.description.index, text: stIn.isNew ? '' : stIn.description),
      MTFieldData(StatusFCode.closed.index),
    ]);

    _init(stIn);
  }
}

abstract class _ProjectStatusEditControllerBase extends EditController with Store {
  late final ProjectStatusesController _statusesController;

  Task get _project => _statusesController.project;

  @observable
  ProjectStatus? _status;

  @computed
  ProjectStatus get status => _project.statusForId(_status!.id) ?? _status!;

  @action
  Future _init(ProjectStatus _statusIn) async {
    _status = _statusIn;
    if (_status!.isNew && _checkDup(_status!.title)) {
      await saveField(StatusFCode.title);
    }
  }

  @action
  Future<bool> saveField(StatusFCode fCode) async {
    updateField(fCode.index, loading: true);

    final es = await _statusesController.saveStatus(status);
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
  Iterable<String> get _siblingsTitles => _statusesController.siblingsTitles(status.id);

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
    if (status.title != str) {
      str = _processedInput(str);
      final oldValue = status.title;
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
      _titleEditTimer = Timer(const Duration(milliseconds: 750), () async => await _setTitle(str));
    }
  }

  @computed
  int get tasksWithStatusCount =>
      tasksMainController.allTasks.where((t) => t.project!.id == _project.id && status.id != null && t.projectStatusId == status.id).length;

  @computed
  bool get usedInTasks => tasksWithStatusCount > 0;

  Future toggleClosed() async {
    final oldValue = status.closed;
    status.closed = !status.closed;
    if (!(await saveField(StatusFCode.closed))) {
      status.closed = oldValue;
    }
  }

  Future delete(BuildContext context) async {
    Navigator.of(context).pop();
    _statusesController.deleteStatus(status);
  }
}
