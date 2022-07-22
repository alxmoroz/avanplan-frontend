// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/status.dart';
import '../../../L1_domain/entities/task.dart';
import '../../components/close_dialog_button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_dropdown.dart';
import '../../components/mt_page.dart';
import '../../components/mt_text_field.dart';
import '../../components/navbar.dart';
import '../../components/text_field_annotation.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'task_edit_controller.dart';

//TODO: подумать над унификацией полей. Возможно, получится избавиться от дуэта MTField и TFAnnotation

Future<Task?> showEditTaskDialog(BuildContext context, [Task? selectedEW]) async {
  taskEditController.selectTaskForEdit(selectedEW);

  return await showModalBottomSheet<Task?>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (_) => MTBottomSheet(TaskEditView(), context),
  );
}

class TaskEditView extends StatefulWidget {
  static String get routeName => 'task_edit';

  @override
  _TaskEditViewState createState() => _TaskEditViewState();
}

class _TaskEditViewState extends State<TaskEditView> {
  TaskEditController get _controller => taskEditController;
  Task? get _task => _controller.taskForEdit;

  //TODO: валидация о заполненности работает неправильно, не сбрасывается после закрытия диалога
  // возможно, остаются tfa с теми же кодами для новых вьюх этого же контроллера и у них висит признак о произошедшем редактировании поля
  // была попытка использовать TFAnnotation для выбора статуса, чтобы реагировать на изменения поля в плане логики валидации
  @override
  void initState() {
    //TODO: возможно, это должно быть в инициализации контроллера?
    _controller.initState(tfaList: [
      TFAnnotation('title', label: loc.common_title, text: _task?.title ?? ''),
      TFAnnotation('description', label: loc.common_description, text: _task?.description ?? '', needValidate: false),
      TFAnnotation('dueDate', label: loc.task_due_date_placeholder, noText: true, needValidate: false),
    ]);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget textFieldForCode(BuildContext context, String code, {VoidCallback? onTap}) {
    final ta = _controller.tfAnnoForCode(code);
    final isDate = code.endsWith('Date');
    return ta.noText
        ? MTTextField.noText(
            controller: _controller.teControllers[code],
            label: ta.label,
            error: ta.errorText,
            onTap: onTap ?? (isDate ? () => _controller.inputDateTime(context) : null),
            suffixIcon: isDate ? calendarIcon(context) : null,
          )
        : MTTextField(
            controller: _controller.teControllers[code],
            label: ta.label,
            error: ta.errorText,
            onTap: onTap,
          );
  }

  /// общий виджет - форма с полями для задач и целей

  Widget form(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: ListView(children: [
        if (_controller.isRoot && _controller.isNew) _controller.wsDropdown(context),
        ...['title', 'dueDate', 'description'].map((code) => textFieldForCode(context, code)),
        MTDropdown<Status>(
          onChanged: (status) => _controller.selectStatus(status),
          value: _controller.selectedStatus,
          items: _controller.statuses,
          label: loc.common_status_placeholder,
        ),
        Padding(
          padding: tfPadding,
          child: InkWell(
            child: Row(children: [
              doneIcon(context, _controller.closed),
              SizedBox(width: onePadding),
              MediumText(loc.common_done, padding: EdgeInsets.symmetric(vertical: onePadding)),
            ]),
            onTap: () => _controller.setClosed(!_controller.closed),
          ),
        ),
        if (!_controller.isNew)
          MTButton(loc.common_delete_btn_title, () => _controller.delete(context),
              titleColor: dangerColor, padding: EdgeInsets.only(top: onePadding)),
        SizedBox(height: onePadding),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          leading: CloseDialogButton(),
          title: _task == null ? loc.task_title_new : '',
          trailing: MTButton(
            loc.common_save_btn_title,
            _controller.validated ? () => _controller.save(context) : null,
            titleColor: _controller.validated ? mainColor : borderColor,
            padding: EdgeInsets.only(right: onePadding),
          ),
        ),
        body: form(context),
      ),
    );
  }
}
