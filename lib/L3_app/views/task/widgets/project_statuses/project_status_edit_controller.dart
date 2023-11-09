// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/project_status.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/field_data.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/status_edit.dart';
import '../../../../usecases/task_status.dart';
import '../../../_base/edit_controller.dart';

part 'project_status_edit_controller.g.dart';

enum StatusFCode { title, closed }

class ProjectStatusEditController extends _ProjectStatusEditControllerBase with _$ProjectStatusEditController {
  ProjectStatusEditController(ProjectStatus stIn, Task project) {
    _project = project;
    initState(fds: [
      MTFieldData(StatusFCode.title.index, text: stIn.isNew ? '' : stIn.title),
      MTFieldData(StatusFCode.closed.index),
    ]);

    _init(stIn);
  }
}

abstract class _ProjectStatusEditControllerBase extends EditController with Store {
  late final Task _project;

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
  Future<bool> saveField(StatusFCode code) async {
    updateField(code.index, loading: true);
    final es = await status.save(_project);
    final saved = es != null;
    if (saved) {
      _status = es;
    }
    updateField(code.index, loading: false);
    return saved;
  }

  @observable
  String? codeError;

  @computed
  Iterable<String> get _existingTitles => _project.statuses.where((s) => s.id != status.id).map((s) => s.title.trim().toLowerCase());

  String _processedInput(String str) => str.trim().isEmpty ? codePlaceholder : str;

  @action
  bool _checkDup(String str) {
    codeError = null;
    if (_existingTitles.contains(str.trim().toLowerCase())) {
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
  Iterable<Task> get _tasksWithStatus => tasksMainController.allTasks.where((t) => t.projectStatusId == status.id);

  @computed
  bool get usedInTasks => _tasksWithStatus.isNotEmpty;

  @computed
  String get tasksWithStatusStr => _tasksWithStatus.take(3).map((p) => '$p').join(', ');

  @computed
  String get tasksWithStatusCountMoreStr => _tasksWithStatus.length > 3 ? loc.more_count(_tasksWithStatus.length - 3) : '';

  Future toggleClosed() async {
    final oldValue = status.closed;
    status.closed = !status.closed;
    if (!(await saveField(StatusFCode.closed))) {
      status.closed = oldValue;
    }
  }

  Future delete(BuildContext context) async {
    Navigator.of(context).pop();
    await status.delete(_project);
  }
}
