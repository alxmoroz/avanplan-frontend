// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/base_entity.dart';
import '../../components/constants.dart';
import '../../components/dropdown.dart';
import '../../components/icons.dart';
import '../../components/text_field.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/date_presenter.dart';
import '../_base/base_controller.dart';

part 'smartable_controller.g.dart';

abstract class SmartableController<T extends Titleable> extends _SmartableControllerBase<T> with _$SmartableController {}

abstract class _SmartableControllerBase<T extends Titleable> extends BaseController with Store {
  /// статусы

  @observable
  ObservableList<T> statuses = ObservableList();

  @action
  void sortStatuses() => statuses.sort((s1, s2) => s1.title.compareTo(s2.title));

  @observable
  int? selectedStatusId;

  @action
  void selectStatus(T? _status) => selectedStatusId = _status?.id;

  @computed
  T? get selectedStatus => statuses.firstWhereOrNull((s) => s.id == selectedStatusId);

  @observable
  bool closed = false;

  @action
  void setClosed(bool? _closed) => closed = _closed ?? false;

  /// дата

  @observable
  DateTime? selectedDueDate;

  @action
  void setDueDate(DateTime? _date) {
    selectedDueDate = _date;
    controllers['dueDate']?.text = _date != null ? _date.strLong : '';
  }

  Future inputDateTime(BuildContext context) async {
    final firstDate = selectedDueDate != null && DateTime.now().isAfter(selectedDueDate!) ? selectedDueDate! : DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: selectedDueDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: DateTime.now().add(const Duration(days: 36500)),
    );
    if (date != null) {
      setDueDate(date);
    }
  }

  Widget textFieldForCode(BuildContext context, String code, {VoidCallback? onTap}) {
    final ta = tfAnnoForCode(code);
    final isDate = code.endsWith('Date');
    return ta.noText
        ? MTTextField.noText(
            controller: controllers[code],
            label: ta.label,
            error: ta.errorText,
            onTap: onTap ?? (isDate ? () => inputDateTime(context) : null),
            suffixIcon: isDate ? calendarIcon(context) : null,
          )
        : MTTextField(
            controller: controllers[code],
            label: ta.label,
            error: ta.errorText,
            onTap: onTap,
          );
  }

  /// общий виджет с полями

  Widget form(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Container(
      constraints: BoxConstraints(maxHeight: (mq.size.height - mq.viewInsets.bottom - mq.viewPadding.bottom) * 0.82),
      child: Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...['title', 'dueDate', 'description'].map((code) => textFieldForCode(context, code)),
              MTDropdown<T>(
                width: mq.size.width - onePadding * 2,
                onChanged: (status) => selectStatus(status),
                value: selectedStatus,
                items: statuses,
              ),
              Padding(
                padding: tfPadding,
                child: InkWell(
                  child: Row(children: [
                    doneIcon(context, closed),
                    SizedBox(width: onePadding),
                    NormalText(loc.btn_mark_done_title, padding: EdgeInsets.symmetric(vertical: onePadding)),
                  ]),
                  onTap: () => setClosed(!closed),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
