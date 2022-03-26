// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/base_entity.dart';
import '../../presenters/date_presenter.dart';
import '../_base/base_controller.dart';

part 'smartable_controller.g.dart';

abstract class SmartableController<S extends Statusable> extends _SmartableControllerBase<S> with _$SmartableController {}

abstract class _SmartableControllerBase<S extends Statusable> extends BaseController with Store {
  /// статусы

  @observable
  ObservableList<S> statuses = ObservableList();

  @action
  void sortStatuses() {
    statuses.sort((s1, s2) => s1.title.compareTo(s2.title));
  }

  @observable
  int? selectedStatusId;

  @action
  void selectStatus(S? _status) {
    selectedStatusId = _status?.id;
  }

  @computed
  S? get selectedStatus => statuses.firstWhereOrNull((s) => s.id == selectedStatusId);

  @observable
  bool closed = false;

  @action
  void setClosed(bool? _closed) {
    closed = _closed ?? false;
  }

  /// дата

  @observable
  DateTime? selectedDueDate;

  @action
  void setDueDate(DateTime? _date) {
    selectedDueDate = _date;
    controllers['dueDate']?.text = _date != null ? _date.strLong : '';
  }
}
