// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/status.dart';
import '../../../L1_domain/entities/task.dart';
import '../../components/field_data.dart';
import '../../extra/services.dart';
import '../../usecases/status_edit.dart';
import '../../usecases/task_status.dart';
import '../_base/edit_controller.dart';

part 'status_edit_controller.g.dart';

enum StatusFCode { code, closed }

class StatusEditController extends _StatusEditControllerBase with _$StatusEditController {
  StatusEditController(Status stIn) {
    initState(fds: [
      MTFieldData(
        StatusFCode.code.index,
        text: stIn.code,
      ),
      MTFieldData(StatusFCode.closed.index),
    ]);

    _init(stIn);
  }
}

abstract class _StatusEditControllerBase extends EditController with Store {
  @observable
  Status? _status;

  @computed
  Status get status => statusesController.status(_status!.wsId, _status!.id) ?? _status!;

  @action
  Future _init(Status _statusIn) async {
    _status = _statusIn;
    if (_status?.isNew == true) {
      await saveField(StatusFCode.code);
    }
  }

  @action
  Future<bool> saveField(StatusFCode code) async {
    updateField(code.index, loading: true);
    final es = await status.save();
    final saved = es != null;
    if (saved) {
      _status = es;
    }
    updateField(code.index, loading: false);
    return saved;
  }

  String get codePlaceholder => loc.status_code_placeholder;

  Future _setCode(String str) async {
    if (status.code != str) {
      codeError = _existingCodes.contains(str.trim().toLowerCase()) ? loc.status_error_validate_dub : null;
      if (codeError == null) {
        if (str.trim().isEmpty) {
          str = codePlaceholder;
        }
        final oldValue = status.code;
        status.code = str;
        if (!(await saveField(StatusFCode.code))) {
          status.code = oldValue;
        }
      }
    }
  }

  Timer? _codeEditTimer;

  Future editCode(String str) async {
    if (_codeEditTimer != null) {
      _codeEditTimer!.cancel();
    }
    _codeEditTimer = Timer(const Duration(milliseconds: 1000), () async => await _setCode(str));
  }

  Future toggleClosed() async {
    final oldValue = status.closed;
    status.closed = !status.closed;
    if (!(await saveField(StatusFCode.closed))) {
      status.closed = oldValue;
    }
  }

  @observable
  String? codeError;

  @computed
  Iterable<String> get _existingCodes =>
      statusesController.statuses(status.wsId).where((s) => s.id != status.id).map((s) => s.code.trim().toLowerCase());

  @computed
  Iterable<Task> get _projectsWithStatus => tasksMainController.projects.where((p) => p.statuses.map((s) => s.id).contains(status.id));

  @computed
  bool get usedInProjects => _projectsWithStatus.isNotEmpty;

  @computed
  String get projectsWithStatusStr => _projectsWithStatus.take(3).map((p) => '$p').join(', ');

  @computed
  String get projectsWithStatusCountMoreStr => _projectsWithStatus.length > 3 ? loc.more_count(_projectsWithStatus.length - 3) : '';
}
