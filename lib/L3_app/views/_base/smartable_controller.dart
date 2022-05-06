// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/text_field.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/date_presenter.dart';
import '../workspace/workspace_bounded.dart';

part 'smartable_controller.g.dart';

abstract class SmartableController extends _SmartableControllerBase with _$SmartableController {}

abstract class _SmartableControllerBase extends WorkspaceBounded with Store {
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

  /// общий виджет - форма с полями для задач и целей

  Widget form(BuildContext context, [List<Widget>? customFields]) {
    return Scrollbar(
      isAlwaysShown: true,
      child: SingleChildScrollView(
        child: Column(children: [
          ...['title', 'dueDate', 'description'].map((code) => textFieldForCode(context, code)),
          if (customFields != null) ...customFields,
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
        ]),
      ),
    );
  }
}
