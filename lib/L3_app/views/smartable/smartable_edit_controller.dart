// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_text_field.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/date_presenter.dart';
import '../workspace/workspace_bounded.dart';

part 'smartable_edit_controller.g.dart';

abstract class SmartableEditController extends _SmartableEditControllerBase with _$SmartableEditController {}

abstract class _SmartableEditControllerBase extends WorkspaceBounded with Store {
  bool get canEdit => throw UnimplementedError();
  Future delete(BuildContext context) async => throw UnimplementedError();

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
      thumbVisibility: true,
      child: ListView(children: [
        ...['title', 'dueDate', 'description'].map((code) => textFieldForCode(context, code)),
        if (customFields != null) ...customFields,
        Padding(
          padding: tfPadding,
          child: InkWell(
            child: Row(children: [
              doneIcon(context, closed),
              SizedBox(width: onePadding),
              MediumText(loc.common_mark_done_btn_title, padding: EdgeInsets.symmetric(vertical: onePadding)),
            ]),
            onTap: () => setClosed(!closed),
          ),
        ),
        if (canEdit) MTButton(loc.common_delete_btn_title, () => delete(context), titleColor: dangerColor, padding: EdgeInsets.only(top: onePadding)),
        SizedBox(height: onePadding),
      ]),
    );
  }
}
